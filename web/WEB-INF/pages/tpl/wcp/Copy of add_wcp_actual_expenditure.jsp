<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>

<div class="layui-row layui-col-space15" id="wcp_bonus_shares_div_vue" >
		<div class="layui-col-xs4 layui-col-md3">
			<div class="layui-card">
				<div class="layui-card-header">
					<span class="layui-badge layui-bg-cyan">
						{{project_code}}- {{project_name}} - {{project_leader}}
					</span>
				</div>
				<div class="layui-card-body">
					<form class="layui-form" action="" onsubmit="return false"  lay-filter="formTest">
						<div class="layui-form-item">
							<label class="layui-form-label">
								费用所属部门
							</label>
							<div class="layui-input-inline disabled">
								<select name="cost_department" required lay-verify="required" id="cost_department" disabled></select>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								报销工号
							</label>
							<div class="layui-input-inline">
								<input type="text" name="reimbursement_number" required lay-verify="required" autocomplete="off" class="layui-input" id="reimbursement_number">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								申请人姓名
							</label>
							<div class="layui-input-inline">
								<input type="text" name="name_of_applicant" required lay-verify="required" autocomplete="off" placeholder="由工号自动带出" readOnly="readOnly" disabled class="layui-input" id="name_of_applicant">
							</div>
						</div>
						<div class="layui-form-item">
						    <label class="layui-form-label">是否最后一次报销</label>
						    <div class="layui-input-inline">
						      <select name="the_last_time" id="the_last_time"  lay-verify="required">
						        <option value="">请选择</option>
						        <option value="Y">是</option>
						        <option value="N">否</option>
						      </select>
						    </div>
						</div>
					</form>
					<span class="layui-badge layui-bg-cyan">
						填写票据信息
					</span>
					<form class="layui-form" action="" onsubmit="return false" id="table_from">
						<div class="layui-form-item">
							<label class="layui-form-label">
								票据类型
							</label>
							<div class="layui-input-inline">
								<select name="bill_type" required lay-verify="required" lay-filter="bill_type" id="bill_type"></select>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								成本事项
							</label>
							<div class="layui-input-inline">
								<select name="cost_matters" required lay-verify="required" lay-filter="cost_matters" id="cost_matters" lay-search></select>
							</div>
						</div>
						
						<div class="layui-form-item">
							<label class="layui-form-label">价税合计</label>
							<div class="layui-input-inline">
								<input type="number" name="amount_in_original_currency" v-model.number="amount_in_original_currency"  required lay-verify="required" autocomplete="off" class="layui-input" >
								</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								呆料
							</label>
							<div class="layui-input-inline">
								<input type="number" name="idle_stock" autocomplete="off" class="layui-input" v-model.number="idle_stock">
							</div>
						</div>
						
						<div class="layui-form-item" id="tax_rate_div">
							<label class="layui-form-label">
								税率
							</label>
							<div class="layui-input-inline">
								<select name="tax_rate"  v-bind:lay-verify="tax_rate_required" id="tax_rate" lay-filter="tax_rate" ></select>
							</div>
						</div>
					
						<div class="layui-form-item" id="tax_rate_div">
							<label class="layui-form-label">
								发票号码
							</label>
							<div class="layui-input-inline">
								<input type="text" name="invoice_number"  v-bind:lay-verify="invoice_number_required" autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item" id="tax_rate_div">
							<label class="layui-form-label">
								发生日期
							</label>
							<div class="layui-input-inline">
							<input type="text" name="date_of_occurrence" id="date_of_occurrence" required lay-verify="required" autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item" id="tax_rate_div">
							<label class="layui-form-label">
								用途
							</label>
							<div class="layui-input-inline">
									<input type="text" name="purpose_of_occurrence" required lay-verify="required" autocomplete="off" class="layui-input">
									</div>
						</div>
							<div v-show="shuie_benjin == '增值税专用发票'">
							<div class="layui-form-item" >
								<label class="layui-form-label">
									税额
								</label>
								<div class="layui-input-inline">
									<input type="text" name="amount_of_tax"  v-model.number="amount_of_tax" autocomplete="off" class="layui-input layui-disabled" disabled v-bind:lay-verify="tax_rate_required" >
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">
									本金
								</label>
								<div class="layui-input-inline">
									<input type="text" name="principal"  v-model.number="principal" autocomplete="off" class="layui-input layui-disabled" disabled v-bind:lay-verify="tax_rate_required" >
								</div>
							</div>
						</div>
						<div class="layui-form-item" id="tax_rate_div">
							<label class="layui-form-label">
							</label>
							<div class="layui-input-inline">
								<button class="layui-btn layui-btn-disabled" lay-submit lay-filter="formdemo" disabled id="wcp_actual_expenditure_add_to_table">添加到表格</button>
								</div>
						</div>
					</form>

				</div>
			</div>
		</div>
		<div class="layui-col-xs8 layui-col-md9">
			<div class="layui-card">
				<div class="layui-card-header">
					<button class="layui-btn layui-btn-disabled" data-type="getCheckData"
					id="getTableInfoToAdd_wcp_actual_expenditure" disabled>
						提交报销
					</button>
				</div>
				<div class="layui-card-body">
					<table  class="layui-table" id="add_wcp_actual_expenditure_table" lay-filter="add_actual_expenditure_table_filter"></table>
				</div>
			</div>
		</div>
	</div>
	<script type="text/html" id="wcp_actual_expenditure_barDemo">
		<a class = "layui-btn layui-btn-danger layui-btn-xs" lay-event = "del" > 删除 </a>
	</script>

<script type="text/javascript">
layui.use(['jquery','layer','form','admin','laydate','table'], function(){
  var $=layui.jquery
  ,layer = layui.layer
  ,form = layui.form
  ,admin = layui.admin
  ,table = layui.table
  ,laydate = layui.laydate;
  var counts=0;
  var add_wcp_actual_expenditure_table_oldData;
  var tableData = new Array();
  //VUE初始化
  var vm = new Vue({
  	el: '#wcp_bonus_shares_div_vue',
  	data: {
	    project_code :admin.getTempData('project_code')
	    ,project_name : ''
	    ,project_leader : ''
		,invoice_number_required : 'N'//发票号码
		,tax_rate_required : 'N'//税率
		,shuie_benjin : ''
		,amount_in_original_currency : 0 //价税合计
		,tax_rate : 0 //税率
		,idle_stock : 0 //呆料
		,amount_of_tax : 0 //税额=价税合计*税率
		,principal : 0 //本金=价税合计-税额
	}
	,watch:{
		 amount_in_original_currency: function (val) {
	      this.amount_of_tax = (val * this.tax_rate * 1).toFixed(2);
	      this.principal=(val * 1 - this.amount_of_tax*1).toFixed(2);
	    }
    }
	
});

  //时间选择器
  laydate.render({elem: '#date_of_occurrence',istime: false,value:new Date()});
  
  //下拉框初始化-成本事项
	 admin.ajax_load_json({
	  	url:'queryAllParameterToStringByPidList',
	  	data:{pid: 18},
	  	success:function(data){
	  		if(data.code==0){
				var _select="<option></option>";
				for(var a=0;a<data.info.length;a++){
					var value=data.info[a].value;
					var text=data.info[a].text;
					_select+="<option value="+value+">"+text+"</option>";
				}
				$("#cost_matters").html(_select);
				 form.render();
	  		}else{
	  			layer.alert(data.info,{icon:5});
	  		}
	  	}
	  });
	/*
  //下拉框初始化-成本事项
  	var cost_matters_arr = new Array();
	cost_matters_arr[0] = "材料费(含税)";
	cost_matters_arr[1] = "抵税金额(增值税专用发票)";
	cost_matters_arr[2] = "外包人工费、水电(含税)";
	cost_matters_arr[3] = "运杂费";
	cost_matters_arr[4] = "工具固定资产分摊";
	cost_matters_arr[5] = "招待";
	var cost_matters_select="<option></option>";
	for(var a=0;a<cost_matters_arr.length;a++){
		var value=cost_matters_arr[a];
		var text=cost_matters_arr[a];
		cost_matters_select+="<option value="+value+">"+text+"</option>";
	}
	$("#cost_matters").html(cost_matters_select);*/
  //下拉框初始化-票据类型
	var bill_type_arr = new Array();
	bill_type_arr[0] = "增值税专用发票";
	bill_type_arr[1] = "增值税普通发票";
	bill_type_arr[2] = "普通发票";
	var bill_type_select="<option></option>";
	for(var a=0;a<bill_type_arr.length;a++){
		var value=bill_type_arr[a];
		var text=bill_type_arr[a];
		bill_type_select+="<option value="+value+">"+text+"</option>";
	}
	$("#bill_type").html(bill_type_select);
	/*//下拉框初始化-费用所属部门
	var cost_department_arr=new Array();
	cost_department_arr[0] = "华东服务部";
	cost_department_arr[1] = "华南服务部";
	cost_department_arr[2] = "华西服务部";
	cost_department_arr[3] = "华北服务部";
	cost_department_arr[4] = "华中服务部";
	cost_department_arr[5] = "盛海办公室";
	var cost_department_select="<option></option>";
	for(var a=0;a<cost_department_arr.length;a++){
		var value=cost_department_arr[a];
		var text=cost_department_arr[a];
		cost_department_select+="<option value="+value+">"+text+"</option>";
	}
	$("#cost_department").html(cost_department_select);*/
	  //下拉框初始化-费用所属部门
	  admin.ajax_load_json({
	  	url:'queryAllParameterToStringByPidList',
	  	data:{pid: 10},
	  	success:function(data){
	  		if(data.code==0){
				var _select="<option></option>";
				for(var a=0;a<data.info.length;a++){
					var value=data.info[a].value;
					var text=data.info[a].text;
					_select+="<option value="+value+">"+text+"</option>";
				}
				$("#cost_department").html(_select);
				 form.render();
	  		}else{
	  			layer.alert(data.info,{icon:5});
	  		}
	  	}
	  });
	/*//下拉框初始化-税率
	var tax_rate_arr=new Array();
	tax_rate_arr[0] = "0.03,3%";
	tax_rate_arr[1] = "0.06,6%";
	tax_rate_arr[2] = "0.09,9%";
	tax_rate_arr[3] = "0.1,10%";
	tax_rate_arr[4] = "0.13,13%";
	tax_rate_arr[5] = "0.16,16%";
	//var tax_rate_select="<option value='0'>无</option>";
	var tax_rate_select="<option></option>";
	for(var a=0;a<tax_rate_arr.length;a++){
		var vate=tax_rate_arr[a].split(",");
		var value=vate[0];
		var text=vate[1];
		tax_rate_select+="<option value="+value+">"+text+"</option>";
	}
	$("#tax_rate").html(tax_rate_select);*/
	//下拉框初始化-税率
	  admin.ajax_load_json({
	  	url:'queryAllParameterToStringByPidList',
	  	data:{pid: 11},
	  	success:function(data){
	  		if(data.code==0){
				var _select="<option></option>";
				for(var a=0;a<data.info.length;a++){
					var value=data.info[a].value;
					var text=data.info[a].text;
					_select+="<option value="+value+">"+text+"</option>";
				}
				$("#tax_rate").html(_select);
				 form.render();
	  		}else{
	  			layer.alert(data.info,{icon:5});
	  		}
	  	}
	  });
	//FORM刷新布局
	form.render('select'); 
	
	 $('#reimbursement_number').blur(function () {
		admin.ajax_load_json({
			url : "getUserNameAndWCPAreaByUserId",
			data:{
				user_id : $(this).val()
			},
			success : function(data){
				console.log();
				if(data.code==0){
				 $("#name_of_applicant").val(data.info[0].user_name);
				
				}else{
					layer.alert(data.info,{icon:5});
				}
			}
		});
	});
	//通过项目编码获取相关信息
	$.post("queryWCProjectsSimpleDetailAllInfoByProjectCode", {project_code: admin.getTempData('project_code')},
		function(data) {
			if (data.code == 1) {
				layer.msg(data.info);
			} else {
				vm.project_leader = data.info[0].project_leader;
				vm.project_name = data.info[0].project_name;
				$('#wcp_actual_expenditure_add_to_table').removeClass("layui-btn-disabled").removeAttr("disabled").text("添加到表格");
				form.val("formTest", {
				"cost_department":data.info[0].project_area_department
				});
			}
	},'json');
  	//下拉框事件-票据类型
	form.on('select(bill_type)', function(data){
	  vm.shuie_benjin=data.value;
	   if(data.value=='增值税专用发票'){
	  	vm.tax_rate_required='required';
	  	form.render('select');
	  }else{
	  	vm.tax_rate_required='N';
	  }
	});
	//下拉框-成本事项
	form.on('select(cost_matters)', function(data){
	  if(data.value=='外包人工费、水电(含税)'||data.value=='材料费(含税)'){
	  	vm.invoice_number_required='required';
	  }else{
	  	vm.invoice_number_required='N';
	  }
	});
	//下拉框-税率
	form.on('select(tax_rate)', function(data){
	  vm.tax_rate=data.value;
	  vm.amount_of_tax = (vm.amount_in_original_currency * vm.tax_rate * 1).toFixed(2);
	  vm.principal=(vm.amount_in_original_currency * 1 - vm.amount_of_tax * 1).toFixed(2);
	});

	//表格初始化
	table.render({
		elem: '#add_wcp_actual_expenditure_table',
		data: tableData,
		totalRow: true,
		page: true,
		limit: 999, //设置每页显示条数
		cols: [[{
			field: null,
			title: '操作',
			minWidth: 100,
			templet: '#wcp_actual_expenditure_barDemo',
		},
		{
			field: 'bill_type',
			minWidth: 120,
			title: '票据类型'
		},
		{
			field: 'cost_matters',
			minWidth: 120,
			title: '成本事项'
		},
		{
			field: 'amount_in_original_currency',
			minWidth: 120,
			title: '价税合计',
			//totalRow: true
		},
		{
			field: 'idle_stock',
			minWidth: 120,
			title: '呆料',
			
		},
		{
			field: 'tax_rate',
			minWidth: 120,
			title: '税率'
		},
		{
			field: 'amount_of_tax',
			minWidth: 120,
			title: '税额'
		},
		{
			field: 'principal',
			minWidth: 120,
			title: '本金'
			//totalRow: true
		},
		{
			field: 'invoice_number',
			minWidth: 120,
			title: '发票号码'
		},
		{
			field: 'date_of_occurrence',
			minWidth: 120,
			title: '发生日期'
		},
		{
			field: 'purpose_of_occurrence',
			minWidth: 120,
			title: '用途'
		}]],
		done: function(res, curr, count) {
		}
	});
	//添加数据到表格
	form.on('submit(formdemo)',function(data) {
		console.log("data.field="+data.field);
		add_wcp_actual_expenditure_table_oldData = table.cache["add_wcp_actual_expenditure_table"];
		if(data.field.tax_rate==""||data.field.tax_rate==null){
			data.field.tax_rate=0;
		}
		var data1 = {
				"bill_type": data.field.bill_type,
				"cost_matters": data.field.cost_matters,
				"amount_in_original_currency": data.field.amount_in_original_currency,
				"idle_stock": data.field.idle_stock,
				"tax_rate": data.field.tax_rate,
				"amount_of_tax": data.field.amount_of_tax,
				"principal": data.field.principal,
				"invoice_number": data.field.invoice_number,
				"date_of_occurrence": data.field.date_of_occurrence,
				"purpose_of_occurrence": data.field.purpose_of_occurrence
			};
			console.log("add_wcp_actual_expenditure_table_oldData",add_wcp_actual_expenditure_table_oldData);
		add_wcp_actual_expenditure_table_oldData.push(data1);
		table.reload('add_wcp_actual_expenditure_table', {
			data: add_wcp_actual_expenditure_table_oldData,
			page: false
		});
		counts++;
		//初始化表单
		document.getElementById("table_from").reset();
		//初始化日期控件
 			laydate.render({elem: '#date_of_occurrence',istime: false,value:new Date()});
 			//
 			vm.invoice_number_required = 'N';
		vm.tax_rate_required = 'N';
		vm.shuie_benjin = '';
		vm.amount_in_original_currency = 0;
		vm.tax_rate = 0;
		vm.idle_stock = 0;
		vm.amount_of_tax = 0;
		vm.principal = 0;
		
		$('#getTableInfoToAdd_wcp_actual_expenditure').removeClass("layui-btn-disabled").removeAttr("disabled");
		
		return false;
	});
	//监听工具条
	table.on('tool(add_actual_expenditure_table_filter)',function(obj) {
		var data = obj.data;
		if (obj.event === 'del') {
			layer.confirm('确定删除吗',
			function(index) {
				obj.del();
				layer.close(index);
				add_wcp_actual_expenditure_table_oldData = table.cache["add_wcp_actual_expenditure_table"];
				table.reload('add_wcp_actual_expenditure_table', {
					data: add_wcp_actual_expenditure_table_oldData,
					page: false
				});
				
				counts--;
				if(counts==0){
					$('#getTableInfoToAdd_wcp_actual_expenditure').addClass("layui-btn-disabled").attr("disabled", "disabled");
				}
			});
		}
	});
				$("#getTableInfoToAdd_wcp_actual_expenditure").click(function() {
				if($("#cost_department").val()==""){
					layer.msg("费用所属部门不可为空");
					return;
				}
				if($("#reimbursement_number").val()==""){
					layer.msg("报销工号不可为空");
					return;
				}
				if($("#name_of_applicant").val()==""){
					layer.msg("申请人姓名不可为空");
					return;
				}
				if($("#the_last_time").val()==""){
					layer.msg("是否最后一次报销不可为空");
					return;
				}
				
				
				for(var i= 0 ; i< add_wcp_actual_expenditure_table_oldData.length;i++){
				   if(add_wcp_actual_expenditure_table_oldData[i] == "" || typeof(add_wcp_actual_expenditure_table_oldData[i]) == "undefined")
                    {
                        add_wcp_actual_expenditure_table_oldData.splice(i,1);
                        i= i-1;
                    }
				}
				var up_str = "{\"project_code\":\"" + vm.project_code +
				 "\",\"cost_department\":\"" + $("#cost_department").val() +
				 "\",\"name_of_applicant\":\"" + $("#name_of_applicant").val() +
				 "\",\"reimbursement_number\":\"" + $("#reimbursement_number").val() +
				 "\",\"applicant_department\":\"" + $("#cost_department").val() +
				 "\",\"the_last_time\":\"" + $("#the_last_time").val() +
				  "\",\"data\":" +arrayToJson(add_wcp_actual_expenditure_table_oldData) + "}";
				console.log(up_str);
				admin.ajax_load_json({
					url: "addWeakCurrentProjectsActualExpenditureGroup",
					data: {
						info: up_str
					},
					success: function(obj) {
						if (obj.code == 0) {
							layer.closeAll();
							layer.msg(obj.info, {
								icon: 1
							});

						} else {
							layer.alert(obj.info, {
								icon: 5
							});
						}
					}
				});
			});
	});
 		function arrayToJson(o) {
			var r = [];
			if (typeof o == "string") return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
			if (typeof o == "object") {
				if (!o.sort) {
					for (var i in o) r.push("\"" + i + "\":" + arrayToJson(o[i]));
					if ( !! document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
						r.push("toString:" + o.toString.toString());
					}
					r = "{" + r.join() + "}";
				} else {
					for (var i = 0; i < o.length; i++) {
						r.push(arrayToJson(o[i]));
					}
					r = "[" + r.join() + "]";
				}
				return r;
			}
			return o.toString();
		}
</script>