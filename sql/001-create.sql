CREATE DATABASE IF NOT EXISTS `dnsbl` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `dnsbl`;

DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE IF NOT EXISTS `blacklist` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `mail_from` varchar(255) NOT NULL,
  `mail_to` varchar(255) NOT NULL,
  `mail_subject` varchar(255) NOT NULL,
  `env_from` varchar(255) NOT NULL,
  `from_ip` varchar(15) NOT NULL,
  `message_id` varchar(255) NOT NULL,
  `rev_ip` varchar(255) NOT NULL,
  `helo` varchar(255) NOT NULL,
  `spam_flag` varchar(255) NOT NULL,
  `spam_point` decimal(10,0) NOT NULL,
  `spam_report` text NOT NULL,
  `alert_service` varchar(255) NOT NULL,
  `alert_server` varchar(255) NOT NULL,
  `mail_body` text NOT NULL,
  `headers` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `whitelist`;
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(15) DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `epoc` timestamp NULL DEFAULT current_timestamp(),
  `comment` varchar(65000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

COMMIT;
