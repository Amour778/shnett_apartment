<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
	<div class="layui-card">
	    <div class="layui-card-header">
	        <h2 class="header-title">立项</h2>
	        <span class="layui-breadcrumb pull-right">
	           <a href="#!function_page_wcp_weak_current_projects_summary">项目总表</a>
	           <a href="#!function_page_wcp_weak_current_project_actual_expenditure">成本报销</a>
	        </span>
	    </div>
	    <div class="layui-card-body">
	        <div class="layui-form toolbar">
	        <div class="layui-inline"  style="width:40%">
				<select name="WCPSselect" xm-select="WCPSselect" lay-verify="required" class="layui-input-inline" 
					lay-vertype="tips" xm-select-search=""
					xm-select-search-type="dl"  xm-select-show-count="3"
					xm-select-skin="default">
				</select>
			</div>
			<div id="layerDemo" class="layui-inline layui-btn-group"  style="width:50%">
			<shiro:hasPermission name="quretWeakCurrentProjectSimple">  
				  <button class="layui-btn layui-btn-normal" lay-filter="quretWeakCurrentProjectSimple" data-method="quretWeakCurrentProjectSimple" type="button" lay-submit><i class="layui-icon layui-icon-search"></i>搜索</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="addWeakCurrentProjectWindow">  
				  <button class="layui-btn layui-btn-normal" data-method="addWeakCurrentProjectWindow" type="button"><i class="layui-icon layui-icon-add-1"></i>新增立项</button>
			</shiro:hasPermission>
			</div>
        </div>
    		<table id="weak_current_project_table" lay-filter="weak_current_project_table_tool"  class="layui-table" lay-size="sm" ></table>
    </div>
</div>
<script type="text/html" id="weak_current_project_tool_bar" >
 <a class="layui-btn layui-btn-normal layui-btn-xs" data-dropdown="#dropdown-wcp-detail-{{d.project_code}}" data-anchor="right-center">
      操作<i class="layui-icon layui-icon-triangle-d" style="font-size: 12px !important;"></i>
    </a>
    <div class="dropdown-menu fixed" id="dropdown-wcp-detail-{{d.project_code}}">
        <ul>
			<li class="title">项目名称:{{d.project_name}}</li>
		<shiro:hasRole name="wck_per_user">
            	<li><a lay-event="show_wcp_simple"><i class="layui-icon layui-icon-form"></i>查看立项内容</a></li>
            	<li><a lay-event="show_wcp_approva_log"><i class="layui-icon layui-icon-form"></i>审批历史</a></li>
			{{#  if(d.audit_status != 1030){ }}
            	<li><a lay-event="edit"><i class="layui-icon layui-icon-edit"></i>修改</a</li>
            	<li><a lay-event="revoke" style="color:red"><i class="layui-icon layui-icon-unlink"></i>撤项</a></li>
			{{#  } }} 
		</shiro:hasRole>
		<shiro:hasAnyRoles name="ruod">
            	<li><a lay-event="show_wcp_simple"><i class="layui-icon layui-icon-form"></i>查看立项内容</a></li>
            	<li><a lay-event="show_wcp_approva_log"><i class="layui-icon layui-icon-form"></i>审批历史</a></li>
			{{#  if(d.audit_status === 1010) {}}
            	<li><a lay-event="show_wcp_simple"><i class="layui-icon layui-icon-edit"></i>审批立项内容</a></li>
			{{#  } }} 
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="ruoa">
            	<li><a lay-event="show_wcp_simple"><i class="layui-icon layui-icon-form"></i>查看立项内容</a></li>
            	<li><a lay-event="show_wcp_approva_log"><i class="layui-icon layui-icon-form"></i>审批历史</a></li>
			{{#  if(d.audit_status === 1020) {}}
            	<li><a lay-event="show_wcp_simple"><i class="layui-icon layui-icon-edit"></i>审批立项内容</a></li>
			{{#  } }} 
		</shiro:hasAnyRoles>
        </ul>
    </div>
</script>

<script type="text/javascript" language="javascript" src="assets/pages/wcp/weak_current_project.js"></script>
