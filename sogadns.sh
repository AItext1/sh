#!/bin/bash

echo "请选择要下载的 DNS 文件:"
echo "1) hk_basic"
echo "2) tw_basic"
echo "3) sgp_basic"
echo "4) jp_basic"
echo "5) kr_basic"
echo "6) us_basic"
echo "7) uk_basic"
echo "8) fr_basic"
echo "9) de_basic"
echo "10) CA"
echo "11) MEL"

read -p "输入选择 (1 或 2): " choice

case $choice in
  1) # hk_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/hk_basic.yml"
    ;;
  2) # tw_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/tw_basic.yml"
    ;;
  3) # sgp_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/sgp_basic.yml"
    ;;
  4) # jp_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/jp_basic.yml"
    ;;
  5) # kr_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/kr_basic.yml"
    ;;
  6) # us_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/us_basic.yml"
    ;;
  7) # uk_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/uk_basic.yml"
    ;;
  8) # fr_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/fr_basic.yml"
    ;;
  9) # de_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/de_basic.yml"
    ;;
  10) # CA
    url="https://raw.githubusercontent.com/AItext1/sh/main/all_ca.yml"
    ;;  
  11) # MEL
    url="https://raw.githubusercontent.com/AItext1/sh/main/all_mel.yml"
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
