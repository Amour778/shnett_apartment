<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>智慧公寓</title>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="shortcut icon" href="assets/images/favicon.ico" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="assets/libs/layui/css/layui.css"/>
    <link rel="stylesheet" href="assets/libs/icon/iconfont.css"/>
    <link rel="stylesheet" href="assets/libs/zTree/css/zTreeStyle/zTreeStyle.css"/>
    <link rel="stylesheet" href="module/formSelects/formSelects-v4.css"/>
    <link rel="stylesheet" href="assets/css/admin.css"/>
    <link rel='stylesheet' href="assets/css/step.css"/>
    <link rel="stylesheet" href="module/dtree/dtree.css">
    <link rel="stylesheet" href="module/dtree/font/dtreefont.css">
    <style>
        div {
            /*font-size:10px
            */
        }
    </style>
</head>

<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <!-- 头部 -->
    <div class="layui-header">
        <div class="layui-logo">
            <img src="assets/images/logo.png"/>
            <cite>智慧公寓</cite>
        </div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item" lay-unselect>
                <a ew-event="flexible" title="侧边伸缩"><i class="layui-icon layui-icon-shrink-right"></i></a>
            </li>
            <li class="layui-nav-item" lay-unselect>
                <a ew-event="refresh" title="刷新"><i class="layui-icon layui-icon-refresh-3"></i></a>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item" lay-unselect>
                <a id="btnMessage" title="消息"><i class="layui-icon layui-icon-notice"></i></a>
            </li>
            <li class="layui-nav-item layui-hide-xs" lay-unselect>
                <a ew-event="fullScreen" title="全屏"><i class="layui-icon layui-icon-screen-full"></i></a>
            </li>
            <li class="layui-nav-item" lay-unselect>
                <a>
                    <img src="assets/images/head.png" class="layui-nav-img">
                    <cite><shiro:principal/></cite>
                </a>
                <dl class="layui-nav-child">
                    <dd lay-unselect>
                        <a id="setInfo">个人信息</a>
                    </dd>
                    <dd lay-unselect>
                        <a id="setPsw">修改密码</a>
                    </dd>
                    <hr>
                    <dd lay-unselect>
                        <a id="btnLogout">退出</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item" lay-unselect>
                <a ew-event="theme" title="主题"><i class="layui-icon layui-icon-more-vertical"></i></a>
            </li>
        </ul>
    </div>

    <!-- 侧边栏 -->
    <div class="layui-side">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree" style="margin-top: 15px;" id="view">
                <script id="demo" type="text/html">
                    {{#  layui.each(d, function(index, item){ }}
                    {{# if(!item.hidden){ }}
                    <li class="layui-nav-item">
                        <a lay-href="{{item.url}}"><i
                                class="layui-icon {{item.icon}}"></i>&emsp;<cite>{{item.name}}</cite></a>
                        {{# if(item.subMenus&&item.subMenus.length>0){ }}
                        <dl class="layui-nav-child">
                            {{# layui.each(item.subMenus, function(index, subItem){ }}
                            {{# if(!subItem.hidden){ }}
                            <dd>
                                <a lay-href="{{subItem.url}}">{{subItem.name}}</a>
                                {{# if(subItem.subMenus&&subItem.subMenus.length>0){ }}
                                <dl class="layui-nav-child">
                                    {{# layui.each(subItem.subMenus, function(index, thrItem){ }}
                                    {{# if(!thrItem.hidden){ }}
                                    <dd>
                                        <a href="{{ thrItem.url }}">{{ thrItem.name }}</a>
                                    </dd>
                                    {{# } }}
                                    {{# }); }}
                                </dl>
                                {{# } }}
                            </dd>
                            {{# } }}
                            {{# }); }}
                        </dl>
                        {{# } }}
                    </li>
                    {{# } }}
                    {{#  }); }}
                </script>
            </ul>
        </div>
    </div>

    <!-- 主体部分 -->
    <div class="layui-body">
        <div class="layui-tab" lay-allowClose="true" lay-filter="admin-pagetabs">
            <ul class="layui-tab-title">
            </ul>
            <div class="layui-tab-content">
            </div>
        </div>
        <div class="layui-icon admin-tabs-control layui-icon-prev" ew-event="leftPage"></div>
        <div class="layui-icon admin-tabs-control layui-icon-next" ew-event="rightPage"></div>
        <div class="layui-icon admin-tabs-control layui-icon-down">
            <ul class="layui-nav admin-tabs-select" lay-filter="admin-pagetabs-nav">
                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;"></a>
                    <dl class="layui-nav-child layui-anim-fadein">
                        <dd ew-event="closeThisTabs" lay-unselect><a href="javascript:;">关闭当前标签页</a></dd>
                        <dd ew-event="closeOtherTabs" lay-unselect><a href="javascript:;">关闭其它标签页</a></dd>
                        <dd ew-event="closeAllTabs" lay-unselect><a href="javascript:;">关闭全部标签页</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <!-- 手机屏幕遮罩层 -->
    <div class="site-mobile-shade"></div>
</div>

<script type="text/javascript" src="assets/libs/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="assets/libs/q.js"></script>
<script type="text/javascript" src="assets/libs/layui/layui.js"></script>
<script type="text/javascript" src="assets/libs/zTree/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="module/vue.js"></script>
<script>
    layui.config({
        base: 'module/'
    }).extend({
        formSelects: 'formSelects/formSelects-v4',
        treetable: 'treetable-lay/treetable',
        authtree: 'authtree/authtree',
        dropdown: 'dropdown/dropdown',
        step: 'step/step',
        notice: 'notice/notice',
        dtree: 'dtree/dtree',
        tableMerge: 'tableMerge/tableMerge',
        numinput: 'numinput/numinput'
    }).use(['admin', 'index'], function () {
        var admin = layui.admin;
        var index = layui.index;
        index.checkPageTabs(true);  // 检查多标签是否开启
        index.initRouter();  // 导航栏和tab联动
        index.bindEvent();  // 绑定事件


    });
</script>
</body>

</html>