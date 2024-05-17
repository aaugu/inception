# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:35:37 by aaugu             #+#    #+#              #
#    Updated: 2024/05/13 13:50:20 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

# ------------------------- MARIADB -------------------------
# Install MariaDb
RUN apt-get update -y && apt-get upgrade -y
RUN apt install mariadb-server mariadb-client -y

# Configure MariaDB by overwritting default configuration file
COPY config/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Prepare MariaDB start
COPY tools/start_mariadb.sh /usr/local/start_mariadb.sh
RUN chmod +x /usr/local/start_mariadb.sh
RUN mkdir -p /run/mysqld

# Exposes port 443 and makes it available only for inter-container communication
EXPOSE ${DB_PORT}

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "usr/local/start_mariadb.sh" ]
