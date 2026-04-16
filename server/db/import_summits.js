const { Pool } = require('pg');

const local = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'vrh_db',
  user: 'postgres',
  password: 'Nacenace1.'
});

const railway = new Pool({
  connectionString: 'postgresql://postgres:ICKpNXYwmGmEANwOkugVkPfxZtzuKJsy@nozomi.proxy.rlwy.net:27897/railway'
});

async function importAll() {
  const localSummits = await local.query('SELECT id, name FROM summits');
  const railwaySummits = await railway.query('SELECT id, name FROM summits');
  
  const summitMap = {};
  localSummits.rows.forEach(s => summitMap[s.name] = s.id);
  const railwaySummitMap = {};
  railwaySummits.rows.forEach(s => railwaySummitMap[s.name] = s.id);

  // Import climbing routes
  await railway.query('TRUNCATE climbing_routes CASCADE;');
  const routes = await local.query('SELECT cr.*, s.name as summit_name FROM climbing_routes cr LEFT JOIN summits s ON cr.summit_id = s.id');
  
  let success = 0, failed = 0;
  for (const r of routes.rows) {
    const summit_id = railwaySummitMap[r.summit_name] || null;
    try {
      await railway.query(
        `INSERT INTO climbing_routes (summit_id, name, name_sl, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, description_sl)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)`,
        [summit_id, r.name, r.name_sl, r.grade_french, r.grade_uiaa, r.grade_alpine, r.type, r.length_m, r.num_bolts, r.rock_type, r.description, r.description_sl]
      );
      success++;
    } catch (err) {
      console.error(`Failed route: ${r.name} — ${err.message}`);
      failed++;
    }
  }
  console.log(`Climbing routes: ${success} inserted, ${failed} failed`);

  // Import trails
  await railway.query('TRUNCATE trails CASCADE;');
  const trails = await local.query('SELECT t.*, s.name as summit_name FROM trails t LEFT JOIN summits s ON t.summit_id = s.id');
  
  success = 0; failed = 0;
  for (const t of trails.rows) {
    const summit_id = railwaySummitMap[t.summit_name] || null;
    try {
      await railway.query(
        `INSERT INTO trails (summit_id, name, name_sl, difficulty, distance_km, elevation_gain_m, activity_type, description, description_sl)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)`,
        [summit_id, t.name, t.name_sl, t.difficulty, t.distance_km, t.elevation_gain_m, t.activity_type, t.description, t.description_sl]
      );
      success++;
    } catch (err) {
      console.error(`Failed trail: ${t.name} — ${err.message}`);
      failed++;
    }
  }
  console.log(`Trails: ${success} inserted, ${failed} failed`);

  await local.end();
  await railway.end();
}

importAll();