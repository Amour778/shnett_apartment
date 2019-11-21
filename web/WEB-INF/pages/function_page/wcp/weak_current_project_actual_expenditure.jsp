<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<div class="layui-card">
	<div class="layui-card-body">
		<div class="layui-form toolbar">
			<div class="layui-inline" style="width: 40%">
				<select name="WCPAselect" xm-select="WCPAselect" lay-verify="required"
				class="layui-input-inline" lay-vertype="tips" xm-select-search="" xm-select-search-type="dl"
				xm-select-show-count="3" xm-select-skin="default">
				</select>
			</div>
			<div id="layerDemo" class="layui-inline layui-btn-group" style="width: 50%">
				<button class="layui-btn layui-btn-normal" lay-filter="queryWeakCurrentProjectsActualExpenditure"
				data-method="queryWeakCurrentProjectsActualExpenditure" type="button" lay-submit="">
					<i class="layui-icon layui-icon-search">
					</i>
					搜索
				</button>
				
			</div>
		</div>
	</div>
</div>
<div class="layui-card">
  <div class="layui-card-body layui-colla-item">
	<div class="layui-row layui-col-space15">
	    <div class="layui-col-xs6 layui-col-md3">
	            <div class="layui-card-body" id="dTree_WCPA_div">
							<ul id="dTree_WCPA" class="dtree" data-id="0">
							</ul>
	            </div>
	    </div>
	    <div class="layui-col-xs6 layui-col-md9">
	            <div class="layui-card-body">
	               <table id="wcp_actual_expenditure_table" lay-data="{id: 'wcp_actual_expenditure_table'}"
							lay-filter="wcp_actual_expenditure_table_tool"  class="layui-table" lay-size="sm" >
							</table>
	            </div>
	    </div>
	</div>
  </div>
</div>
<script type="text/html" id="wcp_actual_expenditure_toolbar">
  <div class="layui-btn-container">
    <button class="layui-btn layui-btn-sm" lay-event="print_wcp_reimbursement" id="print_wcp_reimbursement">打印报销单</button>
  </div>
</script>
<script type="text/html" id="wcp_actual_expenditure_tool_bar">
	<a class="layui-btn layui-btn-normal layui-btn-xs" data-dropdown="#dropdown-wcp-actual_expenditure-user-{{d.actual_id}}" data-anchor="right-center">
		 操作<i class="layui-icon layui-icon-triangle-d" style="font-size: 12px !important;"></i>
	</a>
    <div class="dropdown-menu fixed" id="dropdown-wcp-actual_expenditure-user-{{d.actual_id}}">
		<ul>
			<li class="title">项目名称:{{d.project_name}}</li>
			<li><a lay-event="show">查看</a></li>
			<li><a lay-event="show_wcp_approva_log"><i class="layui-icon layui-icon-form"></i>审批历史</a></li>
		{{#  if(d.audit_status!=2041){ }}
			<shiro:hasRole name="wck_per_user">
				<li><a lay-event="edit"><i class="layui-icon layui-icon-edit"></i>修改</a></li>
				<!--<li><a lay-event="del" style="color:red">删除</a></li>-->
			</shiro:hasRole>
		{{#  } }}
		{{#  if(d.audit_status==2010){ }}
			<shiro:hasRole name="ruod">
				<li><a lay-event="pending"><i class="layui-icon layui-icon-edit"></i>成本报销-大区负责人审核</a></li>
			</shiro:hasRole>
		{{#  } }}  
		{{#  if(d.audit_status==2020){ }}
			<shiro:hasRole name="ruoa">
				<li><a lay-event="pending"><i class="layui-icon layui-icon-edit"></i>成本报销-管理员审核</a></li>
			</shiro:hasRole>
		{{#  } }}  
		{{#  if(d.audit_status==2030){ }}
			<shiro:hasRole name="ruof">
				<li><a lay-event="pending"><i class="layui-icon layui-icon-edit"></i>成本报销-财务审核</a></li>
			</shiro:hasRole>
		{{#  } }}  
		{{#  if(d.audit_status==2040){ }}
			<shiro:hasRole name="ruob">
				<li><a lay-event="pending"><i class="layui-icon layui-icon-edit"></i>成本报销-BOSS审核</a></li>
			</shiro:hasRole>
		{{#  } }}
					
		</ul>
	</div>
</div>
</script>

<script type="text/javascript" language="javascript"
	src="assets/pages/wcp/wcp_actual_expenditure.js"></script>