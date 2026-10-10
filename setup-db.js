// Creates/updates the survey_responses table on every Vercel deploy.
const fs = require("fs"), path = require("path"), { Client } = require("pg");
(async () => {
  const url = process.env.DATABASE_URL;
  if (!url) { console.log("DATABASE_URL not set - skipping DB setup."); return; }
  const client = new Client({ connectionString: url, ssl: { rejectUnauthorized: false } });
  await client.connect();
  await client.query(fs.readFileSync(path.join(__dirname, "..", "supabase", "schema.sql"), "utf8"));
  await client.end();
  console.log("Database table survey_responses is ready.");
})().catch(e => { console.error("DB setup failed:", e.message); process.exit(1); });
