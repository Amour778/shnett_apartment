<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
	<div class="layui-card">
	    <div class="layui-card-body">
	        <div class="layui-form toolbar">
	        <div class="layui-inline"  style="width:40%">
				<select name="WeChatEdianzuselect" xm-select="WeChatEdianzuselect" lay-verify="required" class="layui-input-inline" 
					lay-vertype="tips" xm-select-search=""
					xm-select-search-type="dl"  xm-select-show-count="3"
					xm-select-skin="default">
				</select>
			</div>
			 <div class="layui-inline">
		      <label class="layui-form-label">日期范围</label>
		      <div class="layui-input-inline">
		        <input type="text" class="layui-input" id="WeChatEdianzuDataRange" placeholder=" ~ ">
		      </div>
		    </div>
			<div class="layui-inline layui-btn-group" id="layerDemo">
				  <button class="layui-btn layui-btn-normal" data-method="quretWeChatEdianzuInformationGathering"><i class="layui-icon layui-icon-search"></i>搜索</button>
				 <button class="layui-btn" data-method="exportExcelWeChatEdianzu" id="exportExcelWeChatEdianzu" type="button"><i class="layui-icon layui-icon-download-circle"></i>导出数据</button>
        </div>
    		<table id="wechat_edianzu_information_gathering_table" lay-filter="wechat_edianzu_information_gathering_table_tool"></table>
    </div>
</div>
<script type="text/html" id="wechat_edianzu_information_gathering_table_tool_bar" >
  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="detail"><i class="layui-icon layui-icon-picture"></i></a>

</script>

<script type="text/javascript" language="javascript" src="assets/pages/wechat_edianzu_information_gathering.js"></script>
