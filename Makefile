# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/26 08:55:25 by aaugu             #+#    #+#              #
#    Updated: 2024/05/13 12:00:48 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			= inception
DOCKER_COMPOSE	= docker-compose
DC_FILE			= ./srcs/docker-compose.yml
WP_VOLUME_PATH	= /home/leenae/data/wordpress
MDB_VOLUME_PATH	= /home/leenae/data/mariadb

all : boot build up

boot :
	@(if [ ! -d ${WP_VOLUME_PATH} ]; then mkdir -p ${WP_VOLUME_PATH}; fi)
	@(if [ ! -d ${MDB_VOLUME_PATH} ]; then mkdir -p ${MDB_VOLUME_PATH};	fi)

build :
	$(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) build

up :
	$(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) up -d

down : 
	$(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) down

start : 
	$(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) start

stop : 
	$(DOCKER_COMPOSE) -f $(DC_FILE) $(NAME) stop

restart : stop up

status:
	$(DOCKER_COMPOSE) -f $(DC_FILE) ps

logs:
	$(DOCKER_COMPOSE) -f $(DC_FILE) logs


clean: 	down

fclean: clean
	docker system prune -f -a --volumes


.PHONY: all bool build up down start stop status logs clean fclean