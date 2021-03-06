#!/bin/bash
# author: gfw-breaker
# desc:	synchronize HLS media to local server

webRoot=/usr/share/nginx/html
baseUrl=http://cnhls.ntdtv.com/cn/live800
m3u8=playlist.m3u8
channel=ntdtvcn
mediaDir=$webRoot/$channel


mkdir -p $mediaDir
cd $mediaDir
while : ; do

	# download m3u8 and media 
	wget -q $baseUrl/$m3u8 -O $m3u8.new
	for frag in $(grep ^media $m3u8); do
		if [ -f $frag ]; then
			#echo "skipping $frag ..."
			continue
		fi
		echo "getting  $frag ..."
		wget -q $baseUrl/$frag -O $frag 
	done
	cp $m3u8.new $m3u8

	# remove old frags
	for oldFrag in $(ls -t media* | sed '1,20d'); do
		echo "removing $oldFrag ..."
		rm $oldFrag
	done
	
	# wait for 1 sec	
	sleep 1	
done

## HLS url:
##  http://<server-ip>:<server-port>/ntdtvcn/playlist.m3u8


