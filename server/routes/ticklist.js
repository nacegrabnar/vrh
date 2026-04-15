const express = require('express');
const router = express.Router();
const pool = require('../db');
const jwt = require('jsonwebtoken');

function requireAuth(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ error: 'Login required' });
  try {
    const token = authHeader.split(' ')[1];
    req.user = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch {
    res.status(401).json({ error: 'Invalid token' });
  }
}

// GET /ticklist/me — all ticks for the current user
router.get('/me', requireAuth, async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT t.*,
        s.name  AS summit_name,  s.name_sl AS summit_name_sl,  s.elevation_m, s.type AS summit_type,
        tr.name AS trail_name,   tr.name_sl AS trail_name_sl,  tr.difficulty, tr.distance_km, tr.activity_type,
        cr.name AS route_name,   cr.name_sl AS route_name_sl,  cr.grade_french, cr.grade_uiaa, cr.type AS route_type
       FROM ticklist t
       LEFT JOIN summits s         ON t.summit_id         = s.id
       LEFT JOIN trails tr         ON t.trail_id          = tr.id
       LEFT JOIN climbing_routes cr ON t.climbing_route_id = cr.id
       WHERE t.user_id = $1
       ORDER BY t.created_at DESC`,
      [req.user.id]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET /ticklist/check — which items has the user ticked? returns sets of IDs
router.get('/check', requireAuth, async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT id, summit_id, trail_id, climbing_route_id
       FROM ticklist WHERE user_id = $1`,
      [req.user.id]
    );
    const summits   = {};
    const trails    = {};
    const routes    = {};
    for (const row of result.rows) {
      if (row.summit_id)         summits[row.summit_id]           = row.id;
      if (row.trail_id)          trails[row.trail_id]             = row.id;
      if (row.climbing_route_id) routes[row.climbing_route_id]    = row.id;
    }
    res.json({ summits, trails, routes });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST /ticklist — add a tick
router.post('/', requireAuth, async (req, res) => {
  try {
    const { summit_id, trail_id, climbing_route_id, ascent_date, notes } = req.body;
    const result = await pool.query(
      `INSERT INTO ticklist (user_id, summit_id, trail_id, climbing_route_id, ascent_date, notes)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING *`,
      [req.user.id, summit_id || null, trail_id || null, climbing_route_id || null, ascent_date || null, notes || null]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    if (err.code === '23505') return res.status(409).json({ error: 'Already ticked' });
    res.status(500).json({ error: err.message });
  }
});

// DELETE /ticklist/:id — remove a tick (must own it)
router.delete('/:id', requireAuth, async (req, res) => {
  try {
    const result = await pool.query(
      `DELETE FROM ticklist WHERE id = $1 AND user_id = $2 RETURNING id`,
      [req.params.id, req.user.id]
    );
    if (result.rows.length === 0) return res.status(404).json({ error: 'Tick not found' });
    res.json({ deleted: result.rows[0].id });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
