const express = require('express');
const cors = require('cors');
require('dotenv').config();
const pool = require('./db');
const summitsRouter = require('./routes/summits');
const climbingRoutesRouter = require('./routes/climbing_routes');
const trailsRouter = require('./routes/trails');
const authRouter = require('./routes/auth');
const conditionsRouter = require('./routes/conditions');

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

app.listen(PORT, () => {
  console.log(`Vrh server running on port ${PORT}`);
});