FROM clearlinux/php-fpm

ARG USER_ID
ARG GROUP_ID

VOLUME /var/www

RUN swupd bundle-add php-extras unzip \
    && rm -rf /var/lib/swupd/*

COPY ./php.ini /etc/php.d/php.ini

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && mkdir  -p  /usr/local/bin \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"
# COPY docker-entrypoint.sh /usr/local/bin/
# ENTRYPOINT ["docker-entrypoint.sh"]
RUN useradd -u ${USER_ID} laravel
EXPOSE 9000
CMD ["php-fpm"]




