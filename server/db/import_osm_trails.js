const pool = require('./index');

const OVERPASS_URL = 'https://overpass-api.de/api/interpreter';
const OVERPASS_QUERY = `
[out:json][timeout:60];
area["name"="Slovenija"]["boundary"="administrative"]->.slovenia;
relation["route"="hiking"]["name"](area.slovenia);
out tags;
`.trim();

const SAC_SCALE_MAP = {
  hiking: 'easy',
  mountain_hiking: 'medium',
  demanding_mountain_hiking: 'hard',
  alpine_hiking: 'hard',
  difficult_alpine_hiking: 'hard',
  demanding_alpine_hiking: 'hard',
};

async function fetchOsmTrails() {
  const res = await fetch(OVERPASS_URL, {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: `data=${encodeURIComponent(OVERPASS_QUERY)}`,
  });
  if (!res.ok) throw new Error(`Overpass API error: ${res.status} ${res.statusText}`);
  const json = await res.json();
  return json.elements || [];
}

function mapDifficulty(tags) {
  if (tags.sac_scale) return SAC_SCALE_MAP[tags.sac_scale] || null;
  if (tags['osmc:symbol']) return 'medium';
  return null;
}

function processTrail(el) {
  const t = el.tags || {};
  const name = t.name || null;
  if (!name) return null;
  return {
    name,
    name_sl: t['name:sl'] || t.name || null,
    difficulty: mapDifficulty(t),
    distance_km: t['length:km'] ? parseFloat(t['length:km']) : null,
    description: t.description || null,
  };
}

async function loadSummits(client) {
  const { rows } = await client.query('SELECT id, name, name_sl FROM summits');
  return rows;
}

function matchSummit(trailName, summits) {
  const lower = trailName.toLowerCase();
  for (const summit of summits) {
    const sName = (summit.name || '').toLowerCase();
    const sNameSl = (summit.name_sl || '').toLowerCase();
    if (sName.length > 2 && lower.includes(sName)) return summit.id;
    if (sNameSl.length > 2 && lower.includes(sNameSl)) return summit.id;
  }
  return null;
}

async function main() {
  console.log('Fetching hiking trails from OpenStreetMap Overpass API...');
  const elements = await fetchOsmTrails();
  console.log(`Fetched ${elements.length} relations from OSM`);

  const client = await pool.connect();
  try {
    const summits = await loadSummits(client);

    const { rows: existing } = await client.query('SELECT name FROM trails');
    const existingNames = new Set(existing.map(r => r.name.toLowerCase()));

    let imported = 0;
    let skippedDuplicate = 0;
    let skippedNoName = 0;
    let matchedSummit = 0;
    const seenNames = new Set();

    for (const el of elements) {
      const trail = processTrail(el);

      if (!trail) { skippedNoName++; continue; }

      const nameLower = trail.name.toLowerCase();

      if (existingNames.has(nameLower) || seenNames.has(nameLower)) {
        skippedDuplicate++;
        continue;
      }
      seenNames.add(nameLower);

      const summit_id = matchSummit(trail.name, summits);
      if (summit_id) matchedSummit++;

      await client.query(
        `INSERT INTO trails (summit_id, name, name_sl, difficulty, distance_km, activity_type, description)
         VALUES ($1, $2, $3, $4, $5, 'hiking', $6)`,
        [summit_id, trail.name, trail.name_sl, trail.difficulty, trail.distance_km, trail.description]
      );
      imported++;
    }

    console.log('\n--- Import Results ---');
    console.log(`Fetched from OSM:          ${elements.length}`);
    console.log(`Imported successfully:     ${imported}`);
    console.log(`Skipped (no name):         ${skippedNoName}`);
    console.log(`Skipped (duplicates):      ${skippedDuplicate}`);
    console.log(`Matched to summits:        ${matchedSummit}`);
  } finally {
    client.release();
    await pool.end();
  }
}

main().catch(err => {
  console.error('Import failed:', err.message);
  process.exit(1);
});
