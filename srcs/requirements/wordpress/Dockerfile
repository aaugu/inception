# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:02:10 by aaugu             #+#    #+#              #
#    Updated: 2024/05/06 12:01:55 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

# ------------------------- PHP -------------------------
# Install PHP
RUN apt-get update -y


# ------------------------- WORDPRESS -------------------------
# Install Wordpress
RUN apt-get update -y



# Exposes port 9000 and makes it available only for inter-container communication
EXPOSE ${WP_PORT}

# Set executable that will always run when the container is initiated
ENTRYPOINT [ "sh", "usr/local/start_wordpress.sh" ]