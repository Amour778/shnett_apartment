<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
	<style>
		.b{ font-weight:bold; text-align:center; } 
		.b_left{ font-weight:bold; text-align:left; } 
		.b_right{ font-weight:bold; text-align:right; } 
		.c_left{ font-weight:bold; color:red; text-align:left; } 
		.d{ font-size:10px; text-align:left;}
	</style>
	<div class="layui-card layui-form " id="reimbursement_table_div">
		<div class="layui-card-header">
			<button type='button' class='layui-btn layui-btn-primary' id='check_advance_payment_request'
			v-bind:checkOrreInput='checkOrreInput' lay-submit lay-filter='check_advance_payment_request'>
				<i class="layui-icon layui-icon-ok">
				</i>
				数据确认
			</button>
			<button type="button" class="layui-btn layui-btn-primary" id="print_reimbursement"
			v-bind:style='{ display : dispaly_show_table }' >
				<i class="layui-icon layui-icon-print">
				</i>
				打印
			</button>
		</div>
		<div class="layui-card-body">
			<div v-bind:style='{ display : dispaly_input_table }'>
				<table class="layui-table" lay-size="sm" id="input_reimbursement_table_up"
				border="1px" lay-size='sm'>
					<tbody>
						<tr>
							<td class="b">
								申请人工号
							</td>
							<td>
								<input v-model='user_id' type='text' id='user_id' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input' >
							</td>
							<td class="b">
								*申请人姓名
							</td>
							<td>
								<input v-model='user_name' type='text' id='user_name' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input' >
							</td>
							<td class="b">
								*申请人部门
							</td>
							<td>
								<input v-model='wcp_area' type='text' id='wcp_area' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input' >
							</td>
							<td class="b">
								*申请日期
							</td>
							<td colspan="2">
							 <input v-model='date_time' type="text" class="layui-input" id="date_time" placeholder="yyyy-MM-dd" required  lay-verify='required' >
							</td>
						</tr>
						<tr>
							<td class="b">
								*币种
							</td>
							<td>
								RMB
							</td>
							<td class="b">
								项目编码
							</td>
							<td>
								{{project_code}}
							</td>
							<td class="b">
								附件张数
							</td>
							<td>
							 	<input v-model='attachment_for_copies' type="text" class="layui-input" required  lay-verify='required' >
							</td>
							<td class="b">
								*申请人部门负责人
							</td>
							<td colspan="2">
								<input v-model='head_id_name' type='text' id='wcp_area' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input' >
							</td>
						</tr>
						<tr>
							<td class="b">
								*事项说明：
							</td>
							<td colspan="8">
							 <input v-model='note' type="text" class="layui-input" required  lay-verify='required' >
							</td>
						</tr>
						
					</tbody>
					</table>
						<!-- 实际报销的费用明细-->
						<table class="layui-table" lay-size="sm" id="item_table_reimbursement_input"
				border="1px" lay-size='sm'>
				
					<tbody>
						<tr>
							<td class="b_left" colspan="9">
								一、费用明细区
							</td>
						</tr>
				<tr>
							<td class='b'>
								序号
							</td>
							<td class='b'>
								*费用所属部门
							</td>
							<td class='b'>
								*项目分类
							</td>
							<td class='b'>
								*成本事项
							</td>
							<td class='b'>
								*本币金额
							</td>
							<td class='b'>
								原币金额
							</td>
							<td class='b'>
								*票据类型
							</td>
							<td class='b'>
								发票号码
							</td>
							<td class='b'>
								*实际发生日期/用途
							</td>
						</tr>
						
						</tbody>
					</table>
						<table class="layui-table" lay-size="sm" id="input_reimbursement_table_down"
				border="1px" lay-size='sm'>
				
						<tbody>
						<tr>
							<td class='b_right' colspan="4">
								*合计金额小写：
							</td>
							<!-- 合计金额小写-->
							<td class='b_left' id="item_sum_number"  colspan="5">
								{{item_sum_number}}
							</td>
						</tr>
						<tr>
							<td class='b_left' colspan="2">
								*合计金额大写：
							</td>
							<!-- 合计金额大写-->
							<td class='b_left' colspan="7" id="item_sum_capital">
								{{item_sum_capital}}
							</td>
						</tr>
						<tr>
							<td class="c_left" colspan="9">
								二、冲销明细区
							</td>
						</tr>
						<tr>
							<td class='b'>
								序号
							</td>
							<td class='b' colspan="2">
								前期借款成本事项
							</td>
							<td class='b'>
								借款人/公司名称
							</td>
							<td class='b'>
								前期借款未冲销金额
							</td>
							<td class='b' colspan="2">
								本次冲销金额
							</td>
							<td class='b'>
								剩余未冲销金额
							</td>
							<td class='b'>
								未冲销金额还款方式
							</td>
						</tr>
						<!-- 冲销明细-->
						<tr id="item_table_write_offs">
						</tr>
						<tr>
							<td class="b_left" colspan="9">
								三、付款明细区
							</td>
						</tr>
						<tr>
							<td class='b'>
								序号
							</td>
							<td class='b'>
								收款人工号
							</td>
							<td class='b'>
								*收款人姓名
							</td>
							<td class='b'>
								*收款人部门
							</td>
							<td class='b'>
								*银行卡类型
							</td>
							<td class='b'>
								*开户银行
							</td>
							<td class='b'>
								*开户地
							</td>
							<td class='b'>
								*账号
							</td>
							<td class='b'>
								*金额
							</td>
						</tr>
						<!-- 付款明细-->
						<tr id="item_table_payment">
							<td>
								1
							</td>
							<td>
								{{user_id}}
							</td>
							<td>
								{{user_name}}
							</td>
							<td>
								{{wcp_area}}
							</td>
							<td>
								{{bank_card_type}}
							</td>
							<td>
								<input v-model='bank_card_place' type='text' id='bank_card_place' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input' >
							</td>
							<td>
								<input v-model='bank' type='text' id='bank' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input' >
							</td>
							<td>
								<input v-model='bank_card_account' type='text' id='bank_card_account' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input' >
							</td>
							<td>
								{{item_sum_number}}
							</td>
						</tr>
						<tr>
							<td class="b_left" colspan="9">
								四、审批记录区
							</td>
						</tr>
						<tr>
							<td class="b_left" colspan="2">
								审核/审批人
							</td>
							<td class="b_left" colspan="3">
								*审核/审批人意见签字/日期
							</td>
							<td class="b_left" colspan="2">
								审核/审批人
							</td>
							<td class="b_left" colspan="2">
								*审核/审批人意见签字/日期
							</td>
						</tr>
						<tr>
							<td class="b_left" colspan="2">
								费用所属部门负责人
							</td>
							<td class="b_left" colspan="3" id="dString">
							{{dString}}
							</td>
							<td class="b_left" colspan="2">
								财务负责人
							</td>
							<td class="b_left" colspan="2" id="hString">
							{{hString}}
							</td>
						</tr>
						<tr>
							<td class="b_left" colspan="2">
								系统管理员
							</td>
							<td class="b_left" colspan="3" id="aString">
							{{aString}}
							</td>
							<td class="b_left" colspan="2">
								盛海负责人
							</td>
							<td class="b_left" colspan="2" id="bString">
							{{bString}}
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div v-bind:style='{ display : dispaly_show_table }' id="print_reimbursement_table">
				<table class="layui-table" lay-size="sm" id="print_reimbursement_table_up"
				border="1px" lay-size='sm'>
					<p style="text-align:left">
						<img src="assets/images/shnett.logo.png" style="width:10%;" />
					</p>
					<p style="text-align:center">
						深圳市盛海信息服务有限公司日常经费（含办公费用、行政、差旅支出）报销单（除物业外）
					</p>
					<tbody>
						<tr>
							<td class="b">
								申请人工号
							</td>
							<td>
								{{ user_id }}
							</td>
							<td class="b">
								*申请人姓名
							</td>
							<td>
								{{ user_name }}
							</td>
							<td class="b">
								*申请人部门
							</td>
							<td>
								{{wcp_area}}
							</td>
							<td class="b">
								*申请日期
							</td>
							<td colspan="2">
								{{date_time}}
							</td>
						</tr>
						<tr>
							<td class="b">
								*币种
							</td>
							<td>
								RMB
							</td>
							<td class="b">
								项目编码：
							</td>
							<td>
								{{project_code}}
							</td>
							<td class="b">
								附件张数
							</td>
							<td>
      							{{attachment_for_copies}}
							</td>
							<td class="b"> 
								*申请人部门负责人 
							</td>
							<td  colspan="2">
								{{head_id_name}}
							</td>
						</tr>
						<tr>
							<td class="b">
								*事项说明：
							</td>
							<td colspan="8">
							{{note}}
							</td>
						</tr>
						
						
						</tbody>
					</table>
					
						<!-- 实际报销的费用明细-->
					<table class="layui-table" lay-size="sm" id="item_table_reimbursement_show"
				border="1px" lay-size='sm'>
						<tbody>
						<tr>
							<td class="b_left" colspan="9">
								一、费用明细区
							</td>
						</tr>
				<tr>
							<td class='b'>
								序号
							</td>
							<td class='b'>
								*费用所属部门
							</td>
							<td class='b'>
								*项目分类
							</td>
							<td class='b'>
								*成本事项
							</td>
							<td class='b'>
								*本币金额
							</td>
							<td class='b'>
								原币金额
							</td>
							<td class='b'>
								*票据类型
							</td>
							<td class='b'>
								发票号码
							</td>
							<td class='b'>
								*实际发生日期/用途
							</td>
						</tr>
						</tbody>
				</table>
					<table class="layui-table" lay-size="sm" id="print_reimbursement_table_down"
				border="1px" lay-size='sm'>
				
					<tbody>
						<tr>
							<td class='b_right' colspan="4">
								*合计金额小写：
							</td>
							<!-- 合计金额小写-->
							<td class='b_left' id="item_sum_number"  colspan="5">
							{{item_sum_number}}
							</td>
						</tr>
						<tr>
							<td class='b_left' colspan="2">
								*合计金额大写：
							</td>
							<!-- 合计金额大写-->
							<td class='b_left' colspan="7" id="item_sum_capital">
							{{item_sum_capital}}
							</td>
						</tr>
						<tr>
							<td class="c_left" colspan="9">
								二、冲销明细区
							</td>
						</tr>
						<tr>
							<td class='b'>
								序号
							</td>
							<td class='b' colspan="2">
								前期借款成本事项
							</td>
							<td class='b'>
								借款人/公司名称
							</td>
							<td class='b'>
								前期借款未冲销金额
							</td>
							<td class='b' colspan="2">
								本次冲销金额
							</td>
							<td class='b'>
								剩余未冲销金额
							</td>
							<td class='b'>
								未冲销金额还款方式
							</td>
						</tr>
						<!-- 冲销明细-->
						<tr id="item_table_write_offs">
						</tr>
						<tr>
							<td class="b_left" colspan="9">
								三、付款明细区
							</td>
						</tr>
						<tr>
							<td class='b'>
								序号
							</td>
							<td class='b'>
								收款人工号
							</td>
							<td class='b'>
								*收款人姓名
							</td>
							<td class='b'>
								*收款人部门
							</td>
							<td class='b'>
								*银行卡类型
							</td>
							<td class='b'>
								*开户银行
							</td>
							<td class='b'>
								*开户地
							</td>
							<td class='b'>
								*账号
							</td>
							<td class='b'>
								*金额
							</td>
						</tr>
						<!-- 付款明细-->
						<tr id="item_table_payment">
							<td>
								1
							</td>
							<td>
								{{user_id}}
							</td>
							<td>
								{{user_name}}
							</td>
							<td>
								{{wcp_area}}
							</td>
							<td>
								{{bank_card_type}}
							</td>
							<td>
								{{bank_card_place}}
							</td>
							<td>
								{{bank}}
							</td>
							<td>
								{{bank_card_account}}
							</td>
							<td>
								{{item_sum_number}}
							</td>
						</tr>
						<tr>
							<td class="b_left" colspan="9">
								四、审批记录区
							</td>
						</tr>
						<tr>
							<td class="b_left" colspan="2">
								审核/审批人
							</td>
							<td class="b_left" colspan="3">
								*审核/审批人意见签字/日期
							</td>
							<td class="b_left" colspan="2">
								审核/审批人
							</td>
							<td class="b_left" colspan="2">
								*审核/审批人意见签字/日期
							</td>
						</tr>
						<tr>
							<td class="b_left" colspan="2">
								费用所属部门负责人
							</td>
							<td class="b_left" colspan="3" id="dString">
							{{dString}}
							</td>
							<td class="b_left" colspan="2">
								财务负责人
							</td>
							<td class="b_left" colspan="2" id="hString">
							{{hString}}
							</td>
						</tr>
						<tr>
							<td class="b_left" colspan="2">
								系统管理员
							</td>
							<td class="b_left" colspan="3" id="aString">
							{{aString}}
							</td>
							<td class="b_left" colspan="2">
								盛海负责人
							</td>
							<td class="b_left" colspan="2" id="bString">
							{{bString}}
							</td>
						</tr>
						<tr>
							<td class="d" colspan="9">
								温馨提示：
								<br/>
								1、适用：员工代垫日常经营管理支出（含差旅费、办公费、会务费、行政支出、招聘费、宣传费、通讯费等）费用的报销；
								<br/>
								2、费用明细区：如有多项费用，可增加行进行填写；
								<br/>
								3、付款明细区：如有多个收款人，可增加行进行填写；
								<br/>
								4、冲销明细去：如前期有借款，请填写冲销明细区相关信息；如剩余未冲销金额将于下次继续冲销，“还款方式”请选择“其他”；
								<br/>
								5、带*号的部分为必填项；
								<br/>
								6、请将报销单填写、横向打印并与发票单据及附件粘贴一起后一并提交审核/审批；
								<br/>
								7、完成审批并付款后，请将该报销单交由会计记帐并作为凭证存档。
							</td>
						</tr>
						<tr>
							<td class="d" colspan="9">
								开票信息：
								<br/>
								企业名称：深圳市盛海信息服务有限公司
								<br/>
								地址：深圳市南山区科园路18号北科大厦8011室
								<br/>
								纳税人识别号：91440300MA5DFGBH20
								<br/>
								联系电话：0755-33992226
								<br/>
								账 户 名：深圳市盛海信息服务有限公司
								<br/>
								开户银行：招商银行股份有限公司深圳软件基地支行
								<br/>
								账 号：755931029510106
								<br/>
							</td>
						</tr>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="assets/libs/jquery.printarea.js">
	</script>
	<script type="text/javascript">
		layui.use(['laydate','layer', 'table', 'admin','numinput', 'jquery','form'],
		function() {
			layer = layui.layer,
			admin = layui.admin,
			laydate = layui.laydate,
			form = layui.form,
			numinput = layui.numinput,
			$ = layui.jquery,
			table = layui.table;
			var project_code = admin.getTempData('project_code');
			var group_id = admin.getTempData('group_id');

			var vue_data = new Vue({
				el: '#reimbursement_table_div',
				data: {
					date_time: null,
					project_code: null,
					head_id_name: null,
					user_id: null,
					user_name: null,
					wcp_area: null,
					attachment_for_copies:null,
					note: null,
					bank_card_type: null,
					bank_card_place: null,
					bank: null,
					bank_card_account: null,
					//sum_money: null,
					checkOrreInput: 'check',
					//录入表格
					dispaly_input_table: 'inline',
					//打印表格
					dispaly_show_table: 'none',
					
					//item_table_reimbursement_input :'',
					item_sum_number:0,
					item_sum_capital:'零元整',
					dString: null,
					hString: null,
					aString: null,
					bString: null,
					
				}
			});

			laydate.render({
			    elem: '#date_time',
			    value:new Date()
			});
			//获取报销信息并填充
			admin.ajax_load_json({
				url: "queryWeakActualReimbursementByGroupId",
				data: {
					project_code: project_code,
					group_id: group_id
				},
				success: function(res, status, xhr) {
					if (res.code == 0) {
						if (res.info[0].code == 1) {
							layer.alert(res.info[0].msg, {
								icon: 5
							});
							return;
						}
						var userInfo = res.info[0].msg[0];
						var listInfo = res.list;
						var approval_log = res.other;
						var item_classification = res.other[0].item_classification == null ? "-": res.other[0].item_classification;
						/*拼接数据并填充*/
						//1.填充报销列表数据
						var _html = "";
						for (var a = 0; a < listInfo.length; a++) {
							vue_data.item_sum_number += listInfo[a].amount_in_original_currency!=null&&listInfo[a].amount_in_original_currency!=''?listInfo[a].amount_in_original_currency:0;
							_html += "<tr><td>" + (a + 1) + "</td>" +
							 "<td>" + listInfo[a].applicant_department + "</td>" +
							 "<td>" + item_classification + "</td>" + 
							 "<td>" + listInfo[a].cost_matters + "</td>" + 
							 "<td>" + listInfo[a].amount_in_original_currency + "</td>" + 
							 //"<td>" + listInfo[a].principal + "</td>" + 
							 "<td>0</td>" + 
							 "<td>" + listInfo[a].bill_type + "</td>" + 
							 "<td>" + listInfo[a].invoice_number + "</td>" + 
							 "<td>" + listInfo[a].date_of_occurrence + "/" + listInfo[a].purpose_of_occurrence + "</td></tr>";
						}
						$("#item_table_reimbursement_input").append(_html);
						$("#item_table_reimbursement_show").append(_html);
						
						
				    	vue_data.item_sum_capital=admin.numberToCapital(vue_data.item_sum_number);
						
						//vue_data.sum_money = 0;
						vue_data.date_time = userInfo.date_time;
						vue_data.project_code = project_code;
						//vue_data.head_id = userInfo.head_id;
						//vue_data.head_name = userInfo.head_name;
						vue_data.user_id = userInfo.user_id;
						vue_data.user_name = userInfo.user_name;
						vue_data.wcp_area = userInfo.wcp_area;
						vue_data.bank = userInfo.bank;
						vue_data.bank_card_account = userInfo.bank_card_account;
						vue_data.bank_card_place = userInfo.bank_card_place;
						vue_data.bank_card_type = userInfo.bank_card_type;
						//vue_datadispaly_print_btn = 'none'
						vue_data.dString = approval_log[0].dString;
						vue_data.bString = approval_log[0].bString;
						vue_data.aString = approval_log[0].aString;
						vue_data.hString = approval_log[0].hString;

					} else {
						layer.alert(res.info, {
							icon: 5
						});
					}
				}
			});
			//通过工号获取姓名
			$('#user_id').blur(function() {
				admin.ajax_load_json({
					url: "getUserNameAndWCPAreaByUserId",
					data: {
						user_id: $(this).val()
					},
					success: function(data) {
						console.log();
						if (data.code == 0) {
							vue_data.user_name = data.info[0].user_name;
							vue_data.wcp_area = data.info[0].wcp_area;
							vue_data.bank_card_type = data.info[0].bank_card_type;
							vue_data.bank_card_place = data.info[0].bank_card_place;
							vue_data.bank = data.info[0].bank;
							vue_data.bank_card_account = data.info[0].bank_card_account;
						} else {
							layer.alert(data.info, {
								icon: 5
							});
							vue_data.user_name = null;
							vue_data.wcp_area = null;
							vue_data.bank_card_type = null;
							vue_data.bank_card_place = null;
							vue_data.bank = null;
							vue_data.bank_card_account = null;
						}
					}
				});
			});
			//确认数据按钮
			form.on('submit(check_advance_payment_request)',
			function(data) {
				if (vue_data.checkOrreInput == 'check') { //确认数据按钮
					$('#check_advance_payment_request').html('<i class="layui-icon layui-icon-edit"></i>重新录入');
					vue_data.checkOrreInput = 'reInput';
					vue_data.dispaly_input_table = 'none';
					vue_data.dispaly_show_table = 'inline';
					vue_data.dispaly_upload_btn = 'inline';

					vue_data.amountPaid = data.field.amountPaid; //已付款金额(不含本次)	
					vue_data.totalAmountPayable = data.field.totalAmountPayable; //合同或应付款总额
					vue_data.writeOffTheAdvancePayment = data.field.writeOffTheAdvancePayment; //冲销前期预付款金额
					vue_data.amountOfThisPayment = data.field.amountOfThisPayment; //小写
					vue_data.numberOfDocumentsAndAttachments = data.field.numberOfDocumentsAndAttachments; //单据及附件张数
					vue_data.typeOfReceivingUnit = layui.formSelects.value('typeOfReceivingUnit', 'valStr'); //监听收款单位类别
				} else if (vue_data.checkOrreInput == 'reInput') { //重新录入按钮
					$('#check_advance_payment_request').html('<i class="layui-icon layui-icon-ok"></i>数据确认');
					vue_data.checkOrreInput = 'check';
					vue_data.dispaly_input_table = 'inline';
					vue_data.dispaly_show_table = 'none';
					vue_data.dispaly_upload_btn = 'none';
				}
				return false;
			});
			$("#print_reimbursement").click(function() {
				$("#print_reimbursement_table").printArea();
			});
		});
	</script>