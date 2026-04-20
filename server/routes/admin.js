const express = require('express');
const router = express.Router();
const pool = require('../db');

// ── Token helpers ─────────────────────────────────────────────────────────────
// Simple reversible token: base64(password + ":vrh-admin"). Not for high-security
// use, but fine for a single-operator admin panel behind a password.
function makeToken(password) {
  return Buffer.from(`${password}:vrh-admin`).toString('base64');
}

function requireAdmin(req, res, next) {
  const auth = req.headers.authorization;
  if (!auth || !auth.startsWith('Bearer ')) {
    return res.status(401).json({ error: 'Unauthorized' });
  }
  const token = auth.slice(7);
  const expected = makeToken(process.env.ADMIN_PASSWORD);
  if (token !== expected) {
    return res.status(401).json({ error: 'Unauthorized' });
  }
  next();
}

// ── POST /admin/login ─────────────────────────────────────────────────────────
router.post('/login', (req, res) => {
  const { password } = req.body;
  if (!password || password !== process.env.ADMIN_PASSWORD) {
    return res.status(401).json({ error: 'Invalid password' });
  }
  res.json({ token: makeToken(password) });
});

// ── GET /admin/areas ──────────────────────────────────────────────────────────
router.get('/areas', requireAdmin, async (req, res) => {
  try {
    const result = await pool.query('SELECT id, name FROM areas ORDER BY name ASC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── GET /admin/summits-list ───────────────────────────────────────────────────
router.get('/summits-list', requireAdmin, async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT id, name, elevation_m FROM summits ORDER BY name ASC'
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── GET /admin/trails-list ────────────────────────────────────────────────────
router.get('/trails-list', requireAdmin, async (req, res) => {
  try {
    const result = await pool.query('SELECT id, name FROM trails ORDER BY name ASC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── GET /admin/climbing-list ──────────────────────────────────────────────────
router.get('/climbing-list', requireAdmin, async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT id, name FROM climbing_routes ORDER BY name ASC'
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── GET /admin/trails-review ──────────────────────────────────────────────────
router.get('/trails-review', requireAdmin, async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT t.id, t.name, t.distance_km, t.activity_type, t.is_approved,
              s.name AS summit_name
       FROM trails t LEFT JOIN summits s ON t.summit_id = s.id
       ORDER BY t.is_approved NULLS FIRST, t.name ASC`
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── PATCH /admin/trails/:id/approval ─────────────────────────────────────────
router.patch('/trails/:id/approval', requireAdmin, async (req, res) => {
  try {
    const { id } = req.params;
    const { approved } = req.body;
    if (typeof approved !== 'boolean' && approved !== null) {
      return res.status(400).json({ error: 'approved must be true, false, or null' });
    }
    const result = await pool.query(
      'UPDATE trails SET is_approved = $1 WHERE id = $2 RETURNING id, name, is_approved',
      [approved, id]
    );
    if (result.rows.length === 0) return res.status(404).json({ error: 'Trail not found' });
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── POST /admin/conditions ────────────────────────────────────────────────────
// Like the regular conditions endpoint but without a logged-in user requirement.
router.post('/conditions', requireAdmin, async (req, res) => {
  try {
    const { trail_id, climbing_route_id, status, notes } = req.body;
    const result = await pool.query(
      `INSERT INTO conditions_reports (user_id, trail_id, climbing_route_id, status, notes)
       VALUES (NULL, $1, $2, $3, $4)
       RETURNING *`,
      [trail_id || null, climbing_route_id || null, status, notes]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── GET /admin/summits-manage ─────────────────────────────────────────────────
router.get('/summits-manage', requireAdmin, async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT s.id, s.name, s.name_sl, s.elevation_m, s.type, s.difficulty,
              s.area_id, s.latitude, s.longitude, s.description, s.description_sl,
              a.name AS area_name
       FROM summits s LEFT JOIN areas a ON s.area_id = a.id
       ORDER BY s.name ASC`
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── PATCH /admin/summits/:id ──────────────────────────────────────────────────
router.patch('/summits/:id', requireAdmin, async (req, res) => {
  try {
    const { id } = req.params;
    const { name, name_sl, area_id, elevation_m, type, difficulty, description, description_sl, latitude, longitude } = req.body;
    if (!name || !elevation_m) {
      return res.status(400).json({ error: 'name and elevation_m are required' });
    }
    const result = await pool.query(
      `UPDATE summits
       SET name=$1, name_sl=$2, area_id=$3, elevation_m=$4, type=$5, difficulty=$6,
           description=$7, description_sl=$8, latitude=$9, longitude=$10
       WHERE id=$11 RETURNING *`,
      [name, name_sl || null, area_id || null, elevation_m, type || 'peak',
       difficulty || null, description || null, description_sl || null,
       latitude || null, longitude || null, id]
    );
    if (result.rows.length === 0) return res.status(404).json({ error: 'Summit not found' });
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── DELETE /admin/summits/:id ─────────────────────────────────────────────────
router.delete('/summits/:id', requireAdmin, async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query('DELETE FROM summits WHERE id=$1 RETURNING id', [id]);
    if (result.rows.length === 0) return res.status(404).json({ error: 'Summit not found' });
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── PATCH /admin/trails/:id ───────────────────────────────────────────────────
router.patch('/trails/:id', requireAdmin, async (req, res) => {
  try {
    const { id } = req.params;
    const { name, name_sl, summit_id, difficulty, distance_km, elevation_gain_m,
            activity_type, description, description_sl, is_approved } = req.body;
    if (!name) return res.status(400).json({ error: 'name is required' });
    const approved = is_approved === true ? true : is_approved === false ? false : null;
    const result = await pool.query(
      `UPDATE trails
       SET name=$1, name_sl=$2, summit_id=$3, difficulty=$4, distance_km=$5,
           elevation_gain_m=$6, activity_type=$7, description=$8, description_sl=$9,
           is_approved=$10
       WHERE id=$11 RETURNING *`,
      [name, name_sl || null, summit_id || null, difficulty, distance_km || null,
       elevation_gain_m || null, activity_type || 'hiking', description || null,
       description_sl || null, approved, id]
    );
    if (result.rows.length === 0) return res.status(404).json({ error: 'Trail not found' });
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── DELETE /admin/trails/:id ──────────────────────────────────────────────────
router.delete('/trails/:id', requireAdmin, async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query('DELETE FROM trails WHERE id=$1 RETURNING id', [id]);
    if (result.rows.length === 0) return res.status(404).json({ error: 'Trail not found' });
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = { router, requireAdmin };
