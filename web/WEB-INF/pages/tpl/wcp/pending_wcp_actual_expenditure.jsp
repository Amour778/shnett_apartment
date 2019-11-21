<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<div class="layui-row layui-col-space15" id="wcp_bonus_shares_div_vue">
	<div class="layui-col-xs6 layui-col-md6">
		<div id="wcp_bonus_shares_div_vue">
			<div class="layui-card">
				<div class="layui-card-body">
					<form class="layui-form" action="" onsubmit="return false"
						id="table_from">
						<div class="layui-form-item">
							<label class="layui-form-label">
								费用所属部门
							</label>
							<div class="layui-input-inline">
								<input name="cost_department" required lay-verify="required"
									class="layui-input" v-model="project_area_department"
									id="cost_department" id="cost_department" disabled>

							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								报销工号
							</label>
							<div class="layui-input-inline">
								<input type="text" name="reimbursement_number" required
									lay-verify="required" autocomplete="off" class="layui-input"
									id="reimbursement_number" v-model="reimbursement_number"
									disabled>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								申请人姓名
							</label>
							<div class="layui-input-inline">
								<input type="text" name="name_of_applicant" required
									lay-verify="required" autocomplete="off" class="layui-input"
									id="name_of_applicant" v-model="name_of_applicant" disabled>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								票据类型
							</label>
							<div class="layui-input-inline">
								<input name="bill_type" v-model="bill_type" required
									lay-verify="required" lay-filter="bill_type"
									class="layui-input" id="bill_type" disabled>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								成本事项
							</label>
							<div class="layui-input-inline">
								<input name="cost_matters" v-model="cost_matters" required
									lay-verify="required" lay-filter="cost_matters"
									class="layui-input" id="cost_matters" disabled>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								价税合计
							</label>
							<div class="layui-input-inline">
								<input type="text" name="amount_in_original_currency"
									v-model="amount_in_original_currency" class="layui-input"
									required lay-verify="required" autocomplete="off"
									class="layui-input" input>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								呆料
							</label>
							<div class="layui-input-inline">
								<input type="text" name="idle_stock" autocomplete="off"
									class="layui-input" v-model="idle_stock" disabled>
							</div>
						</div>
						<div class="layui-form-item" id="tax_rate_div">
							<label class="layui-form-label">
								税率
							</label>
							<div class="layui-input-inline">
								<input name="tax_rate" class="layui-input" v-model="tax_rate"
									v-bind:lay-verify="tax_rate_required" id="tax_rate"
									lay-filter="tax_rate" disabled>
							</div>
						</div>
						<div class="layui-form-item" id="tax_rate_div">
							<label class="layui-form-label">
								发票号码
							</label>
							<div class="layui-input-inline">
								<input type="text" name="invoice_number"
									v-model="invoice_number"
									v-bind:lay-verify="invoice_number_required" autocomplete="off"
									class="layui-input" disabled>
							</div>
						</div>
						<div class="layui-form-item" id="tax_rate_div">
							<label class="layui-form-label">
								发生日期
							</label>
							<div class="layui-input-inline">
								<input type="text" name="date_of_occurrence"
									v-model="date_of_occurrence" id="date_of_occurrence" required
									lay-verify="required" autocomplete="off" class="layui-input"
									disabled>
							</div>
						</div>
						<div class="layui-form-item" id="tax_rate_div">
							<label class="layui-form-label">
								用途
							</label>
							<div class="layui-input-inline">
								<input type="text" name="purpose_of_occurrence"
									v-model="purpose_of_occurrence" required lay-verify="required"
									autocomplete="off" class="layui-input" disabled>
							</div>
						</div>
						<div v-show="shuie_benjin == '增值税专用发票'">
							<div class="layui-form-item">
								<label class="layui-form-label">
									税额
								</label>
								<div class="layui-input-inline">
									<input type="text" name="amount_of_tax" v-model="amount_of_tax"
										autocomplete="off" class="layui-input" disabled
										v-bind:lay-verify="tax_rate_required" disabled>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">
									本金
								</label>
								<div class="layui-input-inline">
									<input type="text" name="principal" v-model="principal"
										autocomplete="off" class="layui-input" disabled
										v-bind:lay-verify="tax_rate_required">
								</div>
							</div>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6 layui-col-md6">
		<div id="wcp_bonus_shares_div_vue">
			<div class="layui-card">
				<div class="layui-card-header">
					预估数据
				</div>
				<div class="layui-card-body">
					<form class="layui-form" action="" onsubmit="return false"
						id="table_from">
						<div class="layui-form-item">
							<label class="layui-form-label">
								预估毛利
							</label>
							<div class="layui-input-inline">
								<input name="predict_gross_profit" class="layui-input"
									v-model="predict_gross_profit" id="predict_gross_profit"
									disabled>

							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								预估毛利%
							</label>
							<div class="layui-input-inline">
								<input name="predict_gross_profit" class="layui-input"
									v-model="predict_gross_profit_per"
									id="predict_gross_profit_per" disabled>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								预估净利润
							</label>
							<div class="layui-input-inline">
								<input type="text" name="predict_net_profit" class="layui-input"
									id="predict_net_profit" v-model="predict_net_profit" disabled>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								预估净利润%
							</label>
							<div class="layui-input-inline">
								<input name="predict_net_profit_per"
									v-model="predict_net_profit_per" class="layui-input"
									id="predict_net_profit_per" disabled>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="layui-card">
				<div class="layui-card-header">
					当前数据
				</div>
				<div class="layui-card-body">
					<form class="layui-form" action="" onsubmit="return false"
						id="table_from">
						<div class="layui-form-item">
							<label class="layui-form-label">
								实际毛利
							</label>
							<div class="layui-input-inline">
								<input name="real_gross_profit" class="layui-input"
									v-model="real_gross_profit" id="real_gross_profit" disabled>

							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								实际毛利%
							</label>
							<div class="layui-input-inline">
								<input name="real_gross_profit_per" class="layui-input"
									v-model="real_gross_profit_per" id="real_gross_profit_per"
									disabled>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								实际净利润
							</label>
							<div class="layui-input-inline">
								<input name="net_profit" class="layui-input"
									v-model="net_profit" id="net_profit" disabled>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								实际净利润%
							</label>
							<div class="layui-input-inline">
								<input name="net_profit_per" class="layui-input"
									v-model="net_profit_per" id="net_profit_per" disabled>
							</div>
						</div>
						<shiro:hasAnyRoles name="ruoa,ruof,ruoh,ruod,ruob">
							<div class="layui-form-item model-form-footer"
								id="pending_wcp_actual_expenditure_btn"
								style="float: right; visibility: hidden">
								<button class="layui-btn layui-btn-danger"
									data-method="pending_reject" type="button">
									驳回
								</button>
								<button class="layui-btn" data-method="pending_agree" lay-submit>
									通过
								</button>
							</div>
						</shiro:hasAnyRoles>
					</form>
				</div>
			</div>
		</div>

	</div>
</div>
<script type="text/javascript"><!--


		layui.use(['jquery', 'layer', 'form', 'admin', 'laydate'],
		function() {
			var $ = layui.jquery,
			layer = layui.layer,
			form = layui.form,
			admin = layui.admin,
			laydate = layui.laydate;


			//VUE初始化
			var vm = new Vue({
				el: '#wcp_bonus_shares_div_vue',
				data: {
					invoice_number_required: 'N', //发票号码
					tax_rate_required: 'N' ,//税率
					shuie_benjin: '',
					amount_in_original_currency: 0, //价税合计
					tax_rate: 0, //税率
					idle_stock: 0, //呆料
					amount_of_tax: 0, //税额=价税合计*税率
					principal: 0, //本金=价税合计-税额
					applicant_department: 0,
					bill_type: 0,
					//cost_department: 0,
					project_area_department:'',
					cost_matters: 0,
					date_of_application: 0,
					date_of_occurrence: 0,
					invoice_number: '',
					item_classification: 0,
					name_of_applicant: 0,
					project_code: 0,
					project_leader: 0,
					project_name: 0,
					purpose_of_occurrence: 0,
					reimbursement_number: 0,
					tax_rate: 0,
					real_gross_profit:0,//实际毛利
					real_gross_profit_per:0,//实际毛利%
					net_profit:0,//净利润
					net_profit_per:0,//净利润%
					predict_gross_profit_per:0,//预估毛利
					predict_gross_profit:0,//预估毛利%
					predict_net_profit:0,//预测净利润
					predict_net_profit_per:0,//预测净利润%
					reject_value:0,
					agree_value:0,
					
				}
			});

			//通过ID获取相关信息
			$.post("queryWeakActualInfoAndProfitsByActualID", {
				id: admin.getTempData('id')
			},
			function(data) {
				if (data.code == 1) {
					layer.alert(data.info);
				} else {
					$('#wcp_actual_expenditure_add_to_table').removeClass("layui-btn-disabled").removeAttr("disabled");
					vm.amount_in_original_currency = data.info[0].amount_in_original_currency;
					vm.amount_of_tax = data.info[0].amount_of_tax;
					vm.applicant_department = data.info[0].applicant_department;
					vm.bill_type = data.info[0].bill_type;
					//vm.cost_department = data.info[0].cost_department;
					vm.cost_matters = data.info[0].cost_matters;
					vm.date_of_application = data.info[0].date_of_application;
					vm.date_of_occurrence = data.info[0].date_of_occurrence;
					vm.idle_stock = data.info[0].idle_stock;
					vm.invoice_number = data.info[0].invoice_number;
					vm.item_classification = data.info[0].item_classification;
					vm.name_of_applicant = data.info[0].name_of_applicant;
					vm.principal = data.info[0].principal;
					vm.project_code = data.info[0].project_code;
					vm.project_leader = data.info[0].project_leader;
					vm.project_name = data.info[0].project_name;
					vm.purpose_of_occurrence = data.info[0].purpose_of_occurrence;
					vm.reimbursement_number = data.info[0].reimbursement_number;
					vm.tax_rate = data.info[0].tax_rate;
					
					var project_quotation=data.project_quotation;//项目报价
					
					vm.real_gross_profit= data.real_gross_profit;//实际毛利
					vm.real_gross_profit_per= (data.real_gross_profit_per*100).toFixed(2)+"%";//实际毛利%
					vm.net_profit= data.net_profit;//实际净利润
					vm.net_profit_per=( data.net_profit_per*100).toFixed(2)+"%";//实际净利润%
					
					vm.predict_gross_profit = (data.predict_gross_profit).toFixed(2);//预估毛利
					vm.predict_gross_profit_per= (data.predict_gross_profit / project_quotation*100).toFixed(2)+"%";//预估毛利%
					vm.predict_net_profit = (data.predict_gross_profit*0.75).toFixed(2);//预测净利润
					vm.predict_net_profit_per = (data.predict_gross_profit*0.75/project_quotation*100).toFixed(2)+"%";//预测净利润%
					vm.project_area_department =admin.getTempData('project_area_department');
					
					if (vm.cost_matters == '外包人工费、水电(含税)' || vm.cost_matters == '材料费(含税)') {
						vm.invoice_number_required = 'required';
					} else {
						vm.invoice_number_required = 'N';
					}

					if (vm.bill_type == '增值税专用发票') {
						vm.shuie_benjin = vm.bill_type;
						vm.tax_rate_required = 'required';
					} else {
						vm.tax_rate_required = 'N';
					}
					//getProjectInfo(vm.project_code);
					
					if(data.info[0].audit_status==2010){
						vm.agree_value = 2020;
						vm.reject_value = 2012;
					}else if(data.info[0].audit_status==2020){
						vm.agree_value = 2030;
						vm.reject_value = 2022;
					}else if(data.info[0].audit_status==2030){
						vm.agree_value = 2040;
						vm.reject_value = 2032;
					}else if(data.info[0].audit_status==2040){
						vm.agree_value = 2041;
						vm.reject_value = 2042;
					}
					if(data.info[0].audit_status!=2041){
						$("#pending_wcp_actual_expenditure_btn").css("visibility","visible");
					}
				}
			},
			'json');
		 $('#pending_wcp_actual_expenditure_btn .layui-btn').on('click', function(){
		    var othis = $(this), method = othis.data('method');
		    active[method] ? active[method].call(this, othis) : '';
		   
		  });
  	var active = {
	pending_reject: function(){
	 layer.prompt({
  			formType: 0,
  			title: '请输入驳回理由',
	  		},
	  		function(value, index, elem) {
	  		$('.layui-btn').addClass("layui-btn-disabled").attr("disabled", "disabled");
	  		layer.load();
	  		
	      	  $.post("updataWeakCurrentProjectsActualExpenditureAuditStatusByID", 
	        			{
	        		  		audit_status:vm.reject_value
	        		  		,audit_info:value
	        		  		,id:admin.getTempData('id')
	        		  	},function(data) {
	        		  	layer.closeAll('loading');
	  					$('.layui-btn').removeClass("layui-btn-disabled").removeAttr("disabled");
	    				if (data.code == 0) {
  							layer.closeAll();
	    					layer.msg(data.info, {
	    						icon: 1
	    					});
	    				}
	    				else{
	    				layer.alert(data.info, {
	    					icon: 5
	    				});
	    				}
	        		},'json');
	  		})
        }
	  ,pending_agree: function(){
	  		$('.layui-btn').addClass("layui-btn-disabled").attr("disabled", "disabled");
	  		layer.load();
	   		$.post("updataWeakCurrentProjectsActualExpenditureAuditStatusByID", 
      			{
      		  		audit_status:vm.agree_value
      		  		,audit_info:'N'
      		  		,id:admin.getTempData('id')
      		  	},function(data) {
	        		  	layer.closeAll('loading');
	  			$('.layui-btn').removeClass("layui-btn-disabled").removeAttr("disabled");
  				if (data.code == 0) {
  					layer.closeAll();
  					layer.msg(data.info, {
  						icon: 1
  					});
  				}
  				else{
  				layer.alert(data.info, {
  					icon: 5
  				});
  				}
      		},'json');
	  } 
  }
		});
		//获取利润等信息
	/*function getProjectInfo(project_code){
 		$.ajax({
		type: "POST",
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		url: "queryWCProjectsSimpleDetailAllInfoByProjectCode",
		data: {
			project_code:project_code
		},
		beforeSend: function() {
			layer.load(0);
		},
		success: function(ajaxdata) {
			layer.closeAll('loading');
			var obj = JSON.parse(ajaxdata);
			if (obj.code == 1) {
				layer.alert(obj.info);
			} else if (obj.code == 0) {
				console.log(obj.info[0]);
				var ajaxdataObj=obj.info[0];
				
				var tax_credit_amount=ajaxdataObj.tax_credit_amount?null:0//抵税金额(增值税专用发票)
				subtotal_labor_material_costs=ajaxdataObj.subtotal_labor_material_costs?null:0//人工材料费用小计
				,tax_money=ajaxdataObj.tax_money?null:0//税额 6~11%
				,full_amount_of_tax=ajaxdataObj.full_amount_of_tax//税价全额
				console.log('full_amount_of_tax',full_amount_of_tax);
				
				
				var tax_reimbursement=0;//补税
				//当前数据：vm.amount_in_original_currency
				//毛利=税价全额-人工材料费用小计-管理费及税务小计
				//real_gross_profit= full_amount_of_tax -subtotal_labor_material_costs - subtotal_management_fees_and_taxes
				if (vm.cost_matters == '抵税金额(增值税专用发票)') {
						//人工材料费用小计
					subtotal_labor_material_costs=subtotal_labor_material_costs - vm.amount_in_original_currency;
					if((tax_money-(tax_credit_amount+vm.amount_in_original_currency))>0){
						//补税=(税额 6~11% - 抵税金额(增值税专用发票)) *0.12 + 税价全额*0.0005
						tax_reimbursement = (tax_money-(tax_credit_amount+vm.amount_in_original_currency)) *0.12 + full_amount_of_tax * 0.0005;
					}else{
						//补税=人工材料费用小计*0.0005
						tax_reimbursement = subtotal_labor_material_costs * 0.0005;
					}
					
				} else {
						subtotal_labor_material_costs=subtotal_labor_material_costs + vm.amount_in_original_currency;
						if((tax_money-tax_credit_amount)>0){
							//补税=(税额 6~11% - 抵税金额(增值税专用发票)) *0.12 + 税价全额*0.0005
							tax_reimbursement = (tax_money-tax_credit_amount) *0.12 + full_amount_of_tax * 0.0005;
						}else{
							//补税=人工材料费用小计*0.0005
							tax_reimbursement = subtotal_labor_material_costs * 0.0005;
						}
					
				}
				//管理费及税务小计=管理成本2% +(财务填)补税
				//subtotal_management_fees_and_taxes = management_costs + tax_reimbursement	
				var management_costs = full_amount_of_tax * 0.02;
				var subtotal_management_fees_and_taxes =  management_costs + tax_reimbursement;
				
				//预估毛利=税价全额-人工材料费用小计-管理费及税务小计
				vm.predict_gross_profit=( full_amount_of_tax -subtotal_labor_material_costs - subtotal_management_fees_and_taxes).toFixed(2);
				//预估毛利%=实际毛利/税价全额
				vm.predict_gross_profit_per =( vm.predict_gross_profit / full_amount_of_tax).toFixed(2);
				//预估净利润=实际毛利*0.75
				vm.predict_net_profit = (vm.predict_gross_profit * 0.75).toFixed(2);
				//预估净利%=净利润/税价全额
				vm.predict_net_profit_per = (vm.predict_net_profit / full_amount_of_tax).toFixed(2);
				
				
				
				console.log('预估毛利=税价全额-人工材料费用小计-管理费及税务小计','real_gross_profit= full_amount_of_tax -subtotal_labor_material_costs - subtotal_management_fees_and_taxes');
				console.log('real_gross_profit',real_gross_profit);
				console.log('subtotal_labor_material_costs',subtotal_labor_material_costs);
				console.log('subtotal_management_fees_and_taxes',subtotal_management_fees_and_taxes);
				console.log('税价全额',full_amount_of_tax);
				console.log('人工材料费用小计',subtotal_labor_material_costs);
				console.log('管理费及税务小计=管理成本2% +(财务填)补税');
				console.log('----------------管理成本2% = 税价全额*0.02',full_amount_of_tax * 0.02);
				console.log('----------------(财务填)补税',tax_reimbursement);
			}else{
				layer.msg('未知错误，获取项目数据失败', {
					icon: 5
				});
			}
		},
		complete: function() {
			layer.closeAll('loading');
		},
		error: function(xhr) {
			layer.closeAll('loading');
			if (xhr.status == 400) {
				layer.msg('未知错误', {
					icon: 5
				});
			}
		}
	});
	}*/
</script>