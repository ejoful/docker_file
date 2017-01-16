# docker_file

docker build -t website-com .

docker run -p 8087:80 website-com /bin/bash -c 'php-fpm && sed -i -e "s/\$port/80/g" /etc/nginx/conf.d/website_com.conf && nginx'
