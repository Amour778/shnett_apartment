<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
	<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
		<table class="layui-table" id="show_summary_info_VUE" lay-even>
			<caption v-html="project_code">
				{{project_code}}
			</caption>
			<thead>
				<tr>
					<th>
						字段
					</th>
					<th>
						立项时数据
					</th>
					<th  style='background-color: #baa592; color: #fff;'>
						现数据
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						项目名称
					</td>
					<td>
						{{ project_name_histoy}}
					</td>
					<td v-html="project_name"  style='background-color: #baa592; color: #fff;'>
						{{project_name}}
					</td>
				</tr>
				<tr>
					<td>
						项目区部
					</td>
					<td>
						{{ project_area_department_histoy}}
					</td>
					<td v-html="project_area_department" style='background-color: #baa592; color: #fff;'>
						{{ project_area_department}}
					</td>
				</tr>
				<tr>
					<td>
						区部名称
					</td>
					<td>
						{{ district_name_histoy}}
					</td>
					<td v-html="district_name" style='background-color: #baa592; color: #fff;'>
						{{ district_name}}
					</td>
				</tr>
				<tr>
					<td>
						项目分类
					</td>
					<td>
						{{ item_classification_histoy}}
					</td>
					<td v-html="item_classification" style='background-color: #baa592; color: #fff;'>
						{{ item_classification}}
					</td>
				</tr>
				<tr>
					<td>
						客户名称
					</td>
					<td>
						{{ ustomer_name_histoy}}
					</td>
					<td v-html="ustomer_name" style='background-color: #baa592; color: #fff;'>
						{{ ustomer_name}}
					</td>
				</tr>
				<tr>
					<td>
						计划启动时间
					</td>
					<td>
						{{ planned_start_time_histoy}}
					</td>
					<td v-html="planned_start_time" style='background-color: #baa592; color: #fff;'>
						{{ planned_start_time}}
					</td>
				</tr>
				<tr>
					<td>
						预计完成时间
					</td>
					<td>
						{{ planned_end_time_histoy}}
					</td>
					<td v-html="planned_end_time" style='background-color: #baa592; color: #fff;'>
						{{ planned_end_time}}
					</td>
				</tr>
				<tr>
					<td>
						项目周期
					</td>
					<td>
						{{ project_cycle_histoy}}
					</td>
					<td v-html="project_cycle" style='background-color: #baa592; color: #fff;'>
						{{ project_cycle}}
					</td>
				</tr>
				<tr>
					<td>
						项目报价
					</td>
					<td>
						{{ project_quotation_histoy}}
					</td>
					<td v-html="project_quotation" style='background-color: #baa592; color: #fff;'>
						{{ project_quotation}}
					</td>
				</tr>
				<tr>
					<td>
						项目负责人
					</td>
					<td>
						{{ project_leader_histoy}}
					</td>
					<td v-html="project_leader" style='background-color: #baa592; color: #fff;'>
						{{ project_leader}}
					</td>
				</tr>
				<tr>
					<td>
						项目备注
					</td>
					<td>
						{{ edit_remark_histoy}}
					</td>
					<td v-html="edit_remark" style='background-color: #baa592; color: #fff;'>
						{{ edit_remark}}
					</td>
				</tr>
				<tr>
					<td>
						材料
					</td>
					<td>
						{{ material_histoy}}
					</td>
					<td v-html="material" style='background-color: #baa592; color: #fff;'>
						{{ material}}
					</td>
				</tr>
				<tr>
					<td>
						人工(外请)
					</td>
					<td>
						{{ labor_histoy}}
					</td>
					<td v-html="labor" style='background-color: #baa592; color: #fff;'>
						{{ labor}}
					</td>
				</tr>
				<tr>
					<td>
						固定资产分摊
					</td>
					<td>
						{{ allocation_of_fixed_assets_histoy}}
					</td>
					<td v-html="allocation_of_fixed_assets" style='background-color: #baa592; color: #fff;'>
						{{ allocation_of_fixed_assets}}
					</td>
				</tr>
				<tr>
					<td>
						其他项
					</td>
					<td>
						{{ other_items_histoy}}
					</td>
					<td v-html="other_items" style='background-color: #baa592; color: #fff;'>
						{{ other_items}}
					</td>
				</tr>
				<tr>
					<td>
						费用小计
					</td>
					<td>
						{{ subtotal_cost_histoy}}
					</td>
					<td v-html="subtotal_cost" style='background-color: #baa592; color: #fff;'>
						{{ subtotal_cost}}
					</td>
				</tr>
				<tr>
					<td>
						税率
					</td>
					<td>
						{{ simple_tax_histoy}}
					</td>
					<td v-html="simple_tax" style='background-color: #baa592; color: #fff;'>
						{{ simple_tax}}
					</td>
				</tr>
				
				<tr>
					<td>
						可开票增专金额
					</td>
					<td>
						{{ special_vat_invoice_amount_histoy}}
					</td>
					<td v-html="special_vat_invoice_amount" style='background-color: #baa592; color: #fff;'>
						{{ special_vat_invoice_amount}}
					</td>
				</tr>
				<tr>
					<td>
						普票金额
					</td>
					<td>
						{{ ordinary_invoice_amount_histoy}}
					</td>
					<td v-html="ordinary_invoice_amount" style='background-color: #baa592; color: #fff;'>
						{{ ordinary_invoice_amount}}
					</td>
				</tr>
				<tr>
					<td>
						供应商抵扣税率
					</td>
					<td>
						{{ supplier_invoice_tax_histoy}}
					</td>
					<td v-html="supplier_invoice_tax" style='background-color: #baa592; color: #fff;'>
						{{ supplier_invoice_tax}}
					</td>
				</tr>
				<tr>
					<td>
						供应商开票抵税金额
					</td>
					<td>
						{{ supplier_invoice_histoy}}
					</td>
					<td v-html="supplier_invoice" style='background-color: #baa592; color: #fff;'>
						{{ supplier_invoice}}
					</td>
				</tr>
				<tr>
					<td>
						预估毛利
					</td>
					<td>
						{{ predict_gross_profit_histoy}}
					</td>
					<td v-html="predict_gross_profit" style='background-color: #baa592; color: #fff;'>
						{{ predict_gross_profit}}
					</td>
				</tr>
				<tr>
					<td>
						预估毛利%
					</td>
					<td>
						{{ predict_gross_profit_per_histoy}}
					</td>
					<td v-html="predict_gross_profit_per" style='background-color: #baa592; color: #fff;'>
						{{ predict_gross_profit_per}}
					</td>
				</tr>
				<tr>
					<td>
						预估净利润
					</td>
					<td>
						{{ predict_net_profit_histoy}}
					</td>
					<td v-html="predict_net_profit" style='background-color: #baa592; color: #fff;'>
						{{ predict_net_profit}}
					</td>
				</tr>
				<tr>
					<td>
						预估净利润%
					</td>
					<td>
						{{ predict_net_profit_per_histoy}}
					</td>
					<td v-html="predict_net_profit_per" style='background-color: #baa592; color: #fff;'>
						{{ predict_net_profit_per}}
					</td>
				</tr>
		</table>
		
		<!-- 大区负责人 -->
		<script id="show_wcp_simple_view_head" type="text/html">
			{{# if (d.audit_status === 1010) {}} 
				<button data-method="agree_head" class ="layui-btn">立项-大区负责人-同意 </button>
			{{# } }} 
			{{# if(d.audit_status===1010||d.audit_status===1011){ }}
				<button data-method="reject_head" class="layui-btn layui-btn-danger">立项-大区负责人-驳回</button > 
			{{# }}}
		</script>
		<!-- 管理员 -->
		<script id="show_wcp_simple_view_admin" type="text/html">
				{{# if (d.audit_status === 1020) {}} 
					<button data-method="agree_admin" class ="layui-btn" >立项-管理员-同意 </button>
				{{#  } }}
				{{# if(d.audit_status===1020||d.audit_status===1021){ }}
  					<button data-method="reject_admin" class="layui-btn layui-btn-danger">立项-管理员-驳回</button > 
				{{# }}}
		</script>
		<!-- TEMP_VIEW -->
		<div id="temp_view">
			<shiro:hasRole name="ruod">
				<div class="layui-btn-container" id="show_wcp_simple_view_head_view" style="float:right">
				</div>
			</shiro:hasRole>
			<shiro:hasRole name="ruoa">
				<div class="layui-btn-container" id="show_wcp_simple_view_admin_view"
				style="float:right">
				</div>
			</shiro:hasRole>
		</div>
		<script type="text/javascript">
			layui.use(['form', 'table', 'layer', 'admin', 'jquery', 'laytpl'],
			function() {
				var form = layui.form,
				$ = layui.jquery,
				layer = layui.layer,
				admin = layui.admin,
				laytpl = layui.laytpl,
				table = layui.table;
				var vm = new Vue({
					el: '#show_summary_info_VUE',
					data: {
						project_code: '',
						project_name: '',
						project_area_department: '',
						district_name: '',
						item_classification: '',
						ustomer_name: '',
						planned_start_time: '',
						planned_end_time: '',
						project_cycle: '',
						project_quotation: '',
						project_leader: '',
						material: '',
						labor: '',
						allocation_of_fixed_assets: '',
						other_items: '',
						subtotal_cost: '',
						simple_tax: '',
						submitter: '',
						project_name_histoy: '',
						project_area_department_histoy: '',
						district_name_histoy: '',
						item_classification_histoy: '',
						ustomer_name_histoy: '',
						planned_start_time_histoy: '',
						planned_end_time_histoy: '',
						project_cycle_histoy: '',
						project_quotation_histoy: '',
						project_leader_histoy: '',
						material_histoy: '',
						labor_histoy: '',
						allocation_of_fixed_assets_histoy: '',
						other_items_histoy: '',
						subtotal_cost_histoy: '',
						simple_tax_histoy: '',
						submitter_histoy: '',
						audit_status: null,
						cost_share: 0,
						//可开票增专金额
						special_vat_invoice_amount_histoy: '',
						//普票金额
						ordinary_invoice_amount_histoy: '',
						//供应商抵扣税率
						supplier_invoice_tax_histoy: '',
						//供应商开票抵税金额
						supplier_invoice_histoy: '',
						//预估毛利
						predict_gross_profit_histoy: '',
						//预估毛利%
						predict_gross_profit_per_histoy: '',
						//预估净利润
						predict_net_profit_histoy: '',
						//预估净利润%
						predict_net_profit_per_histoy: '',
						
						//可开票增专金额
						special_vat_invoice_amount: '',
						//普票金额
						ordinary_invoice_amount: '',
						//供应商抵扣税率
						supplier_invoice_tax: '',
						//供应商开票抵税金额
						supplier_invoice: '',
						//预估毛利
						predict_gross_profit: '',
						//预估毛利%
						predict_gross_profit_per: '',
						//预估净利润
						predict_net_profit: '',
						//预估净利润%
						predict_net_profit_per: '',
						//项目说明
						edit_remark:'',
						edit_remark_histoy:'',
					}
				});
				admin.ajax_load_json({
					url: "queryWeakCurrentProjectsSimpleToShow",
					dataType: 'json',
					data: {
						project_code: admin.getTempData('project_code')
					},
					success: function(data) {
						if (data.code == 1) {
							layer.msg(data.info);
						} else {
							vm.audit_status = data.infoOne[0].audit_status;

							vm.project_code = data.infoOne[0].project_code;
							vm.project_name = data.infoOne[0].project_name;
							vm.project_area_department = data.infoOne[0].project_area_department;
							vm.district_name = data.infoOne[0].district_name;
							vm.item_classification = data.infoOne[0].item_classification;
							vm.ustomer_name = data.infoOne[0].ustomer_name;

							vm.planned_start_time = data.infoOne[0].planned_start_time;
							vm.planned_end_time = data.infoOne[0].planned_end_time;
							vm.project_cycle = data.infoOne[0].project_cycle;
							vm.project_quotation = data.infoOne[0].project_quotation;
							vm.project_leader = data.infoOne[0].project_leader;

							vm.material = data.infoOne[0].material;
							vm.labor = data.infoOne[0].labor;
							vm.allocation_of_fixed_assets = data.infoOne[0].allocation_of_fixed_assets;
							vm.other_items = data.infoOne[0].other_items;
							vm.subtotal_cost = data.infoOne[0].subtotal_cost;

							vm.simple_tax = data.infoOne[0].simple_tax * 100 + "%";
							vm.submitter = data.infoOne[0].submitter;
							vm.cost_share = vm.subtotal_cost / vm.project_quotation;
							
							//可开票增专金额
							vm.special_vat_invoice_amount=data.infoOne[0].special_vat_invoice_amount;
							//普票金额
							vm.ordinary_invoice_amount=data.infoOne[0].ordinary_invoice_amount;
							//供应商抵扣税率
							vm.supplier_invoice_tax=data.infoOne[0].supplier_invoice_tax;
							//供应商开票抵税金额
							vm.supplier_invoice=data.infoOne[0].supplier_invoice;
							//预估毛利
							vm.predict_gross_profit=data.infoOne[0].predict_gross_profit;
							//预估毛利%
							vm.predict_gross_profit_per=data.infoOne[0].predict_gross_profit_per;
							//预估净利润
							vm.predict_net_profit=data.infoOne[0].predict_net_profit;
							//预估净利润%
							vm.predict_net_profit_per=data.infoOne[0].predict_net_profit_per;
							vm.edit_remark=data.infoOne[0].edit_remark;
							
							if (vm.audit_status == '1030') { //1013表示项目撤项
								vm.project_code = vm.project_code + " <b style='color:red'>已撤项</b>";
								console.log("vm.project_code", vm.project_code);
								return;
							}
							vm.project_name_histoy = data.infoTwo[0].project_name;
							vm.project_area_department_histoy = data.infoTwo[0].project_area_department;
							vm.district_name_histoy = data.infoTwo[0].district_name;
							vm.item_classification_histoy = data.infoTwo[0].item_classification;
							vm.ustomer_name_histoy = data.infoTwo[0].ustomer_name;

							vm.planned_start_time_histoy = data.infoTwo[0].planned_start_time;
							vm.planned_end_time_histoy = data.infoTwo[0].planned_end_time;
							vm.project_cycle_histoy = data.infoTwo[0].project_cycle;
							vm.project_quotation_histoy = data.infoTwo[0].project_quotation;
							vm.project_leader_histoy = data.infoTwo[0].project_leader;

							vm.material_histoy = data.infoTwo[0].material;
							vm.labor_histoy = data.infoTwo[0].labor;
							vm.allocation_of_fixed_assets_histoy = data.infoTwo[0].allocation_of_fixed_assets;
							vm.other_items_histoy = data.infoTwo[0].other_items;
							vm.subtotal_cost_histoy = data.infoTwo[0].subtotal_cost;

							vm.simple_tax_histoy = data.infoTwo[0].simple_tax * 100 + "%";
							vm.submitter_histoy = data.infoTwo[0].submitter;

							vm.edit_remark_histoy=data.infoTwo[0].edit_remark;
							//可开票增专金额
							vm.special_vat_invoice_amount_histoy=data.infoTwo[0].special_vat_invoice_amount;
							//普票金额
							vm.ordinary_invoice_amount_histoy=data.infoTwo[0].ordinary_invoice_amount;
							//供应商抵扣税率
							vm.supplier_invoice_tax_histoy=data.infoTwo[0].supplier_invoice_tax;
							//供应商开票抵税金额
							vm.supplier_invoice_histoy=data.infoTwo[0].supplier_invoice;
							//预估毛利
							vm.predict_gross_profit_histoy=data.infoTwo[0].predict_gross_profit;
							//预估毛利%
							vm.predict_gross_profit_per_histoy=data.infoTwo[0].predict_gross_profit_per;
							//预估净利润
							vm.predict_net_profit_histoy=data.infoTwo[0].predict_net_profit;
							//预估净利润%
							vm.predict_net_profit_per_histoy=data.infoTwo[0].predict_net_profit_per;
							if (vm.project_name_histoy != vm.project_name) {
								vm.project_name = "<b style='color:red'>" + vm.project_name + "</b>";
							}
							if (vm.project_area_department_histoy != vm.project_area_department) {
								vm.project_area_department = "<b style='color:red'>" + vm.project_area_department + "</b>";
							}
							if (vm.district_name_histoy != vm.district_name) {
								vm.district_name = "<b style='color:red'>" + vm.district_name + "</b>";
							}
							if (vm.item_classification_histoy != vm.item_classification) {
								vm.item_classification = "<b style='color:red'>" + vm.item_classification + "</b>";
							}
							if (vm.ustomer_name_histoy != vm.ustomer_name) {
								vm.ustomer_name = "<b style='color:red'>" + vm.ustomer_name + "</b>";
							}
							if (vm.planned_start_time_histoy != vm.planned_start_time) {
								vm.planned_start_time = "<b style='color:red'>" + vm.planned_start_time + "</b>";
							}
							if (vm.planned_end_time_histoy != vm.planned_end_time) {
								vm.planned_end_time = "<b style='color:red'>" + vm.planned_end_time + "</b>";
							}
							if (vm.project_cycle_histoy != vm.project_cycle) {
								vm.project_cycle = "<b style='color:red'>" + vm.project_cycle + "</b>";
							}
							if (vm.project_quotation_histoy != vm.project_quotation) {
								vm.project_quotation = "<b style='color:red'>" + vm.project_quotation + "</b>";
							}
							if (vm.project_leader_histoy != vm.project_leader) {
								vm.project_leader = "<b style='color:red'>" + vm.project_leader + "</b>";
							}
							if (vm.material_histoy != vm.material) {
								vm.material = "<b style='color:red'>" + vm.material + "</b>";
							}
							if (vm.labor_histoy != vm.labor) {
								vm.labor = "<b style='color:red'>" + vm.labor + "</b>";
							}
							if (vm.allocation_of_fixed_assets_histoy != vm.allocation_of_fixed_assets) {
								vm.allocation_of_fixed_assets = "<b style='color:red'>" + vm.allocation_of_fixed_assets + "</b>";
							}
							if (vm.other_items_histoy != vm.other_items) {
								vm.other_items = "<b style='color:red'>" + vm.other_items + "</b>";
							}
							if (vm.subtotal_cost_histoy != vm.subtotal_cost) {
								vm.subtotal_cost = "<b style='color:red'>" + vm.subtotal_cost + "</b>";
							}
							if (vm.simple_tax_histoy != vm.simple_tax) {
								vm.simple_tax = "<b style='color:red'>" + vm.simple_tax + "</b>";
							}
							if (vm.submitter_histoy != vm.submitter) {
								vm.submitter = "<b style='color:red'>" + vm.submitter + "</b>";
							}
							
							
							
							if (vm.special_vat_invoice_amount_histoy != vm.special_vat_invoice_amount) {
								vm.special_vat_invoice_amount = "<b style='color:red'>" + vm.special_vat_invoice_amount + "</b>";
							}
							if (vm.ordinary_invoice_amount_histoy != vm.ordinary_invoice_amount) {
								vm.ordinary_invoice_amount = "<b style='color:red'>" + vm.ordinary_invoice_amount + "</b>";
							}
							if (vm.supplier_invoice_tax_histoy != vm.supplier_invoice_tax) {
								vm.supplier_invoice_tax = "<b style='color:red'>" + vm.supplier_invoice_tax + "</b>";
							}
							if (vm.supplier_invoice_histoy != vm.supplier_invoice) {
								vm.supplier_invoice = "<b style='color:red'>" + vm.supplier_invoice + "</b>";
							}
							if (vm.predict_gross_profit_histoy != vm.predict_gross_profit) {
								vm.predict_gross_profit = "<b style='color:red'>" + vm.predict_gross_profit + "</b>";
							}
							if (vm.predict_gross_profit_per_histoy != vm.predict_gross_profit_per) {
								vm.predict_gross_profit_per = "<b style='color:red'>" + vm.predict_gross_profit_per + "</b>";
							}
							if (vm.predict_net_profit_histoy != vm.predict_net_profit) {
								vm.predict_net_profit = "<b style='color:red'>" + vm.predict_net_profit + "</b>";
							}
							if (vm.predict_net_profit_per_histoy != vm.predict_net_profit_per) {
								vm.predict_net_profit_per = "<b style='color:red'>" + vm.predict_net_profit_per + "</b>";
							}
							
							///////////
							console.log('data.infoOne[0].audit_status', data.infoOne[0].audit_status);
							var laytpldata = {
								"audit_status": data.infoOne[0].audit_status
							}
							var getTpl = show_wcp_simple_view_admin.innerHTML,
							show_wcp_simple_view_admin_view = document.getElementById('show_wcp_simple_view_admin_view');
							laytpl(getTpl).render(laytpldata,
							function(html) {
								if (show_wcp_simple_view_admin_view != null) {
									console.log(html);
									show_wcp_simple_view_admin_view.innerHTML = html;
								}
							});
							var getTpl = show_wcp_simple_view_head.innerHTML,
							show_wcp_simple_view_head_view = document.getElementById('show_wcp_simple_view_head_view');
							laytpl(getTpl).render(laytpldata,
							function(html) {
								if (show_wcp_simple_view_head_view != null) {
									console.log(html);
									show_wcp_simple_view_head_view.innerHTML = html;
								}
							});
							$('#temp_view .layui-btn').on('click',
							function() {
								var othis = $(this),
								method = othis.data('method');
								active[method] ? active[method].call(this, othis) : '';
							});
							var active = {
								agree_head: function() {
									admin.ajax_load_json({
										url: 'updataWeakCurrentProjectsSimpleAuditStatusByProjectCode',
										data: {
											audit_status: 1020,
											audit_info: 'N',
											project_code: vm.project_code,
											cost_share: vm.cost_share
										},
										success: function(data, status, xhr) {
											if (data.code == 0) {
												layer.closeAll();
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
								},
								reject_head: function() {
									layer.prompt({
										formType: 0,
										title: '请输入驳回理由',
									},
									function(value, index, elem) {
										admin.ajax_load_json({
											url: 'updataWeakCurrentProjectsSimpleAuditStatusByProjectCode',
											data: {
												audit_status: 1012,
												audit_info: value,
												project_code: vm.project_code,
												cost_share: 0
											},
											success: function(data, status, xhr) {
													if (data.code == 0) {
													layer.closeAll();
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
									})

								},
								agree_admin: function() {
										admin.ajax_load_json({
											url: 'updataWeakCurrentProjectsSimpleAuditStatusByProjectCode',
											data: {
												audit_status: 1021,
										audit_info: 'N',
										project_code: vm.project_code,
										cost_share: vm.cost_share
											},
											success: function(data, status, xhr) {
												if (data.code == 0) {
											layer.closeAll();
											layer.msg(data.info, {
												icon: 1
											});
										} else {
											layer.alert(data.info, {icon: 5});
											}
										}
									});
								
								},
								reject_admin: function() {
									layer.prompt({
										formType: 0,
										title: '请输入驳回理由',
									},
									function(value, index, elem) {
										admin.ajax_load_json({
											url: 'updataWeakCurrentProjectsSimpleAuditStatusByProjectCode',
											data: {
												audit_status: 1022,
											audit_info: value,
											project_code: vm.project_code,
											cost_share: 0
											},
											success: function(data, status, xhr) {
												if (data.code == 0) {
												layer.closeAll();
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
									})

								}
							}
						}
					}
				});

			});
		</script>