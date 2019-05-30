FROM php:7.1-fpm-alpine

MAINTAINER Duan Le <duanvnc@gmail.com>

RUN apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        libmcrypt-dev \
        libtool \
        libxml2-dev \
        postgresql-dev \
        sqlite-dev \
    && apk add --no-cache \
        curl \
        git \
        libmcrypt \
        mysql-client \
        postgresql-libs \
        libintl \
        icu \
        icu-dev \
    && docker-php-ext-install \
        curl \
        iconv \
        mbstring \
        mcrypt \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        pdo_sqlite \
        pcntl \
        tokenizer \
        xml \
        zip \
        intl \
    && curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
    && apk del -f .build-deps

RUN chown -R www-data:www-data /var/www/

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
