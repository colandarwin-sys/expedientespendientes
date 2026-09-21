// CONFIGURACIÓN DEL PORTAL - SUPABASE
// 1) Pega tu Project URL y tu Publishable/Anon Key.
// 2) Coloca el correo de cada usuario EXACTAMENTE como lo crearás en Supabase Authentication.
// 3) Cambia enabled a true.
// IMPORTANTE: usa SOLO la Publishable/Anon Key. NUNCA pongas la service_role/secret key en este archivo.

window.PORTAL_CONFIG = {
  enabled: false,
  supabaseUrl: "PEGA_AQUI_TU_PROJECT_URL",
  supabaseAnonKey: "PEGA_AQUI_TU_PUBLISHABLE_O_ANON_KEY",
  users: {
    dcolan: "dcolan@TU_DOMINIO.com",
    avillanueva: "avillanueva@TU_DOMINIO.com",
    ctejada: "ctejada@TU_DOMINIO.com"
  }
};
