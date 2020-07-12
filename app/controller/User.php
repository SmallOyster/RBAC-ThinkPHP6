<?php

/**
 * @name 生蚝科技TP6-RBAC开发框架-C-用户管理
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-11
 * @version 2020-07-12
 */

namespace app\controller;

use app\BaseController;
use app\model\User as UserModel;

class User extends BaseController
{
	public function index()
	{
		return view('/user/index');
	}


	public function getList()
	{
		$page = inputPost('page', 1, 1) ?: 1;
		$perPage = inputPost('perPage', 1, 1) ?: 25;
		$filterData = inputPost('filterData', 1, 1) ?: [];

		$countQuery = new UserModel;
		$query = UserModel::field('*');

		foreach ($filterData as $key => $value) {
			if ($key === 'idLast5') {
				// 根据ID最后5位查询，方便用户快查
				$countQuery = $countQuery->whereRaw('RIGHT(id,5)=:id', ['id' => $value]);
				$query = $query->whereRaw('RIGHT(id,5)=:id', ['id' => $value]);
			} else {
				// 其他条件
				$countQuery = $countQuery->where($key, $value);
				$query = $query->where($key, $value);
			}
		}

		$countQuery = $countQuery->count('id');
		$query = $query->order('id', 'desc')
			->limit(($page - 1) * $perPage, $perPage)
			->select();

		return packApiData(200, 'success', ['total' => $countQuery, 'list' => $query->hidden(['password', 'salt'])], '', false);
	}


	public function toCU()
	{
		$cuInfo = inputPost('cuInfo', 0, 1);
		$cuType = $cuInfo['operate_type'];
		if ($cuType == 'update') {
			$cuInfo['update_time'] = date('Y-m-d H:i:s');
			UserModel::update($cuInfo, ['id' => $cuInfo['id']], ['user_name', 'nick_name', 'phone', 'email', 'role_id', 'update_time']);
			return packApiData(200, 'success');
		} elseif ($cuType == 'create') {
			$cuInfo['id'] = makeUUID();
			$password = mt_rand(100000, 999999);
			$cuInfo['salt'] = getRandomStr(10);
			$cuInfo['password'] = sha1($cuInfo['salt'] . md5($cuInfo['user_name'] . $password) . $password);
			$query = UserModel::create($cuInfo, ['id', 'user_name', 'nick_name', 'password', 'salt', 'phone', 'email', 'role_id']);
			return packApiData(200, 'success', ['q' => $query, 'initialPassword' => $password]);
		} else {
			return packApiData(5002, 'Invalid cu type', [], '非法操作行为');
		}
	}
}
