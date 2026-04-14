const express = require('express');
const router = express.Router();
const pool = require('../db');

// GET all trails
router.get('/', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM trails ORDER BY difficulty ASC'
    );
    res.json(result.rows);
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

// GET single trail
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      'SELECT * FROM trails WHERE id = $1',
      [id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Trail not found' });
    }
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
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
       RETURNING *`,
      [summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, description, description_sl || null]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;