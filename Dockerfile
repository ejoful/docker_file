

FROM centos:centos7

MAINTAINER sky

# -----------------------------------------------------------------------------
# Installing Remi Repository
# -----------------------------------------------------------------------------
RUN yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# -----------------------------------------------------------------------------
# Import the RPM GPG keys for Repositories
# -----------------------------------------------------------------------------
RUN yum -y install epel-release


# open Remi, Remi-php56 Repository
RUN yum-config-manager --enable epel remi remi-php56


# updata 
RUN  yum -y update


# UTC Timezone & Networking
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
	&& echo "NETWORKING=yes" > /etc/sysconfig/network


# install nginx
RUN yum -y install \
	curl \
	curl-devel \
	icu \
	nginx \
	rsync \
	unzip \
	wget \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all 

# install php 5.6
RUN yum -y install \
	php-fpm \
	php-cli \
	php-common \
	php-devel \
	php-fpm \
	php-gd \
	php-imap \
	php-intl \
	php-mbstring \
	php-mcrypt \
	php-mysqlnd \
	php-odbc \
	php-opcache \
	php-pdo \
	php-pear \
	php-pecl-apcu \
	php-pecl-apcu-devel \
	php-pecl-bbcode \
	php-pecl-geoip \
	php-pecl-imagick \
	php-pecl-imagick-devel \
	php-pecl-jsonc \
	php-pecl-jsonc-devel \
	php-pecl-memcache \
	php-pecl-memcached \
	php-pecl-mongo \
	php-pecl-mongodb \
	php-pecl-oauth \
	php-pecl-redis \
	php-pecl-sqlite \
	php-pecl-ssh2 \
	php-pecl-zip \
	php-pgsql \
	php-process \
	php-soap \
	php-tidy \
	php-twig \
	php-xcache \
	php-xml \
	php-xmlrpc \
	php-runtime \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all 
	
#	php-pecl-xdebug 


RUN sed -i \
	-e 's/max_input_time = 60/max_input_time = 180/g' \
	-e 's/memory_limit = 128M/memory_limit = 1024M/g' \
	-e 's/post_max_size = 8M/post_max_size = 2100M/g' \
	-e 's/upload_max_filesize = 2M/upload_max_filesize = 2048M/g' \
	-e 's#;curl.cainfo=#curl.cainfo = /etc/.cacert/cacert.pem#g' \
	-e 's#;openssl.cafile=#openssl.cafile = /etc/.cacert/cacert.pem#g' \
	/etc/php.ini


# download cacert.pem to /etc/.cacert
RUN wget -P /etc/.cacert https://curl.haxx.se/ca/cacert.pem

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN sed -i -e 's~worker_processes auto;~worker_processes auto;\ndaemon off;~' /etc/nginx/nginx.conf

# Enable nginx php-fpm
# RUN systemctl enable nginx php-fpm && systemctl restart nginx && systemctl restart php-fpm


EXPOSE 80 8081














