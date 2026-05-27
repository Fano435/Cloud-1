FROM wordpress:fpm

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
    
COPY ./wp_config.sh /usr/local/bin/wp_config.sh

CMD ["sh", "-c", "chmod +x /usr/local/bin/wp_config.sh && /usr/local/bin/wp_config.sh"]