<?php

/**
 * @name 生蚝科技TP6-RBAC开发框架-V-首页
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-12
 * @version 2020-07-13
 */

namespace app\controller;

use app\BaseController;
use think\facade\Session;
use app\model\User as UserModel;
use app\model\Role as RoleModel;

class Index extends BaseController
{
	public function index()
	{
		return view('/index/index');
	}


	public function logout()
	{
		Session::clear();
		gotourl('/login');
	}


	public function login()
	{
		return view('/index/login');
	}


	public function toLogin()
	{
		$userName = inputPost('userName', 0, 1);
		$password = inputPost('password', 0, 1);

		if (checkPassword($userName, $password) !== true) {
			return packApiData(403, 'Invalid userName or password', [], '用户名或密码错误');
		}

		$userInfo = UserModel::field('id,nick_name AS nickName,role_id AS roleId,phone,email,status')
			->where('user_name', $userName)
			->find()
			->toArray();

		// 账户被禁用
		if ($userInfo['status'] !== 1) return packApiData(1, 'Current account is locked', [], '当前账号被锁定', true);

		// 获取角色名称
		$roleInfo = RoleModel::field('name')
			->where('id', $userInfo['roleId'])
			->find();

		if (isset($roleInfo['name']) && $roleInfo['name']) $userInfo['roleName'] = $roleInfo['name'];
		else return packApiData(2, 'Role info not found', ['roleId' => $userInfo['roleId']], '查询角色信息失败', true);

		// 设置用户信息session
		$userInfo['userName'] = $userName;
		Session::set('userInfo', $userInfo);

		// 更新用户最后登录时间
		UserModel::update(['last_login' => date('Y-m-d H:i:s')], ['user_name' => $userName]);

		return packApiData(200, 'success', [
			'url' => \think\facade\Config::get('app.app_host'),
			'userInfo' => $userInfo
		]);
	}
}
