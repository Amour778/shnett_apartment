<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="layui-card">
	    <div class="layui-card-header">
	        <h2 class="header-title">用户管理</h2>
	        <span class="layui-breadcrumb pull-right">
	          <a href="#!home_console">首页</a>
	          <a><cite>用户管理</cite></a>
	        </span>
	    </div>
	    <div class="layui-card-body">
	        <div class="layui-form toolbar">
					<label class="layui-form-label">
						用户工号
					</label>
					<div class="layui-input-inline" style="width: 200px;">
						<input type="text" name="item_name" autocomplete="off"
							id="input_value" class="layui-input search-input">
					</div>
	<div class="layui-btn-group">
		<button class="layui-btn layui-btn-normal" data-method="select"><i class="layui-icon layui-icon-search"></i>搜索</button>
		<!-- <button class="layui-btn" data-method="select"><i class="layui-icon layui-icon-refresh"></i></button>-->
		<button class="layui-btn layui-btn-normal" data-method="add"><i class="layui-icon layui-icon-add-1"></i>添加</button>
		<button class="layui-btn layui-btn-normal" data-method="upload" id="upload_file"><i class="layui-icon layui-icon-upload-drag"></i>导入数据</button>
		<button class="layui-btn layui-btn-danger" data-method="batch_del" id="del_btn"><i class="layui-icon layui-icon-delete"></i>批量删除</button>
		<!-- <button class="layui-btn" data-method="upload" style="background-color:#5FB878"><i class="layui-icon layui-icon-upload-drag"></i>导入数据</button> -->
	</div>
	
				</div>
<table id="demo" lay-filter="test" cellspacing="0" cellpadding="0" border="0" class="layui-table"></table>
</div>
</div>
<script type="text/javascript" language="javascript" src="statics/layui/layui.js"></script>
<script type="text/javascript" language="javascript" src="statics/js/pages/userinfo.js"></script>
<script type="text/html" id="com_state">
  <input type="checkbox" name="com_state" id="{{d.com_id}}" value="{{d.com_state}}" lay-skin="switch" lay-text="上架|下架" lay-filter="sexDemo" {{ d.com_state == 1 ? 'checked' : '' }}>
</script>
<script type="text/html" id="com_pic">
	<div id="{{d.com_id}}" class="layer-photos-demo"><img layer-src="{{d.com_pic}}" src="{{d.com_pic}}"></div>
</script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs layui-btn-primary" lay-event="edit">修改号码</a>
  <a class="layui-btn layui-btn-xs layui-btn-primary" lay-event="reset">重置密码</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
