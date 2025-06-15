SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;



-- --------------------------------------------------------



CREATE TABLE `chu_ho` (
  `MaHo` int(11) NOT NULL,
  `IDChuHo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;



-- INSERT INTO `chu_ho` (`MaHo`, `IDChuHo`) VALUES
-- (2, 2),
-- (3, 3);

-- --------------------------------------------------------



CREATE TABLE `ho_khau` (
  `MaHo` int(11) NOT NULL,
  `SoThanhVien` int(11) NOT NULL,
  `DiaChi` varchar(200) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;



-- INSERT INTO `ho_khau` (`MaHo`, `SoThanhVien`, `DiaChi`) VALUES
-- (2, 2, 'Phúc thành'),
-- (3, 1, 'Kim');

-- --------------------------------------------------------


CREATE TABLE `khoan_thu` (
  `MaKhoanThu` int(11) NOT NULL,
  `TenKhoanThu` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `SoTien` double NOT NULL,
  `LoaiKhoanThu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;



-- INSERT INTO `khoan_thu` (`MaKhoanThu`, `TenKhoanThu`, `SoTien`, `LoaiKhoanThu`) VALUES
-- (1, '12', 10000, 0),
-- (2, 'nước', 1000.12, 1),
-- (3, 'Tiền Điện', 200000, 1);

-- --------------------------------------------------------



CREATE TABLE `nhan_khau` (
  `ID` int(11) NOT NULL,
  `CMND` varchar(20) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `Ten` varchar(50) CHARACTER SET utf8 NOT NULL,
  `Tuoi` int(11) NOT NULL,
  `SDT` varchar(15) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;




-- --------------------------------------------------------


CREATE TABLE `nop_tien` (
  `IDNopTien` int(11) NOT NULL,
  `MaKhoanThu` int(11) NOT NULL,
  `NgayThu` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;


-- INSERT INTO `nop_tien` (`IDNopTien`, `MaKhoanThu`, `NgayThu`) VALUES
-- (2, 2, '2020-12-16'),
-- (3, 1, '2020-12-16'),
-- (3, 2, '2020-12-16');

-- --------------------------------------------------------


CREATE TABLE `quan_he` (
  `MaHo` int(11) NOT NULL,
  `IDThanhVien` int(11) NOT NULL,
  `QuanHe` varchar(30) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;


-- INSERT INTO `quan_he` (`MaHo`, `IDThanhVien`, `QuanHe`) VALUES
-- (2, 2, ''),
-- (3, 3, 'Là chủ hộ');

-- --------------------------------------------------------

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `passwd` varchar(30) COLLATE utf8mb4_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;



-- INSERT INTO `users` (`ID`, `username`, `passwd`) VALUES
-- (1, 'admin', '1');


ALTER TABLE `chu_ho`
  ADD PRIMARY KEY (`MaHo`,`IDChuHo`),
  ADD KEY `chu_ho_2` (`IDChuHo`);

ALTER TABLE `ho_khau`
  ADD PRIMARY KEY (`MaHo`);

ALTER TABLE `khoan_thu`
  ADD PRIMARY KEY (`MaKhoanThu`);

ALTER TABLE `nhan_khau`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `nop_tien`
  ADD PRIMARY KEY (`IDNopTien`,`MaKhoanThu`),
  ADD KEY `nop_tien_2` (`MaKhoanThu`);

ALTER TABLE `quan_he`
  ADD PRIMARY KEY (`MaHo`,`IDThanhVien`),
  ADD KEY `quan_he_2` (`IDThanhVien`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);



ALTER TABLE `ho_khau`
  MODIFY `MaHo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `khoan_thu`
  MODIFY `MaKhoanThu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `nhan_khau`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;



ALTER TABLE `chu_ho`
  ADD CONSTRAINT `chu_ho_1` FOREIGN KEY (`MaHo`) REFERENCES `ho_khau` (`MaHo`),
  ADD CONSTRAINT `chu_ho_2` FOREIGN KEY (`IDChuHo`) REFERENCES `nhan_khau` (`ID`);


ALTER TABLE `nop_tien`
  ADD CONSTRAINT `nop_tien_1` FOREIGN KEY (`IDNopTien`) REFERENCES `nhan_khau` (`ID`),
  ADD CONSTRAINT `nop_tien_2` FOREIGN KEY (`MaKhoanThu`) REFERENCES `khoan_thu` (`MaKhoanThu`);


ALTER TABLE `quan_he`
  ADD CONSTRAINT `quan_he_1` FOREIGN KEY (`MaHo`) REFERENCES `ho_khau` (`MaHo`),
  ADD CONSTRAINT `quan_he_2` FOREIGN KEY (`IDThanhVien`) REFERENCES `nhan_khau` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
