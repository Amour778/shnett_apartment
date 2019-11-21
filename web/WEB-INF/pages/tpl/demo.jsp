<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<style>
.b{
font-weight:bold;
text-align:center;
}
.b_left{
font-weight:bold;
text-align:left;

}
.b_right{
font-weight:bold;
text-align:right;

}
.c_left{
font-weight:bold;
color:red;
text-align:left;
}
.d{
font-size:10px;
text-align:left;
}
</style>
<div class="layui-card">
  <div class="layui-card-header">
  	<button type="button" class="layui-btn layui-btn-primary" id="print_reimbursement" style="display:none"><i class="layui-icon layui-icon-print"></i>打印</button>
  </div>
  <div class="layui-card-body"  id="print_reimbursement_div">
	<table class="layui-table" lay-size="sm" id="print_reimbursement_table" border="1px">
	<p style="text-align:left"><img src="assets/images/shnett.logo.png" style="width:10%;"/></p>
	<p style="text-align:center">深圳市盛海信息服务有限公司日常经费（含办公费用、行政、差旅支出）报销单（除物业外）</p>

	  <tbody>
		<tr>
		  <td class="b">申请人工号</td>
		  <td id="user_id"></td>
		  
		  <td class="b">*申请人姓名</td>
		  <td>陈贤杰</td>
		  
		  <td class="b">*申请人部门</td>
		  <td>华东服务部</td>
		  
		  <td class="b">*申请日期</td>
		  <td colspan="2">2019/5/17	</td>
		</tr>
		
		<tr>
		  <td class="b">*币种</td>
		  <td>RMB</td>
		  
		  <td class="b">项目编码：</td>
		  <td></td>
		  
		  <td class="b">附件张数</td>
		  <td></td>
		  
		  <td class="b" colspan="2">*申请人部门负责人</td>
		  <td >汤欣斌</td>
		</tr>

		<tr>
		  <td class="b">*事项说明：</td>
		  <td colspan="8"></td>
		</tr>
		
		<tr>
		  <td class="b_left" colspan="9">一、费用明细区</td>
		</tr>  
		
		<tr>
		  <td class='b'>序号</td>
		  <td class='b'>*费用所属部门</td>
		  <td class='b'>*项目分类</td>
		  <td class='b'>*成本事项</td>
		  <td class='b'>*本币金额</td>
		  <td class='b'>原币金额</td>
		  <td class='b'>*票据类型</td>
		  <td class='b'>发票号码</td>
		  <td class='b'>*实际发生日期/用途</td>
		</tr>
		
		<!-- 实际报销的费用明细-->
		<tr id="item_table_reimbursement"></tr>
		
		
		<tr>
		 <td class='b_right' colspan="4">*合计金额小写：</td>
		<!-- 合计金额小写-->
		 <td class='b_right' id="item_sum_number"></td>
		</tr>
		
		<tr>
		 <td class='b_left' colspan="2">*合计金额大写：</td>
		<!-- 合计金额大写-->
		 <td class='b_left'  colspan="7" id="item_sum_capital"></td>
		</tr>
		
		<tr>
		  <td class="c_left" colspan="9">二、冲销明细区</td>
		</tr>
		
		<tr>
		  <td class='b'>序号</td>
		  <td class='b' colspan="2">前期借款成本事项</td>
		  <td class='b'>借款人/公司名称</td>
		  <td class='b'>前期借款未冲销金额</td>
		  <td class='b' colspan="2">本次冲销金额</td>
		  <td class='b'>剩余未冲销金额</td>
		  <td class='b'>未冲销金额还款方式</td>
		</tr> 
		
		<!-- 冲销明细-->
		<tr id="item_table_write_offs"></tr>
		
		
		<tr>
		  <td class="b_left" colspan="9">三、付款明细区</td>
		</tr>
		
		<tr>
		  <td class='b'>序号</td>
		  <td class='b'>收款人工号</td>
		  <td class='b'>*收款人姓名</td>
		  <td class='b'>*收款人部门</td>
		  <td class='b'>*银行卡类型</td>
		  <td class='b'>*开户银行</td>
		  <td class='b'>*开户地</td>
		  <td class='b'>*账号</td>
		  <td class='b'>*金额</td>

		</tr> 
		
		<!-- 付款明细-->
		<tr id="item_table_payment"></tr>
		
		
		
		<tr>
		  <td class="b_left" colspan="9">四、审批记录区</td>
		</tr>
		<tr>
		  <td class="b_left" colspan="2">审核/审批人</td>
		  <td class="b_left" colspan="3">*审核/审批人意见签字/日期	</td>
		  <td class="b_left" colspan="2">审核/审批人</td>
		  <td class="b_left" colspan="2">*审核/审批人意见签字/日期	</td>
		</tr>
		<tr>
		  <td class="b_left" colspan="2">费用所属部门负责人</td>
		  <td class="b_left" colspan="3"></td>
		  <td class="b_left" colspan="2">财务负责人</td>
		  <td class="b_left" colspan="2"></td>
		</tr>
		<tr>
		  <td class="b_left" colspan="2">人资负责人</td>
		  <td class="b_left" colspan="3"></td>
		  <td class="b_left" colspan="2">盛海负责人</td>
		  <td class="b_left" colspan="2"></td>
		</tr>
		
		<tr>
		  <td class="d" colspan="9">
		  温馨提示：<br/>
		  1、适用：员工代垫日常经营管理支出（含差旅费、办公费、会务费、行政支出、招聘费、宣传费、通讯费等）费用的报销；<br/>
			2、费用明细区：如有多项费用，可增加行进行填写；<br/>
			3、付款明细区：如有多个收款人，可增加行进行填写；<br/>	4、冲销明细去：如前期有借款，请填写冲销明细区相关信息；如剩余未冲销金额将于下次继续冲销，“还款方式”请选择“其他”；<br/>
			5、带*号的部分为必填项；<br/>
			6、请将报销单填写、横向打印并与发票单据及附件粘贴一起后一并提交审核/审批；<br/>
			7、完成审批并付款后，请将该报销单交由会计记帐并作为凭证存档。
			</td>
		</tr>
		
		<tr>
		  <td class="d" colspan="9">
			开票信息：<br/>
			企业名称：深圳市盛海信息服务有限公司<br/>
			地址：深圳市南山区科园路18号北科大厦8011室<br/>
			纳税人识别号：91440300MA5DFGBH20<br/>
			联系电话：0755-33992226<br/>
			账 户 名：深圳市盛海信息服务有限公司<br/>
			开户银行：招商银行股份有限公司深圳软件基地支行<br/>
			账  号：755931029510106<br/>
			</td>
		</tr>
	  </tbody>
	</table>
</div>
</div>

<script type="text/javascript" src="assets/libs/jquery.printarea.js"></script>
<script type="text/javascript">
layui.use(['layer','table','admin','jquery'],function() {
    layer = layui.layer
    ,admin = layui.admin
    ,$ = layui.jquery
    ,table = layui.table;
    var project_code = admin.getTempData('project_code');
    var user_id = admin.getTempData('user_id');
    //获取报销信息并填充
    admin.ajax_load_json({
    	url : "queryWeakActualReimbursementByProjectCodeAndUserId",
    	data : {
    		project_code : project_code,
    		user_id : user_id
    	},
    	success : function(result, status, xhr){
    		if(result.code==0){
    			$("#print_reimbursement").css('display','block'); 
    		}else{
    			layer.alert(result.info,{icon:5});
    		}
    	}
    });
    $("#print_reimbursement").click( function (){
	    $("#print_reimbursement_div").printArea();
    });
});
	
</script>