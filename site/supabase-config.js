// CONFIGURACIÓN DEL PORTAL - SUPABASE
// 1) Pega tu Project URL y tu Publishable/Anon Key.
// 2) Coloca el correo de cada usuario EXACTAMENTE como lo crearás en Supabase Authentication.
// 3) Cambia enabled a true.
// IMPORTANTE: usa SOLO la Publishable/Anon Key. NUNCA pongas la service_role/secret key en este archivo.

window.SUPABASE_CONFIG = {
  enabled: true,
  url: "https://ilvqqwsbnghliqspkahi.supabase.co",
  key: "sb_publishable_m8-H94_kHmt_UznV7i_DYg_x2jrAax7",

  users: {
    dcolan: "dcolan@auditoria.medica",
    avillanueva: "avillanueva@auditoria.medica",
    ctejada: "ctejada@auditoria.medica"
  }
};

