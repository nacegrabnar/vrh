const express = require('express');
const router = express.Router();
const pool = require('../db');

// GET summits
// ?type=summits → peaks >= 1800m plus all crags
// ?type=hills   → peaks < 1800m only
// (no param)    → all rows
router.get('/', async (req, res) => {
  try {
    const type = req.query.type;
    let rows;

    const latLng = ', s.latitude, s.longitude';
    if (type === 'hills') {
      const result = await pool.query(
        'SELECT s.*, a.name AS area_name' + latLng +
        ' FROM summits s' +
        ' LEFT JOIN areas a ON s.area_id = a.id' +
        " WHERE s.type = 'peak' AND s.elevation_m < 1800" +
        ' ORDER BY s.elevation_m DESC'
      );
      rows = result.rows;
    } else if (type === 'summits') {
      const result = await pool.query(
        'SELECT s.*, a.name AS area_name' + latLng +
        ' FROM summits s' +
        ' LEFT JOIN areas a ON s.area_id = a.id' +
        " WHERE (s.type = 'peak' AND s.elevation_m >= 1800) OR s.type = 'crag'" +
        ' ORDER BY s.elevation_m DESC'
      );
      rows = result.rows;
    } else {
      const result = await pool.query(
        'SELECT s.*, a.name AS area_name' + latLng +
        ' FROM summits s' +
        ' LEFT JOIN areas a ON s.area_id = a.id' +
        ' ORDER BY s.elevation_m DESC'
      );
      rows = result.rows;
    }

    res.json(rows);
  } catch (err) {
    console.error('GET /summits error:', err.message);
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
    const { name, name_sl, area_id, elevation_m, description, description_sl, type, difficulty } = req.body;
    const result = await pool.query(
      `INSERT INTO summits (name, name_sl, area_id, elevation_m, description, description_sl, type, difficulty)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
       RETURNING *`,
      [name, name_sl, area_id || null, elevation_m, description, description_sl || null, type, difficulty || null]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;