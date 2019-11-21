<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
	<div class="layui-card">
	    <div class="layui-card-body">
	        <div class="layui-form toolbar">
			<div id="layerDemo" class="layui-inline layui-btn-group"  style="width:50%">
				  <button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="quretParameter"><i class="layui-icon layui-icon-search"></i>搜索</button>
				  <button class="layui-btn layui-btn-normal" data-method="addParameter" type="button"><i class="layui-icon layui-icon-add-1"></i>添加参数</button>
				 
        	</div>
        </div>
    		<table id="parameter_table" lay-filter="parameter_table_filter"></table>
    </div>
</div>
	
<script type="text/html" id="parameter_table_tool_bar" >
<div class="layui-btn-group">
  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">修改</a>
  <a class="layui-btn layui-btn-danger  layui-btn-xs" lay-event="del">删除</a>
</div>
</script>
<script type="text/html" id="sexSelected" >
 <input type="checkbox" name="select" value="{{d.select}}" lay-skin="switch" lay-text="是|否" lay-filter="sexSelected" {{ d.select == 'selected' ? 'checked' : '' }}>
</script>
<script type="text/html" id="sexDisabled" >
 <input type="checkbox" name="disable" value="{{d.disable}}" lay-skin="switch" lay-text="是|否" lay-filter="sexDisabled" {{ d.disable == 'disabled' ? 'checked' : '' }}>
</script>

<script type="text/javascript" language="javascript" src="assets/pages/wcp/wcp_parameter.js"></script>
