# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/26 08:55:25 by aaugu             #+#    #+#              #
#    Updated: 2024/05/17 12:46:58 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			= inception
DOCKER_COMPOSE	= docker-compose
DC_FILE			= ./srcs/docker-compose.yml
WP_DATA_PATH	= /home/aaugu/data/wordpress
MDB_DATA_PATH	= /home/aaugu/data/mariadb

all : boot build up

boot :

	@(if [ ! -d ${WP_DATA_PATH} ]; then mkdir -p ${WP_DATA_PATH}; fi)
	@(if [ ! -d ${MDB_DATA_PATH} ]; then mkdir -p ${MDB_DATA_PATH}; fi)

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
	docker volume rm mariadb_volume
	docker volume rm wordpress_volume
	docker system prune -f -a --volumes

.PHONY: all bool build up down start stop status logs clean fclean