<?php

/**
 * @name 生蚝科技TP6-RBAC开发框架-C-菜单接口
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-12
 * @version 2020-07-12
 */

namespace app\controller\api;

use app\BaseController;
use think\facade\Session;
use app\controller\Rbac;

class Menu extends BaseController
{
	public function getCurrentUserMenu()
	{
		if (Session::has('userInfo.roleId')) $roleId = Session::get('userInfo.roleId');
		else return packApiData(403, 'User not login', [], '用户未登录');

		$obj_Rbac = new Rbac();
		return packApiData(200, 'success', ['treeData' => $obj_Rbac->getAllMenuByRole($roleId)]);
	}
}
