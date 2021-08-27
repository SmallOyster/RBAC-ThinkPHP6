<?php

/**
 * @name 生蚝科技信安部OA-R-接口路由
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-15
 * @version 2021-08-25
 */

use think\facade\Route;

Route::group('api', function () {
	Route::group('v1', function () {
		/* RBAC路由[Begin] */
		Route::group('menu', function () {
			Route::get('getCurrentUserMenu', 'api.v1.Menu/getCurrentUserMenu');
			Route::get('roleMenuForZtree', 'api.v1.Menu/getRoleMenuForZtree');
			Route::get('list', 'api.v1.Menu/getList');
		});

		Route::group('user', function () {
			Route::get('getCurrentUserInfo', 'api.v1.User/getCurrentUserInfo');
			Route::get('list', 'api.v1.User/getList');
		});

		Route::group('role', function () {
			Route::get('list', 'api.v1.Role/getList');
		});
		/* RBAC路由[End] */
	});

	Route::group('v2', function () {
		Route::group('account', function () {
			Route::get('getPublicKey','api.v2.Account/getPublicKey');
		});
	});
});
