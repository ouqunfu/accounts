<?php
/**
* 登录相关
*/

namespace app\login\controller;
use think\Db;
use think\Request;
use think\Session;

class Index extends \think\Controller
{
	public function __construct(){
		
		parent::__construct();
		$user_info = Session::get('user_info');
		if($user_info || intval($user_info['id']) > 0){
			$this->redirect('account/index/index');
		}
	}
	
    public function index()
    {
		$this->assign("title", '登录');
        return $this->fetch('index');
    }
	
	public function doLogin(){
		
		$request = request();
		// 获取当前请求的所有变量（经过过滤）
		$input = $request->param();
		
		$username = $input['username'];
		$password = $input['password'];
		
		//查询用户是否存在
		$where['username'] = $username;
		$where['password'] = md5(md5($password).config('encryption_factor_str'));
		$user_info = db('user')->field("*")->where($where)->find();
		
		//$this->success('登录成功', url('index/index/page',''));
		//dump($user_info);die;
		if($user_info['id'] > 0){ //登录成功
			
			//更新登录时间
			$data['login_time'] = time();
			db('user')->where('id',$user_info['id'])->update($data);
			//设置session
			Session::set('user_info',$user_info);
			
			//跳转
			$this->success('登录成功', url('account/index/index',''));
		}
	}
}
