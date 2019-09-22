CREATE DATABASE IF NOT EXISTS `dnsbl` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `dnsbl`;

DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE IF NOT EXISTS `blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `mail_from` varchar(255) DEFAULT NULL,
  `mail_to` varchar(255)  DEFAULT NULL,
  `mail_subject` varchar(255)  NULL,
  `env_from` varchar(255)  NULL,
  `from_ip` varchar(15)  NOT NULL,
  `message_id` varchar(255)  NULL,
  `rev_ip` varchar(255)  NULL,
  `helo` varchar(255)  NULL,
  `spam_flag` varchar(255)  NULL,
  `spam_point` decimal(10,0) NULL,
  `spam_report` text  NULL,
  `alert_service` varchar(255)  NULL,
  `alert_server` varchar(255)  NULL,
  `mail_body` text  NULL,
  `headers` text  NULL,
  `comment` text  NULL,
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
