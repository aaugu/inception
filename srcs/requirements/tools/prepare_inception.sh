CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

WP_DATA_PATH="/home/leenae/data/wordpress"
MDB_DATA_PATH="/home/leenae/data/mariadb"
ENV_PATH=$1

echo "---------- PREPARING DOCKER TO START... ----------"

if [ "$#" -eq 1 ]
	then
		echo "${RED}ERROR: Path to secrets missing !${NC}"
		exit 1
fi

echo "${CYAN}Creating directories to store data...${NC}"
if [ ! -d ${WP_DATA_PATH} ]
	then mkdir -p ${WP_DATA_PATH}
	else echo "${YELLOW}Wordpress data directory was already created!${NC}"
fi

if [ ! -d ${MDB_DATA_PATH} ]
	then mkdir -p ${MDB_DATA_PATH}
	else echo "${YELLOW}Mariadb data directory was already created!${NC}"
fi

echo "${CYAN}Creating .env file...${NC}"

if [ ! -f ${ENV_PATH} ]
then
	c++ -Wall -Wextra -Werror srcs/requirements/tools/main.cpp srcs/requirements/tools/EnvFileGenerator.cpp
	./a.out $2
	rm a.out
	mv .env ${ENV_PATH}

	if [ ! -f ${ENV_PATH} ]
	then
		echo "${RED}ERROR: Could not create .env file!${NC}"
		exit 1
	else
		echo "${GREEN}.env file created successfully!${NC}"
	fi
else
	echo "${YELLOW}.env file was already created!${NC}"
fi