#!/bin/bash
# Railway Validation Script
# Verifica que todo esté configurado correctamente para Railway

echo "🔍 Validando configuración de Railway..."
echo ""

# Check PHP version
echo "✓ Verificando versión de PHP..."
if command -v php &> /dev/null; then
    php --version | head -n 1
else
    echo "❌ PHP no está instalado"
    exit 1
fi

# Check Procfile exists
echo ""
echo "✓ Verificando Procfile..."
if [ -f "Procfile" ]; then
    echo "✅ Procfile encontrado"
    cat Procfile
else
    echo "❌ Procfile no encontrado"
    exit 1
fi

# Check railway.json exists
echo ""
echo "✓ Verificando railway.json..."
if [ -f "railway.json" ]; then
    echo "✅ railway.json encontrado"
else
    echo "❌ railway.json no encontrado"
    exit 1
fi

# Check composer.json
echo ""
echo "✓ Verificando composer.json..."
if [ -f "composer.json" ]; then
    echo "✅ composer.json encontrado"
    # Show PHP version requirement
    grep '"php"' composer.json
else
    echo "❌ composer.json no encontrado"
    exit 1
fi

# Check .env.example
echo ""
echo "✓ Verificando .env.example..."
if [ -f ".env.example" ]; then
    echo "✅ .env.example encontrado"
else
    echo "❌ .env.example no encontrado"
    exit 1
fi

# Check for required directories
echo ""
echo "✓ Verificando estructura de directorios..."
required_dirs=("app" "bootstrap" "config" "database" "public" "routes" "storage")
for dir in "${required_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "✅ Directorio $dir encontrado"
    else
        echo "❌ Directorio $dir no encontrado"
        exit 1
    fi
done

# Validate PHP syntax
echo ""
echo "✓ Validando sintaxis de PHP..."
for file in $(find app -name "*.php" -type f | head -5); do
    if php -l "$file" 2>&1 | grep -q "No syntax errors"; then
        echo "✅ $file - OK"
    else
        echo "⚠️  $file - Error en sintaxis"
    fi
done

# Check database drivers
echo ""
echo "✓ Verificando configuración de base de datos..."
if grep -q "DB_CONNECTION" .env.example; then
    echo "✅ Configuración de base de datos presente"
fi

# Check cache configuration
echo ""
echo "✓ Verificando configuración de caché..."
if grep -q "CACHE_STORE" .env.example; then
    echo "✅ Configuración de caché presente"
fi

echo ""
echo "=========================================="
echo "✅ Validación completada exitosamente!"
echo "=========================================="
echo ""
echo "Próximos pasos:"
echo "1. Ejecutar: git add . && git commit -m 'Add Railway deployment files'"
echo "2. Ejecutar: git push origin main"
echo "3. Ir a https://railway.app y conectar tu repositorio"
echo "4. Seguir la guía en RAILWAY_SETUP.md"
