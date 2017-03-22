/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : accounts

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2017-03-19 16:22:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ac_payment
-- ----------------------------
DROP TABLE IF EXISTS `ac_payment`;
CREATE TABLE `ac_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `sort` tinyint(1) NOT NULL DEFAULT '0',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-已删除',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='支付类型表';

-- ----------------------------
-- Records of ac_payment
-- ----------------------------

-- ----------------------------
-- Table structure for ac_record
-- ----------------------------
DROP TABLE IF EXISTS `ac_record`;
CREATE TABLE `ac_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `order_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-支出 1-收入',
  `payment_id` tinyint(1) NOT NULL DEFAULT '0' COMMENT '支付类型id',
  `tid` tinyint(1) unsigned NOT NULL COMMENT '记录类型id',
  `money` decimal(10,2) unsigned NOT NULL COMMENT '金额',
  `remark` text NOT NULL COMMENT '备注',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NOT NULL COMMENT '修改时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-已删除',
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`,`create_time`,`update_time`,`user_id`),
  KEY `order_type` (`order_type`),
  KEY `id` (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='记录表';

-- ----------------------------
-- Records of ac_record
-- ----------------------------

-- ----------------------------
-- Table structure for ac_type
-- ----------------------------
DROP TABLE IF EXISTS `ac_type`;
CREATE TABLE `ac_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '类型名称',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '记录类型 0-支出类型 1-收入类型',
  `fid` int(10) NOT NULL DEFAULT '0' COMMENT '所属父级类型',
  `sort` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-删除',
  PRIMARY KEY (`id`),
  KEY `tid` (`fid`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='记账类型表';

-- ----------------------------
-- Records of ac_type
-- ----------------------------

-- ----------------------------
-- Table structure for ac_user
-- ----------------------------
DROP TABLE IF EXISTS `ac_user`;
CREATE TABLE `ac_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL COMMENT '登录用户名',
  `password` varchar(255) NOT NULL COMMENT '登录密码',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `login_time` int(10) NOT NULL COMMENT '最近登录时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-已删除',
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`),
  KEY `login_time` (`login_time`),
  KEY `id` (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of ac_user
-- ----------------------------
INSERT INTO `ac_user` VALUES ('2', 'admin', '97f0b9dc7e97e78428d068f4e8885923', '1489905581', '1489910370', '0');
