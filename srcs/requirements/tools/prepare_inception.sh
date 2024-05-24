CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

WP_DATA_PATH="/home/aaugu/data/wordpress"
MDB_DATA_PATH="/home/aaugu/data/mariadb"
ENV_PATH="srcs/.env"
SECRETS_PATH="./secrets"

echo "-------------------- PREPARING DOCKER TO START... --------------------"

if [ "$#" -eq 0 ] || [ "$#" -eq 1 ]; then
	echo "${RED}ERROR: Path to secrets directory or .env file missing !${NC}"
	echo "${RED}Usage: make secrets=<path_to_secrets_directory> env=<path_to_env_file>${NC}"
	exit 1
fi

echo "${CYAN}Preparing secrets ...${NC}"
if [ ! -d ${SECRETS_PATH} ]; then
	cp -r $1 .
	if [ ! -d ${SECRETS_PATH} ]; then
		echo "${RED}Secrets directory is missing!${NC}"
		exit 1
	else
		echo "${GREEN}Secrets directory successfully imported${NC}"
	fi
else
	echo "${GREEN}Secrets directory successfully found${NC}"
fi

echo "${CYAN}Preparing env ...${NC}"

if [ ! -f ${ENV_PATH} ]; then
	cp $2 ${ENV_PATH}
	if [ ! -f ${ENV_PATH} ]; then
		echo "${RED}.env file is missing!${NC}"
		exit 1
	else
		echo "${GREEN}.env file successfully imported${NC}"
	fi
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