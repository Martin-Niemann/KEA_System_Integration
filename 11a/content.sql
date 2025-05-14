# ************************************************************
# Antares - SQL Client
# Version 0.7.34
# 
# https://antares-sql.app/
# https://github.com/antares-sql/antares
# 
# Host: backend-mysql.localhost (MySQL Community Server - GPL 8.4.5)
# Database: reddit_clone
# Generation time: 2025-05-11T21:12:55+02:00
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table comments
# ------------------------------------------------------------

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;

INSERT INTO `comments` (`id_comment`, `comment`, `is_toplevel`, `id_post`, `parent_id`, `id_user`, `created_at`, `updated_at`) VALUES
	(1, "Emmitt49@example.org", 1, 27, NULL, 11, "2025-05-11 19:07:39", "2025-05-11 19:07:39"),
	(2, "Roxane_Bartoletti15@example.net", 1, 27, NULL, 17, "2025-05-11 19:07:39", "2025-05-11 19:07:39"),
	(3, "Titus.Larson34@example.net", 1, 27, NULL, 12, "2025-05-11 19:07:39", "2025-05-11 19:07:39"),
	(4, "Cathy72@example.net", 1, 27, NULL, 14, "2025-05-11 19:07:39", "2025-05-11 19:07:39"),
	(5, "Ryann_Mayert@example.net", 1, 27, NULL, 19, "2025-05-11 19:07:39", "2025-05-11 19:07:39"),
	(6, "Customer Home", 0, 27, 4, 18, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(7, "Salvador", 0, 27, 2, 18, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(8, "channels azure content", 0, 27, 4, 20, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(9, "Shoes port Springs", 0, 27, 5, 15, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(10, "reboot", 0, 27, 5, 13, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(11, "Fresh payment Liaison", 0, 27, 2, 13, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(12, "Organized transmit", 0, 27, 5, 13, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(13, "leverage", 0, 27, 5, 16, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(14, "Plastic optical Investor", 0, 27, 1, 14, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(15, "Arkansas", 0, 27, 2, 16, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(16, "transition disintermediate communities", 0, 27, 3, 17, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(17, "experiences", 0, 27, 5, 15, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(18, "Computers Pennsylvania Fish", 0, 27, 3, 14, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(19, "Suriname Granite IB", 0, 27, 4, 12, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(20, "Robust Borders Soft", 0, 27, 3, 17, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(21, "Industrial deposit projection", 0, 27, 2, 12, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(22, "tertiary", 0, 27, 1, 14, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(23, "transmitting Assurance Savings", 0, 27, 2, 14, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(24, "Bedfordshire Developer", 0, 27, 3, 18, "2025-05-11 19:08:51", "2025-05-11 19:08:51"),
	(25, "Borders system Idaho", 0, 27, 5, 20, "2025-05-11 19:08:51", "2025-05-11 19:08:51");

/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table posts
# ------------------------------------------------------------

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;

INSERT INTO `posts` (`id_post`, `title`, `link`, `text`, `id_subreddit`, `id_user`, `created_at`, `updated_at`) VALUES
	(21, "BMW Volt", NULL, "synthesize Account reboot", 1, 11, "2025-05-11 19:03:15", "2025-05-11 19:03:15"),
	(22, "Mini Camaro", NULL, "Towels database", 1, 19, "2025-05-11 19:03:15", "2025-05-11 19:03:15"),
	(23, "Bugatti Taurus", NULL, "metrics Customer Graphic", 1, 19, "2025-05-11 19:03:15", "2025-05-11 19:03:15"),
	(24, "Bentley Countach", NULL, "Pennsylvania", 1, 14, "2025-05-11 19:03:15", "2025-05-11 19:03:15"),
	(25, "Nissan Durango", NULL, "Awesome Ameliorated sensor", 1, 14, "2025-05-11 19:03:15", "2025-05-11 19:03:15"),
	(26, "Land Rover ATS", NULL, "Wooden Operations driver", 1, 11, "2025-05-11 19:03:15", "2025-05-11 19:03:15"),
	(27, "Toyota PT Cruiser", NULL, "Bedfordshire incremental generating", 1, 20, "2025-05-11 19:03:15", "2025-05-11 19:03:15"),
	(28, "Lamborghini Jetta", NULL, "Philippine parse mindshare", 1, 14, "2025-05-11 19:03:15", "2025-05-11 19:03:15"),
	(29, "Smart Sentra", NULL, "Kids", 1, 11, "2025-05-11 19:03:15", "2025-05-11 19:03:15"),
	(30, "Toyota Explorer", NULL, "initiative the", 1, 15, "2025-05-11 19:03:15", "2025-05-11 19:03:15");

/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table scores
# ------------------------------------------------------------

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;

INSERT INTO `scores` (`id_score`, `score`, `id_post`, `id_comment`, `id_user`, `created_at`, `updated_at`) VALUES
	(51, 1, 24, NULL, 17, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(52, 1, 22, NULL, 19, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(53, 1, 21, NULL, 17, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(54, 1, 22, NULL, 13, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(55, 1, 28, NULL, 16, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(56, 1, 27, NULL, 14, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(57, 1, 27, NULL, 15, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(58, 1, 29, NULL, 15, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(59, 1, 24, NULL, 16, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(60, 1, 21, NULL, 12, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(61, 1, 21, NULL, 19, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(62, 1, 22, NULL, 18, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(63, 1, 23, NULL, 18, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(64, 1, 26, NULL, 20, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(65, 1, 28, NULL, 18, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(66, 1, 23, NULL, 19, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(67, 1, 21, NULL, 20, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(68, 1, 23, NULL, 16, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(69, 1, 23, NULL, 20, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(70, 1, 27, NULL, 13, "2025-05-11 19:06:00", "2025-05-11 19:06:00"),
	(71, 1, NULL, 15, 19, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(72, 1, NULL, 3, 11, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(73, 1, NULL, 5, 18, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(74, 1, NULL, 5, 14, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(75, 1, NULL, 2, 15, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(76, 0, NULL, 17, 12, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(77, 0, NULL, 24, 17, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(78, 1, NULL, 1, 16, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(79, 1, NULL, 13, 19, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(80, 1, NULL, 5, 20, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(81, 1, NULL, 16, 17, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(82, 0, NULL, 2, 20, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(83, 0, NULL, 2, 20, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(84, 0, NULL, 7, 19, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(85, 0, NULL, 17, 16, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(86, 0, NULL, 21, 14, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(87, 1, NULL, 17, 16, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(88, 0, NULL, 2, 17, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(89, 0, NULL, 11, 11, "2025-05-11 19:10:17", "2025-05-11 19:10:17"),
	(90, 1, NULL, 7, 17, "2025-05-11 19:10:17", "2025-05-11 19:10:17");

/*!40000 ALTER TABLE `scores` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table subreddits
# ------------------------------------------------------------

LOCK TABLES `subreddits` WRITE;
/*!40000 ALTER TABLE `subreddits` DISABLE KEYS */;

INSERT INTO `subreddits` (`id_subreddit`, `url`, `name`, `description`, `id_user`) VALUES
	(1, "toyotalive", "ToyotAlive", "This is where Toyotas new and old go to live! Repair tips, MacGyver fixes and more.", 18);

/*!40000 ALTER TABLE `subreddits` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table users
# ------------------------------------------------------------

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id_user`, `user_name`, `email`, `hashed_password`) VALUES
	(11, "Marian.Toy", "Osvaldo.McClure@hotmail.com", "vjoODmUqISxc_Vi"),
	(12, "Maxine_Sawayn40", "Everett_Murphy53@yahoo.com", "mz5GD0scxHWuLzE"),
	(13, "Adolphus_Orn16", "Amelie32@yahoo.com", "Oq9d98VE9J0qd7u"),
	(14, "Rozella.Parisian20", "Uriel.Rutherford88@yahoo.com", "iFGpFb39_Yijgaz"),
	(15, "Jammie.Connelly", "Melisa62@hotmail.com", "NDDrcSxLJYfIENx"),
	(16, "Deon_Lubowitz", "Kiana.Lang@hotmail.com", "DAISViY92qTyOCR"),
	(17, "Alden.Morar31", "Lizeth.Rogahn78@gmail.com", "2UUkOpUC3jE1x8o"),
	(18, "Trevor.Jaskolski", "Annette_Schaden60@hotmail.com", "p2o9mMLT4nkOckK"),
	(19, "Reid.Gerlach63", "Milan.Cummerata@hotmail.com", "H0gYWO5rPtceZ8x"),
	(20, "Alia27", "Orie_Morar@yahoo.com", "X_nLj2I2hp3Vqu6");

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

# Dump completed on 2025-05-11T21:12:55+02:00
