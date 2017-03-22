<?php
/**
* 业务相关
*/

namespace app\account\controller;
use think\Db;
use think\Request;
use think\Session;

class Index extends \think\Controller
{
	
	public function __construct(){
		
		parent::__construct();
		$user_info = Session::get('user_info');
		if(empty($user_info) || intval($user_info['id']) == 0){
			$this->redirect('login/index/index');
		}
		$GLOBALS['user_info'] = $user_info;
	}
	
	/**
	* 当日记录
	*/
    public function index()
    {
		$request = request();
		// 获取当前请求的所有变量（经过过滤）
		$input = $request->param();
		
		if(empty($input)){
			$input['pickdate'] = date('Y年m月d日',time());
		}
		preg_match_all('/\d+/',$input['pickdate'],$pickdate);
		$pickdate = implode('-',$pickdate[0]);
		if(empty($pickdate)){
			$pickdate = date('Y-m-d',time());
		}
		
		$begin_time = strtotime($pickdate);
		$end_time = $begin_time + 24*3600;
		
		$user_id = $GLOBALS['user_info']['id'];
		
		$map = " user_id={$user_id} and is_delete = 0 and trading_time>={$begin_time} and trading_time < {$end_time} ";
		$list = db('record')->field("*")->where($map)->order("create_time desc")->select();
		
		$sum_money = db('record')->field("*")->where($map)->order("create_time desc")->sum('money');
		//dump($sum_money);die;
		
		$this->assign('pickdate',$input['pickdate']);
		$this->assign("sum_money", $sum_money);
		$this->assign("list", $list);
		
		$this->assign('tab',1);
		$this->assign("title", '明细');
        return $this->fetch('index');
    }
	
	
	/**
	* 添加记录页面
	*/
	public function add(){
		
		$type_info_list = get_all_record_type();
		$payment_info_list = get_all_payment_type();
		$this->assign('type_info_list',$type_info_list);
		$this->assign('payment_info_list',$payment_info_list);
		
		$this->assign('pickdate',date('Y年m月d日',time()));
		$this->assign('tab',1);
		$this->assign("title", '记账');
        return $this->fetch('add');
	}
	
	/**
	* 编辑记录页面
	*/
	public function edit(){
		
		$request = request();
		// 获取当前请求的所有变量（经过过滤）
		$input = $request->param();
		
		$rid = intval($input['rid']);
		if(!$rid){
			$this->error('数据出错');
		}
		$map['id'] = $rid;
		$map['user_id'] = $GLOBALS['user_info']['id'];
		$record = db('record')->field("*")->where($map)->find();
		
		$type_info_list = get_all_record_type();
		$payment_info_list = get_all_payment_type();
		$this->assign('type_info_list',$type_info_list);
		$this->assign('payment_info_list',$payment_info_list);
		
		$this->assign('record',$record);
		$this->assign('pickdate',date('Y年m月d日',$record['trading_time']));
		$this->assign('tab',1);
		$this->assign("title", '记账');
        return $this->fetch('add');
	}
	
	/**
	* 处理添加\编辑，数据入库
	*/
	public function doAdd(){
		
		$request = request();
		// 获取当前请求的所有变量（经过过滤）
		$input = $request->param();
		if(empty($input['money']) || $input['money'] <= 0){
			$this->error('请输入金额');
		}
		$data['user_id'] = $GLOBALS['user_info']['id'];
		$data['order_type'] = $input['order_type'];
		$data['payment_id'] = $input['payment_id'];
		$data['tid'] = $input['tid'];
		$data['money'] = $input['money'];
		$data['remark'] = $input['remark'];
		preg_match_all('/\d+/',$input['pickdate'],$pickdate);
		$pickdate = implode('-',$pickdate[0]);
		if(empty($pickdate)){
			$pickdate = date('Y-m-d',time());
		}
		
		$data['trading_time'] = strtotime($pickdate);
		
		$rid = intval($input['rid']);
		if($rid > 0){
			$data['update_time'] = time();
			$res = db('record')->where('id',$rid)->update($data);
		}else{		
			$data['create_time'] = time();
			$res = db('record')->insert($data);
		}
		if($res){
			//跳转
			$this->success('操作成功', url('account/index/index',''));
		}
		
	}
	
	/**
	* 当月报表、账单
	*/
	public function billList(){
		
		$this->assign('tab',2);
		$this->assign("title", '账单');
		
		$request = request();
		// 获取当前请求的所有变量（经过过滤）
		$input = $request->param();
		
		if(empty($input)){
			$input['pickdate'] = date('Y年m月',time());
		}
		preg_match_all('/\d+/',$input['pickdate'],$pickdate);
		//$pickdate = implode('-',$pickdate[0]);
		
		$y = date("Y",time()); //年
		$m = date("m",time()); //月
		$t0 = date('t');  // 本月一共有几天
		
		if(!empty($pickdate)){
			$y = $pickdate[0][0]; 
			$m = $pickdate[0][1]; 
			$t0 = date('t',strtotime($pickdate[0][0].'-'.$pickdate[0][1].'-01'));  
		}
		//月开始时间戳
		$month_start_time = mktime(0,0,0,$m,1,$y);
		//月结束时间戳
		$month_end_time = mktime(23,59,59,$m,$t0,$y);
		
		//类型 支出\收入 0-支出 1-收入
		$order_type = 0;
		
		$sum_money = 0;
		
		//金额用途
		$type_list = db('type')->field("*")->where('is_delete',0)->order("sort desc")->select();
		
		if(is_array($type_list)){
			
			$list = array();
			$i = 0;
			$user_id = $GLOBALS['user_info']['id'];
			foreach($type_list as $key => $v){
				
				$map = " user_id={$user_id} and tid={$v['id']} and order_type={$order_type} and is_delete = 0 and trading_time >= {$month_start_time} and trading_time < {$month_end_time} ";
				$temp_money = db('record')->where($map)->order("create_time desc")->sum('money');
				
				if($temp_money > 0){
					$list[$i] = $type_list[$key];
					$list[$i]['money'] = $temp_money;
					$sum_money += $temp_money;
					$i++;
					unset($temp_money);
				}
			}
		}
		
		$this->assign('pickdate',$input['pickdate']);
		$this->assign("sum_money", $sum_money);
		$this->assign("list", $list);
		
		
		$this->assign('pickdate',$input['pickdate']);
		
		return $this->fetch('billList');
	}
}
