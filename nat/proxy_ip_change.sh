#!/bin/bash

# =======================================================
# 脚本名称：update_proxy_ip.sh
# 功能：定时检查当前公共IP地址，如果与Dnsmasq配置中
#       的IP不一致，则更新配置并重启Dnsmasq服务。
# 版本：1.5 (修复IP无变化时的重复日志问题)
# 作者：BL
# =======================================================

# 配置 Dnsmasq 配置文件的路径
# 请根据你的实际情况修改此路径
DNSMASQ_CONFIG_PATH="/etc/dnsmasq.d/custom_netflix.conf"

# --- 日志配置 ---
# 日志文件路径
LOG_FILE="/var/log/update_proxy_ip.log"
# 日志保留天数
LOG_RETENTION_DAYS=7

# --- 日志函数 ---
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG_FILE"
}

# --- 清理旧日志函数 ---
clean_old_logs() {
    # 移除下面这行，就不会在日志中显示“正在清理...”的信息了
    # log_message "正在清理超过 ${LOG_RETENTION_DAYS} 天的旧日志..."

    # 使用 find 命令查找并删除早于指定天数的日志
    # 这里将错误输出重定向到 /dev/null，避免一些不必要的警告信息（例如文件不存在时）
    find "$LOG_FILE" -type f -mtime +"$LOG_RETENTION_DAYS" -delete 2>/dev/null

    # 只有在清理操作可能发生问题时才记录警告，或者在确实清理了文件时记录
    # 注意：find -delete 返回0不代表真的删除了文件，只代表命令执行成功
    # 这里的条件判断可以根据实际需求调整，例如：
    # if [ $? -ne 0 ]; then
    #     log_message "[警告] 旧日志清理过程中可能出现问题。"
    # fi
    : # 保持一个空操作，防止函数体为空
}


# --- 检查依赖 ---
# 检查 curl 是否安装
if ! command -v curl &> /dev/null; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [错误] curl 未安装。请执行 'apt install curl' 安装。" >> "$LOG_FILE"
    exit 1
fi
# 检查 grep 是否安装 (通常预装)
if ! command -v grep &> /dev/null; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [错误] grep 未安装。" >> "$LOG_FILE"
    exit 1
fi
# 检查 sed 是否安装 (通常预装)
if ! command -v sed &> /dev/null; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [错误] sed 未安装。" >> "$LOG_FILE"
    exit 1
fi
# 检查 systemctl 是否可用 (systemd 系统)
if ! command -v systemctl &> /dev/null; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [错误] systemctl 未安装或系统未使用 systemd。此脚本依赖 systemctl 重启服务。" >> "$LOG_FILE"
    exit 1
fi

# 在脚本开始时清理一次旧日志
clean_old_logs

# --- 获取当前公共IP ---
CURRENT_PROXY_IP=$(curl -4 -s ident.me)

if [ -z "$CURRENT_PROXY_IP" ]; then
    log_message "[错误] 无法获取当前公共IP，请检查网络连接或IP获取服务。"
    exit 1
fi

# --- 检查Dnsmasq配置文件是否存在 ---
if [ ! -f "$DNSMASQ_CONFIG_PATH" ]; then
    log_message "[错误] Dnsmasq 配置文件 '$DNSMASQ_CONFIG_PATH' 不存在。"
    log_message "请确保路径正确，或创建该文件。"
    exit 1
fi

# --- 从Dnsmasq配置文件中读取当前的代理IP ---
OLD_PROXY_IP=$(grep -oP 'address=\/\#\/\K[0-9.]+' "$DNSMASQ_CONFIG_PATH")

if [ -z "$OLD_PROXY_IP" ]; then
    log_message "[警告] 未能从配置文件中读取到旧的代理IP。将假定需要更新。"
    NEEDS_UPDATE=true
elif [ "$CURRENT_PROXY_IP" != "$OLD_PROXY_IP" ]; then
    log_message "检测到IP地址变化：旧IP ($OLD_PROXY_IP) -> 新IP ($CURRENT_PROXY_IP)"
    NEEDS_UPDATE=true
else
    # IP无变化时只输出指定文字，并且也记录到日志中
    local_message="IP 无变化"
    # 移除了 'echo "$local_message"'，以避免重复输出到日志
    log_message "$local_message" # 记录到日志文件（带时间戳）
    NEEDS_UPDATE=false
fi

# --- 根据需要更新配置并重启服务 ---
if [ "$NEEDS_UPDATE" = true ]; then
    log_message "正在更新 Dnsmasq 配置 '$DNSMASQ_CONFIG_PATH'..."
    sed -i "s|address=/#/.*|address=/#/${CURRENT_PROXY_IP}|" "$DNSMASQ_CONFIG_PATH"

    if [ $? -eq 0 ]; then
        log_message "Dnsmasq 配置更新成功。"
        log_message "正在重启 dnsmasq 服务以应用更改..."
        systemctl restart dnsmasq
        if [ $? -eq 0 ]; then
            log_message "Dnsmasq 服务重启成功。"
        else
            log_message "[错误] Dnsmasq 服务重启失败！请检查 dnsmasq 服务状态：'systemctl status dnsmasq'"
            exit 1
        fi
    else
        log_message "[错误] Dnsmasq 配置更新失败！请检查文件权限或sed命令是否正确。"
        exit 1
    fi
fi
