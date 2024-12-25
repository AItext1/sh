#!/bin/bash

echo "请选择要下载的 DNS 文件:"
echo "1) eu"
echo "2) kr"
echo "3) uk"
echo "4) us"
echo "5) mel"

read -p "输入选择 (1 或 2): " choice

case $choice in
  1)
    url="https://raw.githubusercontent.com/AItext1/sh/main/route_uk"
    ;;  
  2)
    url="https://raw.githubusercontent.com/AItext1/sh/main/route_kr"
    ;;  
  3)
    url="https://raw.githubusercontent.com/AItext1/sh/main/route_uk"
    ;;  
  4)
    url="https://raw.githubusercontent.com/AItext1/sh/main/route_us"
    ;;    
  5)
    url="https://raw.githubusercontent.com/AItext1/sh/main/route_mel"
    ;;     
  *)
    echo "无效选择。退出。"
    exit 1
    ;;
esac

wget -O /etc/soga/routes.toml "$url" && soga restart

echo "DNS 更新完成并尝试重启 soga。"

# 显示soga日志
soga log
