#!/bin/bash

echo "请选择要下载的 DNS 文件:"
echo "1) hk"
echo "2) tw_"
echo "3) sgp"
echo "4) jp"
echo "5) us"

read -p "输入选择 (1 或 2): " choice

case $choice in
  1) # hk
    url="https://raw.githubusercontent.com/AItext1/sh/refs/heads/main/nnc/hk.yml"
    ;;
  2) # tw
    url="https://raw.githubusercontent.com/AItext1/sh/refs/heads/main/nnc/tw.yml"
    ;;
  3) # sgp
    url="https://raw.githubusercontent.com/AItext1/sh/refs/heads/main/nnc/sgp.yml"
    ;;
  4) # jp
    url="https://raw.githubusercontent.com/AItext1/sh/refs/heads/main/nnc/jp.yml"
    ;;  
  5) # us
    url="https://raw.githubusercontent.com/AItext1/sh/refs/heads/main/nnc/us.yml"
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
