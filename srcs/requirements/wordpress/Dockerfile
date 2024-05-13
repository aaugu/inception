# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:02:10 by aaugu             #+#    #+#              #
#    Updated: 2024/05/13 11:53:45 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

# ------------------------- PHP -------------------------
# Install PHP
RUN apt-get update -y
RUN apt-get install -y php7.3 php-fpm php-mysql

# PHP Config
RUN mkdir -p /run/php

# ------------------------- WORDPRESS -------------------------
		
# Install wget (to be able to install wordpress after)
RUN apt update -y && apt upgrade -y
RUN apt-get install -y wget

# Prepare Wordpress start
COPY tools/start_wordpress.sh /usr/local/start_wordpress.sh
RUN chmod +x /usr/local/start_wordpress.sh

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

# Define the working directory of the wordpress container
WORKDIR	/var/www/wordpress

# Exposes port 9000 and makes it available only for inter-container communication
EXPOSE ${WP_PORT}

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "usr/local/start_wordpress.sh" ]