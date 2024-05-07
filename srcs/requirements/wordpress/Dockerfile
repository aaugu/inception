# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:02:10 by aaugu             #+#    #+#              #
#    Updated: 2024/05/07 14:33:52 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

# ------------------------- PHP -------------------------
# Install PHP
RUN apt-get update -y
RUN apt-get install -y php7.3 php-fpm php-mysql

# PHP Config


# ------------------------- WORDPRESS -------------------------
# Install Wordpress
RUN apt-get update -y
RUN apt-get -y install wget
RUN wget https://fr.wordpress.org/wordpress-6.5.2-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN	chown -R root:root /var/www/wordpress

# Prepare Wordpress start
COPY tools/start_wordpress.sh /usr/local/start_wordpress.sh
RUN chmod +x /usr/local/start_wordpress.sh

# Define the working directory of the wordpress container
WORKDIR	/var/www/html/wordpress

# Install WP-CLI (Command Line Interface)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Exposes port 9000 and makes it available only for inter-container communication
EXPOSE ${WP_PORT}

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "usr/local/start_wordpress.sh" ]