/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50703
Source Host           : localhost:3306
Source Database       : taomall

Target Server Type    : MYSQL
Target Server Version : 50703
File Encoding         : 65001

Date: 2018-07-24 21:18:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `addresslist`
-- ----------------------------
DROP TABLE IF EXISTS `addresslist`;
CREATE TABLE `addresslist` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `Tel` varchar(20) DEFAULT NULL,
  `Name` varchar(10) DEFAULT NULL,
  `isDefault` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of addresslist
-- ----------------------------
INSERT INTO `addresslist` VALUES ('1', '1', '山西省忻州市忻府区', '13376980987', 'Tom', '0');
INSERT INTO `addresslist` VALUES ('2', '1', '山西省运城市盐湖区运城学院', '1313131', 'John', '1');
INSERT INTO `addresslist` VALUES ('3', '1', '陕西省西安市雁塔区', '90898788987', 'Json', '0');
INSERT INTO `addresslist` VALUES ('4', '1', '北京市朝阳区', '4235235', 'Sun', '0');

-- ----------------------------
-- Table structure for `carlist`
-- ----------------------------
DROP TABLE IF EXISTS `carlist`;
CREATE TABLE `carlist` (
  `Id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `productId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `productName` varchar(20) DEFAULT NULL,
  `salePrice` varchar(20) DEFAULT NULL,
  `productImage` varchar(100) DEFAULT NULL,
  `checked` int(11) DEFAULT NULL,
  `productNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of carlist
-- ----------------------------
INSERT INTO `carlist` VALUES ('0000000011', '4', '1313', '红米S2', '899', '4.jpg', '1', '3');
INSERT INTO `carlist` VALUES ('0000000013', '1', '1313', '小米笔记本Pro', '6999', '1.jpg', '1', '1');
INSERT INTO `carlist` VALUES ('0000000017', '3', '1313', '小米6X', '1399', '3.jpg', '1', '2');
INSERT INTO `carlist` VALUES ('0000000018', '7', '1313', '小米Max', '1299', '7.jpg', '1', '3');
INSERT INTO `carlist` VALUES ('0000000019', '19', '1313', '小米6X 极简保护壳', '29', '19.jpg', '1', '2');
INSERT INTO `carlist` VALUES ('0000000020', '9', '1313', '小米笔记本Air', '5199', '9.jpg', '1', '2');
INSERT INTO `carlist` VALUES ('0000000021', '21', '1313', '自动折叠伞', '99', '21.jpg', '1', '1');
INSERT INTO `carlist` VALUES ('0000000022', '18', '1313', 'MIX 2保护壳', '29', '18.jpg', '0', '5667');
INSERT INTO `carlist` VALUES ('0000000023', '11', '1313', '米家电水壶', '99', '11.jpg', '1', '1');
INSERT INTO `carlist` VALUES ('0000000030', '19', '1', '小米6X 极简保护壳', '29', '19.jpg', '1', '2');
INSERT INTO `carlist` VALUES ('0000000031', '22', '1', '红米5A', '599', '22.jpg', '1', '3');
INSERT INTO `carlist` VALUES ('0000000032', '16', '1', 'x小米小爱音箱', '149', '16.jpg', '1', '4');
INSERT INTO `carlist` VALUES ('0000000034', '21', '1', '自动折叠伞', '99', '21.jpg', '0', '6');
INSERT INTO `carlist` VALUES ('0000000035', '11', '1', '米家电水壶', '99', '11.jpg', '0', '6');

-- ----------------------------
-- Table structure for `goodslist`
-- ----------------------------
DROP TABLE IF EXISTS `goodslist`;
CREATE TABLE `goodslist` (
  `productId` int(11) NOT NULL AUTO_INCREMENT,
  `productName` varchar(20) NOT NULL,
  `productPrice` int(11) NOT NULL,
  `productImg` varchar(50) NOT NULL,
  PRIMARY KEY (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodslist
-- ----------------------------
INSERT INTO `goodslist` VALUES ('1', '小米笔记本Pro', '6999', '1.jpg');
INSERT INTO `goodslist` VALUES ('2', '小米MIX 2', '3499', '2.jpg');
INSERT INTO `goodslist` VALUES ('3', '小米6X', '1399', '3.jpg');
INSERT INTO `goodslist` VALUES ('4', '红米S2', '899', '4.jpg');
INSERT INTO `goodslist` VALUES ('5', '红米note5', '1099', '5.jpg');
INSERT INTO `goodslist` VALUES ('6', '红米5', '699', '6.jpg');
INSERT INTO `goodslist` VALUES ('7', '小米Max', '1299', '7.jpg');
INSERT INTO `goodslist` VALUES ('8', '小米电视4C', '1999', '8.jpg');
INSERT INTO `goodslist` VALUES ('9', '小米笔记本Air', '5199', '9.jpg');
INSERT INTO `goodslist` VALUES ('10', '小米笔记本Pro', '6999', '10.jpg');
INSERT INTO `goodslist` VALUES ('11', '米家电水壶', '99', '11.jpg');
INSERT INTO `goodslist` VALUES ('12', '小米净水器', '1799', '12.jpg');
INSERT INTO `goodslist` VALUES ('13', 'Amazfit Cor手环', '299', '13.jpg');
INSERT INTO `goodslist` VALUES ('14', '米家行车记录仪', '349', '14.jpg');
INSERT INTO `goodslist` VALUES ('15', '米家声波电动牙刷', '199', '15.jpg');
INSERT INTO `goodslist` VALUES ('16', 'x小米小爱音箱', '149', '16.jpg');
INSERT INTO `goodslist` VALUES ('17', '小米运动蓝牙耳机', '129', '17.jpg');
INSERT INTO `goodslist` VALUES ('18', 'MIX 2保护壳', '29', '18.jpg');
INSERT INTO `goodslist` VALUES ('19', '小米6X 极简保护壳', '29', '19.jpg');
INSERT INTO `goodslist` VALUES ('20', '米兔招财猫足金吊坠', '888', '20.jpg');
INSERT INTO `goodslist` VALUES ('21', '自动折叠伞', '99', '21.jpg');
INSERT INTO `goodslist` VALUES ('22', '红米5A', '599', '22.jpg');

-- ----------------------------
-- Table structure for `orderinfo`
-- ----------------------------
DROP TABLE IF EXISTS `orderinfo`;
CREATE TABLE `orderinfo` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) DEFAULT NULL,
  `UserId` int(11) DEFAULT NULL,
  `AddressId` int(11) DEFAULT NULL,
  `CreatedTime` varchar(20) DEFAULT NULL,
  `Shipping` varchar(20) DEFAULT NULL,
  `Discount` varchar(20) DEFAULT NULL,
  `OrderTotal` varchar(255) DEFAULT NULL,
  `OrderStatus` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderinfo
-- ----------------------------
INSERT INTO `orderinfo` VALUES ('80', '3054201807191337487', '1', '2', '2018-07-19 13:37:48', '10', '200', '1885', '1');
INSERT INTO `orderinfo` VALUES ('81', '3058201807191339576', '1', '3', '2018-07-19 13:39:57', '10', '200', '1174', '1');
INSERT INTO `orderinfo` VALUES ('82', '3057201807191620346', '1', '3', '2018-07-19 16:20:34', '10', '200', '207', '1');
INSERT INTO `orderinfo` VALUES ('83', '3052201807191621223', '1', '3', '2018-07-19 16:21:22', '10', '200', '207', '1');
INSERT INTO `orderinfo` VALUES ('84', '3054201807191622120', '1', '3', '2018-07-19 16:22:12', '10', '200', '207', '1');
INSERT INTO `orderinfo` VALUES ('85', '3050201807191623230', '1', '3', '2018-07-19 16:23:23', '10', '200', '207', '1');
INSERT INTO `orderinfo` VALUES ('86', '3057201807191624060', '1', '3', '2018-07-19 16:24:06', '10', '200', '207', '1');
INSERT INTO `orderinfo` VALUES ('87', '3050201807191624565', '1', '2', '2018-07-19 16:24:56', '10', '200', '438', '1');
INSERT INTO `orderinfo` VALUES ('88', '3056201807191629413', '1', '2', '2018-07-19 16:29:41', '10', '200', '207', '1');
INSERT INTO `orderinfo` VALUES ('89', '3052201807191630297', '1', '0', '2018-07-19 16:30:29', '10', '200', '1983', '1');
INSERT INTO `orderinfo` VALUES ('90', '3059201807191631514', '1', '3', '2018-07-19 16:31:51', '10', '200', '1983', '1');
INSERT INTO `orderinfo` VALUES ('91', '3056201807191634049', '1', '2', '2018-07-19 16:34:04', '10', '200', '477', '1');
INSERT INTO `orderinfo` VALUES ('92', '3050201807191637529', '1', '0', '2018-07-19 16:37:52', '10', '200', '477', '1');
INSERT INTO `orderinfo` VALUES ('93', '3051201807191904329', '1', '2', '2018-07-19 19:04:32', '10', '200', '477', '1');
INSERT INTO `orderinfo` VALUES ('94', '3057201807192007525', '1', '0', '2018-07-19 20:07:52', '10', '200', '477', '1');
INSERT INTO `orderinfo` VALUES ('95', '3051201807192038238', '1', '2', '2018-07-19 20:38:23', '10', '200', '438', '1');
INSERT INTO `orderinfo` VALUES ('96', '3058201807192207467', '1', '3', '2018-07-19 22:07:46', '10', '200', '467', '1');
INSERT INTO `orderinfo` VALUES ('97', '3054201807221110217', '1', '3', '2018-07-22 11:10:21', '10', '200', '2261', '1');

-- ----------------------------
-- Table structure for `orderlist`
-- ----------------------------
DROP TABLE IF EXISTS `orderlist`;
CREATE TABLE `orderlist` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) DEFAULT NULL,
  `UserId` int(11) DEFAULT NULL,
  `ProductId` int(11) DEFAULT NULL,
  `ProductNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderlist
-- ----------------------------
INSERT INTO `orderlist` VALUES ('156', '3054201807191337487', '1', '13', '1');
INSERT INTO `orderlist` VALUES ('157', '3054201807191337487', '1', '20', '2');
INSERT INTO `orderlist` VALUES ('158', '3058201807191339576', '1', '18', '23');
INSERT INTO `orderlist` VALUES ('159', '3058201807191339576', '1', '15', '2');
INSERT INTO `orderlist` VALUES ('160', '3058201807191339576', '1', '13', '1');
INSERT INTO `orderlist` VALUES ('161', '3057201807191620346', '1', '16', '2');
INSERT INTO `orderlist` VALUES ('162', '3057201807191620346', '1', '21', '1');
INSERT INTO `orderlist` VALUES ('163', '3052201807191621223', '1', '16', '2');
INSERT INTO `orderlist` VALUES ('164', '3052201807191621223', '1', '21', '1');
INSERT INTO `orderlist` VALUES ('165', '3054201807191622120', '1', '16', '2');
INSERT INTO `orderlist` VALUES ('166', '3054201807191622120', '1', '21', '1');
INSERT INTO `orderlist` VALUES ('167', '3050201807191623230', '1', '16', '2');
INSERT INTO `orderlist` VALUES ('168', '3050201807191623230', '1', '21', '1');
INSERT INTO `orderlist` VALUES ('169', '3057201807191624060', '1', '16', '2');
INSERT INTO `orderlist` VALUES ('170', '3057201807191624060', '1', '21', '1');
INSERT INTO `orderlist` VALUES ('171', '3050201807191624565', '1', '19', '1');
INSERT INTO `orderlist` VALUES ('172', '3050201807191624565', '1', '22', '1');
INSERT INTO `orderlist` VALUES ('173', '3056201807191629413', '1', '21', '1');
INSERT INTO `orderlist` VALUES ('174', '3056201807191629413', '1', '16', '2');
INSERT INTO `orderlist` VALUES ('175', '3052201807191630297', '1', '20', '2');
INSERT INTO `orderlist` VALUES ('176', '3052201807191630297', '1', '16', '2');
INSERT INTO `orderlist` VALUES ('177', '3052201807191630297', '1', '21', '1');
INSERT INTO `orderlist` VALUES ('178', '3059201807191631514', '1', '20', '2');
INSERT INTO `orderlist` VALUES ('179', '3059201807191631514', '1', '16', '2');
INSERT INTO `orderlist` VALUES ('180', '3059201807191631514', '1', '21', '1');
INSERT INTO `orderlist` VALUES ('181', '3056201807191634049', '1', '18', '23');
INSERT INTO `orderlist` VALUES ('182', '3050201807191637529', '1', '18', '23');
INSERT INTO `orderlist` VALUES ('183', '3051201807191904329', '1', '18', '23');
INSERT INTO `orderlist` VALUES ('184', '3057201807192007525', '1', '18', '23');
INSERT INTO `orderlist` VALUES ('185', '3051201807192038238', '1', '19', '1');
INSERT INTO `orderlist` VALUES ('186', '3051201807192038238', '1', '22', '1');
INSERT INTO `orderlist` VALUES ('187', '3058201807192207467', '1', '19', '2');
INSERT INTO `orderlist` VALUES ('188', '3058201807192207467', '1', '22', '1');
INSERT INTO `orderlist` VALUES ('189', '3054201807221110217', '1', '19', '2');
INSERT INTO `orderlist` VALUES ('190', '3054201807221110217', '1', '22', '3');
INSERT INTO `orderlist` VALUES ('191', '3054201807221110217', '1', '16', '4');

-- ----------------------------
-- Table structure for `userlist`
-- ----------------------------
DROP TABLE IF EXISTS `userlist`;
CREATE TABLE `userlist` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(20) DEFAULT NULL,
  `UserPwd` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlist
-- ----------------------------
INSERT INTO `userlist` VALUES ('1', 'sunyu', '123456');
