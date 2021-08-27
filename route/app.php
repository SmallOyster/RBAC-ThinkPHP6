<?php

/**
 * @name 生蚝科技TP6-RBAC开发框架-R-全局路由
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-12
 * @version 2021-08-23
 */

use think\facade\Route;

Route::group('user', function () {
	Route::get('index', 'User/index');
	Route::post('modifyProfile', 'User/modifyProfile');
	Route::post('modifyPassword', 'User/modifyPassword');
});
