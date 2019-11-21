<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div class="layui-card">
    <div class="layui-card-body">
        <div class="layui-form toolbar ">
            <div class="layui-inline">
                <div class="layui-inline">
                    <label class="layui-form-label">年月选择</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="year_month" placeholder="yyyy-MM">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">日期选择</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="day" placeholder="yyyy-MM-dd">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">工号</label>
                    <div class="layui-input-block">
                        <input autocomplete="false" class="layui-input" id="user_id">
                    </div>
                </div>

                <div class="layui-inline">
                    <button class="layui-btn layui-btn-normal" data-method="get_sign_in_info">搜索</button>
                </div>
            </div>
        </div>
        <table id="sign_in_info_table" lay-filter="sign_in_info_table_lay_filter" cellspacing="0" cellpadding="0"
               border="0" class="layui-table"></table>
    </div>
</div>
<script>
    var day = '', year_month = '';
    layui.use(['laydate', 'form', 'layer', 'table', 'admin'], function () {
        var layer = layui.layer
            , table = layui.table
            , laydate = layui.laydate
            , admin = layui.admin
            , form = layui.form;

        //常规用法
        laydate.render({
            elem: '#day'
            ,done: function(value, date, endDate){
                day =value;
                $("#year_month").val("");
                year_month = '';
            }
        });
        //年月选择器
        laydate.render({
            elem: '#year_month'
            , type: 'month'
            ,done: function(value, date, endDate){
                year_month =value;
                $("#day").val("");
                day = '';
            }
        });


        //表格初始化渲染
        table.render({
            id: 'sign_in_info_table',
            elem: '#sign_in_info_table',
            loading: true,
            url: 'querySignInInfo',
            where: {
                user_id: '',
                day: '',
                year_month: ''
            },
            page: true,
            cols: [[
                {field: 'user_id', title: '用户工号'},
                {field: 'sign_year',  title: '年'},
                {field: 'sign_month',  title: '月'},
                {field: 'sign_day',  title: '日'}
            ]]
        });

        //按钮
        $('.layui-btn').on('click',
            function () {
                var othis = $(this),
                    method = othis.data('method');
                active[method] ? active[method].call(this, othis) : '';
            });
        var active = {
            get_sign_in_info: function () {
                table.reload('sign_in_info_table', {
                    url: 'querySignInInfo'
                    , method: 'post'
                    , where: {
                        user_id: $("#user_id").val(),
                        day: day,
                        year_month: year_month
                    }
                });
            }
        }
    });

</script>