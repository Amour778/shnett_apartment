<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="layui-card-header">
    <h2 class="header-title">多标签：</h2>
    <div class="pull-right layui-form">
        <input type="checkbox" lay-skin="switch" lay-text="ON|OFF" id="set-tab" lay-filter="set-tab" checked/>
    </div>
</div>

<script>
    layui.use(['form', 'index', 'admin'], function () {
        var form = layui.form;
        var index = layui.index;
        var admin = layui.admin;

        $('#set-tab').prop('checked', index.pageTabs);
        form.render('checkbox');

        form.on('switch(set-tab)', function (data) {
            if (data.elem.checked) {
                location.reload();
            } else {
                index.pageTabs = false;
                index.checkPageTabs();
                admin.refresh();
                admin.closePopupRight();
            }
        });

    });
</script>