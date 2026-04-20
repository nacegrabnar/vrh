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

module.exports = { router, requireAdmin };
