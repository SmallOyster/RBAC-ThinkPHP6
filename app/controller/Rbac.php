<?php

/**
 * @name 生蚝科技TP6-RBAC开发框架-C-RBAC核心
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-12
 * @version 2021-08-26
 */

namespace app\controller;

use app\model\Menu as MenuModel;
use app\model\RolePermission as RolePermissionModel;

class Rbac
{
	/**
	 * 根据URI获取菜单Id
	 * @param  string URI
	 * @return string 菜单Id
	 */
	public function getMenuId($uri = '')
	{
		$query = MenuModel::field('id')
			->where('uri', $uri)
			->find();

		return (isset($query['id'])) ? $query['id'] : null;
	}


	/**
	 * 获取所有父菜单
	 * @return array 父菜单信息
	 */
	public function getFatherMenu()
	{
		$list = MenuModel::where('father_id', 0)->select();

		return $list->toArray();
	}


	/**
	 * 根据父菜单Id获取子菜单
	 * @param string 父菜单Id
	 * @return array 子菜单信息
	 */
	public function getChildMenu($fatherId = '')
	{
		$list = MenuModel::where('father_id', $fatherId)->select();

		return $list->toArray();
	}


	/**
	 * 根据角色获取所有权限的菜单Id
	 * @param string 角色Id
	 * @return array 菜单Id
	 */
	public function getAllPermissionByRole($roleId = '')
	{
		$list = RolePermissionModel::field('menu_id')
			->where('role_id', $roleId)
			->select()
			->toArray();
		$rtn = [];

		foreach ($list as $info) {
			array_push($rtn, $info['menu_id']);
		}

		return $rtn;
	}


	/**
	 * 根据角色和父菜单Id获取子菜单信息
	 * @param string 角色Id
	 * @param string 父菜单Id
	 * @return array 子菜单信息
	 */
	public function getChildMenuByRole($roleId = '', $fatherId = '')
	{
		$rtn = [MenuModel::getListByRole($roleId, $fatherId), 0, 0, 0];

		foreach ($rtn[0] as $info) {
			$rtn[(int)$info['type']]++;
		}

		return $rtn;
	}


	/**
	 * 根据角色获取所有菜单详细信息
	 * @param string 角色Id
	 * @return array 菜单详细信息
	 */
	public function getAllMenuByRole($roleId = '')
	{
		$fatherMenu = $this->getChildMenuByRole($roleId, '0');
		$fatherMenuCnt = $fatherMenu[1] + $fatherMenu[2] + $fatherMenu[3];
		$menuTree = $fatherMenu[0];

		// 搜寻二级菜单
		for ($i = 0; $i < $fatherMenuCnt; $i++) {
			$fatherId = $fatherMenu[0][$i]['id'];
			$childList = $this->getChildMenuByRole($roleId, $fatherId);

			if ($childList[0] == []) {
				// 没有二级菜单
				$menuTree[$i]['hasChild'] = false;
			} else {
				// 有二级菜单
				$menuTree[$i]['childTypeCnt'] = [0, $childList[1], $childList[2], $childList[3]];
				$menuTree[$i]['hasChild'] = true;
				$menuTree[$i]['child'] = $childList[0];

				// 二级菜单的数量
				$childListCnt = $childList[1] + $childList[2] + $childList[3];

				// 搜寻三级菜单
				for ($j = 0; $j < $childListCnt; $j++) {
					$father2Id = $childList[0][$j]['id'];
					$grandsonList = $this->getChildMenuByRole($roleId, $father2Id);

					if ($grandsonList[0] == []) {
						// 没有三级菜单
						$menuTree[$i]['child'][$j]['hasChild'] = false;
					} else {
						// 有三级菜单
						$menuTree[$i]['child'][$j]['childTypeCnt'] = [0, $grandsonList[1], $grandsonList[2], $grandsonList[3]];
						$menuTree[$i]['child'][$j]['hasChild'] = true;
						$menuTree[$i]['child'][$j]['child'] = $grandsonList[0];
					}
				}
			}
		}

		return $menuTree;
	}
}
