create table if not exists public.survey_responses (
  id uuid primary key,
  created_at timestamptz not null default now(),
  q1 text, q2 text, q3 text, q4 text, q5 text, q6 text, q7 text,
  q8 text, q8_rating smallint, q9 text, q10 text, q11 text, q12 text, q13 text, q14 text,
  agent_id text not null,
  remarks text,
  survey_status text not null,
  raw jsonb
);

alter table public.survey_responses enable row level security;

-- The public (anon) key may only insert. No select/update/delete policies = nobody can read via the public key.
create policy "anon can insert responses"
  on public.survey_responses for insert to anon
  with check (true);

create index if not exists idx_resp_created on public.survey_responses (created_at desc);
create index if not exists idx_resp_agent on public.survey_responses (agent_id);
