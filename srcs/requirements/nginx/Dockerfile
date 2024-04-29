# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/26 10:42:02 by aaugu             #+#    #+#              #
#    Updated: 2024/04/29 14:46:23 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

# ------------------------- NGINX [engine x] -------------------------
# Install Nginx
RUN apt-get update -y
RUN apt-get install -y nginx

# Configure NGINX by overwritting default configuration file
COPY config/nginx.conf /etc/nginx/

# Prepare NGINX start
COPY tools/run_nginx.sh /usr/local/run_ngnix.sh
RUN chmod +x /usr/local/run_ngnix.sh

# ------------------------- SECURE SOCKET LAYER -------------------------
# Install OpenSSL
RUN mkdir -p /etc/nginx/ssl
RUN apt-get update -y
RUN apt-get install -y openssl

# Generate SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -sub "/C=CH/ST=VD/L=Lausanne/O=42/OU=42/CN=aaugu/emailAddress=aaugu@student.42.fr"

# Exposes 443 port and makes it available only for inter-container communication
EXPOSE ${NGINX_PORT}

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "usr/local/run_ngnix.sh" ]