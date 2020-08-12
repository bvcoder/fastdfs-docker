#!/bin/sh

new_val=$FASTDFS_IPADDR
old="fdfs.tu8.pub"

sed -i "s/$old/$new_val/g" /etc/fdfs/client.conf
sed -i "s/$old/$new_val/g" /etc/fdfs/storage.conf
sed -i "s/$old/$new_val/g" /etc/fdfs/mod_fastdfs.conf

cat  /etc/fdfs/client.conf > /etc/fdfs/client.txt
cat  /etc/fdfs/storage.conf >  /etc/fdfs/storage.txt
cat  /etc/fdfs/mod_fastdfs.conf > /etc/fdfs/mod_fastdfs.txt

mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.t
cp /etc/fdfs/nginx.conf /usr/local/nginx/conf

echo "start trackerd"
sh /etc/init.d/fdfs_trackerd start

echo "start storage"
sh /etc/init.d/fdfs_storaged start

echo "start nginx"
/usr/local/nginx/sbin/nginx

tail -f  /dev/null
