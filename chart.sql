-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Inang: 127.0.0.1
-- Waktu pembuatan: 25 Mar 2016 pada 19.08
-- Versi Server: 5.5.27
-- Versi PHP: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Basis data: `simpleton`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `indikator`
--

CREATE TABLE IF NOT EXISTS `indikator` (
  `id_indikator` varchar(5) NOT NULL,
  `indikator` text NOT NULL,
  `id_aspek` varchar(5) NOT NULL,
  PRIMARY KEY (`id_indikator`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `indikator`
--

INSERT INTO `indikator` (`id_indikator`, `indikator`, `id_aspek`) VALUES
('I0001', 'Ada Substansi Yang Akan Dievaluasi', 'A0001'),
('I0002', 'Alat-alat evaluasi:  Angket; Pedoman wawancara; Pedoman observasi', 'A0001'),
('I0003', 'fgsfgfdgdsfhdf', 'A0001'),
('I0005', 'htyrthdfhtr', 'A0001');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lembaga`
--

CREATE TABLE IF NOT EXISTS `lembaga` (
  `id_lembaga` varchar(4) NOT NULL,
  `nama_lembaga` varchar(100) NOT NULL,
  PRIMARY KEY (`id_lembaga`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `lembaga`
--

INSERT INTO `lembaga` (`id_lembaga`, `nama_lembaga`) VALUES
('L001', 'UPT Teknologi Informasi dan Pangkalan Data'),
('L002', 'UPT Perpustakaan'),
('L003', 'UPT Promosi'),
('L004', 'Lembaga Penelitian dan Pengabdian Kepada Masyarakat');

-- --------------------------------------------------------

--
-- Struktur dari tabel `monev`
--

CREATE TABLE IF NOT EXISTS `monev` (
  `kode_kegiatan` varchar(5) NOT NULL,
  `badan_yang_diaudit` varchar(4) DEFAULT NULL,
  `nama_petugas` varchar(21) DEFAULT NULL,
  `petugas_yang_diaudit` varchar(21) DEFAULT NULL,
  `tahun` int(4) DEFAULT NULL,
  PRIMARY KEY (`kode_kegiatan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `monev`
--

INSERT INTO `monev` (`kode_kegiatan`, `badan_yang_diaudit`, `nama_petugas`, `petugas_yang_diaudit`, `tahun`) VALUES
('MO001', 'L004', '151', '238', 2016),
('MO002', 'L002', '238', '53', 2016),
('MO003', 'L003', '26', '79', 2016),
('MO004', 'L001', '713', '572', 2016);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pertanyaan`
--

CREATE TABLE IF NOT EXISTS `pertanyaan` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `kode_kegiatan` varchar(5) NOT NULL,
  `id_aspek` varchar(5) NOT NULL,
  `id_substandar` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data untuk tabel `pertanyaan`
--

INSERT INTO `pertanyaan` (`id`, `kode_kegiatan`, `id_aspek`, `id_substandar`) VALUES
(4, 'MO001', 'A0013', 'SS050'),
(5, 'MO002', 'A0183', 'SS054'),
(6, 'MO003', 'A0192', 'SS048'),
(7, 'MO004', 'A0192', 'SS035');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pertanyaan_detail`
--

CREATE TABLE IF NOT EXISTS `pertanyaan_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_indikator` varchar(5) NOT NULL,
  `id_pertanyaan` varchar(5) NOT NULL,
  `urutan` int(10) NOT NULL,
  `ketercapaian` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data untuk tabel `pertanyaan_detail`
--

INSERT INTO `pertanyaan_detail` (`id`, `id_indikator`, `id_pertanyaan`, `urutan`, `ketercapaian`) VALUES
(1, 'I0001', '4', 0, 2),
(2, 'I0002', '4', 1, 1),
(3, 'I0003', '4', 2, 3),
(4, 'I0001', '5', 0, 2),
(5, 'I0002', '5', 1, 3),
(6, 'I0003', '5', 2, 4),
(7, 'I0005', '5', 3, 5),
(8, 'I0001', '6', 0, 5),
(9, 'I0002', '6', 1, 5),
(10, 'I0003', '6', 2, 5),
(11, 'I0005', '6', 3, 4),
(12, 'I0001', '7', 0, 4),
(13, 'I0002', '7', 1, 5),
(14, 'I0005', '7', 2, 4),
(15, 'I0003', '7', 3, 5);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
