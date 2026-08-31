#!/bin/bash

echo "请选择要下载的 DNS 文件:"
echo "1) hk"
echo "2) tw"
echo "3) sgp"
echo "4) jp"
echo "5) us"

read -p "输入选择 (1 或 2): " choice

case $choice in
  1) # hk
    url="https://raw.githubusercontent.com/AItext1/sh/refs/heads/main/nnc/hk.yml"
    ;;
  *)
    echo "无效选择。退出。"
    exit 1
    ;;
esac

wget -O /etc/soga/dns.yml "$url" && soga restart

echo "DNS 更新完成并尝试重启 soga。"

# 显示soga日志
soga log
