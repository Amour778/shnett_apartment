<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="layui-card">
    <div class="layui-card-header">
        <h2 class="header-title">登录日志</h2>
        <span class="layui-breadcrumb pull-right">
          <a href="#!home_console">首页</a>
          <a><cite>登录日志</cite></a>
        </span>
    </div>
    <div class="layui-card-body">
        <div class="layui-form toolbar">
        <div class="layui-form layui-form-pane">
<div class="layui-inline">
<label class="layui-form-label">
						 账号
					</label>
           <div class="layui-input-inline" style="width: 200px;">
						<input type="text" name="permission_name" autocomplete="off"
							id="logr-edt-account" class="layui-input"  placeholder="请输入账号">
					</div>
					<div class="layui-btn-group">
            <button id="logr-btn-search" class="layui-btn layui-btn-normal" ><i class="layui-icon layui-icon-search"></i>搜索</button>
            </div>
        </div></div></div>

        <table class="layui-table" id="logr-table" lay-filter="logr-table"></table>
    </div>
</div>

<script>
    layui.use(['laydate', 'table', 'util'], function () {
        var laydate = layui.laydate;
        var table = layui.table;
        var util = layui.util;

        // 渲染表格
        table.render({
            elem: '#logr-table',
            url: 'queryLoginLog',
            page: true,
            cols: [[
                {type: 'numbers'},
                {field: 'user_id', title: '账号'},
                {field: 'ip_address', title: 'IP'},
                {field: 'time', title: '登录时间'}
            ]]
        });

        // 时间范围
        laydate.render({
            elem: '#logr-edt-date',
            type: 'date',
            range: true,
            theme: 'molv'
        });

        // 搜索按钮点击事件
        $('#logr-btn-search').click(function () {
            var searchAccount = $('#logr-edt-account').val();
            table.reload('logr-table', {
                where: {
                    user_id: searchAccount
                }
            });
        });
    });
</script>