# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/26 10:42:02 by aaugu             #+#    #+#              #
#    Updated: 2024/04/26 18:02:51 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:11

# LABEL maintainer="m24te28"

RUN apt-get update && \
    apt-get install -y -q curl gnupg2

RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -

RUN apt-get update && \
    apt-get install -y -q nginx

ADD ./config/nginx.conf /etc/nginx/
# ADD server.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]