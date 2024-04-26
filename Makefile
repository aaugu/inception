# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/26 08:55:25 by aaugu             #+#    #+#              #
#    Updated: 2024/04/26 10:21:38 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE	= docker-compose
DC_FILE			= ./srcs/docker-compose.yml

all : build up

build :
	$(DOCKER_COMPOSE) -f $(DC_FILE) build

up :
	$(DOCKER_COMPOSE) -f $(DC_FILE) up -d

down : 
	$(DOCKER_COMPOSE) -f $(DC_FILE) down

start : 
	$(DOCKER_COMPOSE) -f $(DC_FILE) start

stop : 
	$(DOCKER_COMPOSE) -f $(DC_FILE) stop

restart : stop up

status:
	$(DOCKER_COMPOSE) -f $(DC_FILE) ps

logs:
	$(DOCKER_COMPOSE) -f $(DC_FILE) logs


clean: down

fclean: clean
	docker system prune -f -a --volumes


.PHONY: all up down start stop status logs prune clean fclean