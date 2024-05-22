# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/26 10:42:02 by aaugu             #+#    #+#              #
#    Updated: 2024/05/22 14:17:55 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

# ------------------------- NGINX [engine x] -------------------------
# Install Nginx
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y nginx

# Creating NGINX working directories + give access to NGINX
RUN mkdir -p /var/run/nginx
RUN mkdir -p /var/www/wordpress
RUN chmod -R 755 /var/www/wordpress
RUN chown -R www-data:www-data /var/www

# Configure NGINX by overwritting configuration file
COPY config/nginx.conf /etc/nginx/nginx.conf

# Prepare NGINX start
COPY tools/start_nginx.sh /usr/local/start_nginx.sh
RUN chmod +x /usr/local/start_nginx.sh

# ------------------------- SECURE SOCKET LAYER -------------------------
# Install OpenSSL
RUN mkdir -p /etc/nginx/ssl
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y openssl

# Generate SSL certificate (req for request / -x509 for self-signed / -nodes for non encrypted private key)
RUN openssl req -x509 -nodes \
            -out /etc/nginx/ssl/nginx-selfsigned.crt \
            -keyout /etc/nginx/ssl/nginx-selfsigned.key \
            -subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42/CN=aaugu/emailAddress=aaugu@student.42.fr"

# Exposes port 443 and makes it available only for inter-container communication (required for SSL protocol)
EXPOSE 443

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "usr/local/start_nginx.sh" ]