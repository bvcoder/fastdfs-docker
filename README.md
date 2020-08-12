# FastDFS Dockerfile

## 声明
FastDFS Dockerfile 构建镜像

## 目录介绍

### conf 目录

Dockerfile 所需要的一些配置文件
你也可以对这些文件进行修改，比如 storage.conf 里面的 bast_path 等相关

## 使用方法

```bash
# 构建镜像
docker build  -f Dockerfile -t bvcode/fastdfs .
```

运行容器时需要使用参数 FASTDFS_IPADDR 指定宿主机的ip/域名， /home/dfs 为容器存放fastdfs文件和日志的目录， /etc/fdfs 为配置文件目录，如：

```bash
# 运行镜像
docker run -d -e FASTDFS_IPADDR=10.0.0.201 -p 22122:22122 -p 23000:23000 -p 8811:80 -v /root/fdfs:/home/dfs --name my-dfs bvcode/fastdfs
```
