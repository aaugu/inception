# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_mariadb.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:57:53 by aaugu             #+#    #+#              #
#    Updated: 2024/05/27 12:11:54 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo "---------- STARTING MARIADB... ----------"

# Init the database
mysqld --initialize --user=mysql --datadir=/var/lib/mysql;

chown -R mysql:mysql /var/lib/mysql;
chown -R mysql:mysql /run/mysqld;

# Launch mariadb
mysqld --user=mysql --datadir=/var/lib/mysql &	

pid=$!		# $! is the process id of the last command
sleep 5 	# Wait for mariadb to start

mysql -u root -p${MDB_ROOT_PASS} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MDB_ROOT_PASS}';"
mysql -u root -p${MDB_ROOT_PASS} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql -u root -p${MDB_ROOT_PASS} -e "CREATE USER IF NOT EXISTS '${MDB_USER}' IDENTIFIED BY '${MDB_USER_PASS}';"
mysql -u root -p${MDB_ROOT_PASS} -e "GRANT ALL PRIVILEGES ON *.* TO '${MDB_USER}';"
mysql -u root -p${MDB_ROOT_PASS} -e "FLUSH PRIVILEGES;"

# Show databases and user
echo "------------------\n"
mysql -u root -p${MDB_ROOT_PASS} -e "SHOW DATABASES;"
echo "------------------\n"
mysql -u root -p${MDB_USER_PASS} -e "SELECT User, Host FROM mysql.user;"
echo "------------------\n"

kill "$pid"

exec mysqld --user=mysql --datadir=/var/lib/mysql