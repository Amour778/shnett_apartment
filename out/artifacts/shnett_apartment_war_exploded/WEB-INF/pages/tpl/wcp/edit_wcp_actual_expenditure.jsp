<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>

<div id="wcp_bonus_shares_div_vue" >
			<div class="layui-card">
				<div class="layui-card-body">
					<form class="layui-form" action="" onsubmit="return false" lay-filter="_actual_expenditure">
						<div class="layui-form-item">
							<label class="layui-form-label">
								费用所属部门
							</label>
							<div class="layui-input-inline disabled">
								<select name="project_area_department" required lay-verify="required"
									id="project_area_department" id="project_area_department" disabled></select>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								报销工号
							</label>
							<div class="layui-input-inline">
								<input type="text" name="reimbursement_number" required
									lay-verify="required" autocomplete="off" class="layui-input"
									id="reimbursement_number"  v-model="reimbursement_number">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								申请人姓名
							</label>
							<div class="layui-input-inline">
								<input type="text" name="name_of_applicant" required
									lay-verify="required" autocomplete="off" class="layui-input"
									id="name_of_applicant"  v-model="name_of_applicant">
							</div>
						</div>
						<!--<div class="layui-form-item">
						    <label class="layui-form-label">是否最后一次报销</label>
						    <div class="layui-input-inline">
						      <select name="the_last_time" id="the_last_time"  lay-verify="required">
						        <option value="">请选择</option>
						        <option value="Y">是</option>
						        <option value="N">否</option>
						      </select>
						    </div>
						</div>
						--><div class="layui-form-item">
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
								<select name="cost_matters" required lay-verify="required" lay-filter="cost_matters" id="cost_matters"></select>
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
								<input type="number" name="invoice_number"  v-model="invoice_number" v-bind:lay-verify="invoice_number_required" autocomplete="off" class="layui-input">
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
									<input type="text" name="purpose_of_occurrence" v-model="purpose_of_occurrence" required lay-verify="required" autocomplete="off" class="layui-input">
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
							<div class="layui-form-item">
								<label class="layui-form-label">
									修改原因
								</label>
								<div class="layui-input-inline">
									<input type="text" name="edit_remark"   autocomplete="off" class="layui-input" lay-verify="required" >
								</div>
							</div>
						</div>
						<div class="layui-form-item" id="tax_rate_div">
							<label class="layui-form-label">
							</label>
							<div class="layui-input-inline">
								<button class="layui-btn layui-btn-disabled" lay-submit lay-filter="formdemo" disabled id="wcp_actual_expenditure_add_to_table">提交修改</button>
								</div>
						</div>
					</form>
				</div>
			</div>
		</div>

<script type="text/javascript">
layui.use(['jquery','layer','form','admin','laydate'], function(){
  var $=layui.jquery
  ,layer = layui.layer
  ,form = layui.form
  ,admin = layui.admin
  ,laydate = layui.laydate;
  //VUE初始化
  var vm = new Vue({
	  	el: '#wcp_bonus_shares_div_vue',
	  	data: {
		    invoice_number_required : 'N'//发票号码
			,tax_rate_required : 'N'//税率
			,shuie_benjin : ''
			,amount_in_original_currency : 0 //价税合计
			,tax_rate : 0 //税率
			,idle_stock : 0 //呆料
			,amount_of_tax : 0 //税额=价税合计*税率
			,principal : 0 //本金=价税合计-税额
			,applicant_department:0,
			bill_type:0,
			//project_area_department:0,
			cost_matters:0,
			date_of_application:0,
			date_of_occurrence:0,
			invoice_number:'',
			item_classification:0,
			name_of_applicant:0,
			project_code:0,
			project_leader:0,
			project_name:0,
			purpose_of_occurrence:0,
			reimbursement_number:0,
			tax_rate:0
		}
		,watch:{
			 amount_in_original_currency: function (val) {
		      this.amount_of_tax = (val * this.tax_rate * 1).toFixed(2);
		      this.principal=(val * 1 - this.amount_of_tax*1).toFixed(2);
		    }
	    }
	});
	//通过工号获取姓名
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
	
	//通过ID获取相关信息
	$.post("querySimpleInfoByID", {id: admin.getTempData('id')},
		function(data) {
			if (data.code == 1) {
				//layer.closeAll();
				layer.alert(data.info);
			} else {
				$('#wcp_actual_expenditure_add_to_table').removeClass("layui-btn-disabled").removeAttr("disabled");
				vm.amount_in_original_currency=data.info[0].amount_in_original_currency;
				vm.amount_of_tax=data.info[0].amount_of_tax;
				vm.applicant_department=data.info[0].applicant_department;
				vm.bill_type=data.info[0].bill_type;
				//vm.project_area_department=data.info[0].project_area_department;
				vm.cost_matters=data.info[0].cost_matters;
				vm.date_of_application=data.info[0].date_of_application;
				vm.date_of_occurrence=data.info[0].date_of_occurrence;
				vm.idle_stock=data.info[0].idle_stock;
				vm.invoice_number=data.info[0].invoice_number;
				vm.item_classification=data.info[0].item_classification;
				vm.name_of_applicant=data.info[0].name_of_applicant;
				vm.principal=data.info[0].principal;
				vm.project_code=data.info[0].project_code;
				vm.project_leader=data.info[0].project_leader;
				vm.project_name=data.info[0].project_name;
				vm.purpose_of_occurrence=data.info[0].purpose_of_occurrence;
				vm.reimbursement_number=data.info[0].reimbursement_number;
				vm.tax_rate=data.info[0].tax_rate;
				//表单初始赋值
				 /* form.val('_actual_expenditure', {
				    "the_last_time": data.info[0].the_last_time
				  })*/
  
				//时间选择器
			  laydate.render({elem: '#date_of_occurrence',istime: false,value:new Date()});
			  //下拉框初始化-成本事项
			 admin.ajax_load_json({
			  	url:'queryAllParameterToStringByPidList',
			  	data:{pid: 19},
			  	success:function(data){
			  		if(data.code==0){
						var _select="<option></option>";
						for(var a=0;a<data.info.length;a++){
							var value=data.info[a].value;
							var text=data.info[a].text;
							if(vm.cost_matters==value){
								if(vm.cost_matters=='外包人工费、水电(含税)'||vm.cost_matters=='材料费(含税)'){
							  	vm.invoice_number_required='required';
							  }else{
							  	vm.invoice_number_required='N';
							  }
								_select+="<option value="+value+" selected>"+text+"</option>";
							}else{
								_select+="<option value="+value+">"+text+"</option>";
							}
							//_select+="<option value="+value+">"+text+"</option>";
						}
						$("#cost_matters").html(_select);
						 form.render();
			  		}else{
			  			layer.alert(data.info,{icon:5});
			  		}
			  	}
			  });
			 /* //下拉框初始化-成本事项
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
					if(vm.cost_matters==value){
						if(vm.cost_matters=='外包人工费、水电(含税)'||vm.cost_matters=='材料费(含税)'){
					  	vm.invoice_number_required='required';
					  }else{
					  	vm.invoice_number_required='N';
					  }
						cost_matters_select+="<option value="+value+" selected>"+text+"</option>";
					}else{
						cost_matters_select+="<option value="+value+">"+text+"</option>";
					}
					
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
					if(vm.bill_type==value){
						if(vm.bill_type=='增值税专用发票'){
						vm.shuie_benjin=vm.bill_type;
					  	vm.tax_rate_required='required';
					  }else{
					  	vm.tax_rate_required='N';
					  	}
						bill_type_select+="<option value="+value+" selected>"+text+"</option>";
					}else{
						bill_type_select+="<option value="+value+">"+text+"</option>";
					}
					
				}
				$("#bill_type").html(bill_type_select);
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
								if(admin.getTempData('project_area_department')==value){
									_select+="<option value="+value+" selected>"+text+"</option>";
								}else{
									_select+="<option value="+value+">"+text+"</option>";
								}
							}
							$("#project_area_department").html(_select);
							 form.render();
				  		}else{
				  			layer.alert(data.info,{icon:5});
				  		}
				  	}
				  });
				/*//下拉框初始化-费用所属部门
				var project_area_department_arr=new Array();
				project_area_department_arr[0] = "华东服务部";
				project_area_department_arr[1] = "华南服务部";
				project_area_department_arr[2] = "华西服务部";
				project_area_department_arr[3] = "华北服务部";
				project_area_department_arr[4] = "华中服务部";
				project_area_department_arr[5] = "盛海办公室";
				var project_area_department_select="<option></option>";
				console.log("admin.getTempData('project_area_department')",admin.getTempData('project_area_department'));
				for(var a=0;a<project_area_department_arr.length;a++){
					var value=project_area_department_arr[a];
					var text=project_area_department_arr[a];
					if(admin.getTempData('project_area_department')==value){
						project_area_department_select+="<option value="+value+" selected>"+text+"</option>";
					}else{
						project_area_department_select+="<option value="+value+">"+text+"</option>";
					}
				}
				$("#project_area_department").html(project_area_department_select);*/
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
								if(vm.tax_rate==value){
									_select+="<option value="+value+" selected>"+text+"</option>";
								}else{
									_select+="<option value="+value+">"+text+"</option>";
								}
							}
							$("#tax_rate").html(_select);
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
					if(vm.tax_rate==value){
						tax_rate_select+="<option value="+value+" selected>"+text+"</option>";
					}else{
						tax_rate_select+="<option value="+value+">"+text+"</option>";
					}
				}
				$("#tax_rate").html(tax_rate_select);*/
				//FORM刷新布局
				form.render('select'); 
			  	//下拉框事件-票据类型
				form.on('select(bill_type)', function(data){
				  vm.shuie_benjin=data.value;
				   if(data.value=='增值税专用发票'){
				  	vm.tax_rate_required='required';
				  	//form.render('select');
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
			}
	},'json');
	

	
	//添加数据到表格
	form.on('submit(formdemo)',function(data) {
		admin.ajax_load_json({
			url: "updateActaulExpenditureInfoByID",
			data: {
				id: admin.getTempData('id')
				,info: JSON.stringify(data.field)
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
		return false;
	});
	
	});
</script>