<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div class="layui-card">
    <div class="layui-card-body">
        <div class="layui-form toolbar ">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <button class="layui-btn layui-btn-normal" data-method="get_apartment_info">搜索</button>
                    <button class="layui-btn layui-btn-normal" data-method="addNew">添加</button>
                </div>
            </div>
        </div>
        <table id="notice_table" lay-filter="notice_table_lay_filter" cellspacing="0" cellpadding="0"
               border="0"
               class="layui-table"></table>
    </div>
</div>
<script type="text/html" id="notice_table_tool_bar">
    <div class="layui-btn-group">
        <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
    </div>
</script>
<script>
    layui.use(['laydate', 'form', 'element', 'layer', 'table', 'formSelects', 'admin'], function () {
        var element = layui.element
            , layer = layui.layer
            , formSelects = layui.formSelects
            , table = layui.table
            , laydate = layui.laydate
            , admin = layui.admin
            , form = layui.form;


        //表格初始化渲染
        table.render({
            id: 'notice_table',
            elem: '#notice_table',
            loading: true,
            url: 'queryAllNoticeInfoByLimit',
            page: true,
            cols: [[
                //{field: 'nid', width: 240, title: 'ID'},
                {field: 'create_date', width: 180, title: '添加日期'},
                {field: 'info', title: '通知内容'},
                {fixed: 'right',width: 100,title: '操作',align: 'center',toolbar: '#notice_table_tool_bar',unresize: true}
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
            get_apartment_info: function () {
                table.reload('notice_table', {
                    url: 'queryAllNoticeInfoByLimit'
                    , method: 'post'
                });
            },
            addNew: function () {
                layer.prompt({
                    formType: 2,
                    value: '',
                    title: '请输入公告内容'
                }, function(value, index, elem){
                    admin.ajax_load_json({
                        url:'addNewNotice',
                        data:{
                            info:value
                        },
                        success:function(res){
                            if(res.code==0){
                                layer.close(index);
                                layer.msg(res.info,{icon:1});
                                table.reload('notice_table', {
                                    url: 'queryAllNoticeInfoByLimit'
                                    , method: 'post'
                                });
                            }else if(res.code==1){
                                layer.alert(res.info,{icon:5});
                            }else{
                                layer.alert("返回值异常",{icon:5});
                            }
                        }
                    })

                });
            }
        }
        table.on('tool(notice_table_lay_filter)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'delete') {
                admin.ajax_load_json({
                    url:'deleteNoticeInfoToIn',
                    data:{
                        nid:data.nid
                    },
                    success:function(res){
                        if(res.code==0){
                            //layer.close(index);
                            layer.msg(res.info,{icon:1});
                            table.reload('notice_table', {
                                url: 'queryAllNoticeInfoByLimit'
                                , method: 'post'
                            });
                        }else if(res.code==1){
                            layer.alert(res.info,{icon:5});
                        }else{
                            layer.alert("返回值异常",{icon:5});
                        }
                    }
                })
            }
        });

    });

</script>