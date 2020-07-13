<?php
/**
 * @name 生蚝科技TP6-RBAC开发框架-R-全局路由
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-12
 * @version 2020-07-13
 */

use think\facade\Route;

Route::group('user', function () {
	Route::get('index', 'User/index');
	Route::post('list', 'User/getList');
	Route::post('toCU', 'User/toCU');
	Route::post('delete', 'User/toDelete');
	Route::post('resetPassword', 'User/toResetPassword');
	Route::post('banOrOpen', 'User/toBanOrOpen');
});

Route::group('role', function () {
	Route::get('index', 'Role/index');
	Route::post('list', 'Role/getList');
	Route::post('toCU', 'Role/toCU');
	Route::post('delete', 'Role/toDelete');
	Route::post('setDefault', 'Role/toSetDefault');
	Route::post('setPermission', 'Role/toSetPermission');
});

// api接口路由
Route::group('api', function () {
	Route::group('menu', function () {
		Route::get('getCurrentUserMenu', 'api.Menu/getCurrentUserMenu');
		Route::get('roleMenuForZtree', 'api.Menu/getRoleMenuForZtree');
	});

	Route::group('user', function () {
		Route::get('getCurrentUserInfo', 'api.User/getCurrentUserInfo');
		Route::get('list', 'api.User/getList');
	});

	Route::group('role', function () {
		Route::get('list', 'api.Role/getList');
	});
});

Route::get('login', 'Index/login');
Route::post('toLogin', 'Index/toLogin');
Route::get('logout', 'Index/logout');
