<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="message-view" class="layui-card-body layui-tab layui-tab-brief" style="padding: 5px 0;margin: 0;">
    <ul class="layui-tab-title" style="text-align: center;">
        <li class="layui-this">通知(5)</li>
        <li>私信(12)</li>
        <li>待办(3)</li>
    </ul>
    <div class="layui-tab-content" style="padding: 5px 0;">
        <!-- tab1 -->
        <div class="layui-tab-item message-list layui-show">
            <!-- 实际项目请使用后台数据循环出来 -->
            <a class="message-list-item" href="javascript:;">
                <img class="message-item-icon" src="assets/images/message.png">
                <div class="message-item-right">
                    <h2 class="message-item-title">你收到了14份新周报</h2>
                    <p class="message-item-text">10个月前</p>
                </div>
            </a>
            <a class="message-list-item" href="javascript:;">
                <img class="message-item-icon" src="assets/images/message.png">
                <div class="message-item-right">
                    <h2 class="message-item-title">你收到了14份新周报</h2>
                    <p class="message-item-text">10个月前</p>
                </div>
            </a>
            <a class="message-list-item" href="javascript:;">
                <img class="message-item-icon" src="assets/images/message.png">
                <div class="message-item-right">
                    <h2 class="message-item-title">你收到了14份新周报</h2>
                    <p class="message-item-text">10个月前</p>
                </div>
            </a>
        </div>
        <!-- tab2 -->
        <div class="layui-tab-item">
            <a class="message-list-item" href="javascript:;">
                <img class="message-item-icon" src="assets/images/head.png">
                <div class="message-item-right">
                    <h2 class="message-item-title">xx评论了你</h2>
                    <p class="message-item-text">哈哈哈哈哈哈</p>
                    <p class="message-item-text">10个月前</p>
                </div>
            </a>
            <a class="message-list-item" href="javascript:;">
                <img class="message-item-icon" src="assets/images/head.png">
                <div class="message-item-right">
                    <h2 class="message-item-title">xx评论了你</h2>
                    <p class="message-item-text">哈哈哈哈哈哈</p>
                    <p class="message-item-text">10个月前</p>
                </div>
            </a>
            <a class="message-list-item" href="javascript:;">
                <img class="message-item-icon" src="assets/images/head.png">
                <div class="message-item-right">
                    <h2 class="message-item-title">xx评论了你</h2>
                    <p class="message-item-text">哈哈哈哈哈哈</p>
                    <p class="message-item-text">10个月前</p>
                </div>
            </a>
        </div>
        <!-- tab3 -->
        <div class="layui-tab-item">
            <a class="message-list-item" href="javascript:;">
                <div class="message-item-right">
                    <span class="layui-badge pull-right">待完成</span>
                    <h2 class="message-item-title">你收到了14份新周报</h2>
                    <p class="message-item-text">10个月前</p>
                </div>
            </a>
            <a class="message-list-item" href="javascript:;">
                <div class="message-item-right">
                    <span class="layui-badge layui-bg-gray pull-right">已完成</span>
                    <h2 class="message-item-title">你收到了14份新周报</h2>
                    <p class="message-item-text">10个月前</p>
                </div>
            </a>
            <a class="message-list-item" href="javascript:;">
                <div class="message-item-right">
                    <span class="layui-badge layui-bg-gray pull-right">已完成</span>
                    <h2 class="message-item-title">你收到了14份新周报</h2>
                    <p class="message-item-text">10个月前</p>
                </div>
            </a>
        </div>
    </div>
</div>

<script>
    layui.use('element', function () {
        var element = layui.element;

    });
</script>