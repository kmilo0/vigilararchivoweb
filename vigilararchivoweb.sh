#!/bin/bash

url=$1
filename=$(basename $url | awk -F'.' '{print $1}')
ext=$(basename $url | awk -F'.' '{if(NF==2) print $2; else print "html"}')

dir=~/files
mkdir ~/files 2>/dev/null

cantidadArchivos=$(ls $dir/$filename* 2>/dev/null | wc -l )
if [ $cantidadArchivos -eq 0 ]; then
    wget $url -O $dir/$filename$(date +"_%Y_%m_%d_%H_%M_%S")"."$ext 2>/dev/null
else
    latest=$(ls --sort=time $dir/$filename* 2>/dev/null | head -n 1)
    md5sum $latest | awk '{print $1}' > hash_latest
    
    wget $url -O $dir/tmp 2>/dev/null
    md5sum $dir/tmp | awk '{print $1}' > hash_downloaded
    
    diff hash_latest hash_downloaded
    iguales=$?
    
    if [ $iguales -eq 0 ]; then
	echo "son iguales"
	rm $dir/tmp
    else
	echo "son diferentes"
	mv $dir/tmp $dir/$filename$(date +"_%Y_%m_%d_%H_%M_%S")"."$ext
    fi
    
    rm hash_latest hash_downloaded
fi
