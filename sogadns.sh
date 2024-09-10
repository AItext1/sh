#!/bin/bash

echo "请选择要下载的 DNS 文件:"
echo "1) sgp_basic"
echo "2) 1"
echo "3) nnc_us"
echo "4) nnc_tw"
echo "5) nnc_jp"
echo "6) us_basic"
echo "7) hk_basic"
echo "8) ina_hkg"
echo "9) au_hkg"
echo "10) fr_basic"
echo "11) de_basic"
echo "12) tw_basic"

read -p "输入选择 (1 或 2): " choice

case $choice in
  1)
    url="https://raw.githubusercontent.com/AItext1/sh/main/sgp_basic.yml"
    ;;  
  2)
    url="https://raw.githubusercontent.com/AItext1/sh/main/1.yml"
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
  7)
    url="https://raw.githubusercontent.com/AItext1/sh/main/hk_basic.yml"
    ;;      
  8)
    url="https://raw.githubusercontent.com/AItext1/sh/main/ina_hkg.yml"
    ;;    
  9)
    url="https://raw.githubusercontent.com/AItext1/sh/main/au_hkg.yml"
    ;;      
  10)
    url="https://raw.githubusercontent.com/AItext1/sh/main/fr_basic.yml"
    ;;        
  11)
    url="https://raw.githubusercontent.com/AItext1/sh/main/de_basic.yml"
    ;;         
  12)
    url="https://raw.githubusercontent.com/AItext1/sh/main/tw_basic.yml"
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
