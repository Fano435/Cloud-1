FROM wordpress:fpm

COPY ./wp_config.sh /usr/local/bin/wp_config.sh

CMD ["sh", "-c", "chmod +x /usr/local/bin/wp_config.sh && /usr/local/bin/wp_config.sh"]