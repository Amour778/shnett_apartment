<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<form class="layui-form layui-form-pane" lay-filter="cost_estimation_formTest"  id = "cost_estimation">
<div class="layui-row layui-col-space15">
	<div class="layui-col-lg6 layui-col-md6">
		<div class="layui-card">
			<div class="layui-card-header">
				基础信息
			</div>
			<div class="layui-card-body">
				<div class="layui-form-item">
					<label class="layui-form-label">
						*项目区部
					</label>
					<div class="layui-input-block">
							<select name="project_area_department" required lay-verify="required" lay-filter="project_area_department" id="project_area_department"></select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						*区部名称
					</label>
					<div class="layui-input-block">
						<input type="text" name="district_name" required
							lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						*项目分类
					</label>
					<div class="layui-input-block">
						<select name="item_classification" id="item_classification" lay-verify="required"
							lay-search>
						</select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						*客户名称
					</label>
					<div class="layui-input-block">
						<input type="text" name="ustomer_name" required
							lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item" lay-tips="计划启动时间*">
					<label class="layui-form-label">
						*计划启动时间
					</label>
					<div class="layui-input-block" >
						<input type="text" name="planned_start_time" required
							lay-verify="required" autocomplete="off" class="layui-input"
							id="planned_start_time">
					</div>
				</div>
				<div class="layui-form-item"  lay-tips="预计完成时间">
					<label class="layui-form-label">
						预计完成时间
					</label>
					<div class="layui-input-block">
						<input type="text" name="planned_end_time"  autocomplete="off" class="layui-input"
							id="planned_end_time">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						*项目名称
					</label>
					<div class="layui-input-block">
						<input type="text" name="project_name" required
							lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item"  lay-tips="项目周期(天)">
					<label class="layui-form-label">
						项目周期(天)
					</label>
					<div class="layui-input-block">
						<input type="text" name="project_cycle" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						*项目报价
					</label>
					<div class="layui-input-block">
						<input type="text" name="project_quotation" required
							lay-verify="required|numberOrEmpty" autocomplete="off"  placeholder="￥" class="layui-input"   v-model.number = "project_quotation">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						*税率
					</label>
					<div class="layui-input-block">
						<select name="simple_tax" id="simple_tax" lay-verify="required"
							lay-search lay-filter="simple_tax_select_filter">
						</select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						*项目负责人
					</label>
					<div class="layui-input-block">
						<select name="project_leader" required lay-verify="required" lay-filter="project_leader" id="project_leader"></select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						项目备注
					</label>
					<div class="layui-input-block">
					<input type="text" name="edit_remark" v-bind:lay-verify="required_edit_remark"  autocomplete="off"   class="layui-input" >
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-lg6 layui-col-md6">
		<div class="layui-card">
			<div class="layui-card-header">
				成本估算
			</div>
			<div class="layui-card-body">
				<div class="layui-form-item">
					<label class="layui-form-label">
						材料
					</label>
					<div class="layui-input-block">
						<input type="text" name="material" required lay-verify="required|numberOrEmpty"
							autocomplete="off"  placeholder="￥" class="layui-input" v-model.number = "material">
					</div>
				</div>
				
				
				
				
				<div class="layui-form-item">
					<label class="layui-form-label" >
						人工(外请)
					</label>
					<div class="layui-input-block">
						<input type="number" name="labor" required lay-verify="required|numberOrEmpty"
							autocomplete="off"  placeholder="￥" class="layui-input"  v-model.number = "labor">
					</div>
				</div>
				
				
				
				
				<div class="layui-form-item"   lay-tips="固定资产分摊">
					<label class="layui-form-label">
						固定资产分摊
					</label>
					<div class="layui-input-block">
						<input type="number" name="allocation_of_fixed_assets" required
							lay-verify="required|numberOrEmpty" autocomplete="off" placeholder="￥"  class="layui-input"  v-model.number = "allocation_of_fixed_assets">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						其他项
					</label>
					<div class="layui-input-block">
						<input type="number" name="other_items" required
							lay-verify="required|numberOrEmpty" autocomplete="off" placeholder="￥" class="layui-input"  v-model.number = "other_items">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						费用小计
					</label>
					<div class="layui-input-block">
						<input type="number" name="subtotal_cost" required
							lay-verify="required|numberOrEmpty" autocomplete="off" placeholder="￥" class="layui-input"  v-model.number = "subtotal_cost" readonly="readonly" disable="disable">
					</div>
				</div>
				
				<div class="layui-form-item"  lay-tips="可开票增专金额合计">
					<label class="layui-form-label">
						*可开票增专金额合计
					</label>
					<div class="layui-input-block">
						<input type="number" name="special_vat_invoice_amount" required lay-verify="required"
							autocomplete="off"  placeholder="￥" class="layui-input" v-model.number = "special_vat_invoice_amount">
					</div>
				</div>
				
				<div class="layui-form-item" lay-tips="非专票发票金额合计">
					<label class="layui-form-label">
						*非专票发票金额合计
					</label>
					<div class="layui-input-block">
						<input type="number" name="ordinary_invoice_amount" required lay-verify="required"
							autocomplete="off"  placeholder="￥" class="layui-input" v-model.number = "ordinary_invoice_amount">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-lg6 layui-col-md6">
		<div class="layui-card">
			<div class="layui-card-header">
				预估
			</div>
			<div class="layui-card-body"   lay-tips="供应商开票税率">
				<div class="layui-form-item">
					<label class="layui-form-label">
						*供应商开票税率
					</label>
					<div class="layui-input-block">
						<select name="supplier_invoice_tax" id="supplier_invoice_tax" lay-verify="required"
							lay-search  lay-filter="supplier_invoice_tax_select_filter">
						</select>
					</div>
				</div>
				<div class="layui-form-item"  lay-tips="供应商开票抵税金额">
					<label class="layui-form-label">
						供应商开票抵税金额
					</label>
					<div class="layui-input-block">
						<input type="number" name="supplier_invoice" required lay-verify="required|numberOrEmpty"
							autocomplete="off"  placeholder="￥" class="layui-input"  readOnly  v-model.number="supplier_invoice">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						预估毛利
					</label>
					<div class="layui-input-block">
						<input type="text" name="predict_gross_profit" required lay-verify="required|numberOrEmpty"
							autocomplete="off" class="layui-input"  readOnly  v-model.number="predict_gross_profit">
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">
						预估毛利%
					</label>
					<div class="layui-input-block">
						<input type="text" name="predict_gross_profit_per" required lay-verify="required"
							autocomplete="off"  class="layui-input"  readOnly  v-model="predict_gross_profit_per">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label" >
						预估净利润
					</label>
					<div class="layui-input-block">
						<input type="text" name="predict_net_profit" required lay-verify="required|numberOrEmpty"
							autocomplete="off" class="layui-input"  readOnly  v-model.number="predict_net_profit"  >
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						预估净利润%
					</label>
					<div class="layui-input-block">
						<input type="text" name="predict_net_profit_per" required
						 lay-verify="required" autocomplete="off"   class="layui-input "  readOnly v-model="predict_net_profit_per"  >
					</div>
				</div>
			</div>
		</div>
	</div>
<div class="layui-form-item model-form-footer">
	 <button class="layui-btn" lay-submit lay-filter="cost_estimation_formTest">立即提交</button>
</div>
</div>
</form>
<script type="text/javascript">
layui.use(['jquery','layer','form','admin','laydate'], function(){
  var $=layui.jquery
  ,layer = layui.layer
  ,form = layui.form
  ,admin = layui.admin
  ,laydate = layui.laydate;
  var project_code=admin.getTempData('project_code');
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
			$("#project_area_department").html(_select);
			 form.render();
  		}else{
  			layer.alert(data.info,{icon:5});
  		}
  	}
  });
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
			$("#simple_tax").html(_select);
			$("#supplier_invoice_tax").html(_select);
			 form.render();
  		}else{
  			layer.alert(data.info,{icon:5});
  		}
  	}
  });
  
  //下拉框初始化-项目类别
  var item_classification_select='<option value=""></option><option value="弱电-维保">弱电-维保</option><option value="弱电-项目">弱电-项目</option>';
  $("#item_classification").html(item_classification_select);
  
  //下拉框初始化-项目责任人
  var project_leader="<option  value=''>请先选择费用所属部门</option>";
  $("#project_leader").html(project_leader);
  

  form.render('select'); //刷新select选择框渲染
	//初始化VUE
	var vm = new Vue({
		el: '#cost_estimation',
		data: {
			//项目报价
			project_quotation: 0,
			//税率
			simple_tax: 0,
			//材料
			material: 0,
			//人工（外请）
			labor: 0,
			//固定资产分摊
			allocation_of_fixed_assets: 0,
			//其他项
			other_items: 0,
			//费用小计
			//subtotal_cost: 0,
			//可开票增专金额
			special_vat_invoice_amount: 0,
			//普票金额
			ordinary_invoice_amount: 0,
			//供应商抵扣税率
			supplier_invoice_tax: 0,
			//供应商开票抵税金额
			supplier_invoice: 0,
			//预估毛利
			predict_gross_profit: 0,
			//预估毛利%
			predict_gross_profit_per: 0,
			//预估净利润
			predict_net_profit: 0,
			//预估净利润%
			predict_net_profit_per: 0,
			predict_gross_profit_per: 0,
			predict_net_profit_per_temp: 0,
			required_edit_remark:'N'
		},
		methods: {},
		computed: {
			subtotal_cost: function() { //自动计算[费用小计]
				return (this.material * 1 + this.labor * 1 + this.allocation_of_fixed_assets + this.other_items).toFixed(2);
			},
	
		},
		watch: {
			//监听录入，清空[供应商开票税率]下拉选项
			project_quotation: function(val) {
				estimate($("#supplier_invoice_tax").val());
			},
			simple_tax: function(val) {
				estimate($("#supplier_invoice_tax").val());
			},
			special_vat_invoice_amount: function(val) {
				estimate($("#supplier_invoice_tax").val());
			},
			ordinary_invoice_amount: function(val) {
				estimate($("#supplier_invoice_tax").val());
			},
			other_items: function(val) {
				estimate($("#supplier_invoice_tax").val());
			}
		}
	});
  form.verify({
    numberOrEmpty: function (value, item) {
       if (value != "") {
       	var regu = /^(\-|\+)?\d+(\.\d+)?$/;
        if (!regu.test(value)) {
        	return '只能填写数字';
         }
       }
    }
});   
  //更新渲染
  form.render();
  
  //计划开始时间
  laydate.render({
    elem: '#planned_start_time'
  });
  
  //计划结束时间
  laydate.render({
    elem: '#planned_end_time'
  });
  
  form.on('select(simple_tax_select_filter)', function(data){
		vm.simple_tax=data.value;
	})
  
  //监听[供应商开票税率]下拉框选项
  form.on('select(supplier_invoice_tax_select_filter)', function(data){
  	if(vm.project_quotation==0){
	  	form.val("cost_estimation_formTest", {
	  	"supplier_invoice_tax": ''
		});
		layer.msg('请先输入[项目报价]',{shade: [0.8, '#393D49'],shadeClose :true});
  		return;
  	}if(vm.simple_tax==0){
	  	form.val("cost_estimation_formTest", {
	  	"supplier_invoice_tax": ''
		});
		layer.msg('请先选择[税率]',{shade: [0.8, '#393D49'],shadeClose :true});
  		return;
  	}/*if(vm.special_vat_invoice_amount==0){
	  	form.val("cost_estimation_formTest", {
	  	"supplier_invoice_tax": ''
		});
		layer.msg('请先输入[可开票增专金额合计]',{shade: [0.8, '#393D49'],shadeClose :true});
  		return false;
  	}if(vm.ordinary_invoice_amount==0){
	  	form.val("cost_estimation_formTest", {
	  	"supplier_invoice_tax": ''
		});
		layer.msg('请先输入[非专票发票金额合计]',{shade: [0.8, '#393D49'],shadeClose :true});
  		return;
  	}*/
  	if(vm.other_items+''==''){
	  	form.val("cost_estimation_formTest", {
	  	"supplier_invoice_tax": ''
		});
		layer.msg('请先输入[其他项]',{shade: [0.8, '#393D49'],shadeClose :true});
  		return;
  	}
  	estimate(data.value);
  });    
  
  //监听[项目区部]下拉框，获取所属大区成员
	form.on('select(project_area_department)',
	function(data) {
		admin.ajax_load_json({
			url: "queryUserListByWCPArea",
			async: false,
			data: {
				wcp_area: data.value
			},
			success: function(obj) {
				if (obj.code == 0) {
					layer.alert("所选大区无成员", {
						icon: 5
					});
					$("#project_leader").html('');
					form.render();
				} else {
					var project_leader = "<option></option>";
					for (var c = 0; c < obj.code; c++) {
						var value = obj.info[c].user_id;
						var text = obj.info[c].user_name;
						project_leader += "<option value=" + value + ">" + text + "</option>";
					}
					$("#project_leader").html(project_leader);
					form.render();
				}
			}
		});
	});
   //监听提交
  form.on('submit(cost_estimation_formTest)', function(data){
  	var URL="addWeakCurrentProjectsSimple";//添加
  	if(project_code!=null&&project_code!='undefined'){//更新数据
  		URL="updataWeakCurrentProjectsSimpleInfoByProjectCode";
  	}
  	console.log(data.field.predict_gross_profit_per);
  	console.log(data.field.predict_net_profit_per);
  	data.field.predict_gross_profit_per=vm.predict_gross_profit_per_temp;
  	data.field.predict_net_profit_per=vm.predict_net_profit_per_temp;
  	console.log(data.field.predict_gross_profit_per);
  	console.log(data.field.predict_net_profit_per);
	admin.ajax_load_json({
		url: URL,
		//async:false,
		data: {
			info : JSON.stringify(data.field)
			,project_code : project_code
		},
		success: function(obj) {
			if (obj.code == 0) {
				layer.closeAll();
				layer.msg(obj.info, {
					icon: 1
				});
			}
			else{
				layer.alert(obj.info, {
					icon: 5
				});
			}
		}
	});
    return false;
  });
  Vue.nextTick(function () {
  		console.log('new message '+vm.predict_net_profit_per);
  		//项目编码不为空值，则表示是修改项目数据，获取项目数据
  	if(project_code!=null&&project_code!='undefined'){
  		  admin.ajax_load_json({
			url: "queryProjectInfoByProjectCode",
			//async:false,
			data: {
				project_code :project_code
			},
			success: function(obj) {
				if (obj.code == 0) {
					var returnData=obj.info[0];
		        	//项目报价
					vm.project_quotation=returnData.project_quotation;
					//税率
					vm.simple_tax=returnData.simple_tax;
					//材料
					vm.material=returnData.material;
					//人工（外请）
					vm.labor=returnData.labor;
					//固定资产分摊
					vm.allocation_of_fixed_assets=returnData.allocation_of_fixed_assets;
					//其他项
					vm.other_items=returnData.other_items;
					//可开票增专金额
					vm.special_vat_invoice_amount=returnData.special_vat_invoice_amount;
					//普票金额
					vm.ordinary_invoice_amount=returnData.ordinary_invoice_amount;
					//供应商抵扣税率
					//vm.supplier_invoice_tax=returnData.supplier_invoice_tax;
					//供应商开票抵税金额
					vm.supplier_invoice=returnData.supplier_invoice;
					//预估毛利
					vm.predict_gross_profit=returnData.predict_gross_profit;
					//预估毛利%
					vm.predict_gross_profit_per=returnData.predict_gross_profit_per;
					//预估净利润
					vm.predict_net_profit=returnData.predict_net_profit;
					//预估净利润%
					vm.predict_net_profit_per=returnData.predict_net_profit_per;
					
					admin.ajax_load_json({
						url: "queryUserListByWCPArea",
						async:false,
						data: {
							wcp_area : returnData.project_area_department
						},
						success: function(obj) {
							if (obj.code == 0) {
								layer.alert("所选大区无成员", {
								icon: 5
							});
							}
							else{
								var project_leader="<option></option>";
								for(var c=0;c<obj.code;c++){
									var value=obj.info[c].user_id;
									var text=obj.info[c].user_name;
									project_leader+="<option value="+value+">"+text+"</option>";
								}
								$("#project_leader").html(project_leader);
								//form.render();
						}
						}
					});
					
					form.val("cost_estimation_formTest", {
						//费用所属部门
						"project_area_department":returnData.project_area_department
						//区部名称
						,"district_name":returnData.district_name
						//项目类别
						,"item_classification":returnData.item_classification
						//客户名称
						,"ustomer_name":returnData.ustomer_name
						//计划开始时间
						,"planned_start_time":returnData.planned_start_time
						//计划结束时间
						,"planned_end_time":returnData.planned_end_time
						//项目名称
						,"project_name":returnData.project_name
						//项目周期
						,"project_cycle":returnData.project_cycle
						//项目负责人
						,"project_leader":returnData.project_leader
						//税率
						,"simple_tax":returnData.simple_tax
						//费用小计
						,"subtotal_cost":returnData.subtotal_cost
						//项目报价
						,"project_quotation":returnData.project_quotation
						//税率
						,"simple_tax":returnData.simple_tax
						//材料
						,"material":returnData.material
						//人工（外请）
						,"labor":returnData.labor
						//固定资产分摊
						,"allocation_of_fixed_assets":returnData.allocation_of_fixed_assets
						//其他项
						,"other_items":returnData.other_items
						/*//费用小计
						,"subtotal_cost":returnData.subtotal_cost*/
						//可开票增专金额
						,"special_vat_invoice_amount":returnData.special_vat_invoice_amount
						//普票金额
						,"ordinary_invoice_amount":returnData.ordinary_invoice_amount
						//供应商抵扣税率
						,"supplier_invoice_tax":returnData.supplier_invoice_tax
						//供应商开票抵税金额
						,"supplier_invoice":returnData.supplier_invoice
						//预估毛利
						,"predict_gross_profit":returnData.predict_gross_profit
						//预估毛利%
						,"predict_gross_profit_per":returnData.predict_gross_profit_per
						//预估净利润
						,"predict_net_profit":returnData.predict_net_profit
						//预估净利润%
						,"predict_net_profit_per":returnData.predict_net_profit_per
					});
					vm.required_edit_remark='required';
						form.render();
				}else{
					layer.alert(obj.info, {
						icon: 5
					});
				}
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
	          //通常情况下textStatus和errorThrown只有其中一个包含信息
	          layer.alert(textStatus+" || "+errorThrown,{icon:5});
	       }
		});
		//form.render();
		}
	})
 
  function estimate(val){ //计算预估数据
		//供应商开票税率
	  	vm.supplier_invoice_tax=val;
	  	//供应商开票抵税金额 =可开票增专金额/(1+ 供应商开票税率)*供应商开票税率
	  	vm.supplier_invoice=accMul(accDiv(vm.special_vat_invoice_amount*1,(1+vm.supplier_invoice_tax*1)),vm.supplier_invoice_tax*1).toFixed(2);
	         
	  	//管理成本2% = 税价全额*0.02
		var management_costs = vm.project_quotation*1 * 0.02;
		
		//税额 6~11%=税价全额/(1+税率)*税率
		var tax_money=0;
		tax_money =vm.project_quotation*1 / ( 1 + vm.simple_tax*1 ) * vm.simple_tax*1;
		
		//抵税金额(增值税专用发票)
		var tax_credit_amount=0;
		tax_credit_amount = accMul(accDiv(vm.special_vat_invoice_amount*1,(1+vm.supplier_invoice_tax*1)),vm.supplier_invoice_tax*1);
		
		console.log('税额 6~11%tax_money='+tax_money);
		console.log('抵税金额(增值税专用发票)tax_credit_amount='+tax_credit_amount);
		
		var sh=false;
		if((tax_money*1-tax_credit_amount*1)>0){
			sh=true;
		}
		console.log('tax_money*1-tax_credit_amount*1)>0='+sh);
		//补税
		var tax_reimbursement=0;
		if(sh){
			//(税额 6~11% - 抵税金额(增值税专用发票)) *0.12 + 税价全额*0.0005
			tax_reimbursement = ( tax_money - tax_credit_amount ) *0.12 + vm.special_vat_invoice_amount*1 * 0.0005
		}else{
			//人工材料费用小计*0.0005
			tax_reimbursement = (vm.special_vat_invoice_amount+vm.ordinary_invoice_amount+vm.other_items-vm.supplier_invoice)* 0.0005;
		}
		
		console.log('管理成本2%management_costs='+management_costs);
		console.log('(财务填)补税tax_reimbursement='+tax_reimbursement);
		//管理费及税务小计=管理成本2% +(财务填)补税
		var subtotal_management_fees_and_taxes = management_costs + tax_reimbursement;
	
	  	//预估毛利=税价全额-人工材料费用小计-管理费及税务小计
		vm.predict_gross_profit= (vm.project_quotation*1-(vm.special_vat_invoice_amount+vm.ordinary_invoice_amount+vm.other_items-vm.supplier_invoice)*1-subtotal_management_fees_and_taxes*1).toFixed(2);
		//预估毛利%=预估毛利/税价全额
		vm.predict_gross_profit_per=(( vm.predict_gross_profit*1 / vm.project_quotation*1)*100).toFixed(2)+"%";
		vm.predict_gross_profit_per_temp=(vm.predict_gross_profit*1 / vm.project_quotation*1).toFixed(4);
		console.log('预估毛利%vm.predict_gross_profit_per='+vm.predict_gross_profit_per);
		//预估净利润=预估毛利*0.75
		vm.predict_net_profit=(vm.predict_gross_profit*1*0.75).toFixed(2);
		//预估净利润%=预估净利润/税价全额
		console.log('预估净利润vm.predict_net_profit='+vm.predict_net_profit);
		console.log('税价全额vm.project_quotation='+vm.project_quotation);
		console.log('(vm.predict_net_profit*1/ vm.project_quotation*1)='+(vm.predict_net_profit*1/ vm.project_quotation*1));
		vm.predict_net_profit_per=((vm.predict_net_profit*1/ vm.project_quotation*1)*100).toFixed(2)+"%";	
		vm.predict_net_profit_per_temp=(vm.predict_net_profit*1/ vm.project_quotation*1).toFixed(4);
		console.log('预估净利润%vm.predict_net_profit_per='+vm.predict_net_profit_per);	
  	}

 });
 //乘法函数
 function accMul(arg1,arg2) {
    var m=0,s1=arg1.toString(),s2=arg2.toString();
    try{m+=s1.split(".")[1].length}catch(e){}
    try{m+=s2.split(".")[1].length}catch(e){}
    return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);
}
//除法函数
function accDiv(arg1,arg2){
   var t1=0,t2=0,r1,r2;
   try{t1=arg1.toString().split(".")[1].length}catch(e){}
   try{t2=arg2.toString().split(".")[1].length}catch(e){}
   with(Math){
       r1=Number(arg1.toString().replace(".",""));
       r2=Number(arg2.toString().replace(".",""));
       return (r1/r2)*pow(10,t2-t1);
   }
}
</script>