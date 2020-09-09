-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 09 Sep 2020 pada 08.57
-- Versi server: 10.1.37-MariaDB
-- Versi PHP: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ci_online_test`
--
CREATE DATABASE IF NOT EXISTS `ci_online_test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ci_online_test`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

DROP TABLE IF EXISTS `dosen`;
CREATE TABLE IF NOT EXISTS `dosen` (
  `id_dosen` int(11) NOT NULL AUTO_INCREMENT,
  `nip` char(12) NOT NULL,
  `nama_dosen` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  PRIMARY KEY (`id_dosen`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nip` (`nip`),
  KEY `matkul_id` (`matkul_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `dosen`
--

INSERT INTO `dosen` (`id_dosen`, `nip`, `nama_dosen`, `email`, `matkul_id`) VALUES
(1, '11111111', 'Vikky', 'vikky@gmail.com', 2),
(2, '22222222', 'Fikri', 'fikri@gmai.com', 1);

--
-- Trigger `dosen`
--
DROP TRIGGER IF EXISTS `edit_user_dosen`;
DELIMITER $$
CREATE TRIGGER `edit_user_dosen` BEFORE UPDATE ON `dosen` FOR EACH ROW UPDATE `users` SET `email` = NEW.email, `username` = NEW.nip WHERE `users`.`username` = OLD.nip
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `hapus_user_dosen`;
DELIMITER $$
CREATE TRIGGER `hapus_user_dosen` BEFORE DELETE ON `dosen` FOR EACH ROW DELETE FROM `users` WHERE `users`.`username` = OLD.nip
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'admin', 'Administrator'),
(2, 'dosen', 'Pembuat Soal dan ujian'),
(3, 'mahasiswa', 'Peserta Ujian');

-- --------------------------------------------------------

--
-- Struktur dari tabel `h_ujian`
--

DROP TABLE IF EXISTS `h_ujian`;
CREATE TABLE IF NOT EXISTS `h_ujian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ujian_id` int(11) NOT NULL,
  `mahasiswa_id` int(11) NOT NULL,
  `list_soal` longtext NOT NULL,
  `list_jawaban` longtext NOT NULL,
  `jml_benar` int(11) NOT NULL,
  `nilai` decimal(10,2) NOT NULL,
  `nilai_bobot` decimal(10,2) NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `tgl_selesai` datetime NOT NULL,
  `status` enum('Y','N') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ujian_id` (`ujian_id`),
  KEY `mahasiswa_id` (`mahasiswa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `h_ujian`
--

INSERT INTO `h_ujian` (`id`, `ujian_id`, `mahasiswa_id`, `list_soal`, `list_jawaban`, `jml_benar`, `nilai`, `nilai_bobot`, `tgl_mulai`, `tgl_selesai`, `status`) VALUES
(1, 3, 2, '2', '2:A:N', 0, '0.00', '100.00', '2020-09-09 13:35:37', '2020-09-09 13:37:37', 'N'),
(2, 4, 2, '2,3', '2:B:N,3:B:N', 1, '50.00', '100.00', '2020-09-09 13:43:48', '2020-09-09 13:44:48', 'N');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan`
--

DROP TABLE IF EXISTS `jurusan`;
CREATE TABLE IF NOT EXISTS `jurusan` (
  `id_jurusan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_jurusan` varchar(30) NOT NULL,
  PRIMARY KEY (`id_jurusan`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `jurusan`
--

INSERT INTO `jurusan` (`id_jurusan`, `nama_jurusan`) VALUES
(1, 'Management Informatika'),
(2, 'Sistem Informasi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan_matkul`
--

DROP TABLE IF EXISTS `jurusan_matkul`;
CREATE TABLE IF NOT EXISTS `jurusan_matkul` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matkul_id` int(11) NOT NULL,
  `jurusan_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jurusan_id` (`jurusan_id`),
  KEY `matkul_id` (`matkul_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `jurusan_matkul`
--

INSERT INTO `jurusan_matkul` (`id`, `matkul_id`, `jurusan_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas`
--

DROP TABLE IF EXISTS `kelas`;
CREATE TABLE IF NOT EXISTS `kelas` (
  `id_kelas` int(11) NOT NULL AUTO_INCREMENT,
  `nama_kelas` varchar(30) NOT NULL,
  `jurusan_id` int(11) NOT NULL,
  PRIMARY KEY (`id_kelas`),
  KEY `jurusan_id` (`jurusan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `kelas`
--

INSERT INTO `kelas` (`id_kelas`, `nama_kelas`, `jurusan_id`) VALUES
(1, '1A', 2),
(2, '1B', 2),
(4, '2A', 1),
(5, '2B', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas_dosen`
--

DROP TABLE IF EXISTS `kelas_dosen`;
CREATE TABLE IF NOT EXISTS `kelas_dosen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kelas_id` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `kelas_id` (`kelas_id`),
  KEY `dosen_id` (`dosen_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `kelas_dosen`
--

INSERT INTO `kelas_dosen` (`id`, `kelas_id`, `dosen_id`) VALUES
(3, 1, 1),
(4, 4, 1),
(5, 2, 2),
(6, 5, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

DROP TABLE IF EXISTS `mahasiswa`;
CREATE TABLE IF NOT EXISTS `mahasiswa` (
  `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `nim` char(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `kelas_id` int(11) NOT NULL COMMENT 'kelas&jurusan',
  PRIMARY KEY (`id_mahasiswa`),
  UNIQUE KEY `nim` (`nim`),
  UNIQUE KEY `email` (`email`),
  KEY `kelas_id` (`kelas_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`id_mahasiswa`, `nama`, `nim`, `email`, `jenis_kelamin`, `kelas_id`) VALUES
(2, 'diki', '01111111', 'diki@gmail.com', 'L', 5),
(3, 'Putri', '02222222', 'putri@gmail.com', 'P', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `matkul`
--

DROP TABLE IF EXISTS `matkul`;
CREATE TABLE IF NOT EXISTS `matkul` (
  `id_matkul` int(11) NOT NULL AUTO_INCREMENT,
  `nama_matkul` varchar(50) NOT NULL,
  PRIMARY KEY (`id_matkul`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `matkul`
--

INSERT INTO `matkul` (`id_matkul`, `nama_matkul`) VALUES
(1, 'Bahasa Indonesia'),
(2, 'Bahasa Inggris');

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_ujian`
--

DROP TABLE IF EXISTS `m_ujian`;
CREATE TABLE IF NOT EXISTS `m_ujian` (
  `id_ujian` int(11) NOT NULL AUTO_INCREMENT,
  `dosen_id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `nama_ujian` varchar(200) NOT NULL,
  `jumlah_soal` int(11) NOT NULL,
  `waktu` int(11) NOT NULL,
  `jenis` enum('acak','urut') NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `terlambat` datetime NOT NULL,
  `token` varchar(5) NOT NULL,
  PRIMARY KEY (`id_ujian`),
  KEY `matkul_id` (`matkul_id`),
  KEY `dosen_id` (`dosen_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `m_ujian`
--

INSERT INTO `m_ujian` (`id_ujian`, `dosen_id`, `matkul_id`, `nama_ujian`, `jumlah_soal`, `waktu`, `jenis`, `tgl_mulai`, `terlambat`, `token`) VALUES
(1, 2, 1, 'Bahasa indo', 1, 3, 'urut', '2020-09-09 13:21:28', '2020-09-09 13:21:34', 'WHSXN'),
(3, 2, 1, 'INDO', 1, 2, 'acak', '2020-09-09 13:34:38', '2020-09-10 13:34:42', 'IFTHL'),
(4, 2, 1, 'test', 2, 1, 'acak', '2020-09-09 13:42:50', '2020-09-10 13:42:54', 'SVKOI');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_soal`
--

DROP TABLE IF EXISTS `tb_soal`;
CREATE TABLE IF NOT EXISTS `tb_soal` (
  `id_soal` int(11) NOT NULL AUTO_INCREMENT,
  `dosen_id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `bobot` int(11) NOT NULL,
  `file` varchar(255) NOT NULL,
  `tipe_file` varchar(50) NOT NULL,
  `soal` longtext NOT NULL,
  `opsi_a` longtext NOT NULL,
  `opsi_b` longtext NOT NULL,
  `opsi_c` longtext NOT NULL,
  `opsi_d` longtext NOT NULL,
  `opsi_e` longtext NOT NULL,
  `file_a` varchar(255) NOT NULL,
  `file_b` varchar(255) NOT NULL,
  `file_c` varchar(255) NOT NULL,
  `file_d` varchar(255) NOT NULL,
  `file_e` varchar(255) NOT NULL,
  `jawaban` varchar(5) NOT NULL,
  `created_on` int(11) NOT NULL,
  `updated_on` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_soal`),
  KEY `matkul_id` (`matkul_id`),
  KEY `dosen_id` (`dosen_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tb_soal`
--

INSERT INTO `tb_soal` (`id_soal`, `dosen_id`, `matkul_id`, `bobot`, `file`, `tipe_file`, `soal`, `opsi_a`, `opsi_b`, `opsi_c`, `opsi_d`, `opsi_e`, `file_a`, `file_b`, `file_c`, `file_d`, `file_e`, `jawaban`, `created_on`, `updated_on`) VALUES
(1, 2, 1, 1, '', '', '<p>1. Ibu kota negara Indonesia ?</p>', '<p>Bandung</p>', '<p>Surabaya</p>', '<p>Malang</p>', '<p>Jakarta</p>', '', '', '', '', '', '', 'D', 1598365854, 1598365854),
(2, 2, 1, 1, '', '', '<p>1. ibu kota negara indonesia ?</p>', '<p>surabaya</p>', '<p>jakarta</p>', '<p>bandung</p>', '<p>madura</p>', '', '', '', '', '', '', 'B', 1599633091, 1599633091),
(3, 2, 1, 1, '', '', '<p>1. Negara Indonesia memakai Bahasa apa ?</p>', '<p>china</p>', '<p>arab</p>', '<p>indonesia</p>', '<p>germany</p>', '<p>jawa</p>', '', '', '', '', '', 'C', 1599633643, 1599633643),
(4, 2, 1, 1, '', '', '<p>apa makanan pokok Indonesia ?</p>', '<p>pizza</p>', '<p>spageti</p>', '<p>burger</p>', '<p>nasi</p>', '<p>roti</p>', '', '', '', '', '', 'D', 1599633733, 1599633733);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `activation_selector` varchar(255) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `forgotten_password_selector` varchar(255) DEFAULT NULL,
  `forgotten_password_code` varchar(255) DEFAULT NULL,
  `forgotten_password_time` int(11) UNSIGNED DEFAULT NULL,
  `remember_selector` varchar(255) DEFAULT NULL,
  `remember_code` varchar(255) DEFAULT NULL,
  `created_on` int(11) UNSIGNED NOT NULL,
  `last_login` int(11) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) UNSIGNED DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_activation_selector` (`activation_selector`),
  UNIQUE KEY `uc_forgotten_password_selector` (`forgotten_password_selector`),
  UNIQUE KEY `uc_remember_selector` (`remember_selector`),
  UNIQUE KEY `uc_email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `ip_address`, `username`, `password`, `email`, `activation_selector`, `activation_code`, `forgotten_password_selector`, `forgotten_password_code`, `forgotten_password_time`, `remember_selector`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
(1, '127.0.0.1', 'Administrator', '$2y$12$tGY.AtcyXrh7WmccdbT1rOuKEcTsKH6sIUmDr0ore1yN4LnKTTtuu', 'admin@admin.com', NULL, '', NULL, NULL, NULL, NULL, NULL, 1268889823, 1599634046, 1, 'Admin', 'Istrator', 'ADMIN', '0'),
(9, '::1', '11111111', '$2y$10$9MGrXSF61NdsX3dUMcFYHe9hiPcrXM3BrBeZFXuUFxxHst.Q2.XVy', 'vikky@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1598364541, NULL, 1, 'Vikky', 'Vikky', NULL, NULL),
(10, '::1', '22222222', '$2y$10$2DiQZmytoHrzzwSpFEEOxOnKzHl9bbaiMtku8LojizSpNBy4AHkqm', 'fikri@gmai.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1598364600, 1599634024, 1, 'Fikri', 'Fikri', NULL, NULL),
(11, '::1', '01111111', '$2y$10$GrZT9JzISUoOkltv2cjC1ea/yx.nNhaBSTbj9BN/l8U9o9uCoZDjK', 'diki@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1598364829, 1599632916, 1, 'diki', 'diki', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
CREATE TABLE IF NOT EXISTS `users_groups` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`),
  KEY `fk_users_groups_users1_idx` (`user_id`),
  KEY `fk_users_groups_groups1_idx` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `users_groups`
--

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
(3, 1, 1),
(11, 9, 2),
(12, 10, 2),
(13, 11, 3);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `dosen_ibfk_1` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`);

--
-- Ketidakleluasaan untuk tabel `h_ujian`
--
ALTER TABLE `h_ujian`
  ADD CONSTRAINT `h_ujian_ibfk_1` FOREIGN KEY (`ujian_id`) REFERENCES `m_ujian` (`id_ujian`),
  ADD CONSTRAINT `h_ujian_ibfk_2` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswa` (`id_mahasiswa`);

--
-- Ketidakleluasaan untuk tabel `jurusan_matkul`
--
ALTER TABLE `jurusan_matkul`
  ADD CONSTRAINT `jurusan_matkul_ibfk_1` FOREIGN KEY (`jurusan_id`) REFERENCES `jurusan` (`id_jurusan`),
  ADD CONSTRAINT `jurusan_matkul_ibfk_2` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`);

--
-- Ketidakleluasaan untuk tabel `kelas_dosen`
--
ALTER TABLE `kelas_dosen`
  ADD CONSTRAINT `kelas_dosen_ibfk_1` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id_dosen`),
  ADD CONSTRAINT `kelas_dosen_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id_kelas`);

--
-- Ketidakleluasaan untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `mahasiswa_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id_kelas`);

--
-- Ketidakleluasaan untuk tabel `m_ujian`
--
ALTER TABLE `m_ujian`
  ADD CONSTRAINT `m_ujian_ibfk_1` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id_dosen`),
  ADD CONSTRAINT `m_ujian_ibfk_2` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`);

--
-- Ketidakleluasaan untuk tabel `tb_soal`
--
ALTER TABLE `tb_soal`
  ADD CONSTRAINT `tb_soal_ibfk_1` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`),
  ADD CONSTRAINT `tb_soal_ibfk_2` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id_dosen`);

--
-- Ketidakleluasaan untuk tabel `users_groups`
--
ALTER TABLE `users_groups`
  ADD CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
