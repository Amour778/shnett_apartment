<%@ page language='java' import='java.util.*' pageEncoding='UTF-8'%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<div style="margin:5px">
<shiro:hasRole name="wck_per_user">
<button class="layui-btn  layui-btn-primary btn_class" id="advance_payment_request_btn">
	提前付款申请
</button>
</shiro:hasRole>
<button class="layui-btn  layui-btn-primary btn_class" id="reLoad_advance_payment_request_btn">
	<i class="layui-icon layui-icon-refresh"></i>
</button>
</div>
<table lay-size='sm' class='layui-table' id='advance_payment_request_table_id' lay-filter="advance_payment_request_table_filter"></table>

<script type="text/html" id="advance_payment_request_table_bar">
{{#  if(d.audit_sta==2110){ }}
	<shiro:hasRole name="ruod">
		<a class="layui-btn layui-btn-xs btn_class layui-btn-normal" lay-event="pending">审核</a>
	</shiro:hasRole>
{{#  } }}  
{{#  if(d.audit_sta==2120){ }}
	<shiro:hasRole name="ruoa">
		<a class="layui-btn layui-btn-xs btn_class layui-btn-normal" lay-event="pending">审核</a>
	</shiro:hasRole>
{{#  } }}  
{{#  if(d.audit_sta==2130){ }}
	<shiro:hasRole name="ruof">
		<a class="layui-btn layui-btn-xs btn_class layui-btn-normal" lay-event="pending">审核</a>
	</shiro:hasRole>
{{#  } }}  
{{#  if(d.audit_sta==2140){ }}
	<shiro:hasRole name="ruob">
		<a class="layui-btn layui-btn-xs btn_class layui-btn-normal" lay-event="pending">审核</a>
	</shiro:hasRole>
{{#  } }}
<shiro:hasRole name="wck_per_user">
<a class="layui-btn layui-btn-xs btn_class layui-btn-normal" lay-event="edit" >修改</a>
</shiro:hasRole>
</script>
<script type='text/javascript'>
	layui.use([ 'jquery', 'layer','admin','table'],function() {
		var $ = layui.jquery, layer = layui.layer, admin = layui.admin, table = layui.table;
		var project_code = admin.getTempData('project_code');
		  table.render({
			elem: '#advance_payment_request_table_id'
			,id:'advance_payment_request_table_id'
			,loading:true
			,height: window.screen.height*0.4
			,url: 'queryAllWCP_RFP_ByProjectCode'
			,where: {project_code: project_code}
			,even:true
			,cols: [[
				{fixed: 'left',field: 'audit_sta', title: '审核状态', width:140}
				,{field: 'audit_info', title: '审核备注信息', width:120}
				,{field: 'project_area_department', title: '申请部门/费用所属部门', width:200}
				,{field: 'supplierOrCompanyName', title: '供应商或公司', width:120}
				,{field: 'supplierOrCompanyNumber', title: '供应商或公司代码', width:150}
				/*
				,{field: 'totalAmountPayable', title: '应收款项', width:120}//此处是借用wcp_request_for_payment的列名
				,{field: 'amountPaid', title: '已收款项', width:120}//此处是借用wcp_request_for_payment的列名
				*/
				,{field: 'inputDate', title: '日期', width:120}
				,{fixed: 'right',title: '操作', width:100, align:'center', toolbar: '#advance_payment_request_table_bar'}
			]]
			,done: function(res, curr, count){
				$("[data-field='audit_sta']").children().each(function() {
					if ($(this).text() == '2110') {
						$(this).html('<span class="layui-badge layui-bg-gray">大区负责人待审核</span>');
					}else if ($(this).text() == '2112') {
						$(this).html('<span class="layui-badge layui-bg-orange">大区负责人已驳回</span>');
					}else if ($(this).text() == '2120') {
						$(this).html('<span class="layui-badge layui-bg-gray">管理员待审核</span>');
					}else if ($(this).text() == '2122') {
						$(this).html('<span class="layui-badge layui-bg-orange">管理员已驳回</span>');
					}else if ($(this).text() == '2130') {
						$(this).html('<span class="layui-badge layui-bg-gray">财务待审核</span>');
					}else if ($(this).text() == '2132') {
						$(this).html('<span class="layui-badge layui-bg-orange">财务已驳回</span>');
					}else if ($(this).text() == '2140') {
						$(this).html('<span class="layui-badge layui-bg-gray">BOSS待审核</span>');
					}else if ($(this).text() == '2142') {
						$(this).html('<span class="layui-badge layui-bg-orange">BOSS已驳回</span>');
					}else if ($(this).text() == '2141') {
						$(this).html('<span class="layui-badge layui-bg-green">已通过</span>');
					}
				});
				$("[data-field='audit_info']").children().each(function() {
						if ($(this).text() == 'N') {
							$(this).html('');
						}
					});
			}
		  });
	  
	//监听工具条
	table.on('tool(advance_payment_request_table_filter)',function(obj) {
		var data = obj.data;
		var layEvent = obj.event;
		admin.putTempData('rid', data.rid);
		admin.putTempData('received_amount', data.received_amount);//已收款项
		admin.putTempData('project_area_department', data.project_area_department);//部门
		admin.putTempData('project_quotation', data.project_quotation);//应收款项
		if (layEvent === 'pending') {
			admin.putTempData('audit_sta', data.audit_sta);
			admin.putTempData('amountOfThisPayment', data.amountOfThisPayment);
    	  	admin.open({
			    title: '审核-提前付款申请',
		    	path: 'tpl/wcp/pending_advance_payment_request',
  			    area: [window.screen.width*0.7+'px', window.screen.height*0.7+'px'],
  			    success: function (layero, index) {
   			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
   			    },
   			    end: function () {
	   			    table.reload('advance_payment_request_table_id', {
						loading:true
						,height: window.screen.height*0.4
						,url: 'queryAllWCP_RFP_ByProjectCode'
						,where: {project_code: project_code}
						,even:true
					});
				}
			});
		}else if (layEvent === 'edit') {
    	  	admin.open({
			    title: '编辑提前付款申请表',
		    	path: 'tpl/wcp/add_edit_advance_payment_request',
  			    area: [window.screen.width*0.7+'px', window.screen.height*0.7+'px'],
  			    success: function (layero, index) {
   			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
   			    },
   			    end: function () {}
			});
		}
	});
	
	$("#reLoad_advance_payment_request_btn").click(function(){
		table.reload('advance_payment_request_table_id', {
			loading:true
			,height: window.screen.height*0.4
			,url: 'queryAllWCP_RFP_ByProjectCode'
			,where: {project_code: project_code}
			,even:true
		});
	});
	//添加提前付款申请
	$("#advance_payment_request_btn").click(function(){
		admin.putTempData('rid',null);
		admin.open({
		    title: '添加提前付款申请',
		    path: 'tpl/wcp/add_edit_advance_payment_request',
	    	area: [window.screen.width*0.7+'px', window.screen.height*0.7+'px'],
	    	success: function (layero, index) {
		        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
		    },
		    end: function () {}
		});
	});
});
</script>