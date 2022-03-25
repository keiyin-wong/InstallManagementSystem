/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 10.6.4-MariaDB : Database - installation
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`installation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `installation`;

/*Table structure for table `installation_type` */

DROP TABLE IF EXISTS `installation_type`;

CREATE TABLE `installation_type` (
  `id` bigint(200) NOT NULL AUTO_INCREMENT,
  `desc_english` varchar(500) CHARACTER SET latin1 DEFAULT NULL,
  `desc_chinese` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diff_price` tinyint(1) NOT NULL DEFAULT 0,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `installation_type` */

insert  into `installation_type`(`id`,`desc_english`,`desc_chinese`,`diff_price`,`price`) values 
(1,'wall unit','上座柜',1,20),
(2,'base unit','下座柜',0,20),
(3,'concrete top b/unit','石犀桌',0,20),
(4,'tv cabinet & dressing table','电视机和梳妆桌',0,20),
(5,'wardrobe(swing/sliding)','壁柜(开门/汤门)',0,20),
(6,'hi fi glass door',NULL,0,20),
(7,'tall unit','高柜',0,20),
(8,'ep (big)','大 ep',0,20),
(9,'ep (small)','小 ep',0,20),
(10,'canopy','飞板',0,20),
(11,'modify cabinet per unit',NULL,0,20),
(12,'drawer (normal)','柜桐(普通)',0,20),
(13,'drawer (dwd)','柜桐(dwd)',0,20),
(14,'pull out basket','拉篮(normal)',0,20),
(15,'lock','柜桐锁头',0,20),
(16,'sink opening sink','盘开洞',0,20),
(17,'hob opening','煮食炉开洞',0,20),
(18,'install hood (slim)','安装平面油烟机',0,20),
(19,'install hood (chimney)','安装白钢油烟机',0,20),
(20,'oven','oven',0,20),
(21,'plug point','拉插头',0,20),
(22,'plug point (add)','拉插头再加插头',0,20),
(23,'eye ball (beaufix)','小型灯(beaufix)',0,20),
(24,'eye ball (normal/t5)','小型灯t5',0,20),
(25,'dish rack','安装碟架',0,20),
(26,'magic corner','特别拉篮安装',0,20),
(27,'tall larder','高柜拉篮安装',0,20),
(28,'gas spring',NULL,0,20),
(29,'arm c',NULL,0,20),
(30,'150mm pull out basket',NULL,0,20),
(31,'computer, cooker hood hole',NULL,0,20);

/*Table structure for table `installation_type_diff_fees` */

DROP TABLE IF EXISTS `installation_type_diff_fees`;

CREATE TABLE `installation_type_diff_fees` (
  `type` bigint(20) NOT NULL,
  `size` double NOT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`type`,`size`),
  CONSTRAINT `installation_type_fees_type_fk` FOREIGN KEY (`type`) REFERENCES `installation_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `installation_type_diff_fees` */

insert  into `installation_type_diff_fees`(`type`,`size`,`price`) values 
(1,0,20),
(1,100,20),
(1,200,20),
(1,300,20),
(1,400,20),
(1,500,20),
(1,600,20),
(1,700,20),
(1,800,22),
(1,900,24),
(1,1000,26),
(1,1100,28),
(1,1200,30),
(1,1300,32),
(1,1400,40),
(1,1500,42),
(1,1600,46),
(1,1700,48);

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `product_number` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product` */

insert  into `product`(`product_number`,`date`) values 
('10001','2022-03-04'),
('10002','2022-03-24'),
('10003','2022-03-24');

/*Table structure for table `product_details` */

DROP TABLE IF EXISTS `product_details`;

CREATE TABLE `product_details` (
  `product_number` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_line_number` smallint(6) NOT NULL,
  `type` bigint(20) DEFAULT NULL,
  `width` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  PRIMARY KEY (`product_number`,`product_line_number`),
  KEY `type` (`type`),
  CONSTRAINT `product_details_ibfk_1` FOREIGN KEY (`type`) REFERENCES `installation_type` (`id`),
  CONSTRAINT `product_details_ibfk_2` FOREIGN KEY (`product_number`) REFERENCES `product` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_details` */

insert  into `product_details`(`product_number`,`product_line_number`,`type`,`width`,`height`) values 
('10001',1,1,1200,1200),
('10001',2,1,1000,1300),
('10001',3,1,1000,700),
('10001',4,7,1000,800),
('10001',5,1,1000,900),
('10001',6,1,1000,1600),
('10002',1,2,1000,600),
('10002',2,2,1000,300),
('10002',3,2,1000,400);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
