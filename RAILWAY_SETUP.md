# 🚀 Railway Setup Guide - Book Heaven Backend

Esta guía te ayudará a desplegar el backend de Book Heaven en Railway.

## Prerequisitos

- Cuenta en [Railway.app](https://railway.app)
- Git instalado localmente
- CLI de Railway (opcional pero recomendado)

## Paso 1: Preparación en GitHub

El proyecto debe estar en GitHub con los siguientes archivos (ya incluidos):
- `Procfile` - Define los procesos a ejecutar
- `railway.json` - Configuración de Railway
- `.env.example` - Ejemplo de variables de entorno
- `fpm_config.ini` - Configuración de PHP-FPM

## Paso 2: Crear Proyecto en Railway

1. Ve a [Railway.app](https://railway.app) e inicia sesión
2. Haz clic en **"New Project"**
3. Selecciona **"Deploy from GitHub"**
4. Conecta tu cuenta de GitHub y selecciona el repositorio `Book-Heaven`
5. Selecciona el directorio `backend/` como raíz del proyecto

## Paso 3: Configurar Servicios

### A. Agregar MySQL Database

1. En tu proyecto Railway, haz clic en **"Add Service"**
2. Selecciona **"MySQL"**
3. Railway generará automáticamente las variables:
   - `DB_HOST`
   - `DB_PORT`
   - `DB_USERNAME`
   - `DB_PASSWORD`
   - `DB_NAME`

### B. Agregar Redis (Opcional pero Recomendado)

1. Haz clic en **"Add Service"**
2. Selecciona **"Redis"**
3. Se generarán automáticamente:
   - `REDIS_HOST`
   - `REDIS_PORT`
   - `REDIS_PASSWORD` (si aplica)

## Paso 4: Configurar Variables de Entorno

En la sección **Variables** de tu servicio PHP en Railway, agrega:

### Variables Obligatorias
```
APP_NAME=Book Heaven
APP_ENV=production
APP_DEBUG=false
APP_TIMEZONE=America/La_Paz

# Railway generará estas automáticamente si usas sus servicios
# DB_CONNECTION=mysql
# DB_HOST=xxx
# DB_PORT=3306
# DB_DATABASE=xxx
# DB_USERNAME=xxx
# DB_PASSWORD=xxx

LOG_LEVEL=error
LOG_CHANNEL=stack

CACHE_STORE=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
BROADCAST_CONNECTION=redis

FILESYSTEM_DISK=local
```

### Variables Recomendadas
```
SANCTUM_STATEFUL_DOMAINS=tu-dominio.railway.app
SANCTUM_ALLOWED_ORIGINS=https://tu-frontend-domain.railway.app
FRONTEND_URL=https://tu-frontend-domain.railway.app

MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io (o tu proveedor)
MAIL_PORT=465
MAIL_USERNAME=xxx
MAIL_PASSWORD=xxx
```

### Conseguir APP_KEY

Si no tienes un `APP_KEY`, genera uno localmente y cópialo:

```bash
php artisan key:generate --show
```

Copia el valor y agrégalo como variable `APP_KEY` en Railway.

## Paso 5: Despliegue Automático

1. Railway automáticamente detectará el `Procfile`
2. Ejecutará los comandos en este orden:
   - **Build**: `composer install --optimize-autoloader --no-dev`
   - **Release**: Migraciones y cachés
   - **Web**: Servidor PHP-Apache
   - **Queue** (opcional): Worker de colas

## Paso 6: Verificar Despliegue

1. Ve a la pestaña **Deployment** en Railway
2. Espera a que el deployment se complete (muestra un ✓)
3. Abre la URL del dominio en **Railway.app** > **Settings** > **Domains**

## Estructura de Procesos

El `Procfile` define tres procesos:

### Web (Principal)
```bash
web: vendor/bin/heroku-php-apache2 public/ -F fpm_config.ini
```
- Sirve la aplicación PHP con Apache

### Release (Una sola vez al desplegar)
```bash
release: php artisan migrate --force && php artisan cache:clear && ...
```
- Ejecuta migraciones de base de datos
- Cachea rutas, configuración y vistas

### Queue (Procesos en Background)
```bash
queue: php artisan queue:work --sleep=3 --tries=3 --max-time=3600
```
- Procesa jobs en la cola
- Reintentos automáticos

## Configuración de Dominio Personalizado

1. En Railway > Settings > Domains
2. Agrega tu dominio personalizado (ej: `api.bookheaven.com`)
3. Apunta tu DNS al dominio de Railway

## Troubleshooting

### Error de Base de Datos
- Verifica que MySQL esté agregado como servicio
- Revisa que `DB_HOST`, `DB_PORT`, etc. estén correctamente asignados
- Intenta manualmente: `php artisan migrate --force`

### Error de Cache/Redis
- Si no tienes Redis, cambia `CACHE_STORE` a `database`
- Cambia `SESSION_DRIVER` a `database`
- Las colas funcionarán con `QUEUE_CONNECTION=database`

### Error de Compilación
- Revisa los logs en Railway dashboard
- Asegúrate de que `composer.json` y `package.json` sean válidos
- Verifica que `Procfile` esté en el directorio raíz

### Error de Permisos
- Railway maneja permisos automáticamente
- Si hay error de almacenamiento, revisa permisos en `storage/`

## Optimizaciones Incluidas

✅ **Procfile optimizado** - Define procesos eficientes
✅ **PHP-FPM Config** - OPcache habilitado y optimizado
✅ **Railway.json** - Configuración automática con Nixpacks
✅ **.env.railway** - Ejemplo de variables para producción
✅ **Migraciones automáticas** - Se ejecutan en cada deploy
✅ **Cache de configuración** - Mejora de rendimiento
✅ **Compresión delta** - Deploys más rápidos

## Monitoreo

En Railway puedes ver:
- **Metrics**: CPU, Memoria, Requests
- **Logs**: Errores y eventos de aplicación
- **Status**: Estado del despliegue
- **Network**: Configuración de dominio

## Variables de Entorno Importantes

| Variable | Valor Production | Notas |
|----------|----------------|-------|
| APP_ENV | production | Nunca usar development/local |
| APP_DEBUG | false | SIEMPRE false en producción |
| LOG_LEVEL | error o notice | Para no llenar los logs |
| CACHE_STORE | redis | Para mejor rendimiento |
| SESSION_DRIVER | redis | Sesiones en memoria distribuida |

## Recursos

- [Documentación de Railway](https://docs.railway.app)
- [Laravel en Railway](https://docs.railway.app/guides/laravel)
- [PHP Buildpack](https://github.com/railwayapp/nixpacks/blob/main/docs/php.md)

## Soporte

Si encuentras problemas:
1. Revisa los logs en Railway dashboard
2. Verifica las variables de entorno
3. Comprueba que los servicios (MySQL, Redis) estén activos
4. Intenta desplegar nuevamente

---

**¡Listo! Tu backend de Book Heaven está ahora en Railway! 🎉**
