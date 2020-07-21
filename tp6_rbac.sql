SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+08:00";

--
-- Database: `tp6_rbac`
--
CREATE DATABASE IF NOT EXISTS `tp6_rbac` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `tp6_rbac`;

-- --------------------------------------------------------

--
-- 表的结构 `api_request_log`
--

CREATE TABLE `api_request_log` (
  `id` int(11) NOT NULL,
  `request_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int(11) NOT NULL,
  `message` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `req_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `res_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referer` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `log`
--

CREATE TABLE `log` (
  `id` int(11) NOT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT '类型',
  `content` text COLLATE utf8_unicode_ci NOT NULL COMMENT '内容',
  `user_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '记录用户名',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `menu`
--

CREATE TABLE `menu` (
  `key_id` int(11) NOT NULL,
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `father_id` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0991620e-00f9-39a8-9adf-c2f375412b21' COMMENT '父菜单ID（0为主菜单）',
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '名称',
  `icon` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '图标名（FA）',
  `uri` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT '链接URL',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `is_show` tinyint(1) NOT NULL DEFAULT '1',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `menu`
--

INSERT INTO `menu` (`key_id`, `id`, `father_id`, `name`, `icon`, `uri`, `type`, `is_show`, `create_time`, `update_time`) VALUES
(1, '0991620e-00f9-39a8-9adf-c2f375412b21', '0', '系统管理', 'cogs', '#', 1, 1, '2020-07-12 13:40:20', '2020-07-13 11:56:24'),
(2, 'f5d03e9c-57e7-3adb-9845-93999263b80c', '0991620e-00f9-39a8-9adf-c2f375412b21', '用户列表', 'user-cog', 'system/user/index', 1, 1, '2020-07-12 13:40:52', '2020-07-14 20:08:43'),
(3, 'c68914e1-ecd2-361b-9adb-178db52e3731', '0991620e-00f9-39a8-9adf-c2f375412b21', '角色列表', 'users', 'system/role/index', 1, 1, '2020-07-12 13:41:46', '2020-07-14 20:08:45'),
(4, 'ab0b5611-2c74-11ea-871a-00163e0c5689', '0991620e-00f9-39a8-9adf-c2f375412b21', '菜单管理', 'list-ul', 'system/menu/index', 1, 1, '2020-07-12 13:42:06', '2020-07-14 20:08:46'),
(8, 'e0dca3db-9f41-b528-08cd-9df1ee70facb', '0991620e-00f9-39a8-9adf-c2f375412b21', '系统配置管理', 'sliders-h', 'system/setting/index', 1, 1, '2020-07-14 19:48:36', '2020-07-15 17:01:32');

-- --------------------------------------------------------

--
-- 表的结构 `role`
--

CREATE TABLE `role` (
  `key_id` int(11) NOT NULL,
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '角色名称',
  `remark` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为默认角色',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='角色表';

--
-- 转存表中的数据 `role`
--

INSERT INTO `role` (`key_id`, `id`, `name`, `remark`, `is_default`, `create_time`, `update_time`) VALUES
(1, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', '超级管理员', '最高权限，请勿删除此角色！', 0, '2020-07-12 10:31:11', '2020-07-13 22:11:46');

-- --------------------------------------------------------

--
-- 表的结构 `role_permission`
--

CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL,
  `role_id` char(36) COLLATE utf8_unicode_ci NOT NULL COMMENT '角色ID',
  `menu_id` char(36) COLLATE utf8_unicode_ci NOT NULL COMMENT '菜单ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `role_permission`
--

INSERT INTO `role_permission` (`id`, `role_id`, `menu_id`) VALUES
(3, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', '0991620e-00f9-39a8-9adf-c2f375412b21'),
(4, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', 'f5d03e9c-57e7-3adb-9845-93999263b80c'),
(5, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', 'c68914e1-ecd2-361b-9adb-178db52e3731'),
(6, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', 'ab0b5611-2c74-11ea-871a-00163e0c5689'),
(7, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', 'e0dca3db-9f41-b528-08cd-9df1ee70facb');

-- --------------------------------------------------------

--
-- 表的结构 `setting`
--

CREATE TABLE `setting` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chinese_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '/',
  `create_user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_ip` char(39) COLLATE utf8mb4_unicode_ci NOT NULL,
  `update_user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_ip` char(39) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `setting`
--

INSERT INTO `setting` (`id`, `name`, `chinese_name`, `value`, `remark`, `create_user_id`, `create_time`, `create_ip`, `update_user_id`, `update_time`, `update_ip`) VALUES
(1, 'appName', '系统名称', '生蚝科技TP6-RBAC开发框架', '/', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 11:37:45', '120.197.20.72', 'af7d3526-8a7d-d31c-a8fc-8cad40196844', '2020-07-16 11:37:45', '121.32.127.30'),
(2, 'beianCode', '备案号', '粤ICP备00000000号-1', '/', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-15 17:20:51', '121.32.13.194', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-15 17:20:51', '121.32.13.194'),
(3, 'companyName', '企业名称', '生蚝科技', '/', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 21:03:40', '121.32.13.194', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 21:03:40', '121.32.127.30'),
(4, 'homepageUrl', '企业首页网址', 'https://www.xshgzs.com', '/', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-15 17:21:05', '121.32.13.194', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-15 17:21:05', '121.32.13.194'),
(5, 'companyCreateYear', '企业创建时间', '2014', '/', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 21:03:45', '121.32.13.194', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 21:03:45', '121.32.127.30'),
(7, 'companyLogo', '公司Logo图片网址', 'https://www.xshgzs.com/resource/index/images/logo_transparent.png', '/', 'af7d3526-8a7d-d31c-a8fc-8cad40196844', '2020-07-16 16:34:43', '121.32.127.30', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 16:34:43', '121.32.127.30'),
(8, 'smtpHost', 'SMTP服务器', 'smtp.qiye.aliyun.com', '/', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 20:56:15', '121.32.127.30', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 20:56:15', '121.32.127.30'),
(9, 'smtpUserName', '发送邮箱用户名', 'test@test.com', '/', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 20:59:00', '121.32.127.30', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 20:59:00', '121.32.127.30'),
(10, 'smtpPassword', '发送邮箱密码', 'test', '/', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 20:59:06', '121.32.127.30', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 20:59:06', '121.32.127.30'),
(11, 'smtpPort', 'SMTP端口', '465', '常为465/994', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 20:57:40', '121.32.127.30', '7ab1f859-0fdd-2a23-18f7-af790ff51875', '2020-07-16 20:57:40', '121.32.127.30');

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `key_id` int(11) NOT NULL,
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `nick_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '昵称',
  `password` char(40) COLLATE utf8_unicode_ci NOT NULL COMMENT '密码',
  `salt` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:正常,2:未激活)',
  `role_id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `phone` char(11) COLLATE utf8_unicode_ci NOT NULL COMMENT '手机号',
  `email` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '邮箱地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` char(19) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_login` char(19) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`key_id`, `id`, `user_name`, `nick_name`, `password`, `salt`, `status`, `role_id`, `phone`, `email`, `create_time`, `update_time`, `last_login`) VALUES
(1, '7ab1f859-0fdd-2a23-18f7-af790ff51875', 'super', '小生蚝', '82373fe803dd3a3c86da602806379272c7565e8b', 'CF*gpXDdtL', 1, 'df5237c0-1a46-8bcb-7e15-35f16e3630fe', '13300000000', 'test@test.com', '2020-07-12 10:24:32', '2020-07-17 12:34:18', '2020-07-17 12:29:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_request_log`
--
ALTER TABLE `api_request_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `request_id` (`request_id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`key_id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`key_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`key_id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `user_name` (`user_name`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `id` (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `api_request_log`
--
ALTER TABLE `api_request_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `menu`
--
ALTER TABLE `menu`
  MODIFY `key_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- 使用表AUTO_INCREMENT `role`
--
ALTER TABLE `role`
  MODIFY `key_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `role_permission`
--
ALTER TABLE `role_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- 使用表AUTO_INCREMENT `setting`
--
ALTER TABLE `setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `key_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
  