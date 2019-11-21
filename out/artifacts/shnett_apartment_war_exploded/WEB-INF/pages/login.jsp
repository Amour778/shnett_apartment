<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
	<link rel="shortcut icon" href="assets/images/favicon.ico" type="image/x-icon">
    <title>用户登录</title>
    <link rel="stylesheet" href="assets/libs/layui/css/layui.css"/>
    <link rel="stylesheet" href="assets/css/login.css" media="all">
</head>

<body>
<div class="login-wrapper"  >

    <div class="login-body">
        <div class="layui-card">
            <div class="layui-card-header">
                <h1>智慧公寓</h1><!-- <i class="layui-icon layui-icon-engine"></i> -->
            </div>
            <div class="layui-card-body layui-form layui-form-pane">
                <div class="layui-form-item">
                    <label class="layui-form-label"><i class="layui-icon layui-icon-username"></i></label>
                    <div class="layui-input-block">
                        <input name="username" id="username" type="text" lay-verify="required" placeholder="账号"
                               autocomplete="off"  class="layui-input" >
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><i class="layui-icon layui-icon-password"></i></label>
                    <div class="layui-input-block">
                        <input name="password" type="password" id="password" lay-verify="required" placeholder="密码"
                               autocomplete="off"  class="layui-input" >
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><i class="layui-icon layui-icon-vercode"></i></label>
                    <div class="layui-input-block">
                        <div class="layui-row inline-block">
                            <div class="layui-col-xs7">
                                <input name="code" type="text" lay-verify="required" placeholder="验证码" id="validateCode"
                                       autocomplete="off"  class="layui-input">
                            </div>
                            <div class="layui-col-xs5" style="padding-left: 10px;">
                                <img id="codeImg" title='看不清楚，换个图片' src="IdentifyingCode" onclick="changePicture()"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <button lay-filter="login-submit" class="layui-btn layui-btn-fluid" lay-submit id="login_btn"><i class="layui-icon layui-icon-release"></i>登 录</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="assets/libs/layui/layui.js"></script>
<script type="text/javascript" src="assets/libs/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="assets/libs/sha1.js"></script>
<script><!--
function allinfo(){
     if (!!window.ActiveXObject || "ActiveXObject" in window){ return true;}else{ return false;}
} 
var ip_address=null;
//创建RTCPeerConnection接口
/*let conn = new RTCPeerConnection({
		iceServers: []
	}) 
let noop = function(){}
conn.onicecandidate = function(ice){
	if (ice.candidate){
		let ip_regex = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/
		let ip_addr = ip_regex.exec(ice.candidate.candidate)[1];
		ip_address=ip_addr;
		conn.onicecandidate = noop;
	}
}
conn.createDataChannel('getIpAddress');
conn.createOffer(conn.setLocalDescription.bind(conn),noop);*/

  //点击第二个图片的刷新操作
    function changePicture(){
    	 var imgSrc = $("#codeImg");
         var src = imgSrc.attr("src");
         imgSrc.attr("src", chgUrl(src));
     }  

 　　 //加入时间戳，去缓存机制   
    function chgUrl(url) {
        var timestamp = (new Date()).valueOf();
        if ((url.indexOf("&") >= 0)) {
            url = url + "&timestamp=" + timestamp;
        } else {
            url = url + "?timestamp=" + timestamp;
        }
        
        return url;
    }
    layui.config({
        base: 'module/'
    }).use(['admin', 'form'], function () {
        var $ = layui.jquery;
        var form = layui.form;
         var admin = layui.admin;
		if(allinfo()){
			/*layer.alert("使用IE浏览器会发生意想不到的问题，请使用其他浏览器访问");
			var imgSrc = $("#codeImg");
         	var src = imgSrc.attr("src");
         	imgSrc.attr("src",null);
         	$('#login_btn').addClass("layui-btn-disabled").attr("disabled", "disabled");*/
		}
		//回车监听
		$(document).keydown(function (e) {
			if (e.keyCode === 13) {
				$("#login_btn").trigger("click");
			}
		});
        // 表单提交
        form.on('submit(login-submit)', function (obj) {
            layer.load(2);
            admin.ajax_load_json({
                url: admin.base_server + 'tologin',
                 data: {
                    username: $("#username").val(),
                    password: hex_sha1($("#password").val()),
                    validateCode: $("#validateCode").val(),
                    ip:ip_address
                },
                success: function (data) {
                    if (data.code==0) {
                    	location.replace('./index#!home_console');
                        //layer.msg('登录成功', {icon: 1}, function () {});
                    } else {
                    	changePicture();
                        layer.msg(data.info, {icon: 5});
                    }
                },
                error: function (xhr) {
                    layer.closeAll('loading');
                    if (xhr.status == 400) {
                        layer.msg('未知错误', {icon: 5});
                    }
                }
            });
        });

		
        // 图形验证码
        $('.login-captcha').click(function () {
            this.src = this.src + '?t=' + (new Date).getTime();
        });
    });
--></script>
</body>
</html>