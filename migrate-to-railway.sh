#!/bin/bash

# ================================================================
# Railway Database Migration Script
# ================================================================
# Este script te ayuda a migrar tu base de datos a Railway

echo "🚀 Iniciando migración de BD a Railway..."
echo ""

# ================================================================
# OPCIÓN 1: SOLO EJECUTAR MIGRACIONES (Recomendado si es primera vez)
# ================================================================

echo "📋 OPCIÓN 1: Ejecutar migraciones en Railway (Recomendado)"
echo "Esto creará todas las tablas desde cero basado en tus migraciones."
echo ""
echo "Pasos:"
echo "1. Ve a tu proyecto en Railway → Tu servicio PHP"
echo "2. Click en 'Console' o usa Railway CLI"
echo "3. Ejecuta:"
echo ""
echo "   php artisan migrate --force"
echo ""
echo "4. Esto creará automáticamente:"
echo "   ✓ Tabla users"
echo "   ✓ Tabla libros"
echo "   ✓ Tabla comics"
echo "   ✓ Tabla mangas"
echo "   ✓ Tabla audiobooks"
echo "   ✓ Y todas las demás tablas definidas en tus migraciones"
echo ""
read -p "¿Deseas continuar? (s/n): " continuar1

if [ "$continuar1" = "s" ]; then
    echo "✅ Debes ejecutar esto en Railway Console o con Railway CLI"
    exit 0
fi

# ================================================================
# OPCIÓN 2: EXPORTAR Y RESTAURAR DATOS (Si quieres mantener datos)
# ================================================================

echo ""
echo "📊 OPCIÓN 2: Exportar datos locales e importar en Railway"
echo "Esto migra los datos existentes de tu SQLite local."
echo ""

# Verificar si SQLite existe
if [ ! -f "database/database.sqlite" ]; then
    echo "❌ No se encontró database/database.sqlite"
    echo "   Asegúrate de ejecutar primero: php artisan migrate"
    exit 1
fi

echo "✅ Encontrada base de datos SQLite local"
echo ""

# Crear archivo SQL de backup
if [ ! -d "backups" ]; then
    mkdir backups
fi

BACKUP_FILE="backups/bookheaven_backup_$(date +%Y%m%d_%H%M%S).sql"

echo "💾 Exportando datos a: $BACKUP_FILE"
echo ""

# Opciones para exportar de SQLite
echo "Elige método de exportación:"
echo "1) sqlite3 (línea de comando)"
echo "2) Laravel Voyager (si tienes instalado)"
echo "3) Generar SQL manualmente"
echo ""
read -p "Opción (1-3): " option

if [ "$option" = "1" ]; then
    # Usar sqlite3
    if ! command -v sqlite3 &> /dev/null; then
        echo "❌ sqlite3 no está instalado. Instálalo primero:"
        echo "   Windows: choco install sqlite"
        echo "   macOS: brew install sqlite"
        echo "   Linux: apt-get install sqlite3"
        exit 1
    fi
    
    echo ""
    echo "Generando SQL..."
    sqlite3 database/database.sqlite ".dump" > "$BACKUP_FILE"
    echo "✅ Backup creado: $BACKUP_FILE"
    
elif [ "$option" = "2" ]; then
    echo "Usa Laravel Voyager o phpMyAdmin para este paso"
    exit 1
else
    echo "Opción no válida"
    exit 1
fi

echo ""
echo "📤 Próximos pasos para restaurar en Railway:"
echo ""
echo "1. Ve a Railway Dashboard"
echo "2. Abre Console → Tu servicio MySQL"
echo "3. Copia la conexión de acceso a MySQL:"
echo ""
echo "   mysql -h [DB_HOST] -u [DB_USERNAME] -p"
echo ""
echo "4. Una vez conectado a MySQL, ejecuta:"
echo ""
echo "   source /ruta/al/$BACKUP_FILE"
echo ""
echo "O usa Railway CLI:"
echo ""
echo "   npm install -g @railway/cli"
echo "   railway login"
echo "   railway connect mysql < $BACKUP_FILE"
echo ""

read -p "¿Ya restauraste los datos en Railway? (s/n): " restored

if [ "$restored" = "s" ]; then
    echo "✅ Migración completada!"
    echo ""
    echo "Para verificar:"
    echo "1. Ve al tu aplicación en Railway"
    echo "2. Intenta loguearte o acceder a datos"
    echo "3. Si todo funciona, ¡listo!"
else
    echo ""
    echo "📝 Guarda este archivo para referencia:"
    echo "   $BACKUP_FILE"
    echo ""
    echo "Cuando estés listo, restaura el archivo en Railway siguiendo los pasos anteriores"
fi
