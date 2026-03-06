web: vendor/bin/heroku-php-apache2 public/ -F fpm_config.ini
release: php artisan migrate --force && php artisan cache:clear && php artisan config:cache && php artisan route:cache
queue: php artisan queue:work --sleep=3 --tries=3 --max-time=3600
