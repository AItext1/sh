#!/bin/bash

echo "请选择要下载的 DNS 文件:"
echo "1) nnc_hk"
echo "2) nnc_sgp"
echo "3) nnc_us"
echo "4) nnc_tw"
echo "5) nnc_jp"
echo "6) us_basic"

read -p "输入选择 (1 或 2): " choice

case $choice in
  1)
    url="https://raw.githubusercontent.com/AItext1/sh/main/nnc_hk.yml"
    ;;  
  2)
    url="https://raw.githubusercontent.com/AItext1/sh/main/nnc_sgp.yml"
    ;;    
  3)
    url="https://raw.githubusercontent.com/AItext1/sh/main/nnc_us.yml"
    ;; 
  4)
    url="https://raw.githubusercontent.com/AItext1/sh/main/nnc_tw.yml"
    ;; 
  5)
    url="https://raw.githubusercontent.com/AItext1/sh/main/nnc_jp.yml"
    ;;  
  6)
    url="https://raw.githubusercontent.com/AItext1/sh/main/us_basic.yml"
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
