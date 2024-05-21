# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:02:10 by aaugu             #+#    #+#              #
#    Updated: 2024/05/21 15:01:55 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

# Install wget (to be able to install php and wordpress after)
RUN apt-get update -y && apt upgrade -y
RUN apt-get install -y wget

# ------------------------- PHP -------------------------
RUN apt-get update -y && apt-get upgrade -y
RUN apt install gnupg2 software-properties-common ca-certificates lsb-release apt-transport-https -y
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -
# Install PHP and PHP-FPM for PHP requests management 
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install php8.0 php8.0-common php8.0-cli php-fpm -y

# Install of php-mysql and mariadb-client for msql requests management
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install php-mysql mariadb-client -y

# PHP Working directory creation
RUN mkdir -p /run/php

# ------------------------- WORDPRESS -------------------------

# Install WP-CLI (Command Line Interface)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Wordpress working directory creation
RUN	mkdir -p /var/www/wordpress

# Give rights to user www-data and change permissions on directory
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www

# Install wordpress
RUN cd /var/www/wordpress
RUN wp core download --allow-root

# Wordpress config file
COPY conf/www.conf /etc/php/8.0/fpm/pool.d/www.conf

# Prepare Wordpress start
COPY tools/start_wordpress.sh /usr/local/start_wordpress.sh
RUN chmod +x /usr/local/start_wordpress.sh

# Define the working directory of the wordpress container
WORKDIR	/var/www/wordpress

# Exposes port 9000 and makes it available only for inter-container communication
EXPOSE 9000

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "usr/local/start_wordpress.sh" ]