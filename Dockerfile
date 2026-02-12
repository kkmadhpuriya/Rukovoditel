FROM php:8.2-apache

ENV SERVER_NAME=localhost

# Enable Apache rewrite and headers modules
RUN a2enmod rewrite headers

# Set global ServerName to remove warning
RUN echo "ServerName ${SERVER_NAME}" >> /etc/apache2/apache2.conf

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \    
    && rm -rf /var/lib/apt/lists/*

# Configure GD library
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql gd zip

# Set Apache Document Root to /var/www/html (Rukovoditel runs in root, not /public)
ENV APACHE_DOCUMENT_ROOT=/var/www/html

# Configure Apache
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/sites-available/*.conf \
    /etc/apache2/apache2.conf \
    /etc/apache2/conf-available/*.conf

# Enable .htaccess files
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' \
    /etc/apache2/apache2.conf

# Copy application code
COPY . /var/www/html/

# Create necessary directories
RUN mkdir -p /var/www/html/uploads \
    /var/www/html/uploads/attachments \
    /var/www/html/uploads/attachments_preview \
    /var/www/html/uploads/images \
    /var/www/html/uploads/users \
    /var/www/html/uploads/mail \
    /var/www/html/uploads/templates \
    /var/www/html/uploads/onlyoffice \
    /var/www/html/uploads/file_storage \
    /var/www/html/backups \
    /var/www/html/backups/auto \
    /var/www/html/tmp \
    /var/www/html/cache \
    /var/www/html/log

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/uploads \
    && chmod -R 777 /var/www/html/backups \
    && chmod -R 777 /var/www/html/tmp \
    && chmod -R 777 /var/www/html/cache \
    && chmod -R 777 /var/www/html/log

# Declare volumes for persistence
VOLUME /var/www/html

WORKDIR /var/www/html

EXPOSE 80

# # Add healthcheck
# HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
#     CMD curl -f http://localhost/ || exit 1
