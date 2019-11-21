<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="layui-card-header">
    <h2 class="header-title">用户[ <a id="userid_a"></a> ]角色</h2>
</div>
     <select name="SearchCondition" xm-select="selectId" lay-verify="required" class="layui-input-inline" 
				lay-vertype="tips" xm-select-search=""
				xm-select-search-type="dl"  xm-select-show-count="5"
				xm-select-skin="default">
			</select>
			 <div class="layui-form-item">
    <div class="layui-input-block">
<button class="layui-btn layui-btn-normal" data-method="updataUserRoleByUserId">提交</button>
</div></div>
<script type="text/javascript" language="javascript">
layui.use(['layer', 'admin','formSelects'],function() {
	layer = layui.layer,
	form = layui.form,
	$ = layui.jquery,
	formSelects = layui.formSelects;
	console.log(admin.getTableBtnInfo());
	var user_id=admin.getTableBtnInfo();
	$("#userid_a").text(user_id);
	formSelects.data('selectId', 'server', {
	    url: admin.base_server+"getAllRoleWithUserIdToFromSelect",
    	keyword: user_id
	});
	$('.layui-btn').on('click',function() {
		var othis = $(this),
		method = othis.data('method');
		active[method] ? active[method].call(this, othis) : '';
	});
	var active = {
		updataUserRoleByUserId: function() {
			$.ajax({
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				url:admin.base_server+"updataUserRoleByUserId",
				async:false,
				data: {
					user_name:user_id,
					user_role_string : formSelects.value('selectId', 'valStr') 
				},
				beforeSend: function() {
					layer.load(0);
				},success: function(data) {
					var obj = JSON.parse(data);
					if (obj.code == 0) {
					layer.closeAll();
						layer.msg(obj.info, {
							icon: 1
						});
					}else{
					layer.closeAll('loading');
						layer.alert(obj.info, {
							icon: 5
						});
					}
					
				},
				complete: function() {
					layer.closeAll('loading');
				}
			})
		}
	}
  
});
</script>