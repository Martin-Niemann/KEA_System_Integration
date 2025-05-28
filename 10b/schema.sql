-- -----------------------------------------------------
-- Schema reddit_clone
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `reddit_clone`;
USE `reddit_clone`;

-- -----------------------------------------------------
-- Table `reddit_clone`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reddit_clone`.`users`;

CREATE TABLE IF NOT EXISTS `reddit_clone`.`users` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(320) NOT NULL,
  `hashed_password` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reddit_clone`.`subreddits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reddit_clone`.`subreddits`;

CREATE TABLE IF NOT EXISTS `reddit_clone`.`subreddits` (
  `id_subreddit` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(100) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(1000) NULL,
  `id_user` INT NULL,
  PRIMARY KEY (`id_subreddit`),
  UNIQUE INDEX `id_UNIQUE` (`id_subreddit` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `url_UNIQUE` (`url` ASC) VISIBLE,
  INDEX `users_idx` (`id_user` ASC) VISIBLE,
  FULLTEXT `subreddits_fulltext` (`url`,`name`,`description`),
  CONSTRAINT `subreddits_owner`
    FOREIGN KEY (`id_user`)
    REFERENCES `reddit_clone`.`users` (`id_user`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reddit_clone`.`posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reddit_clone`.`posts`;

CREATE TABLE IF NOT EXISTS `reddit_clone`.`posts` (
  `id_post` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(300) NOT NULL,
  `link` VARCHAR(1000) NULL,
  `text` VARCHAR(10000) NULL,
  `id_subreddit` INT NOT NULL,
  `id_user` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_post`),
  UNIQUE INDEX `id_post_UNIQUE` (`id_post` ASC) VISIBLE,
  INDEX `users_idx` (`id_user` ASC) VISIBLE,
  FULLTEXT `posts_fulltext` (`title`,`link`,`text`),
  CONSTRAINT `posts_subreddits`
    FOREIGN KEY (`id_subreddit`)
    REFERENCES `reddit_clone`.`subreddits` (`id_subreddit`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `posts_users`
    FOREIGN KEY (`id_user`)
    REFERENCES `reddit_clone`.`users` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reddit_clone`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reddit_clone`.`comments`;

CREATE TABLE IF NOT EXISTS `reddit_clone`.`comments` (
  `id_comment` INT NOT NULL AUTO_INCREMENT,
  `comment` VARCHAR(10000) NOT NULL,
  `is_toplevel` BOOLEAN NOT NULL,
  `id_post` INT NOT NULL,
  `parent_id` INT NULL,
  `id_user` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comment`),
  UNIQUE INDEX `id_comment_UNIQUE` (`id_comment` ASC) VISIBLE,
  INDEX `posts_idx` (`id_post` ASC) VISIBLE,
  INDEX `users_idx` (`id_user` ASC) VISIBLE,
  INDEX `parent_idx` (`parent_id` ASC) VISIBLE,
  CONSTRAINT `comments_posts`
    FOREIGN KEY (`id_post`)
    REFERENCES `reddit_clone`.`posts` (`id_post`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `comments_users`
    FOREIGN KEY (`id_user`)
    REFERENCES `reddit_clone`.`users` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `comments_parent`
    FOREIGN KEY (`parent_id`)
    REFERENCES `reddit_clone`.`comments` (`id_comment`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `reddit_clone`.`scores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reddit_clone`.`scores`;

CREATE TABLE IF NOT EXISTS `reddit_clone`.`scores` (
  `id_score` INT NOT NULL AUTO_INCREMENT,
  `score` BOOL NOT NULL,
  `id_post` INT,
  `id_comment` INT,
  `id_user` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_score`),
  UNIQUE INDEX `id_score_UNIQUE` (`id_score` ASC) VISIBLE,
  INDEX `posts_idx` (`id_post` ASC) VISIBLE,
  INDEX `comments_idx` (`id_comment` ASC) VISIBLE,
  INDEX `users_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `score_posts`
    FOREIGN KEY (`id_post`)
    REFERENCES `reddit_clone`.`posts` (`id_post`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `score_comment`
    FOREIGN KEY (`id_comment`)
    REFERENCES `reddit_clone`.`comments` (`id_comment`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `score_users`
    FOREIGN KEY (`id_user`)
    REFERENCES `reddit_clone`.`users` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- User `backend`
-- -----------------------------------------------------
DROP USER IF EXISTS backend;

CREATE USER 'backend@127.0.0.1';
-- ALTER USER 'backend' IDENTIFIED BY 'password';

GRANT CREATE, DROP ON reddit_clone.* TO 'backend';
GRANT CREATE, DROP, INSERT, SELECT, UPDATE, DELETE ON TABLE `reddit_clone`.`subreddits` TO 'backend';
GRANT CREATE, DROP, DELETE, INSERT, SELECT, UPDATE ON TABLE `reddit_clone`.`posts` TO 'backend';
GRANT CREATE, DROP, DELETE, INSERT, SELECT, UPDATE ON TABLE `reddit_clone`.`users` TO 'backend';
GRANT CREATE, DROP, DELETE, INSERT, SELECT, UPDATE ON TABLE `reddit_clone`.`comments` TO 'backend';
GRANT CREATE, DROP, DELETE, INSERT, SELECT, UPDATE ON TABLE `reddit_clone`.`scores` TO 'backend';

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

INSERT INTO `comments` (`id_comment`, `comment`, `id_post`, `parent_id`, `id_user`) VALUES
	(1, "Fuck me that is so fucking unfunny...", 3, NULL, 3),
	(2, "Fuck you.", 3, 1, 4),
	(3, "That is so sweet to hear!", 2, NULL, 2);

/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table posts
# ------------------------------------------------------------

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;

INSERT INTO `posts` (`id_post`, `title`, `link`, `text`, `id_subreddit`, `id_user`) VALUES
	(1, "Phoronix: Several Linux Kernel Driver Maintainers Removed Due To Their Association To Russia", "https://www.phoronix.com/news/Russian-Linux-Maintainers-Drop", NULL, 1, 1),
	(2, "Finally did it, got my parent on linux.", NULL, "They’re in their 60’s, finally convinced them.  They say things like “This is the same…”  and I’m like  “Ya because that’s Firefox, the only program you use…”  “What was Windows even doing for us?”", 1, 3),
	(3, "What kind of crime is cockfighting?", NULL, "It\'s a feather-al offense.", 2, 4);

/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table scores
# ------------------------------------------------------------

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;

INSERT INTO `scores` (`id_score`, `score`, `id_post`, `id_comment`, `id_user`) VALUES
	(1, 0, NULL, 1, 1),
	(2, 0, NULL, 1, 5),
	(3, 1, NULL, 2, 1),
	(4, 1, NULL, 2, 5),
	(5, 1, 2, NULL, 2);

/*!40000 ALTER TABLE `scores` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table subreddits
# ------------------------------------------------------------

LOCK TABLES `subreddits` WRITE;
/*!40000 ALTER TABLE `subreddits` DISABLE KEYS */;

INSERT INTO `subreddits` (`id_subreddit`, `url`, `name`, `description`, `id_user`) VALUES
	(1, "linux", "Linux", "All things Linux.", 5),
	(2, "funny", "Funny", "If I see you posting cringe you will be banned.", 2);

/*!40000 ALTER TABLE `subreddits` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table users
# ------------------------------------------------------------

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id_user`, `user_name`, `email`, `hashed_password`) VALUES
	(1, "Brice97", "Ayden.Wolff99@yahoo.com", "aayUXzZo8iD19ct"),
	(2, "Erna_Howe", "Jane56@hotmail.com", "cuA6jE_DYy3Gpoj"),
	(3, "Bertrand_Langosh48", "Devonte.Hilpert@gmail.com", "vY705g_vxicfOjw"),
	(4, "Rafaela_Cole88", "Naomie.Hilpert55@hotmail.com", "tOQLxSu3iFoNOL3"),
	(5, "Neil90", "Andres.Mraz43@gmail.com", "yhIV1rV3eNWcMAh");

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
