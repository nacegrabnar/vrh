const express = require('express');
const router = express.Router();
const pool = require('../db');

function toSlug(name) {
  if (!name) return '';
  return name.toLowerCase()
    .replace(/č/g, 'c').replace(/š/g, 's').replace(/ž/g, 'z').replace(/đ/g, 'd')
    .replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
}

// GET all trails (approved only by default; ?all=true returns all)
router.get('/', async (req, res) => {
  try {
    const showAll = req.query.all === 'true';
    const where = showAll ? '' : 'WHERE t.is_approved = true';
    const result = await pool.query(
      `SELECT t.*, s.name AS summit_name FROM trails t LEFT JOIN summits s ON t.summit_id = s.id ${where} ORDER BY t.difficulty ASC`
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET trail by slug (must be before /:id)
router.get('/by-slug/:slug', async (req, res) => {
  try {
    const { slug } = req.params;
    const result = await pool.query(
      'SELECT t.*, s.name AS summit_name FROM trails t LEFT JOIN summits s ON t.summit_id = s.id'
    );
    const trail = result.rows.find(t =>
      toSlug(t.name) === slug || toSlug(t.name_sl || '') === slug
    );
    if (!trail) return res.status(404).json({ error: 'Trail not found' });
    res.json(trail);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET trails for a specific summit
router.get('/summit/:summit_id', async (req, res) => {
  try {
    const { summit_id } = req.params;
    const result = await pool.query(
      'SELECT * FROM trails WHERE summit_id = $1',
      [summit_id]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET single trail by id
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      'SELECT t.*, s.name AS summit_name FROM trails t LEFT JOIN summits s ON t.summit_id = s.id WHERE t.id = $1',
      [id]
    );
    if (result.rows.length === 0) return res.status(404).json({ error: 'Trail not found' });
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST create a new trail
router.post('/', async (req, res) => {
  try {
    const { summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, description, description_sl } = req.body;
    const result = await pool.query(
      `INSERT INTO trails (summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, description, description_sl)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
      [summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, description, description_sl || null]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
