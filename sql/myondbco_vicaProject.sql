-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 07, 2020 at 05:30 PM
-- Server version: 10.3.24-MariaDB-cll-lve
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `myondbco_vicaProject`
--

-- --------------------------------------------------------

--
-- Table structure for table `ADMIN`
--

CREATE TABLE `ADMIN` (
  `NAME` varchar(100) NOT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `PHONE` varchar(15) NOT NULL,
  `VERIFY` varchar(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ADMIN`
--

INSERT INTO `ADMIN` (`NAME`, `EMAIL`, `PASSWORD`, `PHONE`, `VERIFY`) VALUES
('Daniel', 'danielkang95@gmail.com', 'adminkang', '0123968599', '1');

-- --------------------------------------------------------

--
-- Table structure for table `COURSE`
--

CREATE TABLE `COURSE` (
  `courseid` int(100) NOT NULL,
  `coursename` varchar(100) NOT NULL,
  `courseduration` varchar(50) NOT NULL,
  `coursedes` varchar(500) NOT NULL,
  `courseimage` varchar(50) NOT NULL,
  `userenroll` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `COURSE`
--

INSERT INTO `COURSE` (`courseid`, `coursename`, `courseduration`, `coursedes`, `courseimage`, `userenroll`) VALUES
(10, 'Intro to HTML', 'Flexible', 'In this course, you would learn what HTML is and how to make a web page with marked up text and images. \r\n\r\nLEARNING OUTCOMES:\r\nUpon successful completion of the course, you will be able to:  \r\n- Learn how html works\r\n- Make a web page with marked up text and image', 'HTML', 'chongmei1997@gmail.com'),
(11, 'Basic Flutter ', 'Flexible', 'In this course, you\'ll learn how to use Flutter to quickly develop high-quality, interactive mobile applications for iOS and Android devices. \r\nLEARNING OUTCOMES\r\n- Customize your app with rich\r\n- composable widgets\r\n- Built-in animations\r\n', 'flutter', 'chongmei1997@gmail.com'),
(12, 'Business Management', 'Flexible', 'Learn on the disciplines devoted to organizing, analyzing, and planning various types of business operations.', 'business', 'xinyi1022@hotmail.com'),
(13, 'Photoshop', 'Flexible', 'This tutorials introduces you to the photoshop work area, create and enhance your photos, images and design.', 'photoshop', 'xinyi1022@hotmail.com'),
(14, 'Intro to HTML', 'Flexible', 'In this course, you would learn what HTML is and how to make a web page with marked up text and images. \r\n\r\nLEARNING OUTCOMES:\r\nUpon successful completion of the course, you will be able to:  \r\n- Learn how html works\r\n- Make a web page with marked up text and image', 'HTML', 'happyhour97@hotmail.com'),
(15, 'Basic Flutter ', 'Flexible', 'In this course, you\'ll learn how to use Flutter to quickly develop high-quality, interactive mobile applications for iOS and Android devices. \r\nLEARNING OUTCOMES\r\n- Customize your app with rich\r\n- composable widgets\r\n- Built-in animations\r\n', 'flutter', 'happyhour97@hotmail.com'),
(16, 'Business Management', 'Flexible', 'Learn on the disciplines devoted to organizing, analyzing, and planning various types of business operations.', 'business', 'yujia@gmail.com'),
(17, 'Photoshop', 'Flexible', 'This tutorials introduces you to the photoshop work area, create and enhance your photos, images and design.', 'photoshop', 'chongmei1997@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `EVALUATE`
--

CREATE TABLE `EVALUATE` (
  `id` int(11) NOT NULL,
  `selected1` varchar(15) NOT NULL,
  `selected2` varchar(15) NOT NULL,
  `selected3` varchar(15) NOT NULL,
  `selected4` varchar(15) NOT NULL,
  `selected5` varchar(15) NOT NULL,
  `selected6` varchar(15) NOT NULL,
  `selected7` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `courseid` int(11) NOT NULL,
  `coursename` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `EVALUATE`
--

INSERT INTO `EVALUATE` (`id`, `selected1`, `selected2`, `selected3`, `selected4`, `selected5`, `selected6`, `selected7`, `email`, `courseid`, `coursename`) VALUES
(31, 'Excellent', 'Good', 'Excellent', 'Excellent', 'Good', 'Excellent', 'Good', 'chongmei1997@gmail.com', 10, 'Intro to HTML'),
(13, 'Excellent', 'Good', 'Excellent', 'Good', 'Excellent', 'Good', 'Excellent', 'xinyi1022@hotmail.com', 12, 'Business Management'),
(34, 'Excellent', 'Good', 'Good', 'Average', 'Average', 'Average', 'Bad', 'chongmei1997@gmail.com', 11, 'Basic Flutter '),
(35, 'Good', 'Good', 'Good', 'Average', 'Good', 'Average', 'Good', 'chongmei1997@gmail.com', 17, 'Photoshop');

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE `USER` (
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `dob` varchar(20) NOT NULL,
  `address` varchar(150) NOT NULL,
  `DATE` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `verify` varchar(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`name`, `email`, `password`, `phone`, `dob`, `address`, `DATE`, `verify`) VALUES
('happy', 'happyhour97@hotmail.com', '7c222fb2927d828af22f592134e8932480637c0d', '0123658947', '2020-04-10', 'No 97,bikabineb itamnubsib iiabgsk', '2019-12-13 18:58:02.223491', '1'),
('yujia', 'yujia@gmail.com', 'b1b3773a05c0ed0176787a4f1574ff0075f7521e', '013469785', '2019-12-10', '1902, Block A, Selamat Ceria', '2019-12-14 20:14:20.416892', '1'),
('YuYun199', 'yuyu99@hotmail.com', '8c4dbc923122c534dd1fd99658a70f4916cb5d27', '0123456987', '2008-12-10', 'No,97, Kampung batu dua, 33300, gerik, peraak', '2019-12-14 20:23:04.895964', '1'),
('Choong', 'chongmei1997@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '0123445569', '2008-05-12', 'no 25, Inasis ', '2020-03-08 19:01:47.850693', '1'),
('Polly', 'xinyi1022@hotmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '0123456789', '1999-06-08', '127, KAMPUNG DARAT MERAH, 30120', '2020-02-18 03:56:25.986634', '1'),
('', '', '344ac1bee347aaf849fae5a1f96d225e5712a625', '', '', '', '2020-05-23 06:34:09.139184', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ADMIN`
--
ALTER TABLE `ADMIN`
  ADD PRIMARY KEY (`EMAIL`);

--
-- Indexes for table `COURSE`
--
ALTER TABLE `COURSE`
  ADD PRIMARY KEY (`courseid`);

--
-- Indexes for table `EVALUATE`
--
ALTER TABLE `EVALUATE`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `COURSE`
--
ALTER TABLE `COURSE`
  MODIFY `courseid` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `EVALUATE`
--
ALTER TABLE `EVALUATE`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
