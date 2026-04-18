const express = require('express');
const cors = require('cors');
require('dotenv').config();
const pool = require('./db');
const summitsRouter = require('./routes/summits');
const climbingRoutesRouter = require('./routes/climbing_routes');
const trailsRouter = require('./routes/trails');
const authRouter = require('./routes/auth');
const conditionsRouter = require('./routes/conditions');
const photosRouter = require('./routes/photos');
const { router: adminRouter } = require('./routes/admin');
const ticklistRouter = require('./routes/ticklist');
const weatherRouter = require('./routes/weather');
const areasRouter = require('./routes/areas');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, '../client')));

// API routes (all under /api/)
app.get('/api', (req, res) => res.json({ message: 'Na Vrh API 🏔️' }));
app.use('/api/summits', summitsRouter);
app.use('/api/climbing-routes', climbingRoutesRouter);
app.use('/api/trails', trailsRouter);
app.use('/api/auth', authRouter);
app.use('/api/conditions', conditionsRouter);
app.use('/api/photos', photosRouter);
app.use('/api/ticklist', ticklistRouter);
app.use('/api/weather', weatherRouter);
app.use('/api/areas', areasRouter);

// Admin panel (keep at /admin-api for admin.html)
app.use('/admin-api', adminRouter);
app.get('/admin', (_req, res) => {
  res.sendFile(path.join(__dirname, '../client/admin.html'));
});

// Catch-all: serve index.html for all page routes (SPA client-side routing)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../client/index.html'));
});

app.listen(PORT, () => {
  console.log(`Vrh server running on port ${PORT}`);
});
