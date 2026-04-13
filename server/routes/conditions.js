const express = require('express');
const router = express.Router();
const pool = require('../db');
const jwt = require('jsonwebtoken');

// Middleware to check if user is logged in
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

// GET conditions for a trail
router.get('/trail/:trail_id', async (req, res) => {
  try {
    const { trail_id } = req.params;
    const result = await pool.query(
      `SELECT c.*, u.username 
       FROM conditions_reports c
       JOIN users u ON c.user_id = u.id
       WHERE c.trail_id = $1
       ORDER BY c.reported_at DESC`,
      [trail_id]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET conditions for a climbing route
router.get('/climbing/:route_id', async (req, res) => {
  try {
    const { route_id } = req.params;
    const result = await pool.query(
      `SELECT c.*, u.username 
       FROM conditions_reports c
       JOIN users u ON c.user_id = u.id
       WHERE c.climbing_route_id = $1
       ORDER BY c.reported_at DESC`,
      [route_id]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET all recent conditions
router.get('/recent', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT c.*, u.username,
        t.name as trail_name,
        cr.name as route_name
       FROM conditions_reports c
       JOIN users u ON c.user_id = u.id
       LEFT JOIN trails t ON c.trail_id = t.id
       LEFT JOIN climbing_routes cr ON c.climbing_route_id = cr.id
       ORDER BY c.reported_at DESC
       LIMIT 20`,
      []
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST new conditions report (requires login)
router.post('/', requireAuth, async (req, res) => {
  try {
    const { trail_id, climbing_route_id, status, notes } = req.body;
    const result = await pool.query(
      `INSERT INTO conditions_reports (user_id, trail_id, climbing_route_id, status, notes)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING *`,
      [req.user.id, trail_id || null, climbing_route_id || null, status, notes]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;