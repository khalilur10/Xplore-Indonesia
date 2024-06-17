const fs = require('fs');
const path = require('path');
const { v4: uuidv4 } = require('uuid');

const saveBase64Image = (base64String) => {
  // Ekstrak data base64 dan tipe file
  const matches = base64String.match(/^data:(.+);base64,(.+)$/);
  if (!matches || matches.length !== 3) {
    throw new Error('Invalid base64 string');
  }
  const ext = matches[1].split('/')[1]; // Dapatkan ekstensi file, misalnya png atau jpg
  const imageData = matches[2]; // Data base64
  const buffer = Buffer.from(imageData, 'base64'); // Konversi base64 menjadi buffer

  // Buat nama file unik
  const fileName = `${uuidv4()}.${ext}`;
  const uploadDir = path.join(__dirname, '../uploads');
  const filePath = path.join(uploadDir, fileName);

  // Pastikan direktori 'uploads' ada, jika tidak buat
  if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
  }

  // Tulis file ke sistem
  fs.writeFileSync(filePath, buffer);

  // Kembalikan path relatif untuk digunakan sebagai URL
  return `/uploads/${fileName}`;
};

module.exports = {
  saveBase64Image
};
