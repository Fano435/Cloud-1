#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress/

sleep 10

php -d memory_limit=512M /usr/local/bin/wp core download --locale=fr_FR --allow-root
wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --locale="fr_FR" --allow-root

wp core install --url="https://$DOMAIN_NAME" --title=Blog --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role=author --allow-root

wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root
wp config set WP_CACHE true --allow-root

wp language core install fr_FR --allow-root
wp language core activate fr_FR --allow-root

wp plugin install redis-cache --activate --allow-root
wp redis enable --allow-root
mkdir -p /run/redis
chmod +x /run/redis

php-fpm -F