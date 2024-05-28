# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:35:37 by aaugu             #+#    #+#              #
#    Updated: 2024/05/28 13:14:00 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

# ------------------------- NGINX [engine x] -------------------------
# Install Nginx
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y nginx

# ------------------------- SECURE SOCKET LAYER -------------------------
# Install OpenSSL
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install -y openssl

# Generate SSL certificate (req for request / -x509 for self-signed / -nodes for non encrypted private key)
RUN openssl req -x509 -nodes \
			-out /etc/nginx/ssl/inception.crt \
			-keyout /etc/nginx/ssl/inception.key \
			-subj "/C=SW/ST=VD/L=Lausane/O=42/OU=42/CN=aaugu.42.fr"


# ------------------------- PREPARATION -------------------------

# Creating NGINX working directories + give access to NGINX
RUN mkdir -p /var/run/nginx /var/www/wordpress
RUN chmod -R 755 /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

# Configure NGINX by overwritting configuration file
COPY config/nginx.conf /etc/nginx/nginx.conf

# Prepare NGINX start
COPY tools/start_nginx.sh /usr/local/start_nginx.sh
RUN chmod +x /usr/local/start_nginx.sh

# Exposes port 443 and makes it available only for inter-container communication (required for SSL protocol)
EXPOSE 443

ENTRYPOINT [ "sh", "/usr/local/start_nginx.sh"]
