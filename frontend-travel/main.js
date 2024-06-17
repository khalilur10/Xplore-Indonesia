const express = require('express');
const path = require('path');

const app = express();
const port = 4000; // Ganti port menjadi 4000

// Middleware untuk melayani file statis
app.use(express.static(path.join(__dirname, 'public')));

// Rute untuk menangani semua permintaan dan mengirimkan index.html
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(port, () => {
  console.log(`Server berjalan di http://localhost:${port}`);
});
