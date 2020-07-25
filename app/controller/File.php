<?php

/**
 * @name 宇滔流媒体平台后台-C-文件
 * @author Oyster Cheung <master@xshgzs.com>
 * @since 2020-07-22
 * @version 2020-07-25
 */

namespace app\controller;

use app\BaseController;
use think\facade\Request;

class File extends BaseController
{
	public function upload()
	{
		$type = inputPost('type', 0, 1);

		if (!isset($_FILES['fileInfo'])) return packApiData(4001, 'No file', [], '未选择要上传的文件');
		else $file = $_FILES['fileInfo'];

		$fileExtension = substr($file['name'], strrpos($file['name'], '.') + 1);
		$check = self::checkFile($type, $file, $fileExtension);

		if ($check === 1) {
			return packApiData(4002, 'Invalid upload type', [], '非法的上传路径，请联系管理员');
		} elseif ($check === 2) {
			return packApiData(4003, 'File is too big', [], '文件过大，请重新选择文件', false);
		} elseif ($check === 3) {
			return packApiData(4004, 'Not support extension', [], '不支持上传此文件类型');
		}

		$newName = sha1(date('YmdHis') . mt_rand(123456, 987654)) . '.' . $fileExtension;
		$newLocation = 'file/' . $type . $newName;
		move_uploaded_file($file['tmp_name'], public_path() . $newLocation);

		return packApiData(200, 'success', [
			'url' => Request::root(true) . '/public/' . $newLocation
		]);
	}


	private static function checkFile($type, $fileInfo, $extension)
	{
		$setting = json_decode(getSetting('fileUploadSetting'), true);

		if (!isset($setting[$type])) return 1; // 不支持的上传路径
		else $setting = $setting[$type];

		if ($fileInfo['size'] > $setting['size']) return 2; // 超出大小限制
		elseif (!in_array($extension, $setting['extension'])) return 3; // 不支持此扩展名
		else return 0;
	}
}
