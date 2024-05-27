# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/26 08:55:25 by aaugu             #+#    #+#              #
#    Updated: 2024/05/27 11:07:58 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			= inception
DOCKER_COMPOSE	= docker-compose
DC_FILE			= ./srcs/docker-compose.yml
DATA_PATH		= /home/aaugu/data/
ENV_PATH		= srcs/.env
SECRETS_PATH	= secrets

all : prepare down build up

prepare :
	@(sh srcs/requirements/tools/prepare_inception.sh)
	@(echo "Inception successfully prepared !")

build :
	@(echo "Creating images...")
	@($(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) build)

up :
	@(echo "Building, creating and starting containers...")
	@($(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) up)

down :
	@(echo "Stopping containers...")
	@($(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) down)

start :
	$(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) start

stop :
	$(DOCKER_COMPOSE) -f $(DC_FILE) $(NAME) stop

restart :
	$(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) restart

status:
	@($(DOCKER_COMPOSE) -f $(DC_FILE) ps)

logs:
	@($(DOCKER_COMPOSE) -f $(DC_FILE) logs)


clean: 	down
	@(docker system prune -a)

fclean: clean
	@(docker system prune -a --volumes)
	@(sudo rm -rf $(DATA_PATH))
	#@(rm -rf $(SECRETS_PATH))
	#@(rm $(ENV_PATH))

.PHONY: all prepare build up down start stop status logs clean fclean