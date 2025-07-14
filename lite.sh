#!/bin/bash

echo "请选择要下载的 DNS 文件:"
echo "1) hk_lite"
echo "2) tw_lite"
echo "3) sgp_lite"
echo "4) jp_lite"
echo "5) us_lite"

read -p "输入选择 (1 或 2): " choice

case $choice in
  1) # hk_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/lite_hk.yml"
    ;;
  2) # tw_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/lite_tw.yml"
    ;;
  3) # sgp_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/lite_sgp.yml"
    ;;
  4) # jp_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/lite_jp.yml"
    ;;
  5) # us_basic
    url="https://raw.githubusercontent.com/AItext1/sh/main/lite_us.yml"
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
