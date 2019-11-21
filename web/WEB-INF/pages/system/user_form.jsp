<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="layui-card-header">
    <h2 class="header-title">个人信息</h2>
</div>
<form class="layui-form layui-form-pane" lay-filter="formUserInfo">
  <div class="layui-form-item">
    <label class="layui-form-label">工号</label>
    <div class="layui-input-inline">
      <input type="text" name="user_id" readOnly="true" required   autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">姓名</label>
    <div class="layui-input-inline">
      <input type="text" name="user_name"  id="user_name" required  lay-verify="required"  autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">手机号码</label>
    <div class="layui-input-inline">
      <input type="text" name="user_tel"  id="user_tel" required  lay-verify="required|phone" placeholder="请输入11位手机号" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit lay-filter="saveUserInfo">保存</button>
    </div>
  </div>
</form>


<script type="text/javascript" language="javascript" src="assets/libs/sha1.js"></script>
<script type="text/javascript" language="javascript">
layui.use(['element','form', 'layer','admin','jquery'], function(){
  var layer = layui.layer
  ,$ =  layui.jquery
  ,element = layui.element
  ,admin = layui.admin
  ,form = layui.form;
  
  //获取登陆用户信息并填充
  $.ajax({
		type: "POST",
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		url: "getUserInfoWithUserId",
		async:false,
		beforeSend: function() {
			layer.load(0);
		},
		success: function(data) {
			layer.closeAll('loading');
			var obj = JSON.parse(data);
			if(obj.code==0){
				  form.val("formUserInfo", {
				  "user_id": obj.info[0].user_id
				  ,"user_name": obj.info[0].user_name
				  ,"user_tel":obj.info[0].user_tel
				})
			}else{
				layer.alert(obj.info, {
					icon: 5
				});
			}
		},
		complete: function() {
			layer.closeAll('loading');
		}
	});

  form.verify({
   repwd: function(value, item){
    if($("#pwd_new").val()!=value){
      return '两次输入的新密码不一致';
    }
  },
  pass: function(value, item){
     if(!new RegExp(/^[\S]{6,12}$/).test(value)){
      return '密码必须6到12位，且不能出现空格';
    }
  }
});      
      
  //监听提交
  form.on('submit(saveUserInfo)', function(data){
	$.ajax({
		type: "POST",
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		url: "updataUserNameAndTelWithUserId",
		async:false,
		data: {
			user_name : $("#user_name").val()
			,user_tel :$("#user_tel").val()
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
      
  //监听提交
  form.on('submit(changePwd)', function(data){
	$.ajax({
		type: "POST",
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		url: "updataUserPwdWithUserId",
		async:false,
		data: {
			pwd_old : hex_sha1($("#pwd_old").val())
			,pwd_new : hex_sha1($("#pwd_renew").val())
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