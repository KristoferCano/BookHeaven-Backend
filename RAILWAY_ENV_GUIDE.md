# 📋 Variables de Entorno para Railway - PASO A PASO

## Archivo: `.env.production`

Usa este archivo como referencia. **Copia cada variable a Railway Dashboard** → Tu Servicio PHP → **Variables**

---

## 🔑 Variables Obligatorias (DEBES COMPLETAR ESTAS)

### 1. **APP_KEY** (CRÍTICA)
**Dónde obtenerla:**
```bash
php artisan key:generate --show
```

**Cópialo y pégalo en Railway:**
```
APP_KEY=base64:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 2. **APP_URL** (Tu Dominio)
Railway te dará un dominio automático:
```
APP_URL=https://your-app-name.railway.app
```

O si tienes dominio personalizado:
```
APP_URL=https://api.bookheaven.com
```

---

## 🗄️ Variables de Base de Datos (AUTO-GENERADAS POR RAILWAY)

Cuando agregas **MySQL Service** en Railway, se generan automáticamente:

```
DB_CONNECTION=mysql
DB_HOST=xxxxx.railway.app
DB_PORT=3306
DB_DATABASE=railway
DB_USERNAME=root
DB_PASSWORD=xxxxxxxxxxxxxxxx
```

**Cómo obtenerlas:**
1. Ve a Railway Dashboard → MySQL Service
2. Click en **Variables**
3. Copia los valores y pégalos en tu servicio PHP → Variables

---

## 🔴 Variables de Redis (AUTO-GENERADAS POR RAILWAY)

Cuando agregas **Redis Service** en Railway:

```
REDIS_HOST=xxxxx.railway.app
REDIS_PORT=6379
REDIS_PASSWORD=xxxxxxxxxxxxxxxx
```

**Si no tienes Redis:**
- Cambia a `CACHE_STORE=database` y `SESSION_DRIVER=database`
- Las colas funcionarán con `QUEUE_CONNECTION=database`

---

## 📧 Variables de Email (CONFIGURA SEGÚN TU PROVEEDOR)

### Opción A: Gmail (Recomendado)
```
MAIL_MAILER=smtp
MAIL_SCHEME=tls
MAIL_HOST=smtp.gmail.com
MAIL_PORT=465
MAIL_USERNAME=tu-email@gmail.com
MAIL_PASSWORD=tu-app-password
MAIL_FROM_ADDRESS=noreply@bookheaven.com
MAIL_FROM_NAME=Book Heaven
```

**Cómo obtener App Password de Gmail:**
1. Ve a [myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)
2. Genera una contraseña para "Mail" → "Windows"
3. Usa esa contraseña en `MAIL_PASSWORD`

### Opción B: Mailtrap (Para testing)
```
MAIL_MAILER=smtp
MAIL_SCHEME=tls
MAIL_HOST=live.smtp.mailtrap.io
MAIL_PORT=465
MAIL_USERNAME=api
MAIL_PASSWORD=tu-key-de-mailtrap
```

--- 

## 🔐 Variables de Autenticación (OPCIONAL pero RECOMENDADO)

Si tu frontend está en otro dominio:

```
SANCTUM_STATEFUL_DOMAINS=api.bookheaven.com
SANCTUM_ALLOWED_ORIGINS=https://bookheaven.com
FRONTEND_URL=https://bookheaven.com
```

---

## 📋 TODAS LAS VARIABLES PARA COPIAR A RAILWAY

Copia este bloque completo en **Railway Dashboard** → Tu Servicio PHP → **Variables**:

```
APP_NAME=Book Heaven
APP_ENV=production
APP_DEBUG=false
APP_TIMEZONE=America/La_Paz
APP_LOCALE=es
APP_FALLBACK_LOCALE=es
APP_MAINTENANCE_DRIVER=file
PHP_CLI_SERVER_WORKERS=4
BCRYPT_ROUNDS=12
LOG_CHANNEL=stack
LOG_LEVEL=error
DB_CONNECTION=mysql
SESSION_DRIVER=redis
SESSION_LIFETIME=120
BROADCAST_CONNECTION=redis
FILESYSTEM_DISK=local
QUEUE_CONNECTION=redis
CACHE_STORE=redis
CACHE_PREFIX=bookheaven_
REDIS_CLIENT=phpredis
MAIL_MAILER=smtp
MAIL_SCHEME=tls
MAIL_HOST=smtp.gmail.com
MAIL_PORT=465
MAIL_FROM_ADDRESS=noreply@bookheaven.com
MAIL_FROM_NAME=Book Heaven
SANCTUM_STATEFUL_DOMAINS=api.bookheaven.com
SANCTUM_ALLOWED_ORIGINS=https://bookheaven.com
FRONTEND_URL=https://bookheaven.com
VITE_APP_NAME=Book Heaven
```

---

## 🔄 Como Agregar Variables en Railway

### Opción 1: UI (Interfaz Gráfica)
1. Ve a [Railway.app](https://railway.app)
2. Tu Proyecto → Servicio PHP
3. Pestaña **"Variables"**
4. Click **"Add Variable"**
5. Ingresa `KEY` y `Value`
6. Repite para cada variable

### Opción 2: Archivo .env directamente
1. Descarga tu `.env.production` 
2. En Railway: Click en el archivo `.env`
3. Pega tu contenido
4. Save

### Opción 3: Railway CLI
```bash
railway link
railway env:set APP_KEY="base64:xxxxx"
railway env:set DB_HOST="xxxxx.railway.app"
# ... repite para cada variable
```

---

## ✅ Checklist de Variables

| Variable | Valor | Estado |
|----------|-------|--------|
| `APP_KEY` | Generado con artisan | ⚠️ OBLIGATORIO |
| `APP_URL` | Tu dominio en Railway | ⚠️ OBLIGATORIO |
| `DB_*` | De MySQL Service | Auto-generado ✅ |
| `REDIS_*` | De Redis Service | Auto-generado ✅ |
| `MAIL_*` | Tu proveedor SMTP | ⚠️ Si quieres enviar emails |
| `SANCTUM_*` | Tu frontend URL | Opcional |

---

## 🚀 Orden de Configuración Recomendado

1. ✅ Agregar MySQL Service
2. ✅ Copiar variables `DB_*` 
3. ✅ Agregar Redis Service (opcional)
4. ✅ Copiar variables `REDIS_*`
5. ✅ Generar y agregar `APP_KEY`
6. ✅ Agregar `APP_URL`
7. ✅ Configurar `MAIL_*` (opcional)
8. ✅ Hacer deploy

---

## ❌ Errores Comunes

### Error: "No APP_KEY"
**Solución**: Genera con `php artisan key:generate --show` y cópialo

### Error: "Can't connect to database"
**Solución**: Verifica que MySQL Service esté "Running" (verde) en Railway

### Error: "Unknown database"
**Solución**: Las migraciones no ejecutaron. Revisa logs del deployment

### Error: "Invalid REDIS host"
**Solución**: Redis Service no agregado. Inténtalo sin Redis (cambia `CACHE_STORE=database`)

---

## 📄 Archivo de Referencia

Archivo completo: `backend/.env.production`

```bash
cat backend/.env.production
```

---

## ✨ Después de Configurar Variables

1. Railway se reinicia automáticamente
2. Ejecuta migraciones (automático en release phase)
3. Tu app está lista 🎉

Revisa los **Logs** en Railway Dashboard para verificar que todo salió bien.

---

**¿Necesitas ayuda con algo específico?** 📞
