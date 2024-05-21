CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

WP_DATA_PATH="/home/aaugu/data/wordpress"
MDB_DATA_PATH="/home/aaugu/data/mariadb"

echo "---------- PREPARING DOCKER TO START... ----------"

echo "Creating directories to store data..."
if [ ! -d $WP_DATA_PATH ]
	then mkdir -p ${WP_DATA_PATH}
fi

if [ ! -d $MDB_DATA_PATH ]
	then mkdir -p $MDB_DATA_PATH
fi

echo "Creating .env file..."

if [ ! -f ../.env ]
then	
	if [ "$#" -eq 0 ]
	then
		echo "${RED}ERROR: Path to secrets missing !${NC}"
		exit 1
	else
		c++ -Wall -Wextra -Werror srcs/requirements/tools/main.cpp
		./a.out $1
		rm ./a.out
		if [ ! -f ../.env ]
		then
			echo "${RED}ERROR: Could not create .env file!${NC}"
			exit 1
		else
			echo "${GREEN}.env file created successfully!${NC}"
		fi
	fi
fi