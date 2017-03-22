<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

//获取用途名称
function get_record_type($tid){
	
	if(!$tid){
		return '';
	}
	$map['is_delete'] = 0;
	$map['id'] = $tid;
	$type_info = db('type')->field("name")->where($map)->find();
		
	return $type_info['name'];	
}

//获取支付方式名称
function get_payment_type($pid){
	
	if(!$pid){
		return '';
	}
	$map['is_delete'] = 0;
	$map['id'] = $pid;
	$payment_info = db('payment')->field("name")->where($map)->find();
		
	return $payment_info['name'];	
}

//获取所有用途类型
function get_all_record_type($field='*'){
	
	$map['is_delete'] = 0;
	$type_info_list = db('type')->field($field)->where($map)->order('sort desc')->select();
	
	return $type_info_list;
}

//获取所有支付方式类型
function get_all_payment_type($field='*'){
	
	$map['is_delete'] = 0;
	$payment_info_list = db('payment')->field($field)->where($map)->order('sort desc')->select();
	
	return $payment_info_list;
}




