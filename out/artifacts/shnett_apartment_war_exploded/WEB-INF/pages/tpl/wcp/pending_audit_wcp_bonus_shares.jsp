<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
	<div class="layui-row" id="wcp_bonus_shares_div_vue">
		<div>
			<div class="layui-card">
			<div class="layui-card-header">
					<span class="layui-badge layui-bg-cyan">
						{{project_code}} - 奖金：{{personal}}-可分配奖金:{{kefenpei}}- 质保金比例：{{returned_money_point}} - 质保金金额：{{(personal*returned_money_point).toFixed(2)}}- 责任人：{{project_leader}}
					</span>
				</div>
				<div class="layui-card-body">
					<table class="layui-hide" id="pending_audit_wcp_bonus_shares_table"></table>
					<div class="layui-btn-container" style="text-align:right;"  id="pending_audit_wcp_bonus_shares_btn" >
					  <button class="layui-btn layui-btn-radius" data-method="pending_agree"><i class="layui-icon layui-icon-ok"></i>同意</button> 
					  <button class="layui-btn layui-btn-radius layui-btn-danger" data-method="pending_reject"><i class="layui-icon layui-icon-close"></i>驳回</button> 
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-card">
			<div class="layui-card-header">
					<span class="layui-badge layui-bg-green">
						项目内容
					</span>
				</div>
				<div class="layui-card-body">
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
    </div>
    </div>
	<script type="text/javascript">
	
		layui.use(['form', 'table', 'layer', 'admin', 'jquery'],
		function() {
			var form = layui.form,
			$ = layui.jquery,
			layer = layui.layer,
			admin = layui.admin,
			table = layui.table;
			
			//VUE定义
			var vm = new Vue({
				el: '#wcp_bonus_shares_div_vue',
				data: {
					project_code: admin.getTempData('project_code'),
					personal: 0,
					project_leader: '',
					kefenpei: 0,
					returned_money_point:0,
					user_permission : admin.getTempData('user_permission')
				}
			})
			
			
			//通过项目编码获取相关信息
			$.post("queryWCProjectsSimpleDetailAllInfoByProjectCode", {
				project_code: admin.getTempData('project_code')
			},
			function(data) {
				if (data.code == 1) {
					layer.msg(data.info);
				} else {
					console.log("data.info[0].personal="+data.info[0].personal);
					vm.personal = data.info[0].personal;
					console.log("vm.personal="+vm.personal);
					vm.project_leader = data.info[0].project_leader;
					vm.returned_money_point = data.info[0].returned_money_point;
					vm.kefenpei = (data.info[0].personal-data.info[0].personal * data.info[0].returned_money_point).toFixed(2);
					if(vm.user_permission==null||vm.user_permission==""){
                		$('#pending_audit_wcp_bonus_shares_btn').hide();
                		$('.layui-btn-radius').addClass("layui-btn-disabled").attr("disabled","disabled");;
					}
						
					//表格初始化
			table.render({
				elem: '#pending_audit_wcp_bonus_shares_table',
				where: {
					project_code: vm.project_code,
				},
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				totalRow: true,
				method:'POST',
				url:'queryWeakCurrentProjectsBonusSharesBeanInfoByProjectCodeAndType',
				limit: 999,
				limits:[999],
				cols: [[{
					field: 'user_id',
					title: '工号'
				},
				{
					field: 'user_name',
					title: '姓名'
				},
				{
					field: 'proportion',
					title: '占比',
					totalRow: true
				},
				{
					field: 'money',
					title: '奖金金额',
					totalRow: true
				},
				{
					field: 'returned_money',
					title: '质保金金额',
					totalRow: true
				}]],
				done: function(res, curr, count) {
					var e_money = $("#pending_audit_wcp_bonus_shares_table").next().find('.layui-table-total').find('td[data-field="money"] div').text();
					var e_returned_money = $("#pending_audit_wcp_bonus_shares_table").next().find('.layui-table-total').find('td[data-field="returned_money"] div').text();
					if ((e_money*1 + e_returned_money*1) != vm.personal) {
						layer.alert("可分配金额("+vm.personal+")与实际分配的总金额("+(e_money*1 + e_returned_money*1).toFixed(2)+")不相同",{icon:5});
					}

				}
			});
					
				}
			},
			'json');
			
		  $('#pending_audit_wcp_bonus_shares_btn .layui-btn').on('click', function(){
		    var othis = $(this), method = othis.data('method');
		    active[method] ? active[method].call(this, othis) : '';
		  });
		  //触发事件
  var active = {
   pending_agree: function(){
	   var audit_status=null;
	   if(vm.user_permission=='ruod'){
	   		audit_status="4020";
	   }else if(vm.user_permission=='ruoa'){
	   		audit_status="4030";
	   }else if(vm.user_permission=='ruob'){
	   		audit_status="4040";
	   }else if(vm.user_permission=='ruoh'){
	   		audit_status="4041";
	   }
	   console.log('vm.user_permission',vm.user_permission);
	   console.log('audit_status',audit_status);
 		admin.ajax_load_json({
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			url: "updataWeakCurrentProjectsBonusSharesAuditStatusByProjectCode",
			data: {
				audit_status : audit_status,
				audit_info : "N",
				project_code : vm.project_code
			},
			beforeSend: function() {
				layer.load(0);
			},
			success: function(data) {
				layer.closeAll('loading');
				var obj = JSON.parse(data);
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
   },
   pending_reject: function(){
   layer.confirm('确定驳回吗？', {btn: ['确定','取消']}, function(){
	  layer.prompt({formType: 0,title: '请输入驳回理由',},function(value, index, elem) {
	   var audit_status=null;
	    if(vm.user_permission=='ruod'){
	   		audit_status="4012";
	   }else if(vm.user_permission=='ruoa'){
	   		audit_status="4022";
	   }else if(vm.user_permission=='ruob'){
	   		audit_status="4032";
	   }else if(vm.user_permission=='ruoh'){
	   		audit_status="4042";
	   }
	   console.log('vm.user_permission',vm.user_permission);
	   console.log('audit_status',audit_status);
      	admin.ajax_load_json({
			url: "updataWeakCurrentProjectsBonusSharesAuditStatusByProjectCode",
			data: {
				audit_status : audit_status,
				audit_info : value,
				project_code : vm.project_code
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
        })
     })
   }
  }
			var vmshow = new Vue({
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
					vmshow.project_code=data.info[0].project_code;
					vmshow.project_name=data.info[0].project_name;
					vmshow.audit_status=data.info[0].audit_status;
					vmshow.audit_info=data.info[0].audit_info;
					vmshow.project_area_department=data.info[0].project_area_department;
					vmshow.district_name=data.info[0].district_name;
					vmshow.item_classification=data.info[0].item_classification;
					vmshow.ustomer_name=data.info[0].ustomer_name;
					vmshow.planned_start_time=data.info[0].planned_start_time;
					vmshow.planned_end_time=data.info[0].planned_end_time;
					vmshow.project_cycle=data.info[0].project_cycle;
					//vmshow.project_progress=data.info[0].project_progress;
					if (data.info[0].project_progress == '0') {
						vmshow.project_progress="未开工";
					}else if (data.info[0].project_progress == '30') {
						vmshow.project_progress="已开工30%";
					}else if (data.info[0].project_progress == '70') {
						vmshow.project_progress="已开工70%";
					}else if (data.info[0].project_progress == '90') {
						vmshow.project_progress="已竣工";
					}else if (data.info[0].project_progress == '99') {
						vmshow.project_progress="已验收";
					}else if (data.info[0].project_progress == '100') {
						vmshow.project_progress="结项";
					}
					vmshow.project_quotation=data.info[0].project_quotation;
					vmshow.project_leader=data.info[0].project_leader;
					vmshow.simple_tax=data.info[0].simple_tax*100+'%';
					vmshow.cost_share=data.info[0].cost_share*100+'%';
					vmshow.actual_completion_date=data.info[0].actual_completion_date;
					vmshow.project_closing_day=data.info[0].project_closing_day;
					vmshow.remaining_stock=data.info[0].remaining_stock;
					vmshow.real_gross_profit=data.info[0].real_gross_profit;
					vmshow.real_gross_profit_per=data.info[0].real_gross_profit_per*100+'%';
					vmshow.surplus_gross_profit=data.info[0].surplus_gross_profit;
					vmshow.surplus_gross_profit_per=data.info[0].surplus_gross_profit_per*100+'%';
					vmshow.quality_assurance_funds=data.info[0].quality_assurance_funds;
					vmshow.net_profit=data.info[0].net_profit;
					vmshow.net_profit_per=data.info[0].net_profit_per*100+'%';
					vmshow.received_amount=data.info[0].received_amount;
					vmshow.amount_to_be_collected=data.info[0].amount_to_be_collected;
					vmshow.personal=data.info[0].personal;
					vmshow.capital_pool=data.info[0].capital_pool;
					vmshow.company=data.info[0].company;
					vmshow.returned_money_ishave=data.info[0].returned_money_ishave;
					if(vmshow.returned_money_ishave== 'N') {
							vmshow.returned_money_ishave='否';
					}else if(vmshow.returned_money_ishave== 'Y') {
							vmshow.returned_money_ishave='是';
					}
					vmshow.returned_money_date=data.info[0].returned_money_date;
					//vmshow.returned_money_point=data.info[0].returned_money_point;
					vmshow.returned_money_point=data.info[0].returned_money_point*100+'%';
					vmshow.reminder_date=data.info[0].reminder_date;
					vmshow.personal_warranty=data.info[0].personal_warranty;
					vmshow.personal_actual_distribution=data.info[0].personal_actual_distribution;
					vmshow.material=data.info[0].material;
					vmshow.labor=data.info[0].labor;
					vmshow.allocation_of_fixed_assets=data.info[0].allocation_of_fixed_assets;
					vmshow.other_items=data.info[0].other_items;
					vmshow.subtotal_cost=data.info[0].subtotal_cost;
					vmshow.material_cost_including_tax=data.info[0].material_cost_including_tax;
					vmshow.tax_credit_amount=data.info[0].tax_credit_amount;
					vmshow.outsourcing_including_tax=data.info[0].outsourcing_including_tax;
					vmshow.transport_fees=data.info[0].transport_fees;
					vmshow.allocation_of_fixed_assets_of_instruments=data.info[0].allocation_of_fixed_assets_of_instruments;
					vmshow.entertain=data.info[0].entertain;
					vmshow.subtotal_labor_material_costs=data.info[0].subtotal_labor_material_costs;
					vmshow.management_costs=data.info[0].management_costs;
					vmshow.tax_reimbursement=data.info[0].tax_reimbursement;
					vmshow.subtotal_management_fees_and_taxes=data.info[0].subtotal_management_fees_and_taxes;
					vmshow.principal=data.info[0].principal;
					vmshow.tax_money=data.info[0].tax_money;
					vmshow.full_amount_of_tax=data.info[0].full_amount_of_tax;
					
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