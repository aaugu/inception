CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

ENV_PATH="srcs/.env"
SECRETS_PATH="./secrets"
LOGIN="aaugu"

echo "-------------------- PREPARING DOCKER TO START... --------------------"

echo "${CYAN}Exporting variables...${NC}"
if [ $(uname -s) == 'Darwin']; then
	HOME="/Users/${LOGIN}"
	export STUDENT_DOMAIN = localhost
else
	HOME="/home/${LOGIN}"
	export STUDENT_DOMAIN = ${LOGIN}.42.fr
endif

export WP_DATA_PATH := ${HOME}/data/wordpress
export MDB_DATA_PATH := ${HOME}/data/mariadb

echo "${CYAN}Checking .env file...${NC}"
if [ ! -f ${ENV_PATH} ]; then
	echo "${RED}.env file is missing!${NC}"
	exit 1
else
	echo "${GREEN}.env file successfully found${NC}"
fi

echo "${CYAN}Creating directories to store data...${NC}"
if [ ! -d ${WP_DATA_PATH} ]
then
	mkdir -p ${WP_DATA_PATH}
	if [ ! -d ${WP_DATA_PATH} ]
	then
		echo "${RED}ERROR: Could not create Wordpress data directory!${NC}"
		exit 1
	else
		echo "${GREEN}Wordpress data directory created!${NC}"
	fi
else
	echo "${YELLOW}Wordpress data directory was already created!${NC}"
fi

if [ ! -d ${MDB_DATA_PATH} ]
then
	mkdir -p ${MDB_DATA_PATH}
	if [ ! -d ${WP_DATA_PATH} ]
	then
		echo "${RED}ERROR: Could not create Mariadb data directory!${NC}"
		exit 1
	else
		echo "${GREEN}Mariadb data directory created!${NC}"
	fi
else
	echo "${YELLOW}Mariadb data directory was already created!${NC}"
fi