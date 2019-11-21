<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!-- 菜单 -->
<div class="layui-card">
	    <div class="layui-card-header">
	        <h2 class="header-title">权限管理</h2>
	        <span class="layui-breadcrumb pull-right">
	          <a href="#!home_console">首页</a>
	          <a><cite>权限管理</cite></a>
	        </span>
	    </div>
	    <div class="layui-card-body">
	        <div class="layui-form toolbar">
<div class="layui-form layui-form-pane">
<div class="layui-inline">
					<label class="layui-form-label">
						权限名称
					</label>
					<div class="layui-input-inline" style="width: 200px;">
						<input type="text" name="permission_name" autocomplete="off"
							id="permission_name" class="layui-input"  placeholder="" >
					</div>
				</div>
	<div class="layui-btn-group">
		<shiro:hasPermission name="get_permission">  
		<button class="layui-btn layui-btn-normal" data-method="get_permission"><i class="layui-icon layui-icon-search"></i>搜索</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="add_permission">  
		<button class="layui-btn layui-btn-normal" data-method="add_permission"><i class="layui-icon layui-icon-add-1"></i>添加</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="batch_del_permission">  
		<button class="layui-btn layui-btn-danger" data-method="batch_del_permission" id="batch_del_permission"><i class="layui-icon layui-icon-delete"></i>批量删除</button>
		</shiro:hasPermission>
	</div>
</div>
<!-- 表格 -->
<table id="table_permission" cellspacing="0" cellpadding="0" border="0" class="layui-table" lay-filter="table_permission_lay-filter"></table>
	</div>
</div>
</div>

<script type="text/javascript" language="javascript" src="assets/pages/permission.js"></script>
<script type="text/html" id="permission_bar">
		<shiro:hasPermission name="edit_permission">  
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit_permission" lay-tips="修改" ><i class="layui-icon layui-icon-edit"></i></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="del_permission">  
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del_permission" lay-tips="删除"><i class="layui-icon layui-icon-delete"></i></a>
		</shiro:hasPermission>

</script>