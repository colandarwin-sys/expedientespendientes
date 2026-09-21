-- Debes ver los tres perfiles configurados.
select username, role, can_manage_cuts from public.portal_profiles order by username;

-- Al inicio puede estar vacío: los cortes base ya vienen dentro del portal.
-- Después de que dcolan cargue un nuevo corte, aquí aparecerá.
select fecha, etiqueta, archivo_origen, creado_en, actualizado_en
from public.expedientes_cortes
order by fecha desc;
