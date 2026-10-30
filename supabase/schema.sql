-- AKM GRAFFITI WARS online foundation (Supabase SQL Editor)
-- Run once in a new Supabase project. Never expose a service_role key in the browser.
create extension if not exists pgcrypto;

create table if not exists public.akm_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  player_name text not null default 'NEWCOMER' check (char_length(player_name) between 1 and 20),
  discipline text not null default 'Граффити' check (discipline in ('Граффити','Рэп','Брейкинг','DJ')),
  xp integer not null default 0 check (xp >= 0),
  created_at timestamptz not null default now()
);
create table if not exists public.akm_crews (
  id uuid primary key default gen_random_uuid(),
  name text not null unique check (char_length(name) between 2 and 24),
  discipline text not null check (discipline in ('Граффити','Рэп','Брейкинг','DJ')),
  owner_id uuid not null references auth.users(id) on delete cascade,
  weekly_points integer not null default 0 check (weekly_points >= 0),
  week_started date not null default date_trunc('week', now())::date,
  created_at timestamptz not null default now()
);
create table if not exists public.akm_crew_members (
  crew_id uuid not null references public.akm_crews(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  role text not null default 'member' check (role in ('owner','member')),
  joined_at timestamptz not null default now(),
  primary key (crew_id, user_id),
  unique (user_id)
);
create table if not exists public.akm_activity_events (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  crew_id uuid references public.akm_crews(id) on delete set null,
  event_type text not null check (event_type in ('tag_submitted','daily_challenge_completed','district_visited')),
  district_id text check (district_id in ('jubilee','friendship','memory') or district_id is null),
  points integer not null default 0 check (points between 0 and 10),
  created_at timestamptz not null default now()
);
create table if not exists public.akm_daily_claims (
  user_id uuid not null references auth.users(id) on delete cascade,
  claim_date date not null default current_date,
  claim_type text not null check (claim_type in ('daily_bonus','daily_challenge')),
  created_at timestamptz not null default now(),
  primary key (user_id, claim_date, claim_type)
);
create table if not exists public.akm_territory_scores (
  district_id text not null check (district_id in ('jubilee','friendship','memory')),
  crew_id uuid not null references public.akm_crews(id) on delete cascade,
  points integer not null default 0 check (points >= 0),
  updated_at timestamptz not null default now(),
  primary key (district_id, crew_id)
);

create or replace view public.akm_crew_leaderboard with (security_invoker = true) as
select c.id, c.name, c.discipline, c.weekly_points,
       (select count(*)::integer from public.akm_crew_members m where m.crew_id = c.id) as members
from public.akm_crews c
order by c.weekly_points desc, c.created_at asc;

alter table public.akm_profiles enable row level security;
alter table public.akm_crews enable row level security;
alter table public.akm_crew_members enable row level security;
alter table public.akm_activity_events enable row level security;
alter table public.akm_daily_claims enable row level security;
alter table public.akm_territory_scores enable row level security;

drop policy if exists "profiles readable" on public.akm_profiles;
create policy "profiles readable" on public.akm_profiles for select to authenticated using (true);
drop policy if exists "profile owner insert" on public.akm_profiles;
create policy "profile owner insert" on public.akm_profiles for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists "profile owner update" on public.akm_profiles;
create policy "profile owner update" on public.akm_profiles for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
drop policy if exists "crews readable" on public.akm_crews;
create policy "crews readable" on public.akm_crews for select to authenticated using (true);
drop policy if exists "members readable" on public.akm_crew_members;
create policy "members readable" on public.akm_crew_members for select to authenticated using (true);
drop policy if exists "events readable" on public.akm_activity_events;
create policy "events readable" on public.akm_activity_events for select to authenticated using (true);
drop policy if exists "own claims readable" on public.akm_daily_claims;
create policy "own claims readable" on public.akm_daily_claims for select to authenticated using (auth.uid() = user_id);
drop policy if exists "territories readable" on public.akm_territory_scores;
create policy "territories readable" on public.akm_territory_scores for select to authenticated using (true);

create or replace function public.akm_create_crew(p_name text, p_discipline text)
returns jsonb language plpgsql security definer set search_path = public, auth as $$
declare v_user uuid := auth.uid(); v_crew public.akm_crews;
begin
  if v_user is null then raise exception 'AUTH_REQUIRED'; end if;
  if p_discipline not in ('Граффити','Рэп','Брейкинг','DJ') then raise exception 'INVALID_DISCIPLINE'; end if;
  if char_length(trim(p_name)) not between 2 and 24 then raise exception 'INVALID_CREW_NAME'; end if;
  if exists(select 1 from public.akm_crew_members where user_id = v_user) then raise exception 'ALREADY_IN_CREW'; end if;
  insert into public.akm_profiles(user_id, discipline) values(v_user,p_discipline) on conflict(user_id) do update set discipline=excluded.discipline;
  insert into public.akm_crews(name,discipline,owner_id) values(trim(p_name),p_discipline,v_user) returning * into v_crew;
  insert into public.akm_crew_members(crew_id,user_id,role) values(v_crew.id,v_user,'owner');
  return jsonb_build_object('id',v_crew.id,'name',v_crew.name,'discipline',v_crew.discipline,'weekly_points',v_crew.weekly_points);
end; $$;

create or replace function public.akm_submit_event(p_event_type text, p_district_id text default null)
returns jsonb language plpgsql security definer set search_path = public, auth as $$
declare v_user uuid := auth.uid(); v_crew uuid; v_points integer; v_event_id bigint; v_week date := date_trunc('week', now())::date;
begin
  if v_user is null then raise exception 'AUTH_REQUIRED'; end if;
  if p_event_type not in ('tag_submitted','daily_challenge_completed','district_visited') then raise exception 'INVALID_EVENT'; end if;
  if p_district_id is not null and p_district_id not in ('jubilee','friendship','memory') then raise exception 'INVALID_DISTRICT'; end if;
  select crew_id into v_crew from public.akm_crew_members where user_id=v_user;
  v_points := case p_event_type when 'tag_submitted' then 5 when 'daily_challenge_completed' then 10 else 1 end;
  if p_event_type='tag_submitted' and p_district_id is null then raise exception 'DISTRICT_REQUIRED'; end if;
  -- Daily caps prevent simple refresh/spam farming; one tag contribution per district per day.
  if p_event_type='tag_submitted' and exists(select 1 from public.akm_activity_events where user_id=v_user and event_type=p_event_type and district_id=p_district_id and created_at::date=current_date) then raise exception 'DAILY_TAG_ALREADY_COUNTED'; end if;
  if p_event_type='daily_challenge_completed' and exists(select 1 from public.akm_activity_events where user_id=v_user and event_type=p_event_type and created_at::date=current_date) then raise exception 'DAILY_CHALLENGE_ALREADY_COUNTED'; end if;
  insert into public.akm_activity_events(user_id,crew_id,event_type,district_id,points) values(v_user,v_crew,p_event_type,p_district_id,v_points) returning id into v_event_id;
  if v_crew is not null then
    update public.akm_crews set weekly_points=(case when week_started<v_week then 0 else weekly_points end)+v_points, week_started=v_week where id=v_crew;
    if p_district_id is not null then insert into public.akm_territory_scores(district_id,crew_id,points,updated_at) values(p_district_id,v_crew,v_points,now()) on conflict(district_id,crew_id) do update set points=akm_territory_scores.points+excluded.points,updated_at=now(); end if;
  end if;
  update public.akm_profiles set xp=xp+v_points where user_id=v_user;
  return jsonb_build_object('event_id',v_event_id,'points',v_points,'crew_id',v_crew);
end; $$;

grant select on public.akm_crew_leaderboard to authenticated;
grant select on public.akm_profiles, public.akm_crews, public.akm_crew_members, public.akm_activity_events, public.akm_daily_claims, public.akm_territory_scores to authenticated;
grant execute on function public.akm_create_crew(text,text) to authenticated;
grant execute on function public.akm_submit_event(text,text) to authenticated;
