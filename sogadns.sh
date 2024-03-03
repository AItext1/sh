#!/bin/bash

echo "请选择要下载的 DNS 文件:"
echo "1) hkt"
echo "2) hk"

read -p "输入选择 (1 或 2): " choice

case $choice in
  1)
    url="https://raw.githubusercontent.com/AItext1/sh/main/hkt_dns.yml"
    ;;
  2)
    url="https://raw.githubusercontent.com/AItext1/sh/main/hk_basic_dns.yml"
    ;;
  *)
    echo "无效选择。退出。"
    exit 1
    ;;
esac

wget -O /etc/soga/dns.yml "$url" && soga restart

echo "DNS 更新完成并尝试重启 soga。"

使脚本具有可执行权限：

chmod +x update_dns.sh

然后执行脚本：

./update_dns.sh
