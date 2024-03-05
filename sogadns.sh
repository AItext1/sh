#!/bin/bash

echo "请选择要下载的 DNS 文件:"
echo "1) hkt"
echo "2) hk"
echo "3) sgp_no_netflix"
echo "4) nnc_hk"
echo "5) nnc_sgp"
echo "6) nnc_us"

read -p "输入选择 (1 或 2): " choice

case $choice in
  1)
    url="https://raw.githubusercontent.com/AItext1/sh/main/hkt_dns.yml"
    ;;
  2)
    url="https://raw.githubusercontent.com/AItext1/sh/main/hk_basic_dns.yml"
    ;;
  3)
    url="https://raw.githubusercontent.com/AItext1/sh/main/sgp_no_netflix.yml"
    ;; 
  4)
    url="https://raw.githubusercontent.com/AItext1/sh/main/nnc_hk.yml"
    ;;  
  5)
    url="https://raw.githubusercontent.com/AItext1/sh/main/nnc_sgp.yml"
    ;;    
  6)
    url="https://raw.githubusercontent.com/AItext1/sh/main/nnc_us.yml"
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
