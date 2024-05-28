# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_mariadb.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:57:53 by aaugu             #+#    #+#              #
#    Updated: 2024/05/28 11:28:14 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo "---------- STARTING MARIADB... ----------"

# Init the database
mysqld --initialize --user=mysql --datadir=/var/lib/mysql;

chown -R mysql:mysql /var/lib/mysql;
chown -R mysql:mysql /run/mysqld;

# Launch mariadb
mysqld --user=mysql --datadir=/var/lib/mysql &

# $! is the process id of the last command
pid=$!

# Wait for mariadb to start
sleep 3

# Setup the database
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DB_NAME};"
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}' IDENTIFIED BY '${MARIADB_PASS}';"
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}';"
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Show the databases
echo "------------------\n"
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "SHOW DATABASES;"
echo "------------------\n"
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "SELECT User FROM mysql.user"
echo "------------------\n"

# Kill the process mysqld
kill "$pid"

# Restart mariadb to replace the previous killed process
exec mysqld --user=mysql --datadir=/var/lib/mysql