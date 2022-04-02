/*
SQLyog Community v13.1.9 (64 bit)
MySQL - 10.7.3-MariaDB : Database - installation
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
  `is_direct_price` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `installation_type` */

insert  into `installation_type`(`id`,`desc_english`,`desc_chinese`,`diff_price`,`price`,`is_direct_price`) values 
(1,'wall unit','上座柜',1,20,0),
(2,'base unit','下座柜',0,20,0),
(3,'concrete top b/unit','石犀桌',0,20,0),
(4,'tv cabinet & dressing table','电视机和梳妆桌',0,50,1),
(5,'wardrobe(swing/sliding)','壁柜(开门/汤门)',0,40,0),
(6,'hi fi glass door',NULL,0,20,0),
(7,'tall unit','高柜',0,20,0),
(8,'ep (big)','大 ep',0,10,1),
(9,'ep (small)','小 ep',0,6,1),
(10,'canopy','飞板',0,20,0),
(11,'modify cabinet per unit',NULL,0,20,0),
(12,'drawer (normal)','柜桐(普通)',0,80,0),
(13,'drawer (dwd)','柜桐(dwd)',0,20,0),
(14,'pull out basket','拉篮(normal)',0,20,0),
(15,'lock','柜桐锁头',0,20,0),
(16,'sink opening sink','盘开洞',0,60,0),
(17,'hob opening','煮食炉开洞',0,20,0),
(18,'install hood (slim)','安装平面油烟机',0,50,1),
(19,'install hood (chimney)','安装白钢油烟机',0,20,0),
(20,'oven','oven',0,20,0),
(21,'plug point','拉插头',0,20,0),
(22,'plug point (add)','拉插头再加插头',0,20,0),
(23,'eye ball (beaufix)','小型灯(beaufix)',0,20,0),
(24,'eye ball (normal/t5)','小型灯t5',0,20,0),
(25,'dish rack','安装碟架',0,20,0),
(26,'magic corner','特别拉篮安装',0,20,0),
(27,'tall larder','高柜拉篮安装',0,20,0),
(28,'gas spring',NULL,0,20,0),
(29,'arm c',NULL,0,20,0),
(30,'150mm pull out basket',NULL,0,20,0),
(31,'computer, cooker hood hole',NULL,0,20,0),
(32,'others','其他',0,NULL,1),
(33,'shoes cabinet ft',NULL,0,38,0);

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
('12951','2022-04-01'),
('12952','2022-04-01'),
('12953','2022-04-01'),
('12954','2022-04-01'),
('12955','2022-04-01');

/*Table structure for table `product_details` */

DROP TABLE IF EXISTS `product_details`;

CREATE TABLE `product_details` (
  `product_number` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_line_number` smallint(6) NOT NULL,
  `type` bigint(20) DEFAULT NULL,
  `width` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `final_price` double DEFAULT NULL,
  `desc` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`product_number`,`product_line_number`),
  KEY `type` (`type`),
  CONSTRAINT `product_details_ibfk_1` FOREIGN KEY (`type`) REFERENCES `installation_type` (`id`),
  CONSTRAINT `product_details_ibfk_2` FOREIGN KEY (`product_number`) REFERENCES `product` (`product_number`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_details` */

insert  into `product_details`(`product_number`,`product_line_number`,`type`,`width`,`height`,`final_price`,`desc`,`quantity`) values 
('12951',1,1,2280,900,24,'',0),
('12951',2,1,900,500,20,'',0),
('12951',3,2,4938,680,20,'这个不知道怎样计算',0),
('12951',4,32,0,0,80,'shoe cabinet',1),
('12951',5,8,0,0,10,'',2),
('12951',6,9,0,0,6,'',2),
('12952',1,5,2660,1940,40,'8.72 vs 8.7',0),
('12952',2,4,0,0,50,'',1),
('12952',3,8,0,0,10,'',2),
('12953',1,5,2150,750,40,'跟单的不对',0),
('12953',2,2,1645,350,20,'不知道怎样计算',0),
('12953',3,8,0,0,10,'',2),
('12954',1,32,0,0,200,'一工',1),
('12955',1,1,1600,970,24,'',0),
('12955',2,1,2600,650,20,'',0),
('12955',3,9,0,0,6,'',6),
('12955',4,2,4370,700,20,'',0),
('12955',5,18,0,0,50,'',1),
('12955',6,33,600,910,38,'',0),
('12955',7,5,2950,600,40,'',0),
('12955',8,8,0,0,10,'',3);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `username` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`username`,`password`) values 
('admin','admin1234'),
('keiyin','keiyin');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
