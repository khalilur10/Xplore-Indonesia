-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Jun 2024 pada 12.21
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `travel_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `destinasi`
--

CREATE TABLE `destinasi` (
  `destinasi_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `daerah` varchar(255) NOT NULL,
  `negara` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `images` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deskripsi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `destinasi`
--

INSERT INTO `destinasi` (`destinasi_id`, `name`, `daerah`, `negara`, `alamat`, `images`, `created_at`, `updated_at`, `deskripsi`) VALUES
(1, 'Pantai Kuta', 'Bali', 'Indonesia', 'Jl. Pantai Kuta, Kuta, Badung, Bali', '/uploads/db81f607-2169-4a7a-8d11-7d07215c5b7c.png', '2024-06-14 04:51:05', '2024-06-14 04:51:05', 'Pantai yang sangat indah dengan pasir putih.'),
(2, 'TES', 'TES DAERAH', 'Indonesia', 'ALAMAT', '/uploads/1abbd0a4-52b7-49f6-ae12-fcbabf4c4c05.png', '2024-06-15 07:24:56', '2024-06-15 07:24:56', 'deskripsi deskripsi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `internals`
--

CREATE TABLE `internals` (
  `internal_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `column` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `xs1` varchar(255) DEFAULT NULL,
  `xs2` varchar(255) DEFAULT NULL,
  `xs3` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `destinasi_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `komentar` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `reviews`
--

INSERT INTO `reviews` (`review_id`, `user_id`, `destinasi_id`, `rating`, `komentar`, `created_at`) VALUES
(1, 1, 1, 5, 'Tempat yang sangat indah, sangat direkomendasikan!', '2024-06-15 09:29:15'),
(2, 6, 2, 5, 'tes', '2024-06-15 10:07:36');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sequelizemeta`
--

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data untuk tabel `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('20240519045251-create-user.js'),
('20240519051941-create-destinasi.js'),
('20240519053033-add-deskripsi-to-destinasi.js'),
('20240519053410-create-review.js'),
('20240519054158-create-internal.js');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `code`, `name`, `phone`, `email`, `password`, `created_at`) VALUES
(1, 'USR001', 'John Doe', '1234567890', 'john.doe@example.com', '$2b$10$OnstVIQBlqAbpvgXBKER0eLe0N7yUxMn7ksQoclnPYHbva39.1AV.', '2024-05-19 05:48:57'),
(3, 'USR002', 'John Do2', '1234567890', 'john2.doe@example.com', '$2b$10$lUreK.461k0QqwFtFKDxkOUpPxxYDekXTJxWK/sz.7dpJNi5J7IaW', '2024-05-19 07:12:59'),
(4, 'USR001', 'user', '08123123', 'user@gmail.com', '$2b$10$x/F0PdpaH105rt3AABvnZupS7C.Whl.NU.E4ymT3JjjtlN9EvKj2e', '2024-06-08 13:26:42'),
(5, 'USR001', 'user123', '09830483', 'user123@gmail.com', '$2b$10$rKFtxOcE3GAOpCbd2snTJe6SKtQQj4mvgn0dwtvkHdeuJcmdKBP.W', '2024-06-08 13:49:08'),
(6, 'admin', 'admin', '08512345678', 'admin@gmail.com', '$2b$10$/3AJtGeFh0qAVXm7LiMIAe62P4N/EafJfwBp4MkLwMz8eCmHom32K', '2024-06-11 16:38:26');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `destinasi`
--
ALTER TABLE `destinasi`
  ADD PRIMARY KEY (`destinasi_id`);

--
-- Indeks untuk tabel `internals`
--
ALTER TABLE `internals`
  ADD PRIMARY KEY (`internal_id`);

--
-- Indeks untuk tabel `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `destinasi_id` (`destinasi_id`);

--
-- Indeks untuk tabel `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `destinasi`
--
ALTER TABLE `destinasi`
  MODIFY `destinasi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `internals`
--
ALTER TABLE `internals`
  MODIFY `internal_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`destinasi_id`) REFERENCES `destinasi` (`destinasi_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
