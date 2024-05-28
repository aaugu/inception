# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/26 08:55:25 by aaugu             #+#    #+#              #
#    Updated: 2024/05/28 14:16:17 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			= inception
DOCKER_COMPOSE	= docker-compose
DC_FILE			= ./srcs/docker-compose.yml
DATA_PATH		= /home/aaugu/data/
ENV_PATH		= srcs/.env

# Colors
BLUE			= \033[44m
END				= \033[0m

all : prepare down build up

prepare :
	@(sh ./srcs/requirements/tools/prepare_inception.sh)
	@(echo "Inception successfully prepared !")

build :
	@(echo "Creating images...")
	@($(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) build)

up :
	@(echo "Building, creating and starting containers...")
	@($(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) up)

up-detached :
	@(echo "Building, creating and starting containers...")
	@($(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) up -d)

down :
	@(echo "Stopping containers...")
	@($(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) down)

start :
	$(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) start

stop :
	$(DOCKER_COMPOSE) -f $(DC_FILE) $(NAME) stop

restart :
	$(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) restart

status :
	@(echo "$(BLUE)Running Containers :$(END)")
	@($(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) ps)
	@(echo "")

	@(echo "$(BLUE)Images :$(END)")
	@(docker images)
	@(echo "")

	@(echo "$(BLUE)Containers :$(END)")
	@(docker container ls -a)
	@(echo "")

	@(echo "$(BLUE)Volumes :$(END)")
	@(docker volume ls)
	@(echo "")

	@(echo "$(BLUE)Network :$(END)")
	@(docker network ls)
	@(echo "")

logs:
	@($(DOCKER_COMPOSE) -f $(DC_FILE) -p $(NAME) logs)

clean: down
	@(docker system prune -a)

fclean: down
	@(docker system prune -a --volumes)
	@(docker volume rm $$(docker volume ls -q))
	@(sudo rm -rf $(DATA_PATH))
	@(rm $(ENV_PATH))

re: fclean all

.PHONY: all prepare build up up-detached down start stop status logs clean fclean re

