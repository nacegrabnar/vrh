const express = require('express');
const cors = require('cors');
require('dotenv').config();
const pool = require('./db');
const summitsRouter = require('./routes/summits');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({ message: 'Welcome to Vrh API! 🏔️' });
});

app.use('/summits', summitsRouter);

app.listen(PORT, () => {
  console.log(`Vrh server running on port ${PORT}`);
});