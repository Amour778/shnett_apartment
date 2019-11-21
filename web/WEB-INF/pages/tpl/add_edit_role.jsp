<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
			<form class="layui-form  layui-form-pane">
				<div class="layui-form-item">
					<label class="layui-form-label">角色ID</label>
					<div class="layui-input-block">
						<input class="layui-input" type="number" name="role_id" id="role_id" autocomplete="off" placeholder="例如：1000" lay-verify="required"/>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">角色名称</label>
					<div class="layui-input-block">
						<input class="layui-input" type="text" name="role_name"  id="role_name" autocomplete="off" placeholder="例如：admin" lay-verify="required"/>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">角色昵称</label>
					<div class="layui-input-block">
						<input class="layui-input" type="text" name="role_nickname"  id="role_nickname_fromData" autocomplete="off" placeholder="例如：管理员" lay-verify="required"/>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">选择权限</label>
				</div>
				
				<div class="layui-col-md11 layui-col-md-offset1">
			<div class="layui-form">
				<div class="layui-form-item">
					<div class="layui-form-block">
						<button type="button" class="layui-btn layui-btn-primary" onclick="checkAll('#LAY-auth-tree-index')">全选</button>
						<button type="button" class="layui-btn layui-btn-primary" onclick="uncheckAll('#LAY-auth-tree-index')">全不选</button>
						
					</div>
				</div>
			</div>
		</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
						<div id="LAY-auth-tree-index"></div>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" type="submit" lay-submit lay-filter="LAY-auth-tree-submit">提交</button>
					</div>
				</div>
			</form>
<script type="text/javascript">
layui.use(['jquery', 'authtree', 'form', 'layer', 'admin'], function(){
	var $ = layui.jquery;
	var authtree = layui.authtree;
	var form = layui.form;
	var layer = layui.layer;
	var admin = layui.admin;
	var ROLE_ID=admin.getTableBtnInfo();
	// 初始化
	$.ajax({
		url: 'getAllPermissionInfoToAuthtree',
		dataType: 'json',
		success: function(data){
		if(data.code==1){
			layer.msg(data.msg);
		}else{
			// 渲染时传入渲染目标ID，树形结构数据（具体结构看样例，checked表示默认选中），以及input表单的名字
			authtree.render('#LAY-auth-tree-index', data.data.trees, {
				inputname: 'role_per[]', 
				layfilter: 'lay-check-auth', 
				openall: true,
				autowidth: true
			});
			if(ROLE_ID==null)
				return;
			//根据角色信息自动选中已拥有权限
			$.ajax({
			   url: 'getRoleInfoByRoleId',
			   data: {
			       role_id:ROLE_ID
			   },
			   dataType: 'json',
			   type: 'POST',
			   success: function(result,status,xhr) {
					layer.closeAll('loading');
					$("#role_id").val(result.info[0].role_id).attr("disabled","disabled");
					$("#role_name").val(result.info[0].role_name);
					$("#role_nickname_fromData").val(result.info[0].role_nickname);
					console.log('$("#role_nickname").val()='+$("#role_nickname").val());
					var origin = $('#LAY-auth-tree-index');
					var role_per=result.info[0].role_per.split(",");
					for(var a= 0;a<role_per.length;a++){
						origin.find('input[value="'+role_per[a]+'"]:not(:checked)').prop('checked', true);
					}
					form.render('checkbox');
			   },beforeSend: function() {
						layer.load(0);
				},
				complete: function() {
					layer.closeAll('loading');
				}
			});
			
			
			
			}
		},
		error:function(data){
			layer.msg("获取权限数据失败");
		}
	});
	form.on('submit(LAY-auth-tree-submit)', function(obj){
		var authids = authtree.getChecked('#LAY-auth-tree-index');
		var role_per="";
		for(var a= 0 ; a < authids.length ; a++){
			role_per+=authids[a]+",";
		}
		role_per=role_per.substring(0,role_per.length-1);
		obj.field.role_per = role_per;
		if(ROLE_ID==null){
			//添加角色
			$.ajax({
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				url: "add_role",
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
			//更新角色
			$.ajax({
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				url: "updateRoleInfoByRoleId",
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
<script type="text/javascript">
// 全选样例
function checkAll(dst){
	layui.use(['jquery', 'layer', 'authtree'], function(){
		var layer = layui.layer;
		var authtree = layui.authtree;
		authtree.checkAll(dst);
	});
}
// 全不选样例
function uncheckAll(dst){
	layui.use(['jquery', 'layer', 'authtree'], function(){
		var layer = layui.layer;
		var authtree = layui.authtree;
		authtree.uncheckAll(dst);
	});
}
// 显示全部
function showAll(dst){
	layui.use(['jquery', 'layer', 'authtree'], function(){
		var layer = layui.layer;
		var authtree = layui.authtree;
		authtree.showAll(dst);
	});
}
</script>
