#!/bin/bash

url=$1
filename=$(basename $url | awk -F'.' '{print $1}')
ext=$(basename $url | awk -F'.' '{if(NF==2) print $2; else print "html"}')

cantidadArchivos=$(ls files/$filename* 2>/dev/null | wc -l )
if [ $cantidadArchivos -eq 0 ]; then
    wget $url -O files/$filename$(date +"_%Y_%m_%d_%H_%M_%S")"."$ext 2>/dev/null
else
    latest=$(ls --sort=time files/$filename* 2>/dev/null | head -n 1)
    md5sum $latest | awk '{print $1}' > hash_latest
    
    wget $url -O files/tmp 2>/dev/null
    md5sum files/tmp | awk '{print $1}' > hash_downloaded
    
    diff hash_latest hash_downloaded
    iguales=$?
    
    if [ $iguales -eq 0 ]; then
	echo "son iguales"
	rm files/tmp
    else
	echo "son diferentes"
	mv files/tmp files/$filename$(date +"_%Y_%m_%d_%H_%M_%S")"."$ext
    fi
    
    rm hash_latest hash_downloaded
fi
