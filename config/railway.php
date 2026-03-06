<?php
/**
 * Production Optimization Configuration for Railway
 * This file provides optimized settings for production deployment
 */

return [
    'enable_query_log' => false,
    'cache_routes' => true,
    'cache_config' => true,
    'cache_views' => true,
    'optimize_autoloader' => true,
    'force_https' => true,
    'database_pool_size' => 5,
    'redis_persistence' => true,
];
