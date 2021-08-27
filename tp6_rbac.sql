SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `tp6_rbac` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `tp6_rbac`;

CREATE TABLE `api_request_log` (
  `id` int(11) UNSIGNED NOT NULL,
  `request_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '/',
  `path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` mediumint(9) NOT NULL DEFAULT 0,
  `message` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `req_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `res_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referer` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_user_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `menu` (
  `key_id` int(11) UNSIGNED NOT NULL,
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `father_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '父菜单ID（0为主菜单）',
  `icon` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图标名（FA5）',
  `uri` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '链接URL',
  `sort` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '类型（1菜单2按钮3接口）',
  `is_show` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否显示',
  `create_time` datetime NOT NULL DEFAULT current_timestamp(),
  `update_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `menu` (`key_id`, `id`, `name`, `father_id`, `icon`, `uri`, `sort`, `type`, `is_show`, `create_time`, `update_time`) VALUES
(1, '0991620e-00f9-39a8-9adf-c2f375412b21', '系统管理', '0', 'cogs', '#', 1, 1, 1, '2020-07-12 13:40:20', '2020-07-13 11:56:24'),
(2, 'f5d03e9c-57e7-3adb-9845-93999263b80c', '用户列表', '0991620e-00f9-39a8-9adf-c2f375412b21', 'user-cog', 'system/user/index', 1, 1, 1, '2020-07-12 13:40:52', '2020-07-14 20:08:43'),
(3, 'c68914e1-ecd2-361b-9adb-178db52e3731', '角色列表', '0991620e-00f9-39a8-9adf-c2f375412b21', 'users', 'system/role/index', 2, 1, 1, '2020-07-12 13:41:46', '2021-08-21 16:11:34'),
(4, 'ab0b5611-2c74-11ea-871a-00163e0c5689', '菜单管理', '0991620e-00f9-39a8-9adf-c2f375412b21', 'folder-tree', 'system/menu/index', 1, 1, 1, '2020-07-12 13:42:06', '2021-08-26 16:46:56'),
(5, 'e0dca3db-9f41-b528-08cd-9df1ee70facb', '系统配置管理', '0991620e-00f9-39a8-9adf-c2f375412b21', 'sliders-h', 'system/setting/index', 4, 1, 1, '2020-07-14 19:48:36', '2021-08-21 16:11:36'),

CREATE TABLE `role` (
  `key_id` int(11) NOT NULL,
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '备注',
  `is_default` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为默认角色',
  `is_super` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为管理员角色',
  `create_time` datetime NOT NULL DEFAULT current_timestamp(),
  `update_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

INSERT INTO `role` (`key_id`, `id`, `name`, `remark`, `is_default`, `is_super`, `create_time`, `update_time`) VALUES
(1, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', '超级管理员', '最高权限，请勿删除此角色！', 0, 1, '2020-07-12 10:31:11', '2020-07-13 22:11:46');

CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL,
  `role_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色ID',
  `menu_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `role_permission` (`id`, `role_id`, `menu_id`) VALUES
(1, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', '0991620e-00f9-39a8-9adf-c2f375412b21'),
(2, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', 'f5d03e9c-57e7-3adb-9845-93999263b80c'),
(3, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', 'c68914e1-ecd2-361b-9adb-178db52e3731'),
(4, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', 'ab0b5611-2c74-11ea-871a-00163e0c5689'),
(5, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', 'e0dca3db-9f41-b528-08cd-9df1ee70facb');

CREATE TABLE `setting` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chinese_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '/',
  `create_time` datetime NOT NULL DEFAULT current_timestamp(),
  `create_ip` char(39) COLLATE utf8mb4_unicode_ci NOT NULL,
  `update_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `update_ip` char(39) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `setting` (`id`, `name`, `chinese_name`, `value`, `remark`, `create_time`, `create_ip`, `update_time`, `update_ip`) VALUES
(1, 'appName', '系统名称', '生蚝科技TP6-RBAC开发框架', '/', '2021-08-20 22:38:19', '127.0.0.1', '2021-08-22 16:34:55', '127.0.0.1'),
(2, 'beianCode', '备案号', '粤ICP备00000000号-1', '/', '2020-07-15 17:20:51', '127.0.0.1', '2021-08-21 21:11:58', '127.0.0.1'),
(3, 'companyName', '企业名称', '生蚝科技', '/', '2020-07-16 21:03:40', '127.0.0.1', '2020-07-16 21:03:40', '127.0.0.1'),
(4, 'homepageUrl', '企业首页网址', 'https://www.xshgzs.com', '/', '2020-07-15 17:21:05', '127.0.0.1', '2020-07-15 17:21:05', '127.0.0.1'),
(5, 'companyCreateYear', '企业创建时间', '2014', '/', '2020-07-16 21:03:45', '127.0.0.1', '2020-07-16 21:03:45', '127.0.0.1'),
(7, 'companyLogo', '公司Logo图片网址', 'https://www.xshgzs.com/resource/index/images/logo_transparent.png', '/', '2020-07-16 16:34:43', '127.0.0.1', '2021-08-21 21:33:07', '127.0.0.1'),
(8, 'smtpHost', 'SMTP服务器', 'smtp.qiye.aliyun.com', '/', '2020-07-16 20:56:15', '127.0.0.1', '2020-07-16 20:56:15', '127.0.0.1'),
(9, 'smtpUserName', '发送邮箱用户名', 'test@test.com', '/', '2020-07-16 20:59:00', '127.0.0.1', '2020-07-16 20:59:00', '127.0.0.1'),
(10, 'smtpPassword', '发送邮箱密码', 'test', '/', '2020-07-16 20:59:06', '127.0.0.1', '2020-07-16 20:59:06', '127.0.0.1'),
(11, 'smtpPort', 'SMTP端口', '465', '常为465/994', '2020-07-16 20:57:40', '127.0.0.1', '2020-07-16 20:57:40', '127.0.0.1');

CREATE TABLE `user` (
  `key_id` int(11) NOT NULL,
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `nick_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '昵称',
  `password` char(40) COLLATE utf8_unicode_ci NOT NULL COMMENT '密码',
  `salt` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态(0:禁用,1:正常,2:未激活)',
  `role_id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `phone` char(11) COLLATE utf8_unicode_ci NOT NULL COMMENT '手机号',
  `email` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '邮箱地址',
  `create_time` datetime NOT NULL DEFAULT current_timestamp(),
  `update_time` char(19) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_login` char(19) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `user` (`key_id`, `id`, `user_name`, `nick_name`, `password`, `salt`, `status`, `role_id`, `phone`, `email`, `create_time`, `update_time`, `last_login`) VALUES
(1, '7ab1f859-0fdd-2a23-18f7-af790ff51875', 'super', '小生蚝', 'dc43c89385c2ca956b8abfd76670d4bdb502d6fc', '5X6UA$47Dq', 1, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', '13300000000', 'test@test.com', '2020-07-12 10:24:32', '2020-08-01 21:08:34', '2020-08-01 21:06:34');

ALTER TABLE `api_request_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `request_id` (`request_id`);

ALTER TABLE `menu`
  ADD PRIMARY KEY (`key_id`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `role`
  ADD PRIMARY KEY (`key_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `menu_id` (`menu_id`);

ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `user`
  ADD PRIMARY KEY (`key_id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `user_name` (`user_name`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `api_request_log`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `menu`
  MODIFY `key_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `role`
  MODIFY `key_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `role_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

ALTER TABLE `user`
  MODIFY `key_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
