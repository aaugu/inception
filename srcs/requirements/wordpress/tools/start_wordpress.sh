# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_wordpress.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42lausanne.ch>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:02:35 by aaugu             #+#    #+#              #
#    Updated: 2024/05/28 11:33:37 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo "------------------------------- WORDPRESS START -----------------------------------"

php-fpm7.4 -v

# Wait for mariadb to start
while ! mariadb -u $MARIADB_USER --password=$MARIADB_PASS -h mariadb -P 3306 --silent; do
	sleep 1
	echo "Mariadb is not ready yet."
done

echo "------------------\n"
mariadb -u $MARIADB_USER --password=$MARIADB_PASS -h mariadb -P 3306 -e "SHOW DATABASES;"
echo "------------------\n"

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

	# Configuration de wordpress : connection a la base de donnees et creation des users de wordpress
	# Connect to database
	wp config create --dbname=$MARIADB_DB_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASS --dbhost=$WP_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	# Admin config
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	# Create user
	wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root

fi

# Start php-fpm in the foreground
php-fpm7.4 -F