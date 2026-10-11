-- Current table layout (survey order). Applied to the Supabase project.
create table if not exists public.survey_responses (
  id uuid primary key,
  created_at timestamptz not null default now(),
  started_at timestamptz,
  submitted_at timestamptz,
  duration_seconds integer,
  phone text,
  is_resident text,
  top_issue text, top_issue_other text,
  vote_today text, vote_today_other text,
  pref_cm text, pref_cm_other text,
  bjp_govt_sat text, bjp_govt_rating smallint,
  bjp_leader text,
  sp_leader text,
  vote_ls_2024 text, vote_ls_2024_other text,
  vote_vs_2022 text, vote_vs_2022_other text,
  age text,
  religion text, religion_other text,
  category text, category_other text,
  caste text, caste_other text,
  gender text,
  agent_id text not null,
  remarks text,
  status text not null,
  raw jsonb
);
alter table public.survey_responses enable row level security;
drop policy if exists "anon can insert responses" on public.survey_responses;
create policy "anon can insert responses" on public.survey_responses for insert to anon with check (true);
create index if not exists idx_resp_created on public.survey_responses (created_at desc);
create index if not exists idx_resp_agent on public.survey_responses (agent_id);
create index if not exists idx_resp_status on public.survey_responses (status);
