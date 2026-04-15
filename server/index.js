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
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.static('client'));

app.get('/api', (req, res) => {
  res.json({ message: 'Welcome to Vrh API! 🏔️' });
});

app.use('/summits', summitsRouter);
app.use('/climbing-routes', climbingRoutesRouter);
app.use('/trails', trailsRouter);
app.use('/auth', authRouter);
app.use('/conditions', conditionsRouter);
app.use('/photos', photosRouter);
app.use('/admin-api', adminRouter);
app.use('/ticklist', ticklistRouter);

app.get('/admin', (_req, res) => {
  res.sendFile(path.join(__dirname, '../client/admin.html'));
});

app.listen(PORT, () => {
  console.log(`Vrh server running on port ${PORT}`);
});