
const express = require('express');
const router = express.Router();
const pool = require('../config/db');

// 1. GET: Menampilkan semua data pasien
router.get('/', async (req, res) => {
    try {
        const result = await pool.query(
            'SELECT * FROM pasien ORDER BY id_pasien ASC'
        );

        res.json(result.rows);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// 2. GET: Menampilkan pasien berdasarkan ID
router.get('/:id', async (req, res) => {
    try {
        const { id } = req.params;

        const result = await pool.query(
            'SELECT * FROM pasien WHERE id_pasien = $1',
            [id]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                message: 'Data pasien tidak ditemukan'
            });
        }

        res.json(result.rows[0]);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// 3. POST: Menambahkan pasien baru
router.post('/', async (req, res) => {
    try {
        const {
            nama_pasien,
            nik,
            tanggal_lahir,
            jenis_kelamin,
            alamat,
            no_telepon
        } = req.body;

        const result = await pool.query(
            `INSERT INTO pasien
            (nama_pasien, nik, tanggal_lahir, jenis_kelamin, alamat, no_telepon)
            VALUES ($1, $2, $3, $4, $5, $6)
            RETURNING *`,
            [
                nama_pasien,
                nik,
                tanggal_lahir || null,
                jenis_kelamin || null,
                alamat || null,
                no_telepon || null
            ]
        );

        res.status(201).json({
            message: 'Data pasien berhasil ditambahkan',
            data: result.rows[0]
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// 4. PUT: Mengubah data pasien
router.put('/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const {
            nama_pasien,
            nik,
            tanggal_lahir,
            jenis_kelamin,
            alamat,
            no_telepon
        } = req.body;

        const result = await pool.query(
            `UPDATE pasien
            SET nama_pasien = $1,
                nik = $2,
                tanggal_lahir = $3,
                jenis_kelamin = $4,
                alamat = $5,
                no_telepon = $6
            WHERE id_pasien = $7
            RETURNING *`,
            [
                nama_pasien,
                nik,
                tanggal_lahir || null,
                jenis_kelamin || null,
                alamat || null,
                no_telepon || null,
                id
            ]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                message: 'Data pasien tidak ditemukan'
            });
        }

        res.json({
            message: 'Data pasien berhasil diperbarui',
            data: result.rows[0]
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// 5. DELETE: Menghapus data pasien
router.delete('/:id', async (req, res) => {
    try {
        const { id } = req.params;

        const result = await pool.query(
            'DELETE FROM pasien WHERE id_pasien = $1 RETURNING *',
            [id]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                message: 'Data pasien tidak ditemukan'
            });
        }

        res.json({
            message: 'Data pasien berhasil dihapus',
            data: result.rows[0]
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = router;