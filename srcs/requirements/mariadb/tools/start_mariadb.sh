# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_mariadb.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:57:53 by aaugu             #+#    #+#              #
#    Updated: 2024/05/22 20:17:19 by aaugu            ###   ########.fr        #
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
sleep 10 	# Wait for mariadb to start

mysql --user=root --password=${MDB_ROOT_PASS} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MDB_ROOT_PASS}';"
mysql --user=root --password=${MDB_ROOT_PASS} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql --user=root --password=${MDB_ROOT_PASS} -e "CREATE USER IF NOT EXISTS '${MDB_USER}'@'localhost' IDENTIFIED BY '${MDB_USER_PASS}';"
mysql --user=root --password=${MDB_ROOT_PASS} -e "GRANT ALL PRIVILEGES ON *.* TO '${MDB_USER}'@'localhost' IDENTIFIED BY '${MDB_USER_PASS}';"
mysql --user=root --password=${MDB_ROOT_PASS} -e "FLUSH PRIVILEGES;"

# Show databases and user
echo "------------------\n"
mysql --user=${MDB_USER} --password=${MDB_USER_PASS} -e "SHOW DATABASES;"
echo "------------------\n"
mysql --user=${MDB_USER} --password=${MDB_USER_PASS} -e "SELECT User, Host FROM mysql.user;"
echo "------------------\n"

kill "$pid"

exec mysqld --user=mysql --datadir=/var/lib/mysql