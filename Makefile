# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/26 08:55:25 by aaugu             #+#    #+#              #
#    Updated: 2024/05/23 11:09:06 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			= inception
DOCKER_COMPOSE	= docker-compose
DC_FILE			= ./srcs/docker-compose.yml
DATA_PATH		= /home/aaugu/data/
ENV_PATH		= srcs/.env

all : prepare down build up

prepare :
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
	@(rm $(ENV_PATH))

.PHONY: all prepare build up down start stop status logs clean fclean