import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';
const url = (window.AKM_SUPABASE_URL || '').trim();
const key = (window.AKM_SUPABASE_ANON_KEY || '').trim();
const configured = /^https:\/\/.+\.supabase\.co$/.test(url) && key.length > 20;
let client = null;
if (configured) {
  client = createClient(url, key, { auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true } });
}
const status = { configured, connected: false, user: null };
async function refreshAuth() {
  if (!client) return null;
  const { data, error } = await client.auth.getUser();
  if (error) { status.user = null; status.connected = false; return null; }
  status.user = data.user || null; status.connected = !!data.user; return status.user;
}
async function signIn(email) {
  if (!client) throw new Error('Онлайн-режим не настроен. Сначала добавь ключи Supabase в assets/akm-config.js.');
  const { error } = await client.auth.signInWithOtp({ email, options: { emailRedirectTo: location.origin + location.pathname } });
  if (error) throw error;
  return true;
}
async function signOut() { if (client) await client.auth.signOut(); status.user = null; status.connected = false; }
async function createCrew(name, discipline) {
  if (!client) throw new Error('Онлайн-режим не настроен.');
  const user = await refreshAuth(); if (!user) throw new Error('Сначала подключи аккаунт по email.');
  const { data, error } = await client.rpc('akm_create_crew', { p_name: name, p_discipline: discipline });
  if (error) throw error; return data;
}
async function submitEvent(eventType, districtId = null) {
  if (!client) return { online: false };
  const user = await refreshAuth(); if (!user) throw new Error('Для общего прогресса подключи аккаунт.');
  const { data, error } = await client.rpc('akm_submit_event', { p_event_type: eventType, p_district_id: districtId });
  if (error) throw error; return data;
}
async function leaderboard() {
  if (!client) throw new Error('Онлайн-режим не настроен.');
  const { data, error } = await client.from('akm_crew_leaderboard').select('*').limit(20);
  if (error) throw error; return data || [];
}
async function myCrew() {
  if (!client) return null;
  const user = await refreshAuth(); if (!user) return null;
  const { data, error } = await client.from('akm_crew_members').select('crew_id, role, akm_crews(id,name,discipline,weekly_points)').eq('user_id', user.id).maybeSingle();
  if (error) throw error; return data;
}
if (client) {
  client.auth.onAuthStateChange((_event, session) => { status.user = session?.user || null; status.connected = !!session?.user; window.dispatchEvent(new CustomEvent('akm-online-status', { detail: { ...status } })); });
  refreshAuth().then(() => window.dispatchEvent(new CustomEvent('akm-online-status', { detail: { ...status } })));
}
window.AKM_BACKEND = { status, refreshAuth, signIn, signOut, createCrew, submitEvent, leaderboard, myCrew };
window.dispatchEvent(new CustomEvent('akm-backend-ready', { detail: { ...status } }));
