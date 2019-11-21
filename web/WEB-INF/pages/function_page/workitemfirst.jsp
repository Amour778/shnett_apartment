<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="layui-card">
	    <div class="layui-card-header">
	        <h2 class="header-title">一级事项</h2>
	        <span class="layui-breadcrumb pull-right">
	          <a href="#!function_page_panorama">二级事项</a>
	          <a><cite>一级事项</cite></a>
	        </span>
	    </div>
	    <div class="layui-card-body">
	        <div class="layui-form toolbar">

		<form class="layui-form layui-form-pane">
		
<shiro:hasPermission name="getItemFirstToTable">  
				<div class="layui-inline">
					<label class="layui-form-label">
						事项名称
					</label>
					<div class="layui-input-inline" style="width: 200px;">
						<input type="text" name="item_name" autocomplete="off"
							id="item_name" class="layui-input">
					</div>
				</div>
				
		</shiro:hasPermission>
				<div id="layerDemo" class="layui-inline layui-btn-group">
					<shiro:hasPermission name="getItemFirstToTable">  
						<button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="quretWorkitemfirst"><i class="layui-icon layui-icon-search"></i> 搜索</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="addItemFirst"> 
					<button class="layui-btn layui-btn-normal" data-method="addWorkitemfirstWindow" type="button"><i class="layui-icon layui-icon-add-1"></i> 增加</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="batchDeleteFirstByItemId"> 
					<button class="layui-btn layui-btn-danger" data-method="batdelWorkitemfirst" type="button" id="batchDeleteWorkitemfirst"><i class="layui-icon layui-icon-delete"></i> 批量删除</button>
					</shiro:hasPermission>
				</div>
		</form>
		 </div>
<table id="workitemfirst_first_teble" lay-filter="workitemfirst_table_tool"></table>
	        </div>
	        </div>
		
		<script type="text/html" id="workitemfirst_table_tool_bar">
<div class="layui-btn-group">
<shiro:lacksPermission name="updataItemFirst">
<shiro:lacksPermission name="deleteItemFirst">
<a class="layui-btn layui-btn-primary layui-btn-xs">无权限</a>
</shiro:lacksPermission>
</shiro:lacksPermission>
<shiro:hasPermission name="updataItemFirst"> 
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
</shiro:hasPermission>
<shiro:hasPermission name="deleteItemFirst"> 
  <a class="layui-btn layui-btn-danger  layui-btn-xs" lay-event="del">删除</a>
</shiro:hasPermission>
</div>
</script>
<script src="assets/pages/workitemfirst.js" charset="utf-8"></script>