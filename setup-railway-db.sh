#!/bin/bash

# ================================================================
# Railway Database Setup - Opción Rápida
# ================================================================
# Este script automatiza la migración a Railway

set -e

DB_HOST=${1:-localhost}
DB_PORT=${2:-3306}
DB_USER=${3:-root}
DB_PASS=${4:-}
DB_NAME=${5:-bookheaven}

echo "🔧 Configurando base de datos en Railway..."
echo ""
echo "Parámetros:"
echo "  Host: $DB_HOST"
echo "  Puerto: $DB_PORT"
echo "  Usuario: $DB_USER"
echo "  Base de datos: $DB_NAME"
echo ""

# Verificar conexión
echo "🔗 Verificando conexión a MySQL..."
if ! mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1;" > /dev/null 2>&1; then
    echo "❌ No se puede conectar a MySQL"
    echo "Verifica tus credenciales:"
    echo ""
    echo "En Railway Dashboard:"
    echo "1. MySQL Service → Variables"
    echo "2. Copia: DB_HOST, DB_PORT, DB_USERNAME, DB_PASSWORD"
    echo ""
    exit 1
fi

echo "✅ Conexión exitosa"
echo ""

# Crear base de datos si no existe
echo "📦 Creando base de datos..."
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
echo "✅ Base de datos lista"
echo ""

# Ejecutar migraciones
echo "🔄 Ejecutando migraciones de Laravel..."
APP_ENV=production DB_CONNECTION=mysql DB_HOST="$DB_HOST" DB_PORT="$DB_PORT" DB_USERNAME="$DB_USER" DB_PASSWORD="$DB_PASS" DB_DATABASE="$DB_NAME" php artisan migrate --force

echo ""
echo "✅ Migración completada!"
echo ""
echo "Próximos pasos:"
echo "1. Verifica en Railway que todo esté correcto"
echo "2. Accede a tu aplicación"
echo "3. Prueba que las tablas se crearon correctamente"
