<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form class="layui-form layui-form-pane" id="form">
  <div class="layui-form-item">
    <label class="layui-form-label">用户账号</label>
    <div class="layui-input-block">
      <input type="text" name="user_id" id="user_id" required  lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">用户名称</label>
    <div class="layui-input-block">
      <input type="text" name="user_name"   id="user_name" required lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">手机号码</label>
    <div class="layui-input-block">
      <input type="text" name="user_tel" required  id="user_tel" lay-verify="required|phone" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">易点租地区</label>
    <div class="layui-input-block">
      <input type="text" name="user_area_wechat_edianzu" required  id="user_area_wechat_edianzu" lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">弱电-所属大区</label>
    <div class="layui-input-block">
      <input type="text" name="wcp_area" required  id="wcp_area" lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">用户角色</label>
    <div class="layui-input-block">
     <select name="SearchCondition" xm-select="addUserSelectUserRole" lay-verify="required" class="layui-input-block" 
				lay-vertype="tips" xm-select-search=""
				xm-select-search-type="dl"  xm-select-show-count="5"
				xm-select-skin="default">
			</select>
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
    </div>
  </div>
</form>
<script type="text/javascript" language="javascript">
layui.use(['form', 'layer','formSelects'], function(){
  var layer = layui.layer
  ,$ =  layui.jquery
  ,formSelects = layui.formSelects
  ,form = layui.form;
  formSelects.data('addUserSelectUserRole', 'server', {
	    url: admin.base_server+"getAllRole"
	});
  //监听提交
  form.on('submit(formDemo)', function(data){
	$.ajax({
		type: "POST",
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		url: "add_user",
		async:false,
		data: {
			user_id:$("#user_id").val(),
			user_name:$("#user_name").val(),
			user_tel:$("#user_tel").val(),
			user_area_wechat_edianzu:$("#user_area_wechat_edianzu").val(),
			wcp_area:$("#wcp_area").val(),
			user_role:formSelects.value('addUserSelectUserRole', 'valStr') 
		},
		beforeSend: function() {
			layer.load(0);
		},
		success: function(data) {
			layer.closeAll();
			var obj = JSON.parse(data);
			if (obj.code == 0) {
				layer.msg(obj.info, {
					icon: 1
				});
			}
			else{
			layer.alert(obj.info, {
				icon: 5
			});
		}
		},
		complete: function() {
			layer.closeAll('loading');
		}
	});
    return false;
  });
});
</script>