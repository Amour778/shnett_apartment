<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!-- 菜单 -->
<div class="layui-card">
	    <div class="layui-card-header">
	        <h2 class="header-title">角色管理</h2>
	        <span class="layui-breadcrumb pull-right">
	          <a href="#!home_console">首页</a>
	          <a><cite>角色管理</cite></a>
	        </span>
	    </div>
	    <div class="layui-card-body">
	        <div class="layui-form toolbar">

<div class="layui-form layui-form-pane">
<div class="layui-inline">
					<label class="layui-form-label">
						角色昵称
					</label>
					<div class="layui-input-inline" style="width: 200px;">
						<input type="text" name="role_nickname" autocomplete="off"
							id="role_nickname" class="layui-input"  placeholder="" >
					</div>
				</div>
	<div class="layui-btn-group">
		<shiro:hasPermission name="get_role">  
		<button class="layui-btn layui-btn-normal" data-method="get_role"><i class="layui-icon layui-icon-search"></i>搜索</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="add_role">  
		<button class="layui-btn layui-btn-normal" data-method="add_role"><i class="layui-icon layui-icon-add-1"></i>添加</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="batch_del_role">  
		<button class="layui-btn layui-btn-danger" data-method="batch_del_role" id="batch_del_role"><i class="layui-icon layui-icon-delete"></i>批量删除</button>
		</shiro:hasPermission>
	</div>
</div>
</div>
<table id="table_role" cellspacing="0" cellpadding="0" border="0" class="layui-table" lay-filter="table_role_lay-filter"></table>
</div>
</div>

<!-- 表格 -->
<script type="text/javascript" language="javascript" src="assets/pages/role.js"></script>
<script type="text/html" id="role_bar">
		<shiro:hasPermission name="tpl/edit_role_permission">  
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit_role_permission" lay-tips="角色权限" ><i class="layui-icon layui-icon-edit"></i></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="del_role">  
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del_role" lay-tips="删除"><i class="layui-icon layui-icon-delete"></i></a>
		</shiro:hasPermission>

</script>