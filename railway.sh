#!/bin/bash

# Railway Deployment Script

echo "🚀 Starting Railway deployment..."

# Load environment
export DB_CONNECTION=${DB_CONNECTION:-mysql}
export CACHE_STORE=${CACHE_STORE:-redis}
export SESSION_DRIVER=${SESSION_DRIVER:-redis}
export QUEUE_CONNECTION=${QUEUE_CONNECTION:-redis}

echo "📦 Installing PHP dependencies..."
composer install --optimize-autoloader --no-dev

echo "🗄️  Running migrations..."
php artisan migrate --force

echo "💾 Caching configuration..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "🧹 Clearing caches..."
php artisan cache:clear

echo "✅ Deployment complete!"
