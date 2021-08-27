<?php

/**
 * @name 生蚝科技TP6-RBAC开发框架-C-异常处理
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-15
 * @version 2020-10-22
 */

namespace app\controller;

class Error
{
	public function index()
	{
		return view('/error', [
			'status' => inputGet('a', 1),
			'content' => inputGet('t'),
			'canBack' => inputGet('b', 1),
			'hideTitle' => inputGet('ht', 1)
		]);
	}


	public function noPermission()
	{
		return view('/error', [
			'status' => 'error',
			'content' => '当前用户无权限访问此功能 或 长时间未操作<br>请重新登录',
			'canBack' => '0',
			'hideTitle' => '1'
		]);
	}
}
