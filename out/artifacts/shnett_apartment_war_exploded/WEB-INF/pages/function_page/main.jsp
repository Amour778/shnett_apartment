<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport"
			content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		<link rel="stylesheet" href="statics/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="statics/css/pages/main.css" media="all" />
	</head>
	<body class="childrenBody">
		<fieldset class="layui-elem-field layui-field-title"
			style="margin-top: 30px;">
			<legend>
				系统公告
			</legend>
		</fieldset>
		<ul class="layui-timeline">
			<li class="layui-timeline-item">
				<i class="layui-icon layui-anim layui-anim-rotate layui-anim-loop layui-timeline-axis layui-icon-tips"></i>
				<div class="layui-timeline-content">
					<h3 class="layui-timeline-title">
						2018年9月18日
					</h3>
					<p>
						添加：成功添加二级事项后，系统会自动发送通知短信给负责人。(手机号码请到用户管理模块维护)
					</p>
				</div>
			</li>
			<li class="layui-timeline-item">
				<i class="layui-icon layui-timeline-axis">&#xe63f;</i>
				<div class="layui-timeline-content">
					<h3 class="layui-timeline-title">
						2018年9月4日
					</h3>
					<p>
						添加：用户管理功能，菜单路径：系统设置-用户管理
					</p>
				</div>
			</li>
			<li class="layui-timeline-item">
				<i class="layui-icon layui-timeline-axis">&#xe63f;</i>
				<div class="layui-timeline-content">
					<div class="layui-timeline-title">
						测试项目上线
					</div>
				</div>
			</li>
		</ul>
		<script type="text/javascript" src="statics/layui/layui.js"></script>
		<script type="text/javascript" src="statics/js/pages/main.js"></script>
	</body>
</html>