
const express = require('express');
const app = express();
const pasienRoutes = require('./routes/pasien');

app.use(express.json());

// Halaman utama untuk mengecek server
app.get('/', (req, res) => {
    res.json({
        message: 'API Sistem Informasi Klinik berhasil dijalankan!'
    });
});

// Menggunakan routes pasien
app.use('/api/pasien', pasienRoutes);

// Menjalankan server
const PORT = process.env.PORT || 3000;

require('dotenv').config();

app.listen(PORT, () => {
    console.log(`Server berjalan di http://localhost:${PORT}`);
});