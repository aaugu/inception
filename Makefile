# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/26 08:55:25 by aaugu             #+#    #+#              #
#    Updated: 2024/05/21 23:31:53 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			= inception
DOCKER_COMPOSE	= docker-compose
DC_FILE			= ./srcs/docker-compose.yml
DATA_PATH		= /home/leenae/data/
ENV_PATH		= srcs/.env

all : boot build up

boot :
	@(sh srcs/requirements/tools/prepare_inception.sh $(ENV_PATH) $(path))
	@(echo "Inception successfully prepared !")

build :
	$(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) build

up :
	$(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) up

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
	@(docker system prune -a)

fclean: clean
	@(docker system prune -a --volumes)
	@(sudo rm -rf $(DATA_PATH))
	# @(rm $(ENV_PATH))

.PHONY: all bool build up down start stop status logs clean fclean