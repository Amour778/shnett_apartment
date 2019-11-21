<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <table  class="layui-table layui-text" id="show_summary_info_VUE" lay-even>
        <tbody>
        <tr>
            <td width="100px">项目编码</td>
            <td colspan="2">{{ project_code }}</td>
        </tr>
        <tr>
            <td width="100px">项目区部</td>
            <td colspan="2">{{ project_area_department }}</td>
        </tr>
        <tr>
            <td width="100px">区部名称</td>
            <td colspan="2">{{ district_name }}</td>
        </tr>
        <tr>
            <td width="100px">项目分类</td>
            <td colspan="2">{{ item_classification }}</td>
        </tr>
        <tr>
            <td width="100px">客户名称</td>
            <td colspan="2">{{ ustomer_name }}</td>
        </tr>
        <tr>
            <td width="100px">计划启动时间</td>
            <td colspan="2">{{ planned_start_time }}</td>
        </tr>
        <tr>
            <td width="100px">预计完成时间</td>
            <td colspan="2">{{ planned_end_time }}</td>
        </tr>
        <tr>
            <td width="100px">项项目名称</td>
            <td colspan="2">{{ project_name }}</td>
        </tr>
        <tr>
            <td width="100px">项目周期</td>
            <td colspan="2">{{ project_cycle }}</td>
        </tr>
        <tr>
            <td width="100px">项目进度</td>
            <td colspan="2">{{ project_progress }}</td>
        </tr>
        <tr>
            <td width="100px">项目报价</td>
            <td colspan="2">{{ project_quotation }}</td>
        </tr>
        <tr>
            <td width="100px">项目负责人</td>
            <td colspan="2">{{ project_leader }}</td>
        </tr>
       
        <tr>
            <td rowspan="6" valign="middle" align="center"  width="100px">成本估算</td>

            <td align="left" width="100px">材料</td>
            <td>{{ material}}</td>
        </tr>
        <tr>
            <td align="left" width="100px">人工(外请)</td>
            <td>{{ labor }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">固定资产分摊 </td>
            <td>{{ allocation_of_fixed_assets }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">其他项</td>
            <td>{{ other_items }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">费用小计</td>
            <td>{{ subtotal_cost }}</td>
        </tr>
       
        <tr>
            <td width="100px">成本占比%</td>
            <td colspan="2">{{ cost_share }}</td>
        </tr>
        
        <tr>
            <td width="100px">税率</td>
            <td colspan="2">{{ simple_tax }}</td>
        </tr>
       
        <tr>
            <td width="100px">实际完工日(验收日)</td>
            <td colspan="2">{{ actual_completion_date }}</td>
        </tr>
       
        <tr>
            <td width="100px">项目结单日</td>
            <td colspan="2">{{ project_closing_day }}</td>
        </tr>
       
        <tr>
            <td rowspan="7" valign="middle" align="center"  width="100px">实际开支</td>

            <td align="left" width="100px">材料费(含税)</td>
            <td>{{ material_cost_including_tax }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">抵税金额(增值税专用发票)</td>
            <td>{{ tax_credit_amount }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">外包人工费、水电(含税) </td>
            <td>{{ outsourcing_including_tax }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">运杂费</td>
            <td>{{ transport_fees }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">工具固定资产分摊</td>
            <td>{{ allocation_of_fixed_assets_of_instruments }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">招待</td>
            <td>{{ entertain }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">人工材料费用小计</td>
            <td>{{ subtotal_labor_material_costs }}</td>
        </tr>
        
        <tr>
            <td rowspan="3" valign="middle" align="center"  width="100px">税务管理</td>

            <td align="left" width="100px">管理成本2%</td>
            <td>{{ management_costs }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">(财务填)补税</td>
            <td>{{ tax_reimbursement }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">管理费及税务小计 </td>
            <td>{{ subtotal_management_fees_and_taxes }}</td>
        </tr>

        
        <tr>
            <td width="100px">余材库存</td>
            <td colspan="2">{{ remaining_stock }}</td>
        </tr>
        
         <tr>
            <td rowspan="3" valign="middle" align="center"  width="100px">开票金额 </td>

            <td align="left" width="100px">本金</td>
            <td>{{ principal }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">税额 6~11%</td>
            <td>{{ tax_money }}</td>
        </tr>
        <tr>
            <td align="left" width="100px">税价全额 </td>
            <td>{{ full_amount_of_tax }}</td>
        </tr>
        
        
        <tr>
            <td width="100px">实际毛利</td>
            <td colspan="2">{{ real_gross_profit }}</td>
        </tr>
        <tr>
            <td width="100px">实际毛利%</td>
            <td colspan="2">{{ real_gross_profit_per }}</td>
        </tr>
        <tr>
            <td width="100px">余料毛利</td>
            <td colspan="2">{{ surplus_gross_profit }}</td>
        </tr>
        <tr>
            <td width="100px">余料毛利%</td>
            <td colspan="2">{{ surplus_gross_profit_per }}</td>
        </tr>

        <tr>
            <td width="100px">净利润</td>
            <td colspan="2">{{ net_profit }}</td>
        </tr>
        <tr>
            <td width="100px">净利润%</td>
            <td colspan="2">{{ net_profit_per }}</td>
        </tr>
        
        <tr>
			<td width="100px">可开票增专金额</td>
			<td colspan="2">{{ special_vat_invoice_amount}}</td>
		</tr>
		<tr>
			<td width="100px">普票金额</td>
			<td colspan="2">{{ ordinary_invoice_amount}}</td>
		</tr>
		<tr>
			<td width="100px">供应商抵扣税率</td>
			<td colspan="2">{{ supplier_invoice_tax}}</td>
		</tr>
		<tr>
			<td width="100px">供应商开票抵税金额</td>
			<td colspan="2">{{ supplier_invoice}}</td>
		</tr>
		<tr>
			<td width="100px">预估毛利</td>
			<td colspan="2">{{ predict_gross_profit}}</td>
		</tr>
		<tr>
			<td width="100px">预估毛利%</td>
			<td colspan="2">{{ predict_gross_profit_per}}</td>
		</tr>
		<tr>
			<td width="100px">预估净利润</td>
			<td colspan="2">{{ predict_net_profit}}</td>
		</tr>
		<tr>
			<td width="100px">预估净利润%</td>
			<td colspan="2">{{ predict_net_profit_per}}</td>
		</tr>
        <tr>
            <td width="100px">已收款金额</td>
            <td colspan="2">{{ received_amount }}</td>
        </tr>
        <tr>
            <td width="100px">待收金额</td>
            <td colspan="2">{{ amount_to_be_collected }}</td>
        </tr>
        <tr>
            <td width="100px">个人25%</td>
            <td colspan="2">{{ personal }}</td>
        </tr>
        <tr>
            <td width="100px">资金池25%</td>
            <td colspan="2">{{ capital_pool }}</td>
        </tr>
        <tr>
            <td width="100px">公司50%</td>
            <td colspan="2">{{ company }}</td>
        </tr>
        <tr>
            <td width="100px">是否有质保金</td>
            <td colspan="2">{{ returned_money_ishave }}</td>
        </tr>
        <tr>
            <td width="100px">质保金点数</td>
            <td colspan="2">{{ returned_money_point }}</td>
        </tr>
                <tr>
            <td width="100px">质保金</td>
            <td colspan="2">{{ quality_assurance_funds }}</td>
        </tr>
        <tr>
            <td width="100px">质保金回款日期</td>
            <td colspan="2">{{ returned_money_date }}</td>
        </tr>
        <tr>
            <td width="100px">提醒日期</td>
            <td colspan="2">{{ reminder_date }}</td>
        </tr>
        <tr>
            <td width="100px">个人质保金</td>
            <td colspan="2">{{ personal_warranty }}</td>
        </tr>
        <tr>
            <td width="100px">个人实际发放</td>
            <td colspan="2">{{ personal_actual_distribution }}</td>
        </tr>
    </table>
	<script type="text/javascript">
		layui.use(['form', 'table', 'layer', 'admin', 'jquery'],
		function() {
			var form = layui.form,
			$ = layui.jquery,
			layer = layui.layer,
			admin = layui.admin,
			table = layui.table;
			var vm = new Vue({
		      el: '#show_summary_info_VUE',
		      data: {
		      	project_code:'',
		        project_name:'',
				audit_status:'',
				audit_info:'',
				project_area_department:'',
				district_name:'',
				item_classification:'',
				ustomer_name:'',
				planned_start_time:'',
				planned_end_time:'',
				project_cycle:'',
				project_progress:'',
				project_quotation:'',
				project_leader:'',
				simple_tax:'',
				cost_share:'',
				actual_completion_date:'',
				project_closing_day:'',
				remaining_stock:'',
				real_gross_profit:'',
				real_gross_profit_per:'',
				surplus_gross_profit:'',
				surplus_gross_profit_per:'',
				quality_assurance_funds:'',
				net_profit:'',
				net_profit_per:'',
				received_amount:'',
				amount_to_be_collected:'',
				personal:'',
				capital_pool:'',
				company:'',
				returned_money_ishave:'',
				returned_money_date:'',
				returned_money_point:'',
				reminder_date:'',
				personal_warranty:'',
				personal_actual_distribution:'',
				material:'',
				labor:'',
				allocation_of_fixed_assets:'',
				other_items:'',
				subtotal_cost:'',
				material_cost_including_tax:'',
				tax_credit_amount:'',
				outsourcing_including_tax:'',
				transport_fees:'',
				allocation_of_fixed_assets_of_instruments:'',
				entertain:'',
				subtotal_labor_material_costs:'',
				management_costs:'',
				tax_reimbursement:'',
				subtotal_management_fees_and_taxes:'',
				principal:'',
				tax_money:'',
				full_amount_of_tax:'',
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
		      }
		   });
		admin.ajax_load_json({
			url: "queryWCProjectsSimpleDetailAllInfoByProjectCode",
			dataType: 'json',
			data: {
				project_code: admin.getTempData('project_code')
			},
			success: function(data) {
				if (data.code == 1) {
					layer.msg(data.info);
				} else {
					vm.project_code=data.info[0].project_code;
					vm.project_name=data.info[0].project_name;
					vm.audit_status=data.info[0].audit_status;
					vm.audit_info=data.info[0].audit_info;
					vm.project_area_department=data.info[0].project_area_department;
					vm.district_name=data.info[0].district_name;
					vm.item_classification=data.info[0].item_classification;
					vm.ustomer_name=data.info[0].ustomer_name;
					vm.planned_start_time=data.info[0].planned_start_time;
					vm.planned_end_time=data.info[0].planned_end_time;
					vm.project_cycle=data.info[0].project_cycle;
					//vm.project_progress=data.info[0].project_progress;
					if (data.info[0].project_progress == '0') {
						vm.project_progress="未开工";
					}else if (data.info[0].project_progress == '30') {
						vm.project_progress="已开工30%";
					}else if (data.info[0].project_progress == '70') {
						vm.project_progress="已开工70%";
					}else if (data.info[0].project_progress == '90') {
						vm.project_progress="已竣工";
					}else if (data.info[0].project_progress == '99') {
						vm.project_progress="已验收";
					}else if (data.info[0].project_progress == '100') {
						vm.project_progress="结项";
					}
					vm.project_quotation=data.info[0].project_quotation;
					vm.project_leader=data.info[0].project_leader;
					vm.simple_tax=data.info[0].simple_tax*100+'%';
					vm.cost_share=data.info[0].cost_share*100+'%';
					vm.actual_completion_date=data.info[0].actual_completion_date;
					vm.project_closing_day=data.info[0].project_closing_day;
					vm.remaining_stock=data.info[0].remaining_stock;
					vm.real_gross_profit=data.info[0].real_gross_profit;
					vm.real_gross_profit_per=data.info[0].real_gross_profit_per*100+'%';
					vm.surplus_gross_profit=data.info[0].surplus_gross_profit;
					vm.surplus_gross_profit_per=data.info[0].surplus_gross_profit_per*100+'%';
					vm.quality_assurance_funds=data.info[0].quality_assurance_funds;
					vm.net_profit=data.info[0].net_profit;
					vm.net_profit_per=data.info[0].net_profit_per*100+'%';
					vm.received_amount=data.info[0].received_amount;
					vm.amount_to_be_collected=data.info[0].amount_to_be_collected;
					vm.personal=data.info[0].personal;
					vm.capital_pool=data.info[0].capital_pool;
					vm.company=data.info[0].company;
					vm.returned_money_ishave=data.info[0].returned_money_ishave;
					if(vm.returned_money_ishave== 'N') {
							vm.returned_money_ishave='否';
					}else if(vm.returned_money_ishave== 'Y') {
							vm.returned_money_ishave='是';
					}
					vm.returned_money_date=data.info[0].returned_money_date;
					//vm.returned_money_point=data.info[0].returned_money_point;
					vm.returned_money_point=data.info[0].returned_money_point*100+'%';
					vm.reminder_date=data.info[0].reminder_date;
					vm.personal_warranty=data.info[0].personal_warranty;
					vm.personal_actual_distribution=data.info[0].personal_actual_distribution;
					vm.material=data.info[0].material;
					vm.labor=data.info[0].labor;
					vm.allocation_of_fixed_assets=data.info[0].allocation_of_fixed_assets;
					vm.other_items=data.info[0].other_items;
					vm.subtotal_cost=data.info[0].subtotal_cost;
					vm.material_cost_including_tax=data.info[0].material_cost_including_tax;
					vm.tax_credit_amount=data.info[0].tax_credit_amount;
					vm.outsourcing_including_tax=data.info[0].outsourcing_including_tax;
					vm.transport_fees=data.info[0].transport_fees;
					vm.allocation_of_fixed_assets_of_instruments=data.info[0].allocation_of_fixed_assets_of_instruments;
					vm.entertain=data.info[0].entertain;
					vm.subtotal_labor_material_costs=data.info[0].subtotal_labor_material_costs;
					vm.management_costs=data.info[0].management_costs;
					vm.tax_reimbursement=data.info[0].tax_reimbursement;
					vm.subtotal_management_fees_and_taxes=data.info[0].subtotal_management_fees_and_taxes;
					vm.principal=data.info[0].principal;
					vm.tax_money=data.info[0].tax_money;
					vm.full_amount_of_tax=data.info[0].full_amount_of_tax;
					
					//可开票增专金额
					vm.special_vat_invoice_amount=data.info[0].special_vat_invoice_amount;
					//普票金额
					vm.ordinary_invoice_amount=data.info[0].ordinary_invoice_amount;
					//供应商抵扣税率
					vm.supplier_invoice_tax=data.info[0].supplier_invoice_tax;
					//供应商开票抵税金额
					vm.supplier_invoice=data.info[0].supplier_invoice;
					//预估毛利
					vm.predict_gross_profit=data.info[0].predict_gross_profit;
					//预估毛利%
					vm.predict_gross_profit_per=data.info[0].predict_gross_profit_per;
					//预估净利润
					vm.predict_net_profit=data.info[0].predict_net_profit;
					//预估净利润%
					vm.predict_net_profit_per=data.info[0].predict_net_profit_per;
				}
			}
		});
	});
	</script>