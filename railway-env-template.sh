#!/bin/bash
# Railway Environment Variables Template
# Copy and paste these into Railway dashboard

# ========== APPLICATION SETTINGS ==========
APP_NAME=Book Heaven
APP_ENV=production
APP_DEBUG=false
APP_TIMEZONE=America/La_Paz
APP_LOCALE=es
APP_FALLBACK_LOCALE=es

# ========== KEY & URL ==========
# Generate with: php artisan key:generate --show
APP_KEY=paste_generated_key_here
APP_URL=https://your-app.railway.app

# ========== DATABASE (Auto-provided by Railway MySQL Service) ==========
# These will be automatically set when you add MySQL service
# Uncomment and update only if NOT using Railway's MySQL service
# DB_CONNECTION=mysql
# DB_HOST=your-host.railway.app
# DB_PORT=3306
# DB_DATABASE=railway
# DB_USERNAME=root
# DB_PASSWORD=generated_password

# ========== CACHE & SESSION (Redis recommended) ==========
CACHE_STORE=redis
CACHE_PREFIX=bh_
SESSION_DRIVER=redis
SESSION_LIFETIME=120
BROADCAST_CONNECTION=redis
QUEUE_CONNECTION=redis

# ========== REDIS (Auto-provided by Railway Redis Service) ==========
# These will be automatically set when you add Redis service
# Or keep defaults for Railway's Redis
# REDIS_HOST=redis.railway.app
# REDIS_PORT=6379
# REDIS_PASSWORD=generated_password

# ========== LOGGING ==========
LOG_CHANNEL=stack
LOG_LEVEL=critical
LOG_DEPRECATIONS_CHANNEL=null

# ========== FILE STORAGE ==========
FILESYSTEM_DISK=local
FILESYSTEM_VISIBILITY=private

# ========== SANCTUM AUTHENTICATION ==========
# Update with your frontend URL
SANCTUM_STATEFUL_DOMAINS=api.bookheaven.com
SANCTUM_ALLOWED_ORIGINS=https://bookheaven.com

# ========== CORS & FRONTEND ==========
# Frontend URL for CORS
FRONTEND_URL=https://bookheaven.com

# ========== MAIL CONFIGURATION ==========
# Choose your mail provider and configure
MAIL_MAILER=smtp
MAIL_SCHEME=tls
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=465
MAIL_USERNAME=your_username
MAIL_PASSWORD=your_password
MAIL_FROM_ADDRESS=noreply@bookheaven.com
MAIL_FROM_NAME="Book Heaven"

# ========== AWS S3 (Optional) ==========
# Only if you're using S3 for file storage
# AWS_ACCESS_KEY_ID=your_key
# AWS_SECRET_ACCESS_KEY=your_secret
# AWS_DEFAULT_REGION=us-east-1
# AWS_BUCKET=your_bucket
# AWS_USE_PATH_STYLE_ENDPOINT=false

# ========== VITE ==========
VITE_APP_NAME="Book Heaven"
VITE_API_URL=https://api.bookheaven.com

# ========== ADDITIONAL PRODUCTION OPTIMIZATIONS ==========
BCRYPT_ROUNDS=12
PHP_CLI_SERVER_WORKERS=4
