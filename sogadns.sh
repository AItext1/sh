#!/bin/bash

echo "请选择要下载的 DNS 文件:"
echo "1) HK"
echo "2) TW"
echo "3) SIN"
echo "4) JP"
echo "5) KR"
echo "6) US"
echo "7) UK"
echo "8) FR"
echo "9) GEM"
echo "10) CA"

read -p "输入选择 (1 或 2): " choice

case $choice in
  1) # HK
    url="https://raw.githubusercontent.com/AItext1/sh/main/hk_basic.yml"
    ;;
  2) # TW
    url="https://raw.githubusercontent.com/AItext1/sh/main/tw_basic.yml"
    ;;
  3) # SIN
    url="https://raw.githubusercontent.com/AItext1/sh/main/sgp_basic.yml"
    ;;
  4) # JP
    url="https://raw.githubusercontent.com/AItext1/sh/main/jp_basic.yml"
    ;;
  5) # KR
    url="https://raw.githubusercontent.com/AItext1/sh/main/kr_basic.yml"
    ;;
  6) # US
    url="https://raw.githubusercontent.com/AItext1/sh/main/us_basic.yml"
    ;;
  7) # UK
    url="https://raw.githubusercontent.com/AItext1/sh/main/uk_basic.yml"
    ;;
  8) # FR
    url="https://raw.githubusercontent.com/AItext1/sh/main/fr_basic.yml"
    ;;
  9) # GEM
    url="https://raw.githubusercontent.com/AItext1/sh/main/de_basic.yml"
    ;;
  10) # CA
    url="https://raw.githubusercontent.com/AItext1/sh/main/ca_basic.yml"
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
