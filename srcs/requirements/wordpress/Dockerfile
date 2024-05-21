# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:02:10 by aaugu             #+#    #+#              #
#    Updated: 2024/05/21 22:14:55 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

# ------------------------- PHP -------------------------

# Install PHP and PHP-FPM for PHP requests management 
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install software-properties-common -y
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install php7.0 php-fpm -y

# Install of php-mysql and mariadb-client for msql requests management
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install php-mysql mariadb-client -y

# PHP Working directory creation
RUN mkdir -p /run/php

# ------------------------- WORDPRESS -------------------------

# Install wget
RUN apt-get update -y && apt upgrade -y
RUN apt-get install -y wget

# Prepare Wordpress start
COPY tools/start_wordpress.sh /usr/local/start_wordpress.sh
RUN chmod +x /usr/local/start_wordpress.sh

# Wordpress working directory creation
RUN	mkdir -p /var/www/wordpress

# Give rights to user www-data and change permissions on directory
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www

# Install WP-CLI (Command Line Interface)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Install wordpress
RUN cd /var/www/wordpress
RUN wp core download --allow-root

# Wordpress config file
COPY config/www.conf /etc/php/7.0/fpm/pool.d/www.conf

# Define the working directory of the wordpress container
WORKDIR	/var/www/wordpress

# Exposes port 9000 and makes it available only for inter-container communication
EXPOSE 9000

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "usr/local/start_wordpress.sh" ]