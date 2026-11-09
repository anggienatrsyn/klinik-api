CREATE TABLE pasien (
    id_pasien SERIAL PRIMARY KEY,
    nama_pasien VARCHAR(100) NOT NULL,
    nik VARCHAR(16) UNIQUE NOT NULL,
    tanggal_lahir DATE,
    jenis_kelamin VARCHAR(15),
    alamat TEXT,
    no_telepon VARCHAR(15)
);

CREATE TABLE akun (
    id_akun SERIAL PRIMARY KEY,
    id_pasien INT UNIQUE NOT NULL REFERENCES pasien(id_pasien),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE poli (
    id_poli SERIAL PRIMARY KEY,
    nama_poli VARCHAR(100) NOT NULL,
    deskripsi TEXT
);

CREATE TABLE dokter (
    id_dokter SERIAL PRIMARY KEY,
    nama_dokter VARCHAR(100) NOT NULL,
    spesialisasi VARCHAR(100),
    no_telepon VARCHAR(15)
);

CREATE TABLE dokter_poli (
    id_dokter_poli SERIAL PRIMARY KEY,
    id_dokter INT NOT NULL REFERENCES dokter(id_dokter),
    id_poli INT NOT NULL REFERENCES poli(id_poli),
    UNIQUE (id_dokter, id_poli)
);

CREATE TABLE pendaftaran (
    id_pendaftaran SERIAL PRIMARY KEY,
    id_pasien INT NOT NULL REFERENCES pasien(id_pasien),
    id_dokter INT NOT NULL REFERENCES dokter(id_dokter),
    tanggal_kunjungan DATE NOT NULL,
    keluhan TEXT,
    status VARCHAR(30)
);

CREATE TABLE pemeriksaan (
    id_pemeriksaan SERIAL PRIMARY KEY,
    id_pendaftaran INT UNIQUE NOT NULL REFERENCES pendaftaran(id_pendaftaran),
    diagnosa TEXT,
    tindakan TEXT,
    resep_obat TEXT,
    tanggal_pemeriksaan DATE
);

CREATE TABLE jadwal_dokter (
    id_jadwal SERIAL PRIMARY KEY,
    id_dokter INT NOT NULL REFERENCES dokter(id_dokter),
    hari VARCHAR(15) NOT NULL,
    jam_mulai TIME,
    jam_selesai TIME
);


INSERT INTO pasien
(nama_pasien, nik, tanggal_lahir, jenis_kelamin, alamat, no_telepon)
VALUES
('Andi Saputra', '1234567890123456', '2000-05-12', 'Laki-laki', 'Surabaya', '081234567801'),
('Siti Amelia', '1234567890123457', '2002-08-20', 'Perempuan', 'Sidoarjo', '081234567802'),
('Budi Santoso', '1234567890123458', '1998-03-15', 'Laki-laki', 'Gresik', '081234567803');

INSERT INTO akun (id_pasien, username, password)
VALUES
(1, 'andi', 'dummy_hash_andi'),
(2, 'siti', 'dummy_hash_siti'),
(3, 'budi', 'dummy_hash_budi');

INSERT INTO poli (nama_poli, deskripsi)
VALUES
('Poli Umum', 'Pelayanan kesehatan umum'),
('Poli Gigi', 'Pelayanan kesehatan gigi dan mulut'),
('Poli Anak', 'Pelayanan kesehatan anak');

INSERT INTO dokter (nama_dokter, spesialisasi, no_telepon)
VALUES
('Dr. Ahmad', 'Dokter Umum', '081234567811'),
('Dr. Rina', 'Dokter Gigi', '081234567812'),
('Dr. Maya', 'Dokter Anak', '081234567813');

INSERT INTO dokter_poli (id_dokter, id_poli)
VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 2);

INSERT INTO pendaftaran
(id_pasien, id_dokter, tanggal_kunjungan, keluhan, status)
VALUES
(1, 1, '2026-11-10', 'Demam dan batuk', 'Menunggu'),
(2, 2, '2026-11-10', 'Sakit gigi', 'Terdaftar'),
(3, 3, '2026-11-11', 'Pemeriksaan kesehatan', 'Menunggu');

INSERT INTO pemeriksaan
(id_pendaftaran, diagnosa, tindakan, resep_obat, tanggal_pemeriksaan)
VALUES
(1, 'Demam ringan', 'Pemeriksaan umum', 'Paracetamol', '2026-11-10');

INSERT INTO jadwal_dokter
(id_dokter, hari, jam_mulai, jam_selesai)
VALUES
(1, 'Senin', '08:00', '12:00'),
(2, 'Selasa', '09:00', '13:00'),
(3, 'Rabu', '08:00', '12:00');