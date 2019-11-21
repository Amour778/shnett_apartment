<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<div class="layui-card">
    <div class="layui-card-body">
        <div class="layui-form toolbar ">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">公寓名称</label>
                    <div class="layui-input-block">
                        <input type="text" autocomplete="off" id="apa_name" class="layui-input search-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <button class="layui-btn layui-btn-normal" data-method="get_apartment_info">搜索</button>
                    <button class="layui-btn layui-btn-normal" data-method="add_apartment_info">添加</button>
                </div>
            </div>
        </div>
        <table id="apartment_info_table" lay-filter="apartment_info_table_lay_filter" cellspacing="0" cellpadding="0"
               border="0"
               class="layui-table"></table>
    </div>
</div>
<script type="text/html" id="location">
    <i class="layui-icon layui-icon-location"></i>
</script>
<script type="text/html" id="apartment_info_table_tool_bar">
    <div class="layui-btn-group">
        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">修改</a>
        <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
        <a class="layui-btn layui-btn-xs" lay-event="show">房间</a>
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
            id: 'apartment_info_table',
            elem: '#apartment_info_table',
            loading: true,
            url: 'getApartmentInfoByInputs',
            where: {
                apa_name: ''
            },
            page: true,
            cols: [[
                {field: 'apa_name', width: 240, title: '公寓名称'},
                //{field: 'apa_province',  width: 140,title: '省'},
                //{field: 'apa_city',  width: 140,title: '市'},
                //{field: 'apa_area',  width: 140,title: '区'},
                {field: 'apa_address', width: 280, title: '具体地址'},
                {field: 'apa_user', width: 140, title: '公寓联系人'},
                {field: 'apa_tel', width: 140, title: '联系方式'},
                //{field: 'apa_local',  width: 140,title: '经纬度',toolbar:'#location'},
                {field: 'apa_remarks', width: 140, title: '备注'},
                {
                    fixed: 'right',
                    width: 140,
                    title: '操作',
                    align: 'center',
                    toolbar: '#apartment_info_table_tool_bar',
                    unresize: true
                }
            ]],
            done: function (res, page, count) {
                curr = page;
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
            get_apartment_info: function () {
                table.reload('apartment_info_table', {
                    url: 'getApartmentInfoByInputs'
                    , method: 'post'
                    , where: {
                        apa_name: $("#apa_name").val()
                    }
                });
            },
            add_apartment_info: function () {
                admin.putTempData('apartmentInfo', null);
                admin.popupCenter({
                    title: '添加公寓信息',
                    path: 'tpl/apartment/apartmentInfo',
                    //area: ['500px', '500px'],
                    area: [(window.screen.width * 0.5) + 'px', (window.screen.height * 0.6) + 'px'],
                    success: function (layero, index) {
                        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
                    },
                    end: function () {
                        table.reload('apartment_info_table', {
                            url: 'getApartmentInfoByInputs'
                            , method: 'post'
                            , where: {
                                apa_name: $("#apa_name").val()
                            }
                        });
                    }
                });
            }
        }
        table.on('tool(apartment_info_table_lay_filter)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'show') {
                admin.putTempData('apa_id', data.apa_id);
                admin.popupCenter({
                    title: '房间',
                    path: 'function_page/apartment/apartment_roo',
                    area: [(window.screen.width * 0.8) + 'px', (window.screen.height * 0.6) + 'px'],
                    //area: ['500px', (window.screen.height * 0.6) + 'px'],
                    success: function (layero, index) {
                        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
                    }
                });
            } else if (layEvent === 'edit') {
                console.log(data);
                admin.putTempData('apartmentInfo', data);
                admin.popupCenter({
                    title: '修改公寓信息',
                    path: 'tpl/apartment/apartmentInfo',
                    //area: ['500px', '500px'],
                    area: [(window.screen.width * 0.5) + 'px', (window.screen.height * 0.6) + 'px'],
                    success: function (layero, index) {
                        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
                    },
                    end: function () {
                        table.reload('apartment_info_table', {
                            url: 'getApartmentInfoByInputs'
                            , method: 'post'
                            , where: {
                                apa_name: $("#apa_name").val()
                            }
                        });
                    }
                });
            } else if (layEvent === 'delete') {
                //data.apa_id
                layer.confirm('确定删除？删除公寓信息将同时删除该公寓下所有的房间及床位信息，以及床位的绑定信息', {
                    btn: ['仍然删除', '取消']
                }, function (index, layero) {
                    admin.ajax_load_json({
                        url: 'deleteApartmentInfo',
                        data: {apa_id:data.apa_id},
                        success: function (data) {
                            console.log(data);
                            if (data.code == 0) {
                                layer.closeAll();
                                layer.msg(data.info, {icon: 1});

                                table.reload('apartment_info_table', {
                                    url: 'getApartmentInfoByInputs'
                                    , method: 'post'
                                    , where: {
                                        apa_name: $("#apa_name").val()
                                    }
                                });
                            } else {
                                layer.alert(data.info, {icon: 5});
                            }
                        }
                    });

                });
            }
        });

    });

</script>