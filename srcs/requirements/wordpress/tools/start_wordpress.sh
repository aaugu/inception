# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_wordpress.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaugu <aaugu@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/30 11:02:35 by aaugu             #+#    #+#              #
#    Updated: 2024/05/21 14:53:30 by aaugu            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo "------------------------------- WORDPRESS START -----------------------------------"

php-fpm8.0 -v

# Wait for mariadb to start
while ! mariadb -u ${MDB_USER} --password=${MDB_PASS} -h mariadb -P 3306 --silent; do
	sleep 1
	echo "Mariadb is not ready yet"
done

# Display database
echo "-------------------------------\n"
mariadb -u ${MDB_USER} --password=${MDB_PASS} -h mariadb -P 3306 -e "SHOW DATABASES;"
echo "-------------------------------\n"

# ---------- WP Config ----------
# Connect to database
wp config create --dbname=${DB_NAME} --dbuser=${MDB_USER} --dbpass=${MDB_PASS} --dbhost=${WP_HOST} --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
# Admin config
wp core install --url=${NGINX_HOST} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASS} --admin_email=${WP_ADMIN_MAIL} --skip-email --allow-root
# User creation
wp user create ${WP_USER} ${WP_USER_MAIL} --role=author --user_pass=${WP_USER_PASS} --allow-root

# Start php-fpm in the foreground
php-fpm8.0 -F