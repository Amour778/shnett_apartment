<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

    <table  class="layui-table" id="show_summary_info_VUE" lay-even>
     	<caption v-html="project_code">{{project_code}}</caption>
     	<thead>
	    <tr>
	      <th>字段</th>
	      <th>立项时数据</th>shiro
	      <th>现数据</th>
	    </tr> 
	  </thead>
        <tbody>
  		<tr>
            <td>项目名称</td>
            <td>{{ project_name_histoy}}</td>
            <td v-html="project_name">{{project_name}}</td>
        </tr>
  		<tr>
            <td>项目区部</td>
            <td>{{ project_area_department_histoy}}</td>
            <td v-html="project_area_department">{{ project_area_department}}</td>
        </tr>
  		<tr>
            <td>区部名称</td>
            <td>{{ district_name_histoy}}</td>
            <td v-html="district_name">{{ district_name}}</td>
        </tr>
  		<tr>
            <td>项目分类</td>
            <td>{{ item_classification_histoy}}</td>
            <td v-html="item_classification">{{ item_classification}}</td>
        </tr>
  		<tr>
            <td>客户名称</td>
            <td>{{ ustomer_name_histoy}}</td>
            <td v-html="ustomer_name">{{ ustomer_name}}</td>
        </tr>
  		<tr>
            <td>计划启动时间</td>
            <td>{{ planned_start_time_histoy}}</td>
            <td v-html="planned_start_time">{{ planned_start_time}}</td>
        </tr>
  		<tr>
            <td>预计完成时间</td>
            <td>{{ planned_end_time_histoy}}</td>
            <td v-html="planned_end_time">{{ planned_end_time}}</td>
        </tr>
  		<tr>
            <td>项目周期</td>
            <td>{{ project_cycle_histoy}}</td>
            <td v-html="project_cycle">{{ project_cycle}}</td>
        </tr>
  		<tr>
            <td>项目报价</td>
            <td>{{ project_quotation_histoy}}</td>
            <td v-html="project_quotation">{{ project_quotation}}</td>
        </tr>
  		<tr>
            <td>项目负责人</td>
            <td>{{ project_leader_histoy}}</td>
            <td v-html="project_leader">{{ project_leader}}</td>
        </tr>
  		<tr>
            <td>材料</td>
            <td>{{ material_histoy}}</td>
            <td v-html="material">{{ material}}</td>
        </tr>
  		<tr>
            <td>人工(外请)</td>
            <td>{{ labor_histoy}}</td>
            <td v-html="labor">{{ labor}}</td>
        </tr>
  		<tr>
            <td>固定资产分摊</td>
            <td>{{ allocation_of_fixed_assets_histoy}}</td>
            <td v-html="allocation_of_fixed_assets">{{ allocation_of_fixed_assets}}</td>
        </tr>
  		<tr>
            <td>其他项</td>
            <td>{{ other_items_histoy}}</td>
            <td v-html="other_items">{{ other_items}}</td>
        </tr>
  		<tr>
            <td>费用小计</td>
            <td>{{ subtotal_cost_histoy}}</td>
            <td v-html="subtotal_cost">{{ subtotal_cost}}</td>
        </tr>
  		<tr>
            <td>税率</td>
            <td>{{ simple_tax_histoy}}</td>
            <td v-html="simple_tax">{{ simple_tax}}</td>
        </tr>
  		<tr>
            <td>提交人</td>
            <td>{{ submitter_histoy}}</td>
            <td v-html="submitter">{{ submitter}}</td>
        </tr>
    </table>
<shiro:hasRole name="ruoa">
<div class="layui-btn-container" id="show_wcp_simple_view" style="float:right">
<button data-method="agree_admin" class="layui-btn disa">立项-管理员-同意</button> 
<button data-method="rejecte_admin" class="layui-btn layui-btn-danger disa">立项-管理员-驳回</button>
</div>
</shiro:hasRole>
<shiro:hasRole name="ruod">
<div class="layui-btn-container" id="show_wcp_simple_view" style="float:right">
<button data-method="agree_head" class="layui-btn disa">立项-大区负责人-同意</button> 
<button data-method="rejecte_head" class="layui-btn layui-btn-danger disa">立项-大区负责人-驳回</button>
</div>
</shiro:hasRole>
	<script type="text/javascript">
		layui.use(['form', 'table', 'layer', 'admin', 'jquery','laytpl'],
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
		      	project_code:'',
		      	project_name:'',
		        project_area_department:'',
				district_name:'',
				item_classification:'',
				ustomer_name:'',
				planned_start_time:'',
				planned_end_time:'',
				project_cycle:'',
				project_quotation:'',
				project_leader:'',
				material:'',
				labor:'',
				allocation_of_fixed_assets:'',
				other_items:'',
				subtotal_cost:'',
				simple_tax:'',
				submitter:'',
		      	project_name_histoy:'',
		        project_area_department_histoy:'',
				district_name_histoy:'',
				item_classification_histoy:'',
				ustomer_name_histoy:'',
				planned_start_time_histoy:'',
				planned_end_time_histoy:'',
				project_cycle_histoy:'',
				project_quotation_histoy:'',
				project_leader_histoy:'',
				material_histoy:'',
				labor_histoy:'',
				allocation_of_fixed_assets_histoy:'',
				other_items_histoy:'',
				subtotal_cost_histoy:'',
				simple_tax_histoy:'',
				submitter_histoy:'',
				audit_status:null,
				cost_share:0,
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
					vm.audit_status=data.infoOne[0].audit_status;
					vm.project_code=data.infoOne[0].project_code;
					vm.project_name=data.infoOne[0].project_name;
					vm.project_area_department=data.infoOne[0].project_area_department;
					vm.district_name=data.infoOne[0].district_name;
					vm.item_classification=data.infoOne[0].item_classification;
					vm.ustomer_name=data.infoOne[0].ustomer_name;
					
					vm.planned_start_time=data.infoOne[0].planned_start_time;
					vm.planned_end_time=data.infoOne[0].planned_end_time;
					vm.project_cycle=data.infoOne[0].project_cycle;
					vm.project_quotation=data.infoOne[0].project_quotation;
					vm.project_leader=data.infoOne[0].project_leader;
					
					vm.material=data.infoOne[0].material;
					vm.labor=data.infoOne[0].labor;
					vm.allocation_of_fixed_assets=data.infoOne[0].allocation_of_fixed_assets;
					vm.other_items=data.infoOne[0].other_items;
					vm.subtotal_cost=data.infoOne[0].subtotal_cost;
					
					vm.simple_tax=data.infoOne[0].simple_tax*100+"%";
					vm.submitter=data.infoOne[0].submitter;
					console.log('vm.audit_status',vm.audit_status);
					console.log('vm.subtotal_cost',vm.subtotal_cost);
					console.log('vm.project_quotation',vm.project_quotation);
					vm.cost_share=vm.subtotal_cost/vm.project_quotation;
					console.log('vm.cost_share',vm.cost_share);
					if(vm.audit_status=='1030'){//1013表示项目撤项
					vm.project_code=vm.project_code+" <b style='color:red'>已撤项</b>";
						console.log("vm.project_code",vm.project_code);
						return;
					}
					vm.project_name_histoy=data.infoTwo[0].project_name;
					vm.project_area_department_histoy=data.infoTwo[0].project_area_department;
					vm.district_name_histoy=data.infoTwo[0].district_name;
					vm.item_classification_histoy=data.infoTwo[0].item_classification;
					vm.ustomer_name_histoy=data.infoTwo[0].ustomer_name;
					
					vm.planned_start_time_histoy=data.infoTwo[0].planned_start_time;
					vm.planned_end_time_histoy=data.infoTwo[0].planned_end_time;
					vm.project_cycle_histoy=data.infoTwo[0].project_cycle;
					vm.project_quotation_histoy=data.infoTwo[0].project_quotation;
					vm.project_leader_histoy=data.infoTwo[0].project_leader;
					
					vm.material_histoy=data.infoTwo[0].material;
					vm.labor_histoy=data.infoTwo[0].labor;
					vm.allocation_of_fixed_assets_histoy=data.infoTwo[0].allocation_of_fixed_assets;
					vm.other_items_histoy=data.infoTwo[0].other_items;
					vm.subtotal_cost_histoy=data.infoTwo[0].subtotal_cost;
					
					vm.simple_tax_histoy=data.infoTwo[0].simple_tax*100+"%";
					vm.submitter_histoy=data.infoTwo[0].submitter;
					
					if(vm.project_name_histoy!=vm.project_name){
						vm.project_name="<b style='color:red'>"+vm.project_name+"</b>";
					}
					if(vm.project_area_department_histoy!=vm.project_area_department){
						vm.project_area_department="<b style='color:red'>"+vm.project_area_department+"</b>";
					}
					if(vm.district_name_histoy!=vm.district_name){
						vm.district_name="<b style='color:red'>"+vm.district_name+"</b>";
					}
					if(vm.item_classification_histoy!=vm.item_classification){
						vm.item_classification="<b style='color:red'>"+vm.item_classification+"</b>";
					}
					if(vm.ustomer_name_histoy!=vm.ustomer_name){
						vm.ustomer_name="<b style='color:red'>"+vm.ustomer_name+"</b>";
					}
					if(vm.planned_start_time_histoy!=vm.planned_start_time){
						vm.planned_start_time="<b style='color:red'>"+vm.planned_start_time+"</b>";
					}
					if(vm.planned_end_time_histoy!=vm.planned_end_time){
						vm.planned_end_time="<b style='color:red'>"+vm.planned_end_time+"</b>";
					}
					if(vm.project_cycle_histoy!=vm.project_cycle){
						vm.project_cycle="<b style='color:red'>"+vm.project_cycle+"</b>";
					}
					if(vm.project_quotation_histoy!=vm.project_quotation){
						vm.project_quotation="<b style='color:red'>"+vm.project_quotation+"</b>";
					}
					if(vm.project_leader_histoy!=vm.project_leader){
						vm.project_leader="<b style='color:red'>"+vm.project_leader+"</b>";
					}
					if(vm.material_histoy!=vm.material){
						vm.material="<b style='color:red'>"+vm.material+"</b>";
					}
					if(vm.labor_histoy!=vm.labor){
						vm.labor="<b style='color:red'>"+vm.labor+"</b>";
					}
					if(vm.allocation_of_fixed_assets_histoy!=vm.allocation_of_fixed_assets){
						vm.allocation_of_fixed_assets="<b style='color:red'>"+vm.allocation_of_fixed_assets+"</b>";
					}
					if(vm.other_items_histoy!=vm.other_items){
						vm.other_items="<b style='color:red'>"+vm.other_items+"</b>";
					}
					if(vm.subtotal_cost_histoy!=vm.subtotal_cost){
						vm.subtotal_cost="<b style='color:red'>"+vm.subtotal_cost+"</b>";
					}
					if(vm.simple_tax_histoy!=vm.simple_tax){
						vm.simple_tax="<b style='color:red'>"+vm.simple_tax+"</b>";
					}
					if(vm.submitter_histoy!=vm.submitter){
						vm.submitter="<b style='color:red'>"+vm.submitter+"</b>";
					}
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
		
	   $('#show_wcp_simple_view .layui-btn').on('click', function(){
		var othis = $(this), method = othis.data('method');
		active[method] ? active[method].call(this, othis) : '';
	  });
	  var active = {
		agree_admin: function(){
		$(".disa").attr("class", "layui-input layui-disabled").attr("disabled","disabled");
		   $.post("updataWeakCurrentProjectsSimpleAuditStatusByProjectCode", 
			{
				audit_status : 1020
				,audit_info : 'N'
				,project_code : vm.project_code
				,cost_share : vm.cost_share
			},function(data) {
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
			$(".disa").removeClass("layui-btn-disabled").removeAttr("disabled");
		},
		reject_admin: function(){
		  layer.prompt({
			formType: 0,
			title: '请输入驳回理由',
			},
			function(value, index, elem) {
			$(".disa").attr("class", "layui-input layui-disabled").attr("disabled","disabled");
			  $.post("updataWeakCurrentProjectsSimpleAuditStatusByProjectCode", 
						{
							audit_status:1012
							,audit_info:value
							,project_code:vm.project_code
							,cost_share:0
						},function(data) {
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
			$(".disa").removeClass("layui-btn-disabled").removeAttr("disabled");
			})
			
		},
		agree_head: function(){
			$(".disa").attr("class", "layui-input layui-disabled").attr("disabled","disabled");
		   $.post("updataWeakCurrentProjectsSimpleAuditStatusByProjectCode", 
			{
				audit_status : 1020
				,audit_info : 'N'
				,project_code : vm.project_code
				,cost_share : vm.cost_share
			},function(data) {
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
			$(".disa").removeClass("layui-btn-disabled").removeAttr("disabled");
		},
		reject_head: function(){
		  layer.prompt({
			formType: 0,
			title: '请输入驳回理由',
			},
			function(value, index, elem) {
			$(".disa").attr("class", "layui-input layui-disabled").attr("disabled","disabled");
			  $.post("updataWeakCurrentProjectsSimpleAuditStatusByProjectCode", 
						{
							audit_status:1012
							,audit_info:value
							,project_code:vm.project_code
							,cost_share:0
						},function(data) {
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
					
			$(".disa").removeClass("layui-btn-disabled").removeAttr("disabled");
			})
			
		}
		}
	});
	</script>