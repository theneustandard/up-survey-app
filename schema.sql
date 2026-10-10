-- Safe to run many times (idempotent).
create table if not exists public.survey_responses (
  id uuid primary key,
  created_at timestamptz not null default now(),   -- set by the database when the row is saved
  started_at timestamptz,                          -- when the agent opened the form
  submitted_at timestamptz,                        -- when the agent pressed Submit
  duration_seconds integer,
  q1 text, q2 text, q3 text, q4 text, q5 text, q6 text, q7 text,
  q8 text, q8_rating smallint, q9 text, q10 text, q11 text, q12 text, q13 text, q14 text,
  agent_id text not null,
  remarks text,
  survey_status text not null,
  raw jsonb
);

-- for tables created by an earlier version
alter table public.survey_responses add column if not exists started_at timestamptz;
alter table public.survey_responses add column if not exists submitted_at timestamptz;
alter table public.survey_responses add column if not exists duration_seconds integer;

alter table public.survey_responses enable row level security;

drop policy if exists "anon can insert responses" on public.survey_responses;
create policy "anon can insert responses"
  on public.survey_responses for insert to anon
  with check (true);

create index if not exists idx_resp_created on public.survey_responses (created_at desc);
create index if not exists idx_resp_agent on public.survey_responses (agent_id);
