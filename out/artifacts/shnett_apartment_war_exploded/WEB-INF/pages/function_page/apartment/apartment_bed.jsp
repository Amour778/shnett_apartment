<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="layui-card-header">
   床位
</div>
<div class="layui-card-header">
    <h2 class="header-title">添加床位</h2>
</div>
<div  class="layui-form toolbar margin-top">
    <div class="layui-inline" style="margin-left:-25px">
        <label class="layui-form-label">床位名称</label>
        <div class="layui-input-block">
            <input type="text" autocomplete="off" id="bed_name" class="layui-input search-input" required lay-verify="required" >
        </div>
    </div>

    <div class="layui-inline">
        <div class="layui-btn-group">
            <button type="button" lay-submit lay-filter="add_apartment_bed" class="layui-btn layui-btn-sm layui-btn-normal">添加
            </button>
            <button type="button" class="layui-btn layui-btn-sm" data-method="reflash"><i
                    class="layui-icon layui-icon-refresh-1"></i></button>
        </div>
    </div>
</div >
<div class="layui-form-mid layui-word-aux">绑定/解绑工号，请直接在表格中操作</div>
<table id="apartment_bed_table" lay-filter="apartment_bed_table_lay_filter" cellspacing="0" cellpadding="0"
       border="0"
       class="layui-table"></table>
<script type="text/html" id="apartment_bed_table_tool_bar">
    <button class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="delete">删除</button>
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
        var roo_id = admin.getTempData('roo_id');
        //监听提交
        form.on('submit(add_apartment_bed)', function(data){
            admin.ajax_load_json({
                url: "addNewBedByRoomId",
                data: {
                    roo_id: roo_id,
                    bed_name: $("#bed_name").val()
                },
                success: function (data) {
                    if (data.code == 0) {
                        layer.msg(data.info, {icon: 1});
                        $("#bed_name").val('');
                        table.reload('apartment_bed_table', {
                            url: 'getApartmentBedByApaIdNoLimit'
                            , method: 'post'
                            , page: false
                            , limit: 100
                            , where: {
                                roo_id: roo_id
                            }
                        });
                    } else {
                        layer.alert(data.info, {icon: 2});
                    }
                }
            })
            return false;
        });
        //表格初始化渲染
        table.render({
            id: 'apartment_bed_table',
            elem: '#apartment_bed_table',
            loading: true,
            url: 'getApartmentBedByApaIdNoLimit',
            where: {
                roo_id: roo_id
            },
            page: false,
            limit: 500,
            cols: [[
                {field: 'bed_name', title: '床位名称'},
                {field: 'bed_people', title: '入住人工号', edit: 'text'},
                {
                    fixed: 'right',
                    width: 60,
                    align: 'center',
                    toolbar: '#apartment_bed_table_tool_bar',
                    unresize: true
                }
            ]],
            done: function (res, page, count) {
                curr = page;
            }
        });
        table.on('tool(apartment_bed_table_lay_filter)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'delete') {
                layer.confirm('确定删除？删除床位信息将同时解绑员工的入住信息', {
                    btn: ['仍然删除', '取消']
                }, function (index, layero) {
                    admin.ajax_load_json({
                        url: "deleteBedByBedId",
                        data: {
                            bed_id: data.bed_id
                        },
                        success: function (data) {
                            if (data.code == 0) {
                                layer.msg(data.info, {icon: 1});
                                table.reload('apartment_bed_table', {
                                    url: 'getApartmentBedByApaIdNoLimit'
                                    , method: 'post'
                                    , page: false
                                    , limit: 100
                                    , where: {
                                        roo_id: roo_id
                                    }
                                });
                            } else {
                                layer.alert(data.info, {icon: 2});
                            }
                        }
                    });
                });
            }
        });
        //按钮
        $('.layui-btn').on('click',
            function () {
                var othis = $(this),
                    method = othis.data('method');
                active[method] ? active[method].call(this, othis) : '';
            });
        var active = {
            reflash: function () {
                table.reload('apartment_bed_table', {
                    url: 'getApartmentBedByApaIdNoLimit'
                    , method: 'post'
                    , page: false
                    , limit: 100
                    , where: {
                        roo_id: roo_id
                    }
                });
            }
        }
        table.on('edit(apartment_bed_table_lay_filter)', function (obj) {
            admin.ajax_load_json({
                url: "updateBedPeopleByRoomId",
                data: {
                    bed_id: obj.data.bed_id,
                    bed_people_new: obj.value,
                    bed_people_old: $(this).prev().text()
                },
                success: function (data) {
                    if (data.code == 0) {
                        layer.msg(data.info, {icon: 1});
                        table.reload('apartment_bed_table', {
                            url: 'getApartmentBedByApaIdNoLimit'
                            , method: 'post'
                            , page: false
                            , limit: 100
                            , where: {
                                roo_id: roo_id
                            }
                        });
                    } else {
                        layer.alert(data.info, {icon: 2});
                    }
                }
            })
        });

    });

</script>
<style>
    .margin-top {
        margin-top: 10px
    }
</style>