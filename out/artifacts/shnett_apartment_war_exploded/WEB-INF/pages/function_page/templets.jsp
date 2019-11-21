<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>

<!-- 模板取消锁定的密码为：a123a123 -->
<div class="layui-card">
	    <div class="layui-card-header">
	        <h2 class="header-title">模板下载</h2>
	        <span class="layui-breadcrumb pull-right">
	          <a href="#!home_console">首页</a>
	          <a><cite>模板下载</cite></a>
	        </span>
	    </div>
	    <div class="layui-card-body">
	        <div class="layui-form toolbar">
	        </div>
<table id="templets_demo" lay-filter="templets_test"></table>
	        </div>
	        </div>

<script src="assets/pages/templets.js"></script>
<script type="text/html" id="templets_barDemo"><a class="layui-btn layui-btn-xs" lay-event="detail">下载</a></script>