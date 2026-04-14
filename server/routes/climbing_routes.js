const express = require('express');
const router = express.Router();
const pool = require('../db');

// GET all climbing routes
router.get('/', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM climbing_routes ORDER BY grade_french ASC'
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET climbing routes for a specific summit
router.get('/summit/:summit_id', async (req, res) => {
  try {
    const { summit_id } = req.params;
    const result = await pool.query(
      'SELECT * FROM climbing_routes WHERE summit_id = $1 ORDER BY grade_french ASC',
      [summit_id]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET single climbing route
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      'SELECT * FROM climbing_routes WHERE id = $1',
      [id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Route not found' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST create a new climbing route
router.post('/', async (req, res) => {
  try {
    const { summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, description_sl } = req.body;
    const result = await pool.query(
      `INSERT INTO climbing_routes
        (summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, description_sl)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
       RETURNING *`,
      [summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, description_sl || null]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;