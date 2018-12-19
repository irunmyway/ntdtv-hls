#!/bin/bash
# author: gfw-breaker

webRoot=/usr/share/nginx/html

# deploy web content
server_ip=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)
sed -i "s/local_server_ip/$server_ip/g" pages/index.html
cp pages/* $webRoot 

# enable ntdtv-hls service
cp ntdtv-hls /etc/init.d
chkconfig ntdtv-hls on

