-- ============================================================
-- EXPEDIENTES PENDIENTES - ESTRUCTURA SUPABASE
-- Ejecutar UNA SOLA VEZ en Supabase > SQL Editor
-- ============================================================

create table if not exists public.portal_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  username text not null unique,
  role text not null check (role in ('admin','viewer')),
  can_manage_cuts boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.expedientes_cortes (
  fecha date primary key,
  etiqueta text,
  archivo_origen text,
  payload jsonb not null,
  creado_por uuid references auth.users(id),
  creado_en timestamptz not null default now(),
  actualizado_en timestamptz not null default now()
);

create index if not exists expedientes_cortes_creado_en_idx on public.expedientes_cortes(creado_en desc);

alter table public.portal_profiles enable row level security;
alter table public.expedientes_cortes enable row level security;

revoke all on public.portal_profiles from anon;
revoke all on public.expedientes_cortes from anon;
grant select on public.portal_profiles to authenticated;
grant select, insert, update, delete on public.expedientes_cortes to authenticated;

-- Cada usuario autenticado solo puede leer su propio perfil.
drop policy if exists "perfil propio" on public.portal_profiles;
create policy "perfil propio"
  on public.portal_profiles for select
  to authenticated
  using (user_id = auth.uid());

-- Los 3 usuarios autenticados pueden consultar todos los cortes.
drop policy if exists "usuarios leen cortes" on public.expedientes_cortes;
create policy "usuarios leen cortes"
  on public.expedientes_cortes for select
  to authenticated
  using (
    exists (select 1 from public.portal_profiles p where p.user_id = auth.uid())
  );

-- Solo el perfil con can_manage_cuts=true (dcolan) puede crear cortes.
drop policy if exists "admin crea cortes" on public.expedientes_cortes;
create policy "admin crea cortes"
  on public.expedientes_cortes for insert
  to authenticated
  with check (
    exists (select 1 from public.portal_profiles p where p.user_id = auth.uid() and p.can_manage_cuts = true)
  );

-- Solo el administrador puede reemplazar un corte de la misma fecha.
drop policy if exists "admin actualiza cortes" on public.expedientes_cortes;
create policy "admin actualiza cortes"
  on public.expedientes_cortes for update
  to authenticated
  using (
    exists (select 1 from public.portal_profiles p where p.user_id = auth.uid() and p.can_manage_cuts = true)
  )
  with check (
    exists (select 1 from public.portal_profiles p where p.user_id = auth.uid() and p.can_manage_cuts = true)
  );

-- Solo el administrador puede eliminar cortes.
drop policy if exists "admin elimina cortes" on public.expedientes_cortes;
create policy "admin elimina cortes"
  on public.expedientes_cortes for delete
  to authenticated
  using (
    exists (select 1 from public.portal_profiles p where p.user_id = auth.uid() and p.can_manage_cuts = true)
  );

-- Trigger para fecha de actualización.
create or replace function public.set_expedientes_updated_at()
returns trigger language plpgsql as $$
begin
  new.actualizado_en = now();
  new.creado_por = coalesce(new.creado_por, auth.uid());
  return new;
end;
$$;

drop trigger if exists trg_expedientes_updated_at on public.expedientes_cortes;
create trigger trg_expedientes_updated_at
before insert or update on public.expedientes_cortes
for each row execute function public.set_expedientes_updated_at();
