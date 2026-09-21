EXPEDIENTES PENDIENTES - PRODUCCION
GitHub + Netlify + Supabase
==================================

ESTRUCTURA
- site/        -> portal que Netlify publica
- supabase/    -> scripts que debes ejecutar en Supabase SQL Editor
- netlify.toml -> le dice a Netlify que publique solo la carpeta site

ORDEN CORRECTO
1. Configura Supabase.
2. Edita site/supabase-config.js.
3. Prueba el portal.
4. Sube TODA esta carpeta a GitHub.
5. Conecta el repositorio de GitHub a Netlify.

SUPABASE
A) Crea o abre un proyecto.
B) SQL Editor -> New query -> pega y ejecuta:
   supabase/01_CREAR_BASE_SUPABASE.sql
C) Authentication -> Users -> crea/invita 3 usuarios con correo y contraseña:
   dcolan
   avillanueva
   ctejada
D) Edita supabase/02_VINCULAR_USUARIOS.sql y reemplaza los 3 correos de ejemplo.
E) Ejecuta ese segundo script en SQL Editor.
F) En Supabase abre Connect o Settings -> API Keys y copia:
   - Project URL
   - Publishable key (sb_publishable_...)
   No uses Secret key ni service_role.

CONFIGURAR EL PORTAL
Abre site/supabase-config.js y cambia:
- enabled: false -> enabled: true
- PEGA_AQUI_TU_PROJECT_URL -> tu Project URL
- PEGA_AQUI_TU_PUBLISHABLE_O_ANON_KEY -> tu Publishable key
- reemplaza los 3 correos por los mismos correos creados en Supabase Auth.
Guarda.

GITHUB
1. Crea un repositorio nuevo, por ejemplo: expedientes-pendientes.
2. Puede ser PRIVADO (recomendado para el código de trabajo).
3. En Add file -> Upload files, arrastra TODO el contenido de esta carpeta:
   site/
   supabase/
   netlify.toml
   .gitignore
   README_PRIMERO.txt
4. Commit changes.

NETLIFY
1. Add new project -> Import an existing project.
2. Elige GitHub y autoriza el repositorio.
3. Selecciona el repo expedientes-pendientes.
4. Netlify leerá netlify.toml y usará "site" como Publish directory.
5. No necesitas Build command.
6. Publish / Deploy.

PRUEBA FINAL
1. Abre la URL .netlify.app.
2. Entra con dcolan + su contraseña de Supabase.
3. Debe indicar datos compartidos.
4. Carga un corte nuevo.
5. Abre la misma URL en otra laptop.
6. Entra con avillanueva o ctejada.
7. Deben ver el mismo corte y no deben poder cargar/eliminar.
8. Ejecuta supabase/03_VERIFICAR_CONEXION.sql para confirmar los perfiles y cortes.

IMPORTANTE
- La Publishable key puede estar en el navegador; la seguridad real la aplica RLS.
- Nunca publiques una Secret key/service_role en GitHub, Netlify ni supabase-config.js.
- Si cambias archivos en GitHub, Netlify volverá a publicar automáticamente el sitio conectado.
