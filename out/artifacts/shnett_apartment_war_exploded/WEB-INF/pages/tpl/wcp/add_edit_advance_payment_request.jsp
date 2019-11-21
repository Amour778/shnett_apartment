<%@ page language='java' import='java.util.*' pageEncoding='UTF-8' %>

<div class='layui-card layui-form' id='advance_payment_request_vue_div'>
  <div class='layui-card-header'>
  	<button type='button' class='layui-btn layui-btn-primary' id='check_advance_payment_request' v-bind:checkOrreInput='checkOrreInput'  lay-submit lay-filter='check_advance_payment_request'><i class="layui-icon layui-icon-ok"></i>数据确认</button>
  	<button type='button' class='layui-btn layui-btn-primary' id='print_advance_payment_request' v-bind:style='{ display : dispaly_upload_btn }'><i class='layui-icon layui-icon-print'></i>打印</button>
  	<button type='button' class='layui-btn' id='upload_advance_payment_request' v-bind:style='{ display : dispaly_upload_btn }'><i class='layui-icon layui-icon-release'></i>提交申请</button>
  </div>
  <div class='layui-card-body' id='print_advance_payment_request_div'>
<table style='font-weight:bold;text-align:center;' class='layui-table' lay-size='sm' v-bind:style='{ display : dispaly_input_table }' id='advance_payment_request_input_table'>
			<tr>
				<td>
					申请部门
				</td>
				<td>
				
				 	<input v-model='project_area_department' type='text' id='project_area_department' required readOnly='readOnly' lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
				</td>
				<td>
					供应商或公司
				</td>
				<td colspan='3'>
					<select name='supplierOrCompanyName' xm-select='supplierOrCompanyName' xm-select-radio='' xm-select-search=''  lay-verify='required' lay-verType='tips' class='advance_payment_request_input' ></select>
					<!--<div style='width:300px'>
						<select name='supplierOrCompanyName' xm-select='supplierOrCompanyName' xm-select-radio='' xm-select-search=''  lay-verify='required' lay-verType='tips' class='advance_payment_request_input' ></select>
					</div>-->
					<!--<input type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >-->
				</td>
				<td>
					供应商或公司代码
				</td>
				<td colspan='3'>
					 <input v-model='supplierOrCompanyNumber' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
				</td>
			</tr>
			<tr>
				<td>
					经办人
				</td>
				<td>
					 <input v-model='agent' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
				</td>
				<td>
					开户银行
				</td>
				<td colspan='3'>
					 <input v-model='bank' type='text' id='bank' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input'  lay-tips='开户银行可根据银行账号自动获取，结果仅供参考'>
				</td>
				<td>
					银行账号
				</td>
				<td colspan='3'>
					 <input v-model='theBankAccount'  type='text' id='theBankAccount' required   lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
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
					<select name='typeOfReceivingUnit' xm-select='typeOfReceivingUnit'  xm-select-radio='' class='advance_payment_request_input'  lay-verify='required' >
					    <option value='外部供应商'>外部供应商</option>
					    <option value='统购'>统购</option>
					    <option value='非统购'>非统购</option>
					    <option value='一次性'>一次性</option>
					    <option value='内部公司'>内部公司</option>
					</select>
					 <!-- <input v-model='typeOfReceivingUnit' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' > -->
				</td>
			</tr>
			<tr>
				<td>
					 <input v-model='theNetworkCode' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
				</td>
				<td>
					 <input v-model='project_code' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
				</td>
				<td>
					 <input v-model='project_area_department' type='text' id='title' required  lay-verify='required'  readOnly='readOnly' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
				</td>
				<td>
					付款性质
				</td>
				<td colspan='6'>
					<select name='natureOfPayment' xm-select='natureOfPayment'  xm-select-radio=''  class='advance_payment_request_input'  lay-verify='required'>
					    <option value='预付款'>预付款</option>
					    <option value='项目进度款'>项目进度款</option>
					    <option value='结算款'>结算款</option>
					    <option value='代付款'>代付款</option>
					    <option value='公司间往来'>公司间往来</option>
					</select>
					<input v-model='natureOfPayment' v-bind:style='{ display : dispaly_natureOfPayment }' type='text' id='title' v-bind:lay-verify='required_natureOfPayment' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
					 <!--  <input v-model='natureOfPayment' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' > -->
				</td>
			</tr>
			<tr>
				<td rowspan='3'>
					付款原因
				</td>
				<td rowspan='3' colspan='3'>
					 <textarea  v-model='becauseOfPayment' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></textarea>
				</td>
				<td>
					合同号码
				</td>
				<td colspan='2'>
					 <input v-model='theContractNumber' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
				</td>
				<td>
					批次
				</td>
				<td colspan='2'>
					 <input v-model='batch' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
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
			 		<input  name='amountPaid' id="amountPaid" class='layui-input layui-input-number advance_payment_request_input' disabled min='0' step='1' data-prec='2' lay-verify='required'  readOnly='readOnly' lay-verType='tips'>
					<!-- <input v-model='amountPaid' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' > --> 
				</td>
				<td rowspan='2' colspan='3'>
				<input  name='totalAmountPayable' id="totalAmountPayable" class='layui-input layui-input-number advance_payment_request_input' disabled min='0' step='1' data-prec='2' lay-verify='required' readOnly='readOnly'  lay-verType='tips'>
					 <!--<input v-model='totalAmountPayable' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >--> 
				</td>
			</tr>
			<tr>
				<td>
					冲销前期预付款金额
				</td>
				<td colspan='3'>
					 <input  name='writeOffTheAdvancePayment' id="writeOffTheAdvancePayment" class='layui-input layui-input-number advance_payment_request_input' min='0' step='1' data-prec='2' lay-verify='required' lay-verType='tips'>
					 <!--<input v-model='writeOffTheAdvancePayment' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >--> 
				</td>
			</tr>
			<tr>
				<td rowspan='2'>本次付款金额</td>
				<td>小写</td>
				<td colspan='2'>
				<input  name='amountOfThisPayment' id="amountOfThisPayment" class='layui-input layui-input-number advance_payment_request_input' min='0' step='1' data-prec='2' lay-verify='required' lay-verType='tips'>
					 <!--<input v-model='amountOfThisPayment' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >--> 
				</td>
				<td rowspan='2' colspan='3'>单据及附件张数</td>
				<td rowspan='2' colspan='3'>
					<input  name='numberOfDocumentsAndAttachments' id="numberOfDocumentsAndAttachments" class='layui-input layui-input-number advance_payment_request_input' min='0' step='1' data-prec='0' lay-verify='required' lay-verType='tips'>
					 <!-- <input v-model='numberOfDocumentsAndAttachments' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >--> 
				</td>
			</tr>
			<tr>
				<td>大写</td>
				<td colspan='2'><input v-model='capital' type='text' id='title' readOnly='readOnly' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
			</tr>
			<tr>
				<td>付款要求</td>
				<td colspan='3'> <input v-model='paymentRequest' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
				<td>FA录入</td>
				<td colspan='2'> <input v-model='FA_Entry' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
				<td>FA审核</td>
				<td colspan='2'> <input v-model='FA_Audit' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
			</tr>
			<tr>
				<td>付款方式</td>
				<td colspan='3'>
					<select name='termsOfPayment' xm-select='termsOfPayment'  xm-select-radio='' class='advance_payment_request_input'  lay-verify='required' >
					    <option value='支票'>支票</option>
					    <option value='电子付款'>电子付款</option>
					    <option value='现金'>现金</option>
					    <option value='其他'>其他</option>
					</select>
					<input v-model='termsOfPayment' v-bind:style='{ display : dispaly_termsOfPayment }' type='text' id='title' v-bind:lay-verify='required_termsOfPayment' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' >
				</td>
				<td>GLAP录入</td>
				<td colspan='2'> <input v-model='GL_AP_Entry' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
				<td>GLAP审核</td>
				<td colspan='2'> <input v-model='GL_AP_Audit' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
			</tr>
			 <tr>
				<td rowspan='5'>审批流程</td>
				<td colspan='2'>相关部门审批</td>
				<td colspan='2'>财务部门审批</td>
				<td colspan='2'>负责人审批</td>
				<td colspan='3'>收款人签名</td>
			</tr>
			 <tr>
				<td rowspan='4' colspan='2'> <input v-model='approvalOfRelevantDepartments' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
				<td rowspan='4' colspan='2'> <input v-model='financeDepartmentApproval' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
				<td rowspan='4' colspan='2'> <input v-model='responsiblePersonApproval' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
				<td colspan='3'> <input v-model='signatureOfPayee' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
			</tr>
			 <tr>
				<td colspan='3'>出纳员签名</td>
			</tr>
			 <tr>
				<td colspan='3'> <input v-model='cashiersSignature' type='text' id='title' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' ></td>
			</tr>
			 <tr>
				<td colspan='3'> <input type='text' id='advance_payment_request_date' required  lay-verify='required' lay-verType='tips' autocomplete='off' class='layui-input advance_payment_request_input' placeholder='年/月/日'></td>
			</tr>
	</table>
	<table style='font-weight:bold;text-align:center;' v-bind:style='{ display : dispaly_show_table }'  lay-size='sm' class='layui-table' id='advance_payment_request_show_table'>
			<tr>
				<td colspan='2' style='border:0px;'>
					<img src='assets/images/shnett.logo.png' style='width:70%;' />
				</td>
				<td colspan='8' style='font-size:30px;text-align:left;border:0px;'>
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
				<td  colspan='3' style='border:0px;'>
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
				<td rowspan='2'>本次付款金额</td>
				<td>小写</td>
				<td colspan='2'>
					{{amountOfThisPayment}}
					</td>
				<td rowspan='2' colspan='3'>单据及附件张数</td>
				<td rowspan='2' colspan='3'>
					{{numberOfDocumentsAndAttachments}}
					</td>
			</tr>
			<tr>
				<td>大写</td>
				<td colspan='2'>零元整</td>
			</tr>
			<tr>
				<td>付款要求</td>
				<td colspan='3'> {{paymentRequest}}</td>
				<td>FA录入</td>
				<td colspan='2'> {{FA_Entry}}</td>
				<td>FA审核</td>
				<td colspan='2'> {{FA_Audit}}</td>
			</tr>
			<tr>
				<td>付款方式</td>
				<td colspan='3'> {{termsOfPayment}}</td>
				<td>GLAP录入</td>
				<td colspan='2'> {{GL_AP_Entry}}</td>
				<td>GLAP审核</td>
				<td colspan='2'> {{GL_AP_Audit}}</td>
			</tr>
			 <tr>
				<td rowspan='5'>审批流程</td>
				<td colspan='2'>相关部门审批</td>
				<td colspan='2'>财务部门审批</td>
				<td colspan='2'>负责人审批</td>
				<td colspan='3'>收款人签名</td>
			</tr>
			 <tr>
				<td rowspan='4' colspan='2'> {{approvalOfRelevantDepartments}}</td>
				<td rowspan='4' colspan='2'> {{financeDepartmentApproval}}</td>
				<td rowspan='4' colspan='2'> {{responsiblePersonApproval}}</td>
				<td colspan='3'> {{signatureOfPayee}}</td>
			</tr>
			 <tr>
				<td colspan='3'>出纳员签名</td>
			</tr>
			 <tr>
				<td colspan='3'> {{cashiersSignature}}</td>
			</tr>
			 <tr>
				<td colspan='3'> {{inputDate}}</td>
			</tr>
	</table>
	</div>
  </div>
<script type='text/javascript' src='assets/libs/jquery.printarea.js'></script>
	<script type='text/javascript'>
		layui.use(['jquery', 'layer', 'form', 'admin', 'laydate','formSelects', 'numinput'],
		function() {
			var $ = layui.jquery,
			layer = layui.layer,
			form = layui.form,
			admin = layui.admin,
			numinp = layui.numinput,
			formSelects = layui.formSelects,
			laydate = layui.laydate;
			var project_code = admin.getTempData('project_code');
			var rid = typeof(admin.getTempData('rid'))=="undefined"?null:admin.getTempData('rid');
			//console.log('project_code',project_code);
			//console.log('rid',rid);
			var vue_data = new Vue({
				el: '#advance_payment_request_vue_div',
				data: {
					checkOrreInput : 'check',//按钮的显示内容
					dispaly_input_table : 'inline',//录入表格
					dispaly_show_table : 'none',//打印表格
					dispaly_upload_btn : 'none',//提交数据
					dispaly_natureOfPayment : 'none',//付款性质
					required_natureOfPayment : 'N',//付款性质
					dispaly_termsOfPayment : 'none',//付款方式
					required_termsOfPayment : 'N',//付款方式 
					project_area_department : '',//申请部门
					supplierOrCompanyName : '',//供应商或公司
					supplierOrCompanyNumber : '',//供应商或公司代码
					agent : '',//经办人
					bank : '',//开户银行
					theBankAccount : '',//银行账号
					theNetworkCode : '',//网络代码
					project_code : '',//项目代码
					project_area_department : '',//费用所属部门
					typeOfReceivingUnit : '',//收款单位类别
					natureOfPayment : '',//付款性质
					becauseOfPayment : '',//付款原因
					theContractNumber : '',//合同号码
					batch : '',//批次
					amountPaid : '',//已付款金额(不含本次)		
					totalAmountPayable : '',//合同或应付款总额		
					writeOffTheAdvancePayment : '',//冲销前期预付款金额
					amountOfThisPayment : '',//小写
					capital : '',//大写
					numberOfDocumentsAndAttachments : '',//单据及附件张数		
					paymentRequest : '',//付款要求
					FA_Entry : '',//FA录入
					FA_Audit : '',//FA审核
					termsOfPayment : '',//付款方式
					GL_AP_Entry : '',//GL/AP录入
					GL_AP_Audit : '',//GL/AP审核
					approvalOfRelevantDepartments : '',//相关部门审批	
					financeDepartmentApproval : '',//财务部门审批	
					responsiblePersonApproval : '',//负责人审批	
					signatureOfPayee : '',//收款人签名		
					cashiersSignature : '',//出纳员签名
					inputDate : '',//年月日
				}
			})
			
			numinp.init({
			    topBtns: 789, // 123：123键置顶, 789：789键置顶
			    rightBtns: true,// 右侧功能按钮
			    listening: true,// 监听键盘事件
			    defaultPrec: '2',// 批量配置默认小数精确度
			    hideEnd:function(){
			    	vue_data.amountPaid = $("#amountPaid").val();
			    	vue_data.totalAmountPayable = $("#totalAmountPayable").val();
			    	vue_data.writeOffTheAdvancePayment = $("#writeOffTheAdvancePayment").val();
			    	vue_data.amountOfThisPayment = $("#amountOfThisPayment").val();
			    	vue_data.numberOfDocumentsAndAttachments = $("numberOfDocumentsAndAttachments").val();
			    	//console.log(vue_data.amountOfThisPayment);
			    	//数字转中文大写
				   vue_data.capital = admin.numberToCapital(vue_data.amountOfThisPayment==''||vue_data.amountOfThisPayment==null?0:vue_data.amountOfThisPayment);

			    }
			});
			//供应商或公司的下拉选项数据
			  formSelects.data('supplierOrCompanyName', 'server', {
		           url: 'querySupplierInfoToFormSelects',
		            success: function(id, url, searchVal, result){
		            	$('.xm-select-radio').css('width','300px');
		            }
		       });
		       //根据用户选择的供应商或公司的数据，自动填充供应商名称及其代码
			  formSelects.on('supplierOrCompanyName', function(id, vals, val, isAdd, isDisabled){
				  vue_data.supplierOrCompanyName = val.name;
				  vue_data.supplierOrCompanyNumber =  val.value;
		      });
			//初始化
			formSelects.render('supplierOrCompanyName');
			formSelects.render('typeOfReceivingUnit');
			formSelects.render('natureOfPayment');
			formSelects.render('termsOfPayment');
			//下拉不需要快捷操作按钮
			formSelects.btns('supplierOrCompanyName', []);
			formSelects.btns('typeOfReceivingUnit', []);
			formSelects.btns('natureOfPayment', []);
			formSelects.btns('termsOfPayment', []);
	       //根据用户选择的付款性质，选择是否显示输入框
			  formSelects.on('natureOfPayment', function(id, vals, val, isAdd, isDisabled){
				  if(val.value=='代付款'){
				  	vue_data.natureOfPayment = '代付款:';
					vue_data.dispaly_natureOfPayment ='inline';
					vue_data.required_natureOfPayment = 'required';
				  }else{
				  	vue_data.natureOfPayment = val.value;
					vue_data.dispaly_natureOfPayment ='none';
					vue_data.required_natureOfPayment = 'N';
				  }
		      });
		      
	       //根据用户选择的付款方式，选择是否显示输入框
			  formSelects.on('termsOfPayment', function(id, vals, val, isAdd, isDisabled){
				  if(val.value=='其他'){
				  	vue_data.termsOfPayment = '';
					vue_data.dispaly_termsOfPayment ='inline';
					vue_data.required_termsOfPayment = 'required';
				  }else{
				  	vue_data.termsOfPayment = val.value;
					vue_data.dispaly_termsOfPayment ='none';
					vue_data.required_termsOfPayment = 'N';
				  }
		      });
		      
		    //修改数据：获取数据库中的数据
		    if(rid!=null){
		    	admin.ajax_load_json({
			  		url: 'queryWCP_info_ToAdd_RFP_ByProjectCode',
					dataType: 'json',
					data: {
						project_code: project_code
					},
					success: function(data) {
						if(data.code==0){
							vue_data.project_area_department  = data.info[0].project_area_department;//申请部门
							vue_data.amountPaid  = data.info[0].amountPaid ;//已付款金额(不含本次)
							vue_data.totalAmountPayable  = data.info[0].totalAmountPayable ;//合同或应付款总额
							numinp.setDefaultValue($("#amountPaid"),data.info[0].amountPaid);//已付款金额(不含本次)
							numinp.setDefaultValue($("#totalAmountPayable"),data.info[0].totalAmountPayable);//合同或应付款总额
						}else{
							layer.alert(data.info,{icon:5});
						}
					}
				});
				admin.ajax_load_json({
					url : 'queryOneWCP_RFP_ByRid',
					data : {
						rid : rid
					},
					success : function(data){
						if(data.code==0){
							//赋值
							//vue_data.project_area_department  = data.info.project_area_department ;//申请部门
							vue_data.supplierOrCompanyName  = data.info.supplierOrCompanyName ;//供应商或公司
							vue_data.supplierOrCompanyNumber  = data.info.supplierOrCompanyNumber ;//供应商或公司代码
							vue_data.agent  = data.info.agent ;//经办人
							vue_data.bank  = data.info.bank ;//开户银行
							vue_data.theBankAccount  = data.info.theBankAccount ;//银行账号
							vue_data.theNetworkCode  = data.info.theNetworkCode ;//网络代码
							vue_data.project_code  = data.info.project_code ;//项目代码
							//vue_data.project_area_department  = data.info.project_area_department ;//费用所属部门
							vue_data.typeOfReceivingUnit  = data.info.typeOfReceivingUnit ;//收款单位类别
							vue_data.natureOfPayment  = data.info.natureOfPayment ;//付款性质
							vue_data.becauseOfPayment  = data.info.becauseOfPayment ;//付款原因
							vue_data.theContractNumber  = data.info.theContractNumber ;//合同号码
							vue_data.batch  = data.info.batch ;//批次
							//vue_data.amountPaid  = data.info.amountPaid ;//已付款金额(不含本次)
							//vue_data.totalAmountPayable  = data.info.totalAmountPayable ;//合同或应付款总额
							vue_data.writeOffTheAdvancePayment  = data.info.writeOffTheAdvancePayment ;//冲销前期预付款金额
							vue_data.amountOfThisPayment  = data.info.amountOfThisPayment ;//小写
							vue_data.capital  = data.info.capital ;//大写
							vue_data.numberOfDocumentsAndAttachments  = data.info.numberOfDocumentsAndAttachments ;//单据及附件张数
							vue_data.paymentRequest  = data.info.paymentRequest ;//付款要求
							vue_data.FA_Entry  = data.info.FA_Entry ;//FA录入
							vue_data.FA_Audit  = data.info.FA_Audit ;//FA审核
							vue_data.termsOfPayment  = data.info.termsOfPayment ;//付款方式
							vue_data.GL_AP_Entry  = data.info.GL_AP_Entry ;//GL/AP录入
							vue_data.GL_AP_Audit  = data.info.GL_AP_Audit ;//GL/AP审核
							vue_data.approvalOfRelevantDepartments  = data.info.approvalOfRelevantDepartments ;//相关部门审批
							vue_data.financeDepartmentApproval  = data.info.financeDepartmentApproval ;//财务部门审批
							vue_data.responsiblePersonApproval  = data.info.responsiblePersonApproval ;//负责人审批
							vue_data.signatureOfPayee  = data.info.signatureOfPayee ;//收款人签名
							vue_data.cashiersSignature  = data.info.cashiersSignature ;//出纳员签名
							vue_data.inputDate  = data.info.inputDate ;//年月日
							
							//一些无法依靠vue来改变显示内容的控件值
							//供应商或公司下拉框
							formSelects.value('supplierOrCompanyName', [data.info.supplierOrCompanyNumber]);
							//收款单位类别下拉框
							formSelects.value('typeOfReceivingUnit', [data.info.typeOfReceivingUnit]);
							//付款性质下拉框
							if(data.info.natureOfPayment!='预付款'&&data.info.natureOfPayment!='项目进度款'&&data.info.natureOfPayment!='结算款'&&data.info.natureOfPayment!='公司间往来'){
								formSelects.value('natureOfPayment', ['代付款']);//付款性质
								vue_data.dispaly_natureOfPayment ='inline';
								vue_data.required_natureOfPayment = 'required';
							}else{
							  	formSelects.value('natureOfPayment', [data.info.natureOfPayment]);//付款性质
								vue_data.dispaly_natureOfPayment ='none';
								vue_data.required_natureOfPayment = 'N';
							}
							//付款方式下拉框
							if(data.info.termsOfPayment!='支票'&&data.info.termsOfPayment!='电子付款'&&data.info.termsOfPayment!='现金'){
							 	formSelects.value('termsOfPayment', ['其他']);//付款方式
							  	vue_data.termsOfPayment = data.info.termsOfPayment;
								vue_data.dispaly_termsOfPayment ='inline';
								vue_data.required_termsOfPayment = 'required';
						  	}else{
								formSelects.value('termsOfPayment', [data.info.termsOfPayment]);//付款方式
								vue_data.dispaly_termsOfPayment ='none';
								vue_data.required_termsOfPayment = 'N';
							}
							//数字输入组件
							//numinp.setDefaultValue($("#amountPaid"),data.info.amountPaid);//已付款金额(不含本次)
							//numinp.setDefaultValue($("#totalAmountPayable"),data.info.totalAmountPayable);//合同或应付款总额
							numinp.setDefaultValue($("#writeOffTheAdvancePayment"),data.info.writeOffTheAdvancePayment );//冲销前期预付款金额
							numinp.setDefaultValue($("#amountOfThisPayment"),data.info.amountOfThisPayment) ;//小写
							numinp.setDefaultValue($("#numberOfDocumentsAndAttachments"),data.info.numberOfDocumentsAndAttachments) ;//单据及附件张数
							$("#advance_payment_request_date").val(data.info.inputDate);
						}else{
							layer.alert(data.info,{icon:5});
						}
					}
				})		    
		    }else{
		    	admin.ajax_load_json({
			  		url: 'queryWCP_info_ToAdd_RFP_ByProjectCode',
					dataType: 'json',
					data: {
						project_code: project_code
					},
					success: function(data) {
						if(data.code==0){
							vue_data.project_area_department  = data.info[0].project_area_department;//申请部门
							vue_data.amountPaid  = data.info[0].amountPaid ;//已付款金额(不含本次)
							vue_data.totalAmountPayable  = data.info[0].totalAmountPayable ;//合同或应付款总额
							numinp.setDefaultValue($("#amountPaid"),data.info[0].amountPaid);//已付款金额(不含本次)
							numinp.setDefaultValue($("#totalAmountPayable"),data.info[0].totalAmountPayable);//合同或应付款总额
						}else{
							layer.alert(data.info,{icon:5});
						}
					}
				});
		    }

			
			//初始化日期
			 laydate.render({
			    elem: '#advance_payment_request_date'
			    ,done: function(value, date, endDate){
			    	vue_data.inputDate=value;
			    }
			  });
			  
			  //确认数据按钮
			  form.on('submit(check_advance_payment_request)', function(data){
			 	if(vue_data.checkOrreInput=='check'){//确认数据按钮
			  		$('#check_advance_payment_request').html('<i class="layui-icon layui-icon-edit"></i>重新录入');
			  		vue_data.checkOrreInput='reInput';
				  	vue_data.dispaly_input_table = 'none';
				  	vue_data.dispaly_show_table = 'inline';
			  		vue_data.dispaly_upload_btn = 'inline';
				  	
				  	vue_data.amountPaid = data.field.amountPaid;//已付款金额(不含本次)	
				  	vue_data.totalAmountPayable = data.field.totalAmountPayable;//合同或应付款总额
				  	vue_data.writeOffTheAdvancePayment = data.field.writeOffTheAdvancePayment;//冲销前期预付款金额
				  	vue_data.amountOfThisPayment = data.field.amountOfThisPayment;//小写
				  	vue_data.numberOfDocumentsAndAttachments = data.field.numberOfDocumentsAndAttachments;//单据及附件张数
				  	vue_data.typeOfReceivingUnit = layui.formSelects.value('typeOfReceivingUnit', 'valStr'); //监听收款单位类别
			  	}else if(vue_data.checkOrreInput=='reInput'){ //重新录入按钮
			  		$('#check_advance_payment_request').html('<i class="layui-icon layui-icon-ok"></i>数据确认');
			  		vue_data.checkOrreInput='check';
				  	vue_data.dispaly_input_table = 'inline';
				  	vue_data.dispaly_show_table = 'none';
			  		vue_data.dispaly_upload_btn = 'none';
			  	}
				return false;
				});
			  
			  //打印数据按钮
			  $('#print_advance_payment_request').click(function(){
			  	 $('#print_advance_payment_request_div').printArea();
			  });
			  
			  //提交数据
			  $("#upload_advance_payment_request").click(function(){
			  	var add_info=''; 
				add_info += '{"rid":"'+rid +'",'+//rid
					'"project_area_department":"'+vue_data.project_area_department +'",'+//申请部门
					'"supplierOrCompanyName":"'+vue_data.supplierOrCompanyName +'",'+//供应商或公司
					'"supplierOrCompanyNumber":"'+vue_data.supplierOrCompanyNumber +'",'+//供应商或公司代码
					'"agent":"'+vue_data.agent +'",'+//经办人
					'"bank":"'+vue_data.bank +'",'+//开户银行
					'"theBankAccount":"'+vue_data.theBankAccount +'",'+//银行账号
					'"theNetworkCode":"'+vue_data.theNetworkCode +'",'+//网络代码
					'"project_code":"'+vue_data.project_code +'",'+//项目代码
					'"project_area_department":"'+vue_data.project_area_department +'",'+//费用所属部门
					'"typeOfReceivingUnit":"'+vue_data.typeOfReceivingUnit +'",'+//收款单位类别
					'"natureOfPayment":"'+vue_data.natureOfPayment +'",'+//付款性质
					'"becauseOfPayment":"'+vue_data.becauseOfPayment +'",'+//付款原因
					'"theContractNumber":"'+vue_data.theContractNumber +'",'+//合同号码
					'"batch":"'+vue_data.batch +'",'+//批次
					'"amountPaid":'+vue_data.amountPaid +','+//已付款金额(不含本次)
					'"totalAmountPayable":'+vue_data.totalAmountPayable +','+//合同或应付款总额
					'"writeOffTheAdvancePayment":'+vue_data.writeOffTheAdvancePayment +','+//冲销前期预付款金额
					'"amountOfThisPayment":'+vue_data.amountOfThisPayment +','+//小写
					'"capital":"'+vue_data.capital +'",'+//大写
					'"numberOfDocumentsAndAttachments":"'+vue_data.numberOfDocumentsAndAttachments +'",'+//单据及附件张数
					'"paymentRequest":"'+vue_data.paymentRequest +'",'+//付款要求
					'"FA_Entry":"'+vue_data.FA_Entry +'",'+//FA录入
					'"FA_Audit":"'+vue_data.FA_Audit +'",'+//FA审核
					'"termsOfPayment":"'+vue_data.termsOfPayment +'",'+//付款方式
					'"GL_AP_Entry":"'+vue_data.GL_AP_Entry +'",'+//GL/AP录入
					'"GL_AP_Audit":"'+vue_data.GL_AP_Audit +'",'+//GL/AP审核
					'"approvalOfRelevantDepartments":"'+vue_data.approvalOfRelevantDepartments +'",'+//相关部门审批
					'"financeDepartmentApproval":"'+vue_data.financeDepartmentApproval +'",'+//财务部门审批
					'"responsiblePersonApproval":"'+vue_data.responsiblePersonApproval +'",'+//负责人审批
					'"signatureOfPayee":"'+vue_data.signatureOfPayee +'",'+//收款人签名
					'"cashiersSignature":"'+vue_data.cashiersSignature +'",'+//出纳员签名
					'"inputDate":"'+vue_data.inputDate +'"}';//年月日
					admin.ajax_load_json({
						url : 'addOrUpdateWCP_RFP_info',
						data : {
							info : add_info
						},
						success : function(data){
							if(data.code==0){
								layer.msg(data.info,{icon:1});
							}else{
								layer.alert(data.info,{icon:5});
							}
						}
					})
			  });
			 
			  //开户银行可以根据输入的银行账号获取
			  $('#theBankAccount').blur(function(){ //vue_data.theBankAccount = '6222021110003245541';
			    var theBankAccount = vue_data.theBankAccount;
			    if(theBankAccount.length==0){
			    	return;
			    }
			    if(theBankAccount.length<13||theBankAccount.length>19){
					layer.tips('卡号长度小于13位或大于19位，可能无法自动填充开户行数据', '#theBankAccount',{tips: [4, '#78BA32'],closeBtn :1,time: 0});
			    	//layer.msg('卡号长度小于13位或大于19位');
			    	return;
			    }
			  	admin.ajax_load_json({
			  	url: 'https://ccdcapi.alipay.com/validateAndCacheCardInfo.json',
					dataType: 'json',
					data: {
						cardNo: theBankAccount,
						cardBinCheck: true
					},
					success: function(data) {
						if(data.stat=='ok'&&data.validated==true){
							var count=0;
							for(var i in BANK_JSON){
							     if(data.bank==i){
								     count++;
								     vue_data.bank = BANK_JSON[i];
								     break;
							     }
							}
							if(count==0){
								layer.tips('未找到符合的银行名称，请确认卡号是否正确或者手动输入开户行名称', '#bank',{tips: [4, '#78BA32'],closeBtn :1,time: 0});
							}
						}else{
							layer.tips('根据卡号获取银行名称异常，请确认卡号是否正确或者手动输入开户行名称', '#bank',{tips: [4, '#78BA32'],closeBtn :1,time: 0});
						}
					  	
						
					}
			  	})
			  }) 
				//银行代码对应名称数据
			  var BANK_JSON=JSON.parse('{"CDB":"国家开发银行","ICBC":"中国工商银行","ABC":"中国农业银行","BOC":"中国银行","CCB":"中国建设银行","PSBC":"中国邮政储蓄银行","COMM":"交通银行","CMB":"招商银行","SPDB":"上海浦东发展银行","CIB":"兴业银行","HXBANK":"华夏银行","GDB":"广东发展银行","CMBC":"中国民生银行","CITIC":"中信银行","CEB":"中国光大银行","EGBANK":"恒丰银行","CZBANK":"浙商银行","BOHAIB":"渤海银行","SPABANK":"平安银行","SHRCB":"上海农村商业银行","YXCCB":"玉溪市商业银行","YDRCB":"尧都农商行","BJBANK":"北京银行","SHBANK":"上海银行","JSBANK":"江苏银行","HZCB":"杭州银行","NJCB":"南京银行","NBBANK":"宁波银行","HSBANK":"徽商银行","CSCB":"长沙银行","CDCB":"成都银行","CQBANK":"重庆银行","DLB":"大连银行","NCB":"南昌银行","FJHXBC":"福建海峡银行","HKB":"汉口银行","WZCB":"温州银行","QDCCB":"青岛银行","TZCB":"台州银行","JXBANK":"嘉兴银行","CSRCB":"常熟农村商业银行","NHB":"南海农村信用联社","CZRCB":"常州农村信用联社","H3CB":"内蒙古银行","SXCB":"绍兴银行","SDEB":"顺德农商银行","WJRCB":"吴江农商银行","ZBCB":"齐商银行","GYCB":"贵阳市商业银行","ZYCBANK":"遵义市商业银行","HZCCB":"湖州市商业银行","DAQINGB":"龙江银行","JINCHB":"晋城银行JCBANK","ZJTLCB":"浙江泰隆商业银行","GDRCC":"广东省农村信用社联合社","DRCBCL":"东莞农村商业银行","MTBANK":"浙江民泰商业银行","GCB":"广州银行","LYCB":"辽阳市商业银行","JSRCU":"江苏省农村信用联合社","LANGFB":"廊坊银行","CZCB":"浙江稠州商业银行","DYCB":"德阳商业银行","JZBANK":"晋中市商业银行","BOSZ":"苏州银行","GLBANK":"桂林银行","URMQCCB":"乌鲁木齐市商业银行","CDRCB":"成都农商银行","ZRCBANK":"张家港农村商业银行","BOD":"东莞银行","LSBANK":"莱商银行","BJRCB":"北京农村商业银行","TRCB":"天津农商银行","SRBANK":"上饶银行","FDB":"富滇银行","CRCBANK":"重庆农村商业银行","ASCB":"鞍山银行","NXBANK":"宁夏银行","BHB":"河北银行","HRXJB":"华融湘江银行","ZGCCB":"自贡市商业银行","YNRCC":"云南省农村信用社","JLBANK":"吉林银行","DYCCB":"东营市商业银行","KLB":"昆仑银行","ORBANK":"鄂尔多斯银行","XTB":"邢台银行","JSB":"晋商银行","TCCB":"天津银行","BOYK":"营口银行","JLRCU":"吉林农信","SDRCU":"山东农信","XABANK":"西安银行","HBRCU":"河北省农村信用社","NXRCU":"宁夏黄河农村商业银行","GZRCU":"贵州省农村信用社","FXCB":"阜新银行","HBHSBANK":"湖北银行黄石分行","ZJNX":"浙江省农村信用社联合社","XXBANK":"新乡银行","HBYCBANK":"湖北银行宜昌分行","LSCCB":"乐山市商业银行","TCRCB":"江苏太仓农村商业银行","BZMD":"驻马店银行","GZB":"赣州银行","WRCB":"无锡农村商业银行","BGB":"广西北部湾银行","GRCB":"广州农商银行","JRCB":"江苏江阴农村商业银行","BOP":"平顶山银行","TACCB":"泰安市商业银行","CGNB":"南充市商业银行","CCQTGB":"重庆三峡银行","XLBANK":"中山小榄村镇银行","HDBANK":"邯郸银行","KORLABANK":"库尔勒市商业银行","BOJZ":"锦州银行","QLBANK":"齐鲁银行","BOQH":"青海银行","YQCCB":"阳泉银行","SJBANK":"盛京银行","FSCB":"抚顺银行","ZZBANK":"郑州银行","SRCB":"深圳农村商业银行","BANKWF":"潍坊银行","JJBANK":"九江银行","JXRCU":"江西省农村信用","HNRCU":"河南省农村信用","GSRCU":"甘肃省农村信用","SCRCU":"四川省农村信用","GXRCU":"广西省农村信用","SXRCCU":"陕西信合","WHRCB":"武汉农村商业银行","YBCCB":"宜宾市商业银行","KSRB":"昆山农村商业银行","SZSBK":"石嘴山银行","HSBK":"衡水银行","XYBANK":"信阳银行","NBYZ":"鄞州银行","ZJKCCB":"张家口市商业银行","XCYH":"许昌银行","JNBANK":"济宁银行","CBKF":"开封市商业银行","WHCCB":"威海市商业银行","HBC":"湖北银行","BOCD":"承德银行","BODD":"丹东银行","JHBANK":"金华银行","BOCY":"朝阳银行","LSBC":"临商银行","BSB":"包商银行","LZYH":"兰州银行","BOZK":"周口银行","DZBANK":"德州银行","SCCB":"三门峡银行","AYCB":"安阳银行","ARCU":"安徽省农村信用社","HURCB":"湖北省农村信用社","HNRCC":"湖南省农村信用社","NYNB":"广东南粤银行","LYBANK":"洛阳银行","NHQS":"农信银清算中心","CBBQS":"城市商业银行资金清算中心"}');
			  
		});
	</script>