# UP Survey App (Raniganj AC)
Static bilingual survey form → saves to Supabase → hosted on Vercel. No build step.

## Files
- `index.html` – the survey app
- `config.js` – Supabase URL + anon key
- `supabase/schema.sql` – table + Row Level Security

## How the table gets created
The table is defined in `supabase/schema.sql`. On every Vercel deploy, `npm run build` runs `scripts/setup-db.js`, which creates the `survey_responses` table (and adds any new columns) in your Supabase database. A browser app cannot create tables itself, so this runs on the server at deploy time.
Each record stores timestamps: `created_at` (saved time, set by the database), `started_at`, `submitted_at` and `duration_seconds`.

Needs one Vercel environment variable: `DATABASE_URL` = Supabase → Project Settings → Database → Connection string (URI). Keep it only in Vercel, never in the repo. Without it the build skips DB setup, and you can paste `schema.sql` in the Supabase SQL Editor instead.

## 1. Supabase
1. Create a project at supabase.com (pick a region close to India, e.g. Mumbai).
2. (Optional if you use `DATABASE_URL`) SQL Editor → paste `supabase/schema.sql` → Run.
3. Project Settings → API → copy **Project URL** and **anon public key** into `config.js`.
   (Never put the `service_role` key in this repo.)

## 2. GitHub
```bash
cd up-survey-app
git init && git add . && git commit -m "Survey app"
git branch -M main
git remote add origin https://github.com/<you>/up-survey-app.git
git push -u origin main
```

## 3. Vercel
1. vercel.com → Add New → Project → import the GitHub repo.
2. Framework Preset: **Other** (`vercel.json` sets the build command and output directory). Add environment variable `DATABASE_URL`.
3. Deploy. Every push to `main` redeploys automatically.

## Viewing data
Supabase → Table Editor → `survey_responses` → Export CSV. (Only you can read it; the public key cannot.)

## Notes
- Answers about religion, caste and party preference are sensitive personal data. Don't collect phone numbers/names, restrict Supabase dashboard access, and delete data when the study ends.
- Local test: `npx serve .`
