<?php

/**
 * @name 生蚝科技TP6-RBAC开发框架-M-菜单
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-12
 * @version 2021-08-26
 */

namespace app\model;

use think\Model;

class Menu extends Model
{
	protected $pk = 'key_id';
	protected $convertNameToCamel = true;

	static public function getListByRole($roleId = '', $fatherId = '', $type = '')
	{
		$list = self::alias('m')
			->field('m.id,m.name,m.father_id,m.icon,m.uri,m.sort,m.type,m.create_time,m.update_time')
			->where('m.father_id', $fatherId)
			->where('m.is_show', 1);

		if ($type !== '') $list = $list->where('m.type', $type);

		$list = $list->where('rp.role_id', $roleId)
			->join('role_permission rp', 'm.id=rp.menu_id')
			->order('m.sort')
			->select();

		return $list->toArray();
	}
}
