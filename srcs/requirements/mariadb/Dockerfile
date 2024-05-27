# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:35:37 by aaugu             #+#    #+#              #
#    Updated: 2024/05/27 12:01:59 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

# ------------------------- MARIADB -------------------------
# Install MariaDB
RUN apt-get update -y && apt-get upgrade -y
RUN apt install mariadb-server -y

# Working directory creation
RUN mkdir -p /run/mysqld /var/lib/mysql

# Configure MariaDB by overwritting default configuration file
COPY config/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Prepare MariaDB start
COPY tools/start_mariadb.sh /usr/local/start_mariadb.sh
RUN chmod +x /usr/local/start_mariadb.sh

# Exposes port 3306 and makes it available only for inter-container communication
EXPOSE 3306

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "/usr/local/start_mariadb.sh" ]
