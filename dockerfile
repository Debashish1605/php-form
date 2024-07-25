FROM php:8.1-apache

RUN docker-php-ext-install mysqli

RUN a2enmod rewrite

WORKDIR /var/www/html

COPY index.html .
COPY submit.php .

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD [ "apache2-foreground" ]

