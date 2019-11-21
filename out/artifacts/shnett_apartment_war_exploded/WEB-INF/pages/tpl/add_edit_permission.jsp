<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
			<form class="layui-form  layui-form-pane">
				<div class="layui-form-item">
					<label class="layui-form-label">权限ID</label>
					<div class="layui-input-block">
						<input class="layui-input" type="number" name="menuId" id="menuId" autocomplete="off" placeholder="例如：01"  lay-verify="required" lay-tips="ID长度为2位则表示为父菜单，<br/>4位则表示为子菜单(其中前2位是父菜单ID)，<br/>6位则表示为界面按钮(其中前4位是子菜单ID)"/>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">权限名称</label>
					<div class="layui-input-block">
						<input class="layui-input" type="text" name="name"  id="name" autocomplete="off" placeholder="例如：主页" lay-verify="required"/>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">URL</label>
					<div class="layui-input-block">
						<input class="layui-input" type="text" name="url"  id="url" autocomplete="off" placeholder="例如：home/console" lay-verify="required"/>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label" lay-tips="相关页面路径">相关页面路径</label>
					<div class="layui-input-block">
						<input class="layui-input" type="text" name="path"  id="path" autocomplete="off" placeholder="例如：home/console.jsp" />
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">图标</label>
					<div class="layui-input-block">
						<input class="layui-input" type="text" name="icon"  id="icon" autocomplete="off" placeholder="例如：layui-icon-home" />
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" type="submit" lay-submit lay-filter="submit_add_edit_permission">提交</button>
					</div>
				</div>
			</form>
<script type="text/javascript">
layui.use(['jquery',  'form', 'layer', 'admin'], function(){
	var $ = layui.jquery;
	var form = layui.form;
	var layer = layui.layer;
	var admin = layui.admin;
	var PERMISSION_ID=admin.getTableBtnInfo();
	
	$("#icon").bind("input propertychange",function(event){
       $("#icon").attr("lay-tips","<i class='layui-icon "+$("#icon").val()+"'></i>");
		layer.tips("<i class='layui-icon "+$("#icon").val()+"'></i>", '#icon', {
	  tips: 1
	});
	});
	
	console.log("PERMISSION_ID==="+PERMISSION_ID);
	// 初始化
	if(PERMISSION_ID!=null){
	//根据角色信息自动选中已拥有权限
	$.ajax({
	   url: 'getRoleInfoByMenuId',
	   data: {
	       menuId : PERMISSION_ID
	   },
	   dataType: 'json',
	   type: 'POST',
	   success: function(result,status,xhr) {
			layer.closeAll('loading');
			$("#menuId").val(result.info[0].menuId).attr("disabled","disabled");
			$("#name").val(result.info[0].name);
			$("#url").val(result.info[0].url);
			$("#path").val(result.info[0].path);
			$("#icon").val(result.info[0].icon).attr("lay-tips","<i class='layui-icon "+result.info[0].icon+"'></i>");
	   },beforeSend: function() {
				layer.load(0);
		},
		complete: function() {
			layer.closeAll('loading');
		}
	});
	}
	
	form.on('submit(submit_add_edit_permission)', function(obj){
		if(PERMISSION_ID==null){
			//添加权限
			$.ajax({
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				url: "add_permission",
				data: obj.field,
				beforeSend: function() {
					layer.load(0);
				},
				success: function(data) {
					layer.closeAll('loading');
					var obj = JSON.parse(data);
					if (obj.code == 0) {
						layer.closeAll();
						layer.msg(obj.info, {
							icon: 1
						});
						
					} else {
						layer.alert(obj.info, {
							icon: 5
						});
					}
				},
				complete: function() {
					layer.closeAll('loading');
				}
			});
		}else{
			//更新权限
			obj.field.menuId=PERMISSION_ID;
			$.ajax({
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				url: "updateRoleInfoByMenuId",
				data: obj.field,
				beforeSend: function() {
					layer.load(0);
				},
				success: function(data) {
					layer.closeAll('loading');
					var obj = JSON.parse(data);
					if (obj.code == 0) {
						layer.closeAll();
						layer.msg(obj.info, {
							icon: 1
						});
						
					} else {
						layer.alert(obj.info, {
							icon: 5
						});
					}
				},
				complete: function() {
					layer.closeAll('loading');
				}
			});
		}
		return false;
	});
});
</script>
