<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
	<div class="layui-card">
	    <div class="layui-card-header">
	        <h2 class="header-title">二级事项</h2>
	        <span class="layui-breadcrumb pull-right">
	          <a href="#!function_page_workitemfirst">一级事项</a>
	          <a><cite>二级事项</cite></a>
	        </span>
	    </div>
	    <div class="layui-card-body">
	        <div class="layui-form toolbar">
	        
			<shiro:hasPermission name="queryInfoBySearchCondition">
	        <div class="layui-inline"  style="width:40%">
				<select name="SearchCondition" xm-select="panorama_selectId" lay-verify="required" class="layui-input-inline" 
					lay-vertype="tips" xm-select-search=""
					xm-select-search-type="dl" xm-select-show-count="3"
					xm-select-skin="default">
				</select>
			</div>
			</shiro:hasPermission>
			<div id="layerDemo" class="layui-inline layui-btn-group"  style="width:50%">
				<shiro:hasPermission name="queryInfoBySearchCondition">  
				  <button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="quretPanorama"><i class="layui-icon layui-icon-search"></i>搜索</button>
				  </shiro:hasPermission>
				  <shiro:hasPermission name="tpl/add_panorama">  
				  <button class="layui-btn layui-btn-normal" data-method="addPanoramaWindow" type="button"><i class="layui-icon layui-icon-add-1"></i>新增二级事项</button>
				   </shiro:hasPermission>
				  <shiro:hasPermission name="tpl/addstep"> 
				  <button class="layui-btn layui-btn-normal" data-method="addStepWindow" type="button"><i class="layui-icon layui-icon-edit"></i>添加/更新步骤</button>
				  </shiro:hasPermission>
				  <shiro:hasPermission name="batchDeleteSecondByItemId"> 
					<button class="layui-btn layui-btn-danger" data-method="batchPanoramaDelete" type="button" id="batchDeletePanorama"><i class="layui-icon layui-icon-delete"></i>批量删除</button>
				 </shiro:hasPermission>
				 <!--<button class="layui-btn" data-method="downloadPanorama" type="button" id="downloadPanorama"><i class="layui-icon layui-icon-download-circle"></i>导出数据</button>
				 --></div>
        </div>
    		<table id="pannrama_table" lay-filter="panorama_table_tool"></table>
    </div>
</div>
	

<script type="text/html" id="table_step" >
<shiro:lacksPermission name="table_step"><a class="layui-btn layui-btn-primary layui-btn-xs">无权限</a></shiro:lacksPermission>
  <shiro:hasPermission name="table_step"> 
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="step">步骤</a>
 </shiro:hasPermission>
</script>
		<script type="text/html" id="panorama_tool_bar" >
<div class="layui-btn-group">
  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="detail" >详情</a>
  <shiro:hasPermission name="tpl/progress"> 
  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="progress">进展</a>
 </shiro:hasPermission>
  <shiro:hasPermission name="tpl/edit_panorama"> 
  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">修改</a>
 </shiro:hasPermission>
  <shiro:hasPermission name="deleteItemSecond"> 
  <a class="layui-btn layui-btn-danger  layui-btn-xs" lay-event="del">删除</a>
 </shiro:hasPermission>
</div>
</script>

<script type="text/javascript" language="javascript" src="assets/pages/panorama.js"></script>
