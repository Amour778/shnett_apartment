<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<div id="wcp_bonus_shares_div_vue">
	<div class="layui-card">
		<div class="layui-card-body">
			<form class="layui-form" action="" onsubmit="return false"
				id="table_from"><!--
				<div class="layui-form-item">
					<label class="layui-form-label">
						费用所属部门
					</label>
					<div class="layui-input-inline">
						<input name="cost_department" required lay-verify="required"
							class="layui-input" v-model="cost_department"
							id="cost_department" id="cost_department" disabled>
						
					</div>
				</div>
				--><div class="layui-form-item">
					<label class="layui-form-label">
						报销工号
					</label>
					<div class="layui-input-inline">
						<input type="text" name="reimbursement_number" required
							lay-verify="required" autocomplete="off"
							class="layui-input" id="reimbursement_number"
							v-model="reimbursement_number" disabled>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						申请人姓名
					</label>
					<div class="layui-input-inline">
						<input type="text" name="name_of_applicant" required
							lay-verify="required" autocomplete="off"
							class="layui-input" id="name_of_applicant"
							v-model="name_of_applicant" disabled>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						票据类型
					</label>
					<div class="layui-input-inline">
						<input name="bill_type" v-model="bill_type" required
							lay-verify="required" lay-filter="bill_type" class="layui-input"
							id="bill_type" disabled>
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
							class="layui-input" disabled>
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
						<input type="text" name="invoice_number" v-model="invoice_number"
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
<script type="text/javascript">
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
					tax_rate_required: 'N', //税率
					shuie_benjin: '',
					amount_in_original_currency: 0, //价税合计
					tax_rate: 0, //税率
					idle_stock: 0, //呆料
					amount_of_tax: 0, //税额=价税合计*税率
					principal: 0, //本金=价税合计-税额
					applicant_department: 0,
					bill_type: 0,
					//cost_department: 0,
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
					tax_rate: 0
				}
			});

			admin.ajax_load_json({
				url:"querySimpleInfoByID",
				data:{
					id: admin.getTempData('id')
				},
				success:function(data){
				
				if (data.code == 1) {
					layer.alert(data.info);
				} else {
					//$('#wcp_actual_expenditure_add_to_table').removeClass("layui-btn-disabled").removeAttr("disabled");
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
				}
				}
			})
			//通过ID获取相关信息


		});
	</script>