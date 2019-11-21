<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
	<div class="layui-card">
	    <div class="layui-card-header">
	        <h2 class="header-title">项目总表</h2>
	        <span class="layui-breadcrumb pull-right">
	           <a href="#!function_page_wcp_weak_current_project">立项</a>
	           <a href="#!function_page_wcp_weak_current_project_actual_expenditure">成本报销</a>
	        </span>
	    </div>
	    <div class="layui-card-body">
	        <div class="layui-form toolbar">
	        
			<shiro:hasPermission name="quretWeakCurrentProjectSimple">
	        <div class="layui-inline"  style="width:40%">
				<select name="WCPDselect" xm-select="WCPDselect" lay-verify="required"  class="layui-input-inline" 
					lay-vertype="tips" xm-select-search=""
					xm-select-search-type="dl"  xm-select-show-count="3"
					xm-select-skin="default">
				</select>
			</div>
			<div id="layerDemo" class="layui-inline layui-btn-group"  style="width:50%">
				  <button class="layui-btn layui-btn-normal" lay-submit lay-filter="quret_wcp_summary"><i class="layui-icon layui-icon-search"></i>搜索</button>
			</div>
			
			</shiro:hasPermission>
        </div>
        
    		<table id="wcp_summary_table" lay-filter="wcp_summary_table_tool" class="layui-table" lay-size="sm"></table>
    </div>
</div>
	

<script type="text/html" id="wcp_summary_table_bar" >
<a class="layui-btn layui-btn-normal layui-btn-xs" data-dropdown="#dropdown-wcp-summary-user-{{d.project_code}}" data-anchor="right-center">
     操作<i class="layui-icon layui-icon-triangle-d" style="font-size: 12px !important;"></i>
    </a>
    <div class="dropdown-menu fixed" id="dropdown-wcp-summary-user-{{d.project_code}}">
        <ul>
			<li class="title">项目名称:{{d.project_name}}</li>
 			<li><a lay-event="show_wcp_summary"><i class="layui-icon layui-icon-form"></i>查看-项目内容</a></li>
            <li><a lay-event="show_wcp_approva_log"><i class="layui-icon layui-icon-form"></i>审批历史</a></li>
			{{#  if(d.project_progress != 100 &&d.project_progress != '100' ){ }}
				<li><a lay-event="advance_payment_request_list"><i class="layui-icon layui-icon-list"></i>提前付款申请总表</a></li>
			{{#  } }} 
			<shiro:hasRole name="wck_per_user">
				{{#  if(d.audit_status === 1021||d.audit_status === 3012||d.audit_status === 3022||d.audit_status === 3032){ }}
 					<li><a lay-event="wcp_summary_update_progress"><i class="layui-icon layui-icon-edit"></i>更新进度</a></li>
            		<li><a lay-event="wcp_summary_actual_expenditure"><i class="layui-icon layui-icon-edit"></i>添加成本报销</a></li>
				{{#  } }} 
            	 {{#  if(d.audit_status === 3031 ||d.audit_status === 4012 ||d.audit_status === 4022 ||d.audit_status === 4032 ||d.audit_status === 4042){ }}
 					<li><a lay-event="wcp_bonus_shares"><i class="layui-icon layui-icon-edit"></i>个人奖金分配</a></li>
				{{#  } }}
 				{{#  if(d.audit_status >= 4010){ }}
 					<li><a lay-event="show_wcp_bonus_shares"><i class="layui-icon layui-icon-form"></i>查看-奖金分配</a></li>
  				{{#  } }}
				{{#  if(d.audit_status === 9979 || d.audit_status===9982){ }}
 					<li><a lay-event="returned_money"><i class="layui-icon layui-icon-edit"></i>质保金已回款申请</a></li>
  				{{#  } }}

			</shiro:hasRole>

			<shiro:hasRole name="ruof">
 				{{#  if(d.audit_status <=2212){ }}
 						<li><a lay-event="pending_aoai" style="color:green">开票申请审核</a></li>
  				{{#  } }}
			</shiro:hasRole>
			<shiro:hasAnyRoles name="ruoh,ruoa,ruof,ruod,ruob">
				<shiro:hasRole name="ruod">
 					{{#  if(d.audit_status === 3010){ }}
 						<li><a lay-event="application_closing" style="color:green">申请结项-大区负责人待审核</a></li>
  					{{#  } }}
				</shiro:hasRole>
				<shiro:hasRole name="ruof">
 					{{#  if(d.audit_status === 3020){ }}
 						<li><a lay-event="application_closing" style="color:green">申请结项-财务待审核</a></li>
  					{{#  } }}
				</shiro:hasRole>
				<shiro:hasRole name="ruoa">
 					{{#  if(d.audit_status === 3030){ }}
 						<li><a lay-event="application_closing" style="color:green">申请结项-管理员待审核</a></li>
  					{{#  } }}
				</shiro:hasRole>
				<shiro:hasRole name="ruod">
 					{{#  if(d.audit_status === 4010){ }}
 						<li><a lay-event="personal_bonus_Finance">个人奖金-大区负责人待审核</a></li>
  					{{#  } }}
				</shiro:hasRole>
				<shiro:hasRole name="ruoa">
 					{{#  if(d.audit_status === 4020){ }}
 						<li><a lay-event="personal_bonus_Administrator">个人奖金-管理员待审核</a></li>
  					{{#  } }}
				</shiro:hasRole>
				<shiro:hasRole name="ruob">
					{{#  if(d.audit_status === 4030){ }}
 						<li><a lay-event="personal_bonus_Boss_resources">个人奖金-BOSS待审核</a></li>
  					{{#  } }}
				</shiro:hasRole>
				<shiro:hasRole name="ruoh">
					{{#  if(d.audit_status === 4040){ }}
 						<li><a lay-event="personal_bonus_Human_resources">个人奖金-人资待审核</a></li>
  					{{#  } }}
				</shiro:hasRole>
			</shiro:hasAnyRoles>

			{{#  if(d.audit_status === 9999  ||  d.audit_status === 9989){ }}
 				<li><a lay-event="show_wcp_bonus_shares"><i class="layui-icon layui-icon-form"></i>查看-奖金分配</a></li>
  			{{#  } }}

			{{#  if(d.audit_status === 9980){ }}
 				<li><a lay-event="reminder_date"><i class="layui-icon layui-icon-edit"></i>财务审批-质保金已回款</a></li>
  			{{#  } }}

			{{#  if(d.audit_status !== 1011){ }}
 				<li><a lay-event="show_wcp_files"><i class="layui-icon layui-icon-form"></i>查看上传-附件</a></li>
  			{{#  } }}
 					
        </ul>
    </div>
</script>
<script type="text/html" id="predict_gross_profit_perTpl">
  {{ d.predict_gross_profit_per*100}}%
</script>
<script type="text/html" id="predict_net_profit_perTpl">
  {{ d.predict_net_profit_per*100}}%
</script>
<script type="text/javascript" language="javascript" src="assets/pages/wcp/weak_current_projects_summary.js"></script>
