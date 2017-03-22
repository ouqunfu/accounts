-- phpMyAdmin SQL Dump
-- version 4.0.10.16
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2017-03-21 03:51:07
-- 服务器版本: 5.5.53-log
-- PHP 版本: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `accounts`
--

-- --------------------------------------------------------

--
-- 表的结构 `ac_payment`
--

CREATE TABLE IF NOT EXISTS `ac_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '支付方式名称',
  `sort` tinyint(1) NOT NULL DEFAULT '0',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-已删除',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='支付类型表' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `ac_payment`
--

INSERT INTO `ac_payment` (`id`, `name`, `sort`, `is_delete`) VALUES
(1, '微信', 0, 0),
(2, '支付宝', 0, 0),
(3, '现金', 0, 0),
(4, '其他', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `ac_record`
--

CREATE TABLE IF NOT EXISTS `ac_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `order_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-支出 1-收入',
  `payment_id` tinyint(1) NOT NULL DEFAULT '0' COMMENT '支付类型id',
  `tid` tinyint(1) unsigned NOT NULL COMMENT '记录类型id',
  `money` decimal(10,2) unsigned NOT NULL COMMENT '金额',
  `remark` text NOT NULL COMMENT '备注',
  `trading_time` int(10) NOT NULL DEFAULT '0' COMMENT '交易时间',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NOT NULL COMMENT '修改时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-已删除',
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`,`create_time`,`update_time`,`user_id`),
  KEY `order_type` (`order_type`),
  KEY `id` (`id`) USING BTREE,
  KEY `trading_time` (`trading_time`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='记录表' AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `ac_record`
--

INSERT INTO `ac_record` (`id`, `user_id`, `order_type`, `payment_id`, `tid`, `money`, `remark`, `trading_time`, `create_time`, `update_time`, `is_delete`) VALUES
(1, 2, 0, 1, 1, 1.00, '测试测试', 1490003570, 1490003570, 0, 0),
(7, 2, 0, 2, 2, 255.00, '多岁的风格', 1490005325, 1490005325, 0, 0),
(6, 2, 0, 3, 3, 0.22, '反反复复', 1490004681, 1490004681, 0, 0),
(8, 2, 0, 1, 1, 5.50, '早餐 肠粉', 1490060785, 1490060785, 0, 0),
(9, 2, 0, 2, 2, 50.00, '羊城通', 1490065252, 1490065252, 0, 0),
(10, 2, 0, 3, 3, 100.00, '测试赛', 1490065591, 1490065591, 0, 0),
(11, 2, 0, 1, 1, 17.00, '晚餐 螺蛳粉', 1489939200, 1490066117, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `ac_type`
--

CREATE TABLE IF NOT EXISTS `ac_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '类型名称',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '记录类型 0-支出类型 1-收入类型',
  `fid` int(10) NOT NULL DEFAULT '0' COMMENT '所属父级类型',
  `sort` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-删除',
  PRIMARY KEY (`id`),
  KEY `tid` (`fid`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='记账类型表' AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `ac_type`
--

INSERT INTO `ac_type` (`id`, `name`, `type`, `fid`, `sort`, `is_delete`) VALUES
(1, '餐饮', 0, 0, 0, 0),
(2, '交通', 0, 0, 0, 0),
(3, '购物', 0, 0, 0, 0),
(4, '医药', 0, 0, 0, 0),
(5, '投资', 0, 0, 0, 0),
(6, '其他', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `ac_user`
--

CREATE TABLE IF NOT EXISTS `ac_user` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户表' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `ac_user`
--

INSERT INTO `ac_user` (`id`, `username`, `password`, `create_time`, `login_time`, `is_delete`) VALUES
(2, 'admin', '97f0b9dc7e97e78428d068f4e8885923', 1489905581, 1490003028, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
