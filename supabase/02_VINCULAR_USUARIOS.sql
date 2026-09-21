-- ============================================================
-- VINCULAR LOS 3 USUARIOS DE AUTH CON LOS PERMISOS DEL PORTAL
-- PASO PREVIO: crea primero los 3 usuarios en Authentication > Users.
-- Luego reemplaza los 3 correos de ejemplo por los correos reales.
-- Ejecuta este script en SQL Editor.
-- ============================================================

insert into public.portal_profiles (user_id, username, role, can_manage_cuts)
select id, 'dcolan', 'admin', true
from auth.users where lower(email)=lower('dcolan@TU_DOMINIO.com')
on conflict (user_id) do update set username=excluded.username, role=excluded.role, can_manage_cuts=excluded.can_manage_cuts;

insert into public.portal_profiles (user_id, username, role, can_manage_cuts)
select id, 'avillanueva', 'viewer', false
from auth.users where lower(email)=lower('avillanueva@TU_DOMINIO.com')
on conflict (user_id) do update set username=excluded.username, role=excluded.role, can_manage_cuts=excluded.can_manage_cuts;

insert into public.portal_profiles (user_id, username, role, can_manage_cuts)
select id, 'ctejada', 'viewer', false
from auth.users where lower(email)=lower('ctejada@TU_DOMINIO.com')
on conflict (user_id) do update set username=excluded.username, role=excluded.role, can_manage_cuts=excluded.can_manage_cuts;

-- Verificación: deben aparecer exactamente 3 filas.
select username, role, can_manage_cuts from public.portal_profiles order by username;
