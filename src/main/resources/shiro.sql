/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.6.22-log : Database - shiro
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`shiro` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `shiro`;

/*Table structure for table `sys_resource` */

DROP TABLE IF EXISTS `sys_resource`;

CREATE TABLE `sys_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `available` varchar(4) DEFAULT NULL,
  `open` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Data for the table `sys_resource` */

insert  into `sys_resource`(`id`,`name`,`type`,`url`,`parent_id`,`permission`,`available`,`open`) values (0,'root','menu','/',-1,NULL,'1',1),(1,'用户权限','menu','',0,NULL,'1',0),(2,'用户添加','menu','/user/add*',1,NULL,'1',NULL),(3,'用户修改','menu','/user/update*',1,NULL,'1',NULL),(4,'用户查询','menu','/user/get*,/user/list*',1,NULL,'1',NULL),(5,'用户删除','menu','/user/delete*',1,NULL,'1',NULL),(6,'导航','menu','/page/top',0,NULL,'1',0),(7,'角色权限','menu','',0,NULL,'1',0),(8,'角色添加','menu','/role/add*',7,NULL,'1',NULL),(9,'角色修改','menu','/role/update*',7,NULL,'1',NULL),(10,'角色查询','menu','/role/get*,/role/list*',7,NULL,'1',NULL),(11,'角色删除','menu','/role/delete*',7,NULL,'1',NULL),(12,'资源权限','menu','',0,NULL,'1',0),(13,'资源添加','menu','/resource/add*',12,NULL,'1',NULL),(14,'资源修改','menu','/resource/update*',12,NULL,'1',NULL),(15,'资源查询','menu','/resource/list*,/resource/get*',12,NULL,'1',NULL),(16,'资源删除','menu','/resource/delete*',12,NULL,'1',NULL),(17,'角色查询','menu','',7,NULL,'1',NULL),(18,'页面显示','menu','/page/*',0,NULL,'1',0),(19,'分配角色','menu','/user/allow_role',1,NULL,'1',NULL),(20,'分配资源','menu','/role/allow_resource',7,NULL,'1',NULL),(22,'权限列表','menu','/resource/get*',0,NULL,'1',0),(23,'通用资源','menu','**/common/*,/,/common/**',0,NULL,'1',0),(26,'通用资源2','menu','/common/forceLogout/**',23,NULL,'1',NULL);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(20) DEFAULT NULL,
  `description` varchar(30) DEFAULT NULL,
  `resource_ids` varchar(255) DEFAULT NULL,
  `available` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`role`,`description`,`resource_ids`,`available`) values (1,'admin','超级管理员','0,1,2,3,4,5,19,6,7,8,9,10,11,17,20,12,13,14,15,16,18,22,23,26','1'),(5,'deploy','发布管理员','0,1,4,5,19,6,7,8,9,10,11,17,20,12,13,14,15,16,18,22,23','1'),(6,'manager','项目经理','0,1,2,6,18,22,23','1'),(7,'system','系统管理员','0,1,2,3,4,5,19,6,7,8,9,12,13,14,15,16,18','1'),(8,'apply','申请管理员','18','1'),(9,'Maintain','维护管理员','18','1'),(10,'product','产品管理员','18','1'),(11,'approval','审批管理员','18','1'),(15,'base','基础角色','0,1,2,4,6,7,8,9,10,11,12,14,15,18,23','1');

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `realname` varchar(30) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `role_ids` varchar(255) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `locked` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`realname`,`password`,`role_ids`,`email`,`phone`,`locked`) values (1,'admin','张三','e00cf25ad42683b3df678c61f42c6bda','1','yjsfgn@163.com','13939393331','2'),(7,'lisi23','李四','1134b8e47e43e73e4e8c08bf1d725136','1,5','sdgsfgn@163.com','13638329323','0'),(8,'wangwu','王五','738d992e4099926873bd8520e377ddab','6','huisfgn11@163.com','13532919481','2'),(13,'sfgn','慧艳','a1cce9106626be9d2f140d888bc463cf','5,6','1580766061@qq.com','15010627375','2'),(14,'zhenzidan','贞子','c1ff13e541ec84718a4414af787a87e0','0','yjsfgn@163.com','13939393331','2'),(17,'hmu88','张三','e81a74c64665e45d1aac46af02698fb1','0','yjiu11@163.com','13939393331','2'),(18,'test','测试人员','1fb0e331c05a52d5eb847d6fc018320d','15','yjiusfgn@163.com','13919918383','0'),(19,'yjiu','刘洋','a3846c4ec6ca4f175527df0498d8fc85','15','yjiu11@163.com','13641305513','0');

/* Function  structure for function  `rand_address` */

/*!50003 DROP FUNCTION IF EXISTS `rand_address` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `rand_address`() RETURNS varchar(255) CHARSET utf8
BEGIN
		DECLARE str INT(10) DEFAULT 0;
		DECLARE return_str varchar(200) DEFAULT '';
		set str = rand_num();
		case str
			when 101 then set return_str = '北京';
			when 102 then set return_str = '天津';
			when 103 then set return_str = '广州';
			when 104 then set return_str = '广东';
			when 105 then set return_str = '河北';
			when 106 then set return_str = '河南';
			when 107 then set return_str = '四川';
			when 108 then set return_str = '厦门';
			when 109 then set return_str = '贵阳';
			when 110 then set return_str = '太原';
			else set return_str = '北上广';
		end case;
	RETURN return_str;
END */$$
DELIMITER ;

/* Function  structure for function  `rand_num` */

/*!50003 DROP FUNCTION IF EXISTS `rand_num` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `rand_num`() RETURNS int(10)
BEGIN
	DECLARE i INT DEFAULT 0;
	SET i = FLOOR(100+RAND()*10);
	RETURN i;
END */$$
DELIMITER ;

/* Function  structure for function  `rand_string` */

/*!50003 DROP FUNCTION IF EXISTS `rand_string` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `rand_string`(n INT) RETURNS varchar(255) CHARSET utf8
BEGIN
		declare chars_str varchar(100) default 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' ;
		DECLARE return_str VARCHAR(255) DEFAULT '';
		DECLARE i INT DEFAULT 0 ;
		WHILE i < n DO
			set return_str = CONCAT(return_str, substring(chars_str, floor(1+ rand()*52),1));
			SET i = i + 1;
		END WHILE;
	RETURN return_str;
END */$$
DELIMITER ;

/* Procedure structure for procedure `insert_users` */

/*!50003 DROP PROCEDURE IF EXISTS  `insert_users` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_users`(in STAR int(10),in max_num INT(10))
BEGIN
	DECLARE i INT DEFAULT 0;
	DECLARE tmp VARCHAR(50) DEFAULT '';
	SET autocommit =0;
	REPEAT
		SET i = i+1;
		SET tmp = CONCAT(rand_string(4) ,'@163.com');
		INSERT INTO users(id,username,password,email,address,ENABLE,createDate,updateDate) 
			values((STAR+i),rand_string(6),rand_string(12),tmp,rand_address(),1,'20180104','20180104');
		UNTIL i = max_num
	end REPEAT;	
	COMMIT;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
