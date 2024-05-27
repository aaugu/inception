# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:02:10 by aaugu             #+#    #+#              #
#    Updated: 2024/05/27 11:57:30 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

# Install wget
RUN apt-get update -y && apt upgrade -y
RUN apt-get install -y wget

# ------------------------------------ PHP ------------------------------------

# Install PHP and PHP-FPM for PHP requests management 
RUN apt-get install php7.4 php-fpm -y

# Install of php-mysql and mariadb-client for msql requests management
RUN apt-get install php-mysql mariadb-client -y

# ------------------------- PREPARATION FOR WORDPRESS -------------------------

# Creating Wordpress working directories
RUN mkdir -p /var/www/wordpress

# PHP Working directory creation
RUN mkdir -p /run/php

# Give rights to user www-data
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www/

# Wordpress config file
COPY config/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod +x /etc/php/7.4/fpm/pool.d/www.conf

# Prepare Wordpress start
COPY tools/start_wordpress.sh /usr/local/start_wordpress.sh
RUN chmod -R 755 /usr/local/start_wordpress.sh

# Exposes port 9000 and makes it available only for inter-container communication
EXPOSE 9000

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "/usr/local/start_wordpress.sh" ]