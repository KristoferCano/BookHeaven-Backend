# 🗄️ Guía de Migración de BD a Railway

## Tu Situación Actual

- **BD Local**: SQLite (`database/database.sqlite`)
- **Migraciones**: 30+ archivos de migración de Laravel
- **Próximo Destino**: MySQL en Railway

---

## 🚀 Opción 1: Crear BD Nueva en Railway (RECOMENDADO)

**Ideal si:**
- Es tu primera vez en production
- Quieres una BD limpia
- Tienes datos que pueden regenerarse

### Paso 1: Agregar MySQL a Railway

1. Ve a **[Railway.app](https://railway.app)** → Tu Proyecto
2. Click en **"+ Add Service"**
3. Selecciona **"MySQL"**
4. Railway crea la BD automáticamente ✅

### Paso 2: Railway Ejecutará Migraciones Automáticamente

En tu `Procfile` ya está configurado:

```bash
release: php artisan migrate --force
```

**¿Qué significa?**
- Cada vez que hagas deploy, Laravel ejecuta AUTOMÁTICAMENTE todas tus migraciones
- Crea todas las tablas: `users`, `libros`, `comics`, `mangas`, `audiobooks`, etc.
- Railway maneja esto automáticamente ✅

### Paso 3: Verificar

En **Railway Dashboard**:

1. Ve a tu Servicio PHP → **Deployment**
2. Busca en los **Logs**:
   ```
   Migrated: 2025_02_12_000001_create_roles_table
   Migrated: 2025_02_12_000008_create_audiobooks_table
   ...
   ```
3. Si ves "Migrated" = ✅ Las tablas se crearon correctamente

---

## 🗃️ Opción 2: Migrar Datos de SQLite a MySQL (Avanzado)

**Ideal si:**
- Quieres mantener los datos actuales
- Tienes datos importantes que no quieres perder

### Método A: Con Railway CLI (Recomendado)

```bash
# 1. Instalar Railway CLI
npm install -g @railway/cli

# 2. Loguearte
railway login

# 3. Conectar a tu proyecto
cd tu-proyecto
railway link

# 4. Exportar datos de SQLite
sqlite3 backend/database/database.sqlite ".dump" > backup.sql

# 5. Restaurar en Railway MySQL
railway run mysql < backup.sql
```

### Método B: Manual (Si Railway CLI no funciona)

```bash
# 1. Obtener credenciales de MySQL en Railway
# Ve a: Railway Dashboard → MySQL Service → Variables
# Copia: DB_HOST, DB_PORT, DB_USERNAME, DB_PASSWORD, DB_DATABASE

# 2. Exportar datos locales (en Windows PowerShell)
sqlite3 backend/database/database.sqlite ".dump" | Out-File -Encoding UTF8 backup.sql

# 3. Restaurar en Railway (reemplaza con valores reales)
mysql -h tu-db-host.railway.app -u root -p -P 3306 tu_base_datos < backup.sql

# Te pedirá password (cópialo de Railway Variables)
```

### Método C: phpMyAdmin (Interfaz Gráfica)

1. Railway proporciona **phpMyAdmin** automáticamente
2. Ve a: Railway Dashboard → MySQL → Public URL
3. Ingresa con credenciales del MySQL Service
4. Usa el import/export de phpMyAdmin

---

## ⚠️ Paso Importante: Configurar Variables de Entorno

En **Railway Dashboard** → Tu Servicio PHP → **Variables**:

```
# Database
DB_CONNECTION=mysql
APP_ENV=production
APP_DEBUG=false

# Las siguientes se generan automáticamente:
# DB_HOST=xxxxx.railway.app
# DB_PORT=3306
# DB_USERNAME=root
# DB_PASSWORD=xxxxx
# DB_DATABASE=railway
```

**Railway automáticamente proporciona estas variables cuando añades MySQL** ✅

---

## 📋 Checklist Final

### Para Opción 1 (Sólo Migraciones - RECOMENDADO):
- [ ] Agregar MySQL service en Railway
- [ ] Hacer commit y push de cambios
- [ ] Esperar a que Railway complete el deploy
- [ ] Revisar logs que digan "Migrated"
- [ ] Probar tu aplicación

### Para Opción 2 (Con Datos):
- [ ] Exportar BD local a SQL (comando arriba)
- [ ] Instalar Railway CLI o usar MySQL manualmente
- [ ] Restaurar SQL en Railway
- [ ] Verificar datos en phpMyAdmin de Railway

---

## 🔍 Verificar que Funcionó

### En Railway Logs:
```
✅ Migrated: 2025_02_12_000001_create_roles_table
✅ Migrated: 2025_02_12_000008_create_audiobooks_table
```

### En Tu App:
1. Accede a `tu-app.railway.app`
2. Intenta loguearte
3. Verifica que puedes acceder a datos
4. Si ves datos correctos = ✅ Migración exitosa

---

## ❌ Troubleshooting

### Error: "SQLSTATE[HY000]: General error: 1030"
**Solución**: MySQL service no está conectado correctamente
- Verifica variables en Railway Dashboard
- Asegúrate que MySQL Service está "Running" (verde)

### Error: "No such table: users"
**Solución**: Las migraciones no ejecutaron
- Ve a Logs → busca "Migrated"
- Si no hay migraciones, reinicia el deploy

### Error: "Access denied for user 'root'"
**Solución**: Credenciales incorrectas
- Copia exactamente de Railway → MySQL Service → Variables
- Copia/Pega, no escribas a mano

---

## 📚 Mi Recomendación

**Usa OPCIÓN 1:**
- ✅ Más simple
- ✅ Más seguro
- ✅ Se ejecuta automáticamente
- ✅ No necesitas scripts extra

**Solo usa OPCIÓN 2 si:**
- Tienes datos críticos que perder
- Quieres migración de BD local → Railway

---

## Links Útiles

- [Railway MySQL Docs](https://docs.railway.app/guides/mysql)
- [Laravel Migrations](https://laravel.com/docs/11.x/migrations)
- [Railway CLI](https://docs.railway.app/reference/cli-api)

---

**¿Necesitas ayuda con algún paso específico?** 🤔
