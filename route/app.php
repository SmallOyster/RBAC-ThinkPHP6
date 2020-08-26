<?php

/**
 * @name 生蚝科技TP6-RBAC开发框架-R-全局路由
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-12
 * @version 2020-08-24
 */

use think\facade\Route;

Route::group('user', function () {
	Route::get('index', 'User/index');
	Route::post('modifyProfile', 'User/modifyProfile');
	Route::post('modifyPassword', 'User/modifyPassword');
});

Route::get('/', 'Index/index');
Route::post('/serverStatus', 'Index/getServerStatus');
Route::get('login', 'Index/login');
Route::post('toLogin', 'Index/toLogin');
Route::get('logout', 'Index/logout');
Route::get('forgetPassword', 'Index/forgetPassword');
Route::post('sendCode2ForgetPassword', 'Index/sendCode2ForgetPassword');
Route::post('resetPassword', 'Index/toResetPassword');

Route::group('error', function () {
	Route::get('noPermission', 'error/noPermission');
});

Route::group('file', function () {
	Route::post('upload', 'File/upload');
});
