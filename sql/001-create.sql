CREATE DATABASE IF NOT EXISTS `dnsbl` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `dnsbl`;

DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE IF NOT EXISTS `blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `mail_from` varchar(255) DEFAULT NULL,
  `mail_to` varchar(255) DEFAULT NULL,
  `mail_subject` varchar(255) DEFAULT NULL,
  `env_from` varchar(255) DEFAULT NULL,
  `from_ip` varchar(15) NOT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `rev_ip` varchar(255) DEFAULT NULL,
  `helo` varchar(255) DEFAULT NULL,
  `domain_from` varchar(255) DEFAULT NULL,
  `spam_flag` varchar(255) DEFAULT NULL,
  `spam_point` varchar(10) DEFAULT NULL,
  `spam_report` text DEFAULT NULL,
  `alert_service` varchar(255) DEFAULT NULL,
  `alert_server` varchar(255) DEFAULT NULL,
  `mail_body` text DEFAULT NULL,
  `headers` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `whitelist`;
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(15)  DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `epoc` timestamp NULL DEFAULT current_timestamp(),
  `comment` text(65000)  DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
