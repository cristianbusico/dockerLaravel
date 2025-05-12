FROM php:8.3-fpm

RUN if [ -n "$HTTP_PROXY" ]; then pear config-set http_proxy $HTTP_PROXY; fi

RUN pecl install redis-5.3.7 \
    && docker-php-ext-enable redis

RUN pecl install xdebug-3.4.1 \
    && docker-php-ext-enable xdebug

RUN docker-php-ext-install mysqli exif pdo pdo_mysql

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
    		libfreetype6-dev \
    		libjpeg-dev \
    		libpng-dev \
            libwebp-dev \
    		libpq-dev \
    		libzip-dev \
    		libsqlite3-dev \
    	; \
    	\
    	docker-php-ext-configure gd \
    		--with-freetype \
    		--with-jpeg=/usr \
            --with-webp \
    	; \
    \
    docker-php-ext-install -j "$(nproc)" gd ;\
    docker-php-ext-install zip pdo_sqlite

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN rm -f /usr/local/etc/php/php.ini
RUN rm -f /usr/local/etc/php-fpm.d/www.conf
RUN rm -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN echo 'it_IT.UTF-8 UTF-8' >> /etc/locale.gen
RUN apt-get install -y locales;
#RUN echo 'LANG="it_IT.UTF8"' >> /etc/default/locale
ENV LANG it_IT.UTF8

