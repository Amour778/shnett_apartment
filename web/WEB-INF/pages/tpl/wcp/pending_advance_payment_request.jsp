<%@ page language='java' import='java.util.*' pageEncoding='UTF-8' %>

<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
	<div class='layui-card layui-form' id='advance_payment_request_vue_div'>
		<div class='layui-card-header'>
			<button class="layui-btn layui-btn-radius" id="pending_agree">
				<i class="layui-icon layui-icon-ok">
				</i>
				同意
			</button>
			<button class="layui-btn layui-btn-radius layui-btn-danger" id="pending_reject">
				<i class="layui-icon layui-icon-close">
				</i>
				驳回
			</button>
			<button type='button' class='layui-btn layui-btn-primary' id='print_pending_advance_payment_requestent_btn'>
				<i class='layui-icon layui-icon-print'>
				</i>
				打印
			</button>
		</div>
		<div class='layui-card-body' id='print_pending_advance_payment_request_div'>
			<table style='font-weight:bold;text-align:center;' lay-size='sm' class='layui-table' id='advance_payment_request_show_table'>
				<tr>
					<td colspan='2' style='text-align:center;border:0px;'>
						<img src='assets/images/shnett.logo.png'/>
					</td>
					<td colspan='8' style='font-size:30px;text-align:left;border:0px;' >
						付款申请单
					</td>
				</tr>
				<tr>
					<td colspan='6' style='text-align:cenert;border:0px;'>
						{{inputDate}}
					</td>
					<td style='border:0px'>
						公司代码
					</td>
					<td colspan='3' style='border:0px;'>
						{{supplierOrCompanyNumber}}
					</td>
				</tr>
				<tr>
					<td>
						申请部门
					</td>
					<td>
						{{project_area_department}}
					</td>
					<td>
						供应商或公司
					</td>
					<td colspan='3'>
						{{supplierOrCompanyName}}
					</td>
					<td>
						供应商或公司代码
					</td>
					<td colspan='3'>
						{{supplierOrCompanyNumber}}
					</td>
				</tr>
				<tr>
					<td>
						经办人
					</td>
					<td>
						{{agent}}
					</td>
					<td>
						开户银行
					</td>
					<td colspan='3'>
						{{bank}}
					</td>
					<td>
						银行账号
					</td>
					<td colspan='3'>
						{{theBankAccount}}
					</td>
				</tr>
				<tr>
					<td>
						网络代码
					</td>
					<td>
						项目代码
					</td>
					<td>
						费用所属部门
					</td>
					<td>
						收款单位类别
					</td>
					<td colspan='6'>
						{{typeOfReceivingUnit}}
					</td>
				</tr>
				<tr>
					<td>
						{{theNetworkCode}}
					</td>
					<td>
						{{project_code}}
					</td>
					<td>
						{{project_area_department}}
					</td>
					<td>
						付款性质
					</td>
					<td colspan='6'>
						{{natureOfPayment}}
					</td>
				</tr>
				<tr>
					<td rowspan='3'>
						付款原因
					</td>
					<td rowspan='3' colspan='3'>
						{{becauseOfPayment}}
					</td>
					<td>
						合同号码
					</td>
					<td colspan='2'>
						{{theContractNumber}}
					</td>
					<td>
						批次
					</td>
					<td colspan='2'>
						{{batch}}
					</td>
				</tr>
				<tr>
					<td colspan='3'>
						已付款金额(不含本次)
					</td>
					<td colspan='3'>
						合同或应付款总额
					</td>
				</tr>
				<tr>
					<td rowspan='2' colspan='3'>
						{{amountPaid}}
					</td>
					<td rowspan='2' colspan='3'>
						{{totalAmountPayable}}
					</td>
				</tr>
				<tr>
					<td>
						冲销前期预付款金额
					</td>
					<td colspan='3'>
						{{writeOffTheAdvancePayment}}
					</td>
				</tr>
				<tr>
					<td rowspan='2'>
						本次付款金额
					</td>
					<td>
						小写
					</td>
					<td colspan='2'>
						{{amountOfThisPayment}}
					</td>
					<td rowspan='2' colspan='3'>
						单据及附件张数
					</td>
					<td rowspan='2' colspan='3'>
						{{numberOfDocumentsAndAttachments}}
					</td>
				</tr>
				<tr>
					<td>
						大写
					</td>
					<td colspan='2'>
						零元整
					</td>
				</tr>
				<tr>
					<td>
						付款要求
					</td>
					<td colspan='3'>
						{{paymentRequest}}
					</td>
					<td>
						FA录入
					</td>
					<td colspan='2'>
						{{FA_Entry}}
					</td>
					<td>
						FA审核
					</td>
					<td colspan='2'>
						{{FA_Audit}}
					</td>
				</tr>
				<tr>
					<td>
						付款方式
					</td>
					<td colspan='3'>
						{{termsOfPayment}}
					</td>
					<td>
						GLAP录入
					</td>
					<td colspan='2'>
						{{GL_AP_Entry}}
					</td>
					<td>
						GLAP审核
					</td>
					<td colspan='2'>
						{{GL_AP_Audit}}
					</td>
				</tr>
				<tr>
					<td rowspan='5'>
						审批流程
					</td>
					<td colspan='2'>
						相关部门审批
					</td>
					<td colspan='2'>
						财务部门审批
					</td>
					<td colspan='2'>
						负责人审批
					</td>
					<td colspan='3'>
						收款人签名
					</td>
				</tr>
				<tr>
					<td rowspan='4' colspan='2'>
						{{approvalOfRelevantDepartments}}
					</td>
					<td rowspan='4' colspan='2'>
						{{financeDepartmentApproval}}
					</td>
					<td rowspan='4' colspan='2'>
						{{responsiblePersonApproval}}
					</td>
					<td colspan='3'>
						{{signatureOfPayee}}
					</td>
				</tr>
				<tr>
					<td colspan='3'>
						出纳员签名
					</td>
				</tr>
				<tr>
					<td colspan='3'>
						{{cashiersSignature}}
					</td>
				</tr>
				<tr>
					<td colspan='3'>
						{{inputDate}}
					</td>
				</tr>
			</table>
		</div>
	</div>
	<script type='text/javascript' src='assets/libs/jquery.printarea.js'>
	</script>
	<script type='text/javascript'>
		layui.use(['jquery', 'layer', 'form', 'admin'],
		function() {
			var $ = layui.jquery,
			layer = layui.layer,
			form = layui.form,
			admin = layui.admin;
			var pending_advance_payment_request_index = admin.getTempData('pending_advance_payment_request_index');
			var rid = admin.getTempData('rid');
			var audit_sta = admin.getTempData('audit_sta');
			var project_code= admin.getTempData('project_code');
			var amountOfThisPayment= admin.getTempData('amountOfThisPayment');
			var agree_value = null;
			var reject_value = null;
			if (audit_sta == '2110') {
				agree_value = 2120;
				reject_value = 2112;
			} else if (audit_sta == '2120') {
				agree_value = 2130;
				reject_value = 2122;
			} else if (audit_sta == '2130') {
				agree_value = 2140;
				reject_value = 2132;
			} else if (audit_sta == '2140') {
				agree_value = 2141;
				reject_value = 2142;
			}

			var vue_data = new Vue({
				el: '#advance_payment_request_vue_div',
				data: { //申请部门
					project_area_department: '',
					//供应商或公司
					supplierOrCompanyName: '',
					//供应商或公司代码
					supplierOrCompanyNumber: '',
					//经办人
					agent: '',
					//开户银行
					bank: '',
					//银行账号
					theBankAccount: '',
					//网络代码
					theNetworkCode: '',
					//项目代码
					project_code: '',
					//费用所属部门
					project_area_department: '',
					//收款单位类别
					typeOfReceivingUnit: '',
					//付款性质
					natureOfPayment: '',
					//付款原因
					becauseOfPayment: '',
					//合同号码
					theContractNumber: '',
					//批次
					batch: '',
					//已付款金额(不含本次)
					amountPaid: '',
					//合同或应付款总额	
					totalAmountPayable: '',
					//冲销前期预付款金额
					writeOffTheAdvancePayment: '',
					//小写
					amountOfThisPayment: '',
					//大写
					capital: '',
					//单据及附件张数	
					numberOfDocumentsAndAttachments: '',
					//付款要求
					paymentRequest: '',
					//FA录入
					FA_Entry: '',
					//FA审核
					FA_Audit: '',
					//付款方式
					termsOfPayment: '',
					//GL/AP录入
					GL_AP_Entry: '',
					//GL/AP审核
					GL_AP_Audit: '',
					//相关部门审批	
					approvalOfRelevantDepartments: '',
					//财务部门审批	
					financeDepartmentApproval: '',
					//负责人审批	
					responsiblePersonApproval: '',
					//收款人签名		
					signatureOfPayee: '',
					//出纳员签名
					cashiersSignature: '',
					//年月日
					inputDate: '',
				}
			});
			admin.ajax_load_json({
				url: 'queryOneWCP_RFP_ByRid',
				data: {
					rid: rid
				},
				success: function(data) {
					if (data.code == 0) {
						vue_data.project_area_department = data.info.project_area_department; //申请部门
						vue_data.supplierOrCompanyName = data.info.supplierOrCompanyName; //供应商或公司
						vue_data.supplierOrCompanyNumber = data.info.supplierOrCompanyNumber; //供应商或公司代码
						vue_data.agent = data.info.agent; //经办人
						vue_data.bank = data.info.bank; //开户银行
						vue_data.theBankAccount = data.info.theBankAccount; //银行账号
						vue_data.theNetworkCode = data.info.theNetworkCode; //网络代码
						vue_data.project_code = data.info.project_code; //项目代码
						vue_data.project_area_department = data.info.project_area_department; //费用所属部门
						vue_data.typeOfReceivingUnit = data.info.typeOfReceivingUnit; //收款单位类别
						vue_data.natureOfPayment = data.info.natureOfPayment; //付款性质
						vue_data.becauseOfPayment = data.info.becauseOfPayment; //付款原因
						vue_data.theContractNumber = data.info.theContractNumber; //合同号码
						vue_data.batch = data.info.batch; //批次
						vue_data.amountPaid = data.info.amountPaid; //已付款金额(不含本次)
						vue_data.totalAmountPayable = data.info.totalAmountPayable; //合同或应付款总额
						vue_data.writeOffTheAdvancePayment = data.info.writeOffTheAdvancePayment; //冲销前期预付款金额
						vue_data.amountOfThisPayment = data.info.amountOfThisPayment; //小写
						vue_data.capital = data.info.capital; //大写
						vue_data.numberOfDocumentsAndAttachments = data.info.numberOfDocumentsAndAttachments; //单据及附件张数
						vue_data.paymentRequest = data.info.paymentRequest; //付款要求
						vue_data.FA_Entry = data.info.FA_Entry; //FA录入
						vue_data.FA_Audit = data.info.FA_Audit; //FA审核
						vue_data.termsOfPayment = data.info.termsOfPayment; //付款方式
						vue_data.GL_AP_Entry = data.info.GL_AP_Entry; //GL/AP录入
						vue_data.GL_AP_Audit = data.info.GL_AP_Audit; //GL/AP审核
						vue_data.approvalOfRelevantDepartments = data.info.approvalOfRelevantDepartments; //相关部门审批
						vue_data.financeDepartmentApproval = data.info.financeDepartmentApproval; //财务部门审批
						vue_data.responsiblePersonApproval = data.info.responsiblePersonApproval; //负责人审批
						vue_data.signatureOfPayee = data.info.signatureOfPayee; //收款人签名
						vue_data.cashiersSignature = data.info.cashiersSignature; //出纳员签名
						vue_data.inputDate = data.info.inputDate; //年月日
					} else {
						layer.alert(data.info, {
							icon: 5
						});
					}
				}
			});

			//同意
			$('#pending_agree').click(function() {
				admin.ajax_load_json({
					url: 'updateWCP_RFP_AuditStaAndAuditInfoByRid',
					data: {
						rid: rid,
						audit_sta: agree_value,
						audit_info: 'N',
						project_code: project_code,
						amountOfThisPayment: amountOfThisPayment
					},
					success: function(data) {
						if (data.code == 0) {
							layer.msg(data.info, {
								icon: 1
							});
						} else {
							layer.alert(data.info, {
								icon: 5
							});
						}
					}
				});
			});

			//驳回
			$('#pending_reject').click(function() {
				layer.prompt({
					formType: 0,
					title: '请输入驳回理由',
				},
				function(value, index, elem) {
					admin.ajax_load_json({
						url: 'updateWCP_RFP_AuditStaAndAuditInfoByRid',
						data: {
							rid: rid,
							audit_sta: reject_value,
							audit_info: value,
							project_code: project_code,
							amountOfThisPayment: amountOfThisPayment
						},
						success: function(data) {
							if (data.code == 0) {
								layer.msg(data.info, {
									icon: 1
								});
							} else {
								layer.alert(data.info, {
									icon: 5
								});
							}
						}
					});
				});
			});

			//打印数据按钮
			$('#print_pending_advance_payment_requestent_btn').click(function() {
				$('#print_pending_advance_payment_request_div').printArea();
			});
		});
	</script>