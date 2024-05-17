# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:02:10 by aaugu             #+#    #+#              #
#    Updated: 2024/05/17 14:19:28 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

# Install wget (to be able to install php and wordpress after)
RUN apt-get update -y && apt upgrade -y
RUN apt-get install -y wget

# ------------------------- PHP -------------------------
# Install PHP
RUN apt-get update -y && apt-get upgrade -y
RUN apt install gnupg2 software-properties-common ca-certificates lsb-release apt-transport-https -y
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y php8.0 php8.0-common php8.0-cli php-fpm php-mysql

# PHP Config
RUN mkdir -p /run/php

# ------------------------- WORDPRESS -------------------------

# Install WP-CLI (Command Line Interface)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Install wordpress
RUN	mkdir -p /var/www/wordpress
RUN chmod -R 755 /var/www
RUN chown -R www-data:www-data /var/www
RUN cd /var/www/wordpress
RUN wp core download --allow-root

# Prepare Wordpress start
COPY tools/start_wordpress.sh /usr/local/start_wordpress.sh
RUN chmod +x /usr/local/start_wordpress.sh

# Define the working directory of the wordpress container
WORKDIR	/var/www/wordpress

# Exposes port 9000 and makes it available only for inter-container communication
EXPOSE 9000

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "usr/local/start_wordpress.sh" ]