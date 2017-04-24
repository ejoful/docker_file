# docker_file

docker build -t website-com .

docker run -p 8087:80 website-com /bin/bash -c 'php-fpm && sed -i -e "s/\\$port/80/g" /etc/nginx/conf.d/website_com.conf && nginx'

docker run -t -i website-com /bin/bash

docker stop 139b7d7e6d98

docker进入后台运行的容器
 
我们运行docker容器的时候，使用了-d参数，把容器在后台运行后。
这个时候，我们使用docker ps命令，我们就可以知道哪些程序在后台运行。

我们要怎么进入到docker容器呢？
1:使用docker attach命令
我们使用
docker attach db3 或者 docker attach d48b21a7e439
db3是后台容器的NAMES,d48b21a7e439是容器的进程ID  CONTAINER ID
然后就进去了这个容器的ssh界面。
但是它有一个缺点，只要这个连接终止，或者使用了exit命令，容器就会退出后台运行
2:使用docker exec命令
这个命令使用exit命令后，不会退出后台，一般使用这个命令，使用方法如下
docker exec -it db3 /bin/sh 或者 docker exec -it d48b21a7e439 /bin/sh
