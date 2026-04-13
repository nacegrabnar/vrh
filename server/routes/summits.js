const express = require('express');
const router = express.Router();
const pool = require('../db');

// GET all summits
router.get('/', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM summits ORDER BY elevation_m DESC'
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET single summit by id
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      'SELECT * FROM summits WHERE id = $1',
      [id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Summit not found' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST create a new summit
router.post('/', async (req, res) => {
  try {
    const { name, name_sl, elevation_m, description, type } = req.body;
    const result = await pool.query(
      `INSERT INTO summits (name, name_sl, elevation_m, description, type)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING *`,
      [name, name_sl, elevation_m, description, type]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;