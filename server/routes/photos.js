const express = require('express');
const router = express.Router();
const pool = require('../db');
const jwt = require('jsonwebtoken');
const multer = require('multer');
const path = require('path');

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

const storage = multer.diskStorage({
  destination: path.join(__dirname, '../../client/uploads'),
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname).toLowerCase();
    cb(null, `${Date.now()}-${Math.random().toString(36).slice(2)}${ext}`);
  }
});

const upload = multer({
  storage,
  limits: { fileSize: 8 * 1024 * 1024 },
  fileFilter: (req, file, cb) => {
    if (file.mimetype.startsWith('image/')) cb(null, true);
    else cb(new Error('Only image files are allowed'));
  }
});

// GET photos for a trail
router.get('/trail/:trail_id', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT p.*, u.username FROM photos p
       JOIN users u ON p.user_id = u.id
       WHERE p.trail_id = $1
       ORDER BY p.taken_at DESC`,
      [req.params.trail_id]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET photos for a climbing route
router.get('/climbing/:route_id', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT p.*, u.username FROM photos p
       JOIN users u ON p.user_id = u.id
       WHERE p.climbing_route_id = $1
       ORDER BY p.taken_at DESC`,
      [req.params.route_id]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST upload photo for a trail
router.post('/trail/:trail_id', requireAuth, upload.single('photo'), async (req, res) => {
  try {
    const url = `/uploads/${req.file.filename}`;
    const caption = req.body.caption || null;
    const result = await pool.query(
      `INSERT INTO photos (user_id, trail_id, url, caption)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [req.user.id, req.params.trail_id, url, caption]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST upload photo for a climbing route
router.post('/climbing/:route_id', requireAuth, upload.single('photo'), async (req, res) => {
  try {
    const url = `/uploads/${req.file.filename}`;
    const caption = req.body.caption || null;
    const result = await pool.query(
      `INSERT INTO photos (user_id, climbing_route_id, url, caption)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [req.user.id, req.params.route_id, url, caption]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
