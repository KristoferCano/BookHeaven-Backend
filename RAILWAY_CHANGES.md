# 📋 Cambios Realizados para Railway

## Archivos Nuevos Creados

### 1. **Procfile** 
Archivo de configuración que define los procesos a ejecutar en Railway:
- `web`: Servidor PHP-Apache principal
- `release`: Migraciones y cachés (ejecuta una sola vez al desplegar)
- `queue`: Worker para procesar colas en background

### 2. **railway.json**
Configuración específica de Railway con:
- Buildpack Nixpacks para detectar automáticamente la configuración
- Comando de build optimizado
- Política de reintentos automáticos

### 3. **fpm_config.ini**
Configuración optimizada de PHP-FPM para producción:
- OPcache habilitado y optimizado
- Configuraciones de memoria y timeout

### 4. **.env.railway**
Archivo de ejemplo con variables para ambiente de producción con comentarios.

### 5. **config/railway.php**
Configuración de PHP con optimizaciones específicas para Railway.

### 6. **RAILWAY_SETUP.md** ⭐
**Guía completa paso a paso** para desplegar en Railway:
- Cómo conectar GitHub
- Configurar servicios (MySQL, Redis)
- Variables de entorno necesarias
- Troubleshooting y monitoreo
- Estructura de procesos explicada

### 7. **railway-env-template.sh**
Script de template con todas las variables de entorno necesarias con explicaciones.

### 8. **validate-railway.sh**
Script para validar que todo está listo para Railway:
- Verifica Procfile
- Valida sintaxis de PHP
- Comprueba directorios necesarios

## Archivos Modificados

### **.env.example**
Actualizado con:
- Mejor estructura y comentarios
- Configuración para desarrollo y producción
- Comentarios sobre servicios de Railway
- Ejemplo de CORS y Sanctum

## Optimizaciones Implementadas

✅ **Web Server**: Apache con PHP-FPM configurado para rendimiento
✅ **Cache**: Redis para caché distribuida
✅ **Sessions**: Redis para sesiones escalables
✅ **Queues**: Worker background para jobs
✅ **Database**: MySQL con soporte para auto-configuración de Railway
✅ **PHP**: OPcache habilitado y configurado
✅ **Autoloader**: Optimizado para producción
✅ **Migraciones**: Automáticas en cada deploy (release phase)

## Variables Configuradas

### Auto-configuradas por Railway
- `DB_HOST`, `DB_PORT`, `DB_USERNAME`, `DB_PASSWORD`, `DB_NAME`
- `REDIS_HOST`, `REDIS_PORT`, `REDIS_PASSWORD`

### Necesarias antes de Deploy
- `APP_KEY` (generar con `php artisan key:generate --show`)
- `APP_URL` (tu dominio en Railway)
- `MAIL_*` (configurar SMTP si usas email)
- `SANCTUM_*` (configurar dominio de frontend)

## Flujo de Despliegue Automatizado

1. **Build Phase**: Instala dependencias PHP y Node
2. **Release Phase**: 
   - Ejecuta migraciones de BD
   - Cachea rutas y configuración
3. **Web Process**: Servidor principal Apache con PHP
4. **Queue Process**: Worker para procesar jobs (opcional)

## Checklist antes de Deploy

- [ ] Verificar que `Procfile` está en el directorio raíz (/backend/)
- [ ] Generar `APP_KEY`: `php artisan key:generate --show`
- [ ] Copiar variables del template al Dashboard de Railway
- [ ] Configurar MySQL service en Railway
- [ ] Configurar Redis service (opcional pero recomendado)
- [ ] Hacer commit y push de los cambios
- [ ] Conectar repo en Railway.app

## Comandos Útiles

```bash
# Validar configuración antes de desplegar
bash validate-railway.sh

# Hacer commit de los cambios
git add .
git commit -m "Add Railway deployment configuration"
git push origin main

# Ver logs en local (necesitas Railway CLI)
railway logs

# Ejecutar comando en Railway
railway run php artisan migrate
```

## Recursos Importantes

- 📖 [RAILWAY_SETUP.md](./RAILWAY_SETUP.md) - Guía paso a paso (LEER ESTO PRIMERO)
- 🔧 [railway-env-template.sh](./railway-env-template.sh) - Variables de entorno
- ✅ [validate-railway.sh](./validate-railway.sh) - Script de validación

## Notas Importantes

- El archivo `Procfile` debe estar en la raíz del proyecto (`backend/`)
- Railway automáticamente usa `.env` variables de sus servicios (MySQL, Redis)
- El `APP_KEY` debe ser generado antes de usar en producción
- El database "release" phase se ejecuta automáticamente antes del web process

## Soporte

Si tienes problemas durante el deploy:
1. Revisa los logs en el Dashboard de Railway
2. Verifica que MySQL y Redis estén corriendo
3. Comprueba las variables de entorno en Railway
4. Ejecuta `railway logs` en local para más detalles

---

**Los cambios están listos. ¡El backend de Book Heaven ahora está optimizado para Railway!** 🚀
