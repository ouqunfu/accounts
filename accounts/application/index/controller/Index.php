<?php
/**
* 测试相关
*/
namespace app\index\controller;
use think\Db;
use think\Request;
use think\Session;

class Index extends \think\Controller
{
	public function __construct(){
		parent::__construct();
	}
	
    public function index()
    {
        return '<style type="text/css">*{ padding: 0; margin: 0; } .think_default_text{ padding: 4px 48px;} a{color:#2E5CD5;cursor: pointer;text-decoration: none} a:hover{text-decoration:underline; } body{ background: #fff; font-family: "Century Gothic","Microsoft yahei"; color: #333;font-size:18px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.6em; font-size: 42px }</style><div style="padding: 24px 48px;"> <h1>:)</h1><p> ThinkPHP V5<br/><span style="font-size:30px">十年磨一剑 - 为API开发设计的高性能框架</span></p><span style="font-size:22px;">[ V5.0 版本由 <a href="http://www.qiniu.com" target="qiniu">七牛云</a> 独家赞助发布 ]</span></div><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_bd568ce7058a1091"></thinkad>';
    }
	
	/**-------------tp5增删改查示例代码-------------------**/
	
	//增加
	public function add(){
		
		$data['username'] = 'admin';
		$data['password'] = 'admin';
		$data['create_time'] = md5('123456');
		db('user')->insert($data);
		
	}
	
	//查询
	public function select(){
		
		$user_info = db('user')->field("*")->where('id',2)->find();
		dump($user_info);
	}
	
	//修改
	public function update(){
		
		$data['password'] = md5(md5('123456').config('encryption_factor_str'));
		$data['create_time'] = time();
		$res = db('user')->where('id',2)->update($data);
		dump($res);
	}
	
	//删除
	public function delete(){
		
		$res= db('user')->where('id',2)->delete();
		dump($res);
	}
	
	//获取配置
	public function getConfig(){
		//所有配置
		config();
		//加密因子
		dump(config('encryption_factor_str')); 
	}
	
	
	//页面
	public function page(){
		
		return $this->fetch('page');
	}
	
	//页面请求处理
	public function doRequest(){
		
		//$request = Request::instance();
		//使用助手函数
		$request = request();
		echo "当前模块名称是" . $request->module();
		echo "当前控制器名称是" . $request->controller();
		echo "当前操作名称是" . $request->action();
		
		// 获取当前请求的所有变量（经过过滤）
		$input = $request->param();
		
		dump($input);
		dump(input());
		echo $input['param3'];
		echo input('param1');
	}
	
	//session 和 cache 处理
	public function sesseionAndCache(){
		
		//设置
		Session::set('name','thinkphp');
		//获取
		echo Session::get('name');
		//清空
		Session::clear();
		echo '值是否清除=='.Session::get('name');
	}
}
