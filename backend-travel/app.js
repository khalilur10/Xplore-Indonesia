const express = require('express');
const path = require('path');
const { sequelize } = require('./models');
const userRoutes = require('./routes/users');
const authRoutes = require('./routes/auth');
const destinasiRoutes = require('./routes/destinasi');
const reviewRoutes = require('./routes/reviews');
const internalRoutes = require('./routes/internals');
const cors = require('cors');
const bodyParser = require('body-parser');
const fs = require('fs');

const app = express();
app.use(bodyParser.json({ limit: '10mb' }));
app.use(bodyParser.urlencoded({ limit: '10mb', extended: true }));

const PORT = process.env.PORT || 3000;
const BASE_URL = `http://localhost:${PORT}/api`;

app.use(cors({
  origin: '*',
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
}));


const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// Serve uploads folder as static
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.use('/api/users', userRoutes);
app.use('/api/auth', authRoutes);
app.use('/api/destinasi', destinasiRoutes);
app.use('/api/reviews', reviewRoutes);
app.use('/api/internals', internalRoutes);
 // Gunakan localhost

app.listen(PORT, async () => {
  console.log(`Server is running on port ${PORT}`);
  console.log(`Base URL for API: ${BASE_URL}`);
  
  try {
    await sequelize.authenticate();
    console.log('Database connected!');
  } catch (error) {
    console.error('Unable to connect to the database:', error);
  }
});
