const express = require('express');
const router = express.Router();
const pool = require('../db');

// GET all areas with summit counts
router.get('/', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT a.*, COUNT(s.id)::int AS summit_count
      FROM areas a
      LEFT JOIN summits s ON s.area_id = a.id
      GROUP BY a.id
      ORDER BY a.name
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET area by slug with its summits
router.get('/:slug', async (req, res) => {
  try {
    const { slug } = req.params;
    const areaRes = await pool.query('SELECT * FROM areas WHERE slug = $1', [slug]);
    if (areaRes.rows.length === 0) return res.status(404).json({ error: 'Area not found' });
    const area = areaRes.rows[0];
    const summitsRes = await pool.query(
      'SELECT * FROM summits WHERE area_id = $1 ORDER BY elevation_m DESC',
      [area.id]
    );
    res.json({ ...area, summits: summitsRes.rows });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
