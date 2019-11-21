<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="layui-card-header">
    <h2 class="header-title">添加房间</h2>
</div>
<form class="layui-form layui-form-item" id="add_apartment_room_form">
    <div class="layui-inline">
        <label class="layui-form-label">房间名称</label>
        <div class="layui-input-block">
            <input type="text" autocomplete="off" id="roo_name" class="layui-input search-input" placeholder="必填" required lay-verify="required" >
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">楼层</label>
        <div class="layui-input-block">
            <input type="text" autocomplete="off" id="roo_floor" class="layui-input search-input">
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">几人间</label>
        <div class="layui-input-block">
            <input type="text" autocomplete="off" id="roo_people" class="layui-input search-input">
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">房间价格</label>
        <div class="layui-input-block">
            <input type="text" autocomplete="off" id="roo_price" class="layui-input search-input">
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">房间配置</label>
        <div class="layui-input-block">
            <input type="text" autocomplete="off" id="roo_allocation" class="layui-input search-input">
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">房间备注</label>
        <div class="layui-input-block">
            <input type="text" autocomplete="off" id="roo_remarks" class="layui-input search-input">
        </div>
    </div>
    <div class="layui-inline">
        <div class="layui-btn-group">
            <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-submit lay-filter="add_apartment_room">添加</button>
            <button type="button" class="layui-btn layui-btn-sm" data-method="reflash"><i class="layui-icon layui-icon-refresh-1"></i></button>
        </div>
    </div>
</form>
<table id="apartment_room_table" lay-filter="apartment_room_table_lay_filter" cellspacing="0" cellpadding="0"
       border="0"
       class="layui-table"></table>
<script type="text/html" id="apartment_room_table_tool_bar">
    <div class="layui-btn-group">
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
        <a class="layui-btn layui-btn-xs" lay-event="show_bed">床位</a>
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
        var apa_id = admin.getTempData('apa_id');

        //表格初始化渲染
        table.render({
            id: 'apartment_room_table',
            elem: '#apartment_room_table',
            loading: true,
            url: 'getApartmentRoomByApaId',
            where: {
                apa_id: apa_id
            },
            page: true,
            cols: [[
                {field: 'roo_name', width: 140, edit:'text',title: '房间名称'},
                {field: 'roo_floor', width: 100, edit:'text',title: '楼层'},
                {field: 'roo_people', width: 100, edit:'text',title: '几人间'},
                {field: 'roo_remarks', width: 140, edit:'text',title: '房间备注'},
                {field: 'roo_price',  width: 140,edit:'text',title: '房间价格'},
                {field: 'roo_allocation', width: 140, edit:'text',title: '房间配置'},
                {
                    fixed: 'right',
                    width: 140,
                    title: '操作',
                    align: 'center',
                    toolbar: '#apartment_room_table_tool_bar',
                    unresize: true
                }
            ]],
            done: function (res, page, count) {
                curr = page;
            }
        });
        form.on('submit(add_apartment_room)', function(data){
            admin.ajax_load_json({
                url:"addNewRoomWithApaId",
                data:{
                    apa_id:apa_id,
                    roo_name:$("#roo_name").val(),
                    roo_floor:$("#roo_floor").val(),
                    roo_people:$("#roo_people").val(),
                    roo_price:$("#roo_price").val(),
                    roo_allocation:$("#roo_allocation").val(),
                    roo_remarks:$("#roo_remarks").val()
                },
                success: function (data) {
                    if(data.code==0){
                        layer.msg(data.info,{icon:1});
                        table.reload('apartment_room_table', {
                            url: 'getApartmentRoomByApaId'
                            , method: 'post'
                            , page: false
                            , limit: 100
                            , where: {
                                apa_id: apa_id
                            }
                        });
                        document.getElementById("add_apartment_room_form").reset();
                    }else{
                        layer.alert(data.info,{icon:2});
                    }
                }
            })
            return false;
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
                table.reload('apartment_room_table', {
                    url: 'getApartmentRoomByApaId'
                    , method: 'post'
                    , page: false
                    , limit: 100
                    , where: {
                        apa_id: apa_id
                    }
                });
            }
        }
        table.on('tool(apartment_room_table_lay_filter)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            admin.putTempData('roo_id', data.roo_id);
            if (layEvent === 'show_bed') {
                admin.popupRight('function_page/apartment/apartment_bed');
            }else if(layEvent === 'delete') {
                layer.confirm('确定删除？删除房间信息将同时删除该房间下所有的床位信息，以及床位的绑定信息', {
                    btn: ['仍然删除', '取消']
                }, function(index, layero){
                    admin.ajax_load_json({
                        url:"deleteRlayEventoomByRoomId",
                        data:{
                            roo_id:obj.data.roo_id
                        },
                        success: function (data) {
                            if(data.code==0){
                                layer.msg(data.info,{icon:1});

                                table.reload('apartment_room_table', {
                                    url: 'getApartmentRoomByApaId'
                                    , method: 'post'
                                    , page: false
                                    , limit: 100
                                    , where: {
                                        apa_id: apa_id
                                    }
                                });
                            }else{
                                layer.alert(data.info,{icon:2});
                            }
                        }
                    })
                });

            }
        });
        table.on('edit(apartment_room_table_lay_filter)', function(obj){
            console.log(obj.value); //得到修改后的值
            console.log(obj.field); //当前编辑的字段名
            console.log(obj.data); //所在行的所有相关数据
            console.log($(this).prev().text());//修改前的值

            admin.ajax_load_json({
                url:"updateColValueByRoomId",
                data:{
                    roo_id:obj.data.roo_id,
                    col_name:obj.field,
                    col_value:obj.value
                },
                success: function (data) {
                    if(data.code==0){
                        layer.msg(data.info,{icon:1});
                    }else{
                        layer.alert(data.info,{icon:2});
                    }
                }
            })

        });
    });

</script>