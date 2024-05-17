# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_mariadb.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:57:53 by aaugu             #+#    #+#              #
#    Updated: 2024/05/13 21:58:51 by aaugu            ###   ########.fr        #
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
sleep 10	# Wait for mariadb to start

mysql -u root -p ${MDB_ROOT_PASS} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MDB_ROOT_PASS}';"
mysql -u root -p ${MDB_ROOT_PASS} -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -u root -p ${MDB_ROOT_PASS} -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_USER_PASS}';"
mysql -u root -p ${MDB_ROOT_PASS} -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}' IDENTIFIED BY '${DB_USER_PASS}';"
mysql -u root -p ${MDB_ROOT_PASS} -e "FLUSH PRIVILEGES";


# Show the databases
echo "------------------\n"
mysql -u root -p${MDB_ROOT_PASS} -e "SHOW DATABASES;"
echo "------------------\n"
mysql -u root -p${MDB_ROOT_PASS} -e "SELECT User FROM mysql.user"
echo "------------------\n"

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

mysql ${DB_NAME} -u${DB_ROOT} -p${DB_ROOT_PASS}
mysqladmin -u${DB_ROOT} -p${DB_ROOT_PASS} shutdown

exec mysqld --user=mysql --datadir=/var/lib/mysql