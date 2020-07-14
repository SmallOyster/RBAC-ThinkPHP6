<?php

/**
 * @name 生蚝科技TP6-RBAC开发框架-R-全局路由
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-12
 * @version 2020-07-14
 */

use think\facade\Route;

Route::group('system', function () {
	Route::group('user', function () {
		Route::get('index', 'system.User/index');
		Route::post('list', 'system.User/getList');
		Route::post('toCU', 'system.User/toCU');
		Route::post('delete', 'system.User/toDelete');
		Route::post('resetPassword', 'system.User/toResetPassword');
		Route::post('banOrOpen', 'system.User/toBanOrOpen');
	});

	Route::group('menu', function () {
		Route::get('index', 'system.Menu/index');
		Route::post('toCU', 'system.Menu/toCU');
		Route::post('delete', 'system.Menu/toDelete');
	});

	Route::group('role', function () {
		Route::get('index', 'system.Role/index');
		Route::post('list', 'system.Role/getList');
		Route::post('toCU', 'system.Role/toCU');
		Route::post('delete', 'system.Role/toDelete');
		Route::post('setDefault', 'system.Role/toSetDefault');
		Route::post('setPermission', 'system.Role/toSetPermission');
	});
});

// api接口路由
Route::group('api', function () {
	Route::group('menu', function () {
		Route::get('getCurrentUserMenu', 'api.Menu/getCurrentUserMenu');
		Route::get('roleMenuForZtree', 'api.Menu/getRoleMenuForZtree');
		Route::get('list', 'api.Menu/getList');
	});

	Route::group('user', function () {
		Route::get('getCurrentUserInfo', 'api.User/getCurrentUserInfo');
		Route::get('list', 'api.User/getList');
	});

	Route::group('role', function () {
		Route::get('list', 'api.Role/getList');
	});
});

Route::get('/', 'Index/index');
Route::get('login', 'Index/login');
Route::post('toLogin', 'Index/toLogin');
Route::get('logout', 'Index/logout');
