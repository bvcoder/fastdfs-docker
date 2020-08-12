FROM alpine:3

ADD conf/ /etc/fdfs/
ADD fastdfs.sh /home/

RUN  apk add --no-cache git build-base automake autoconf libtool pcre pcre-dev zlib zlib-dev openssl-dev wget \
  &&    mkdir /usr/local/src && cd /usr/local/src  \
  &&    git clone https://github.com/happyfish100/libfastcommon.git --depth 1        \
  &&    git clone https://github.com/happyfish100/fastdfs.git --depth 1    \
  &&    git clone https://github.com/happyfish100/fastdfs-nginx-module.git --depth 1   \
  &&    wget http://nginx.org/download/nginx-1.18.0.tar.gz    \
  &&    tar -zxvf nginx-1.18.0.tar.gz    \
  &&    mkdir /home/dfs   \
  &&    cd /usr/local/src/libfastcommon/  \
  &&    ./make.sh && ./make.sh install  \
  &&    cd /usr/local/src/fastdfs/  \
  &&    ./make.sh && ./make.sh install  \
  &&    cd /usr/local/src/nginx-1.18.0/  \
  &&    ./configure --add-module=/usr/local/src/fastdfs-nginx-module/src/   \
  &&    make && make install  \
  &&    chmod +x /home/fastdfs.sh \
  &&    apk del git build-base automake autoconf libtool pcre-dev zlib zlib-dev openssl-dev wget


VOLUME /etc/fdfs

EXPOSE 22122 23000 80
CMD ["/home/fastdfs.sh"]
