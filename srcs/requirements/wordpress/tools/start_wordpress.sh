# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_wordpress.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:02:35 by aaugu             #+#    #+#              #
#    Updated: 2024/05/23 14:00:33 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo "------------------------------- WORDPRESS START -----------------------------------"

php-fpm7.4 -v

# Wait for mariadb to start
while ! mariadb -u $MDB_USER --password=$MDB_PASS -h mariadb -P 3306 --silent; do
	sleep 1
	echo "Mariadb is not ready yet"
done

# Display database
echo "-------------------------------\n"
mariadb -u $MDB_USER --password=$MDB_PASS -h mariadb -P 3306 -e "SHOW DATABASES;"
echo "-------------------------------\n"

# Check if wordpress is already installed
if [ -e /var/www/wordpress/wp-config.php ]
then echo "wp-config already exists."
else
	
	# get wp-cli
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp	

	# Download wordpress
	cd /var/www/wordpress
	wp core download --allow-root

	# ---------- WP Config ----------
	# Connect to database
	wp config create --dbname=${DB_NAME} --dbuser=${MDB_USER} --dbpass=${MDB_USER_PASS} --dbhost=${WP_HOST} --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	# Admin config
	wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASS} --admin_email=${WP_ADMIN_MAIL} --skip-email --allow-root
	# User creation
	wp user create ${WP_USER} ${WP_USER_MAIL} --role=author --user_pass=${WP_USER_PASS} --allow-root

fi

# Start php-fpm in the foreground
php-fpm7.4 -F