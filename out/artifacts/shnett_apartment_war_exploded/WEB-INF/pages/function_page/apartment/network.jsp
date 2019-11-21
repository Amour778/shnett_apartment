<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div class="layui-row layui-col-space12">
    <div class="layui-col-md6">
        <div class="layui-card">
            <div class="layui-card-header">
                区部信息
            </div>
            <div class="layui-card-body">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">名称或代码</label>
                        <div class="layui-input-block">
                            <input type="text" autocomplete="off" id="input_main" class="layui-input search-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-normal" id="get_main">搜索</button>
                        <button class="layui-btn layui-btn-normal" id="add_main">添加</button>
                    </div>
                </div>
                <table id="main_info_table" lay-filter="main_info_table_lay_filter" cellspacing="0" cellpadding="0"
                       border="0" class="layui-table"></table>
            </div>
        </div>
    </div>
    <div class="layui-col-md6">
        <div class="layui-card">
            <div class="layui-card-header">
                <b style="color: #3492ED" id="mainId"></b>点部信息
            </div>
            <div class="layui-card-body">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">名称或代码</label>
                        <div class="layui-input-block">
                            <input type="text" autocomplete="off" id="input_point" class="layui-input search-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-normal" id="get_point">搜索</button>
                    </div>
                </div>
                <table id="point_info_table" lay-filter="point_info_table_lay_filter" cellspacing="0" cellpadding="0"
                       border="0" class="layui-table"></table>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="main_info_table_tool_bar">
    <div class="layui-btn-group">
        <a class="layui-btn  layui-btn layui-btn-xs" lay-event="point">点部</a>
        <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
    </div>
</script>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="addNewPoint">添加新点部</button>
    </div>
</script>


<script type="text/html" id="point_info_table_tool_bar">
    <div class="layui-btn-group">
        <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
    </div>
</script>
<script>
    var mainId=null;
    layui.use(['laydate', 'form', 'layer', 'table', 'admin'], function () {
        var layer = layui.layer
            , table = layui.table
            , admin = layui.admin
            , form = layui.form;

        //搜索大区信息
        $("#get_main").on('click',function(){
            table.reload('main_info_table', {
                url: 'getAllNetworkMainInfoToLayuiList'
                ,where: {input: $("#input_main").val()}
            });
        })
        //搜索点部信息
        $("#get_point").on('click',function(){
            if( mainId==null){
                layer.msg('请先点击区部信息表格中的“点部”按钮再搜索');
                return;
            }
            table.reload('point_info_table', {
                url: 'getAllNetworkpointInfoToLayuiList'
                ,where: {
                    mainId:mainId,
                    input: $("#input_point").val()
                }
            });
        })

        //添加大区
        $("#add_main").on('click',function(){
            layer.prompt({title: '输入区部代码，确认后输入区部名称', formType: 0}, function(mainId, index1){
                layer.close(index1);
                layer.prompt({title: '输入区部名称，并确认', formType: 0}, function(main_name, index2){
                    admin.ajax_load_json({
                        url: 'addNetworkMainInfo',
                        data: {
                            mainId:mainId,
                            main_name:main_name
                        },
                        success: function (data) {
                            if(data.code==0){
                                layer.close(index2);
                                layer.msg(data.info,{icon:1});
                                table.reload('main_info_table', {
                                    url: 'getAllNetworkMainInfoToLayuiList'
                                    ,where: {input: $("#input_main").val()}
                                });
                            }else if(data.code==1){
                                layer.alert(data.info,{icon:5});
                            }
                        }
                    })
                });
            });
        })
        //大区表格初始化渲染
        table.render({
            id: 'main_info_table',
            elem: '#main_info_table',
            loading: true,
            url: 'getAllNetworkMainInfoToLayuiList',
            where: {
                input: $("#input_main").val()
            },
            page: {
                layout: ['limit', 'count', 'prev', 'page', 'next']
                ,groups: 1
            },
            cols: [[
                {field: 'mainId',title: '代码'},
                {field: 'main_name',edit:'text',title: '名称'},
                {fixed: 'right',width: 120,title: '操作',align: 'center',toolbar: '#main_info_table_tool_bar',unresize: true}
            ]]
        });
        table.on('edit(main_info_table_lay_filter)', function(obj){
            admin.ajax_load_json({
                url:"updateNetworkMainName",
                data:{
                    mainId:obj.data.mainId,
                    main_name:obj.value
                },
                success: function (data) {
                    if(data.code==0){
                        layer.msg(data.info,{icon:1});
                    }else{
                        layer.alert(data.info,{icon:5});
                    }
                }
            })

        });

        //所属大区表格按钮
        table.on('tool(main_info_table_lay_filter)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            mainId=data.mainId;
            if (layEvent === 'delete') {
                layer.open({
                    content: '确认删除此区部信息吗？<br/>删除的同时将会删除该区部下的点部信息，但为确保床位信息的准确性，并不会删除该区部下用户的信息！',
                    btn: ['仍然删除', '取消'],
                    yes: function(index, layero){
                        admin.ajax_load_json({
                            url: 'deleteNetworkMainInfoNotWithUserInfo',
                            data: {
                                mainId:mainId
                            },
                            success: function (data) {
                                if(data.code==0){
                                    layer.msg(data.info,{icon:1});
                                    table.reload('main_info_table', {
                                        url: 'getAllNetworkMainInfoToLayuiList'
                                        ,where: {input: $("#input_main").val()}
                                    });
                                    table.reload('point_info_table', {
                                        data:[]
                                    });
                                    mainId=null;
                                    $("#mainId").html(mainId);
                                }else if(data.code==1){
                                    layer.alert(data.info,{icon:5});
                                }else{
                                    layer.alert('返回信息异常，无法正常解析',{icon:5});
                                }
                            }
                        })
                    },

                });
            }
            else if (layEvent === 'point') {
                $("#mainId").html(mainId);
                table.render({
                    id: 'point_info_table',
                    elem: '#point_info_table',
                    toolbar: '#toolbarDemo',
                    defaultToolbar:[],
                    loading: true,
                    url: 'getAllNetworkpointInfoToLayuiList',
                    where: {
                        mainId: data.mainId,
                        input: $("#input_main").val()
                    },
                    page: {
                    layout: ['limit', 'count', 'prev', 'page', 'next']
                        ,groups: 1
                },
                    cols: [[
                        {field: 'pointId', title: '分点部代码'},
                        {field: 'point_name',edit:'text',title: '分点部名称'},
                        {fixed: 'right',width: 80,title: '操作',align: 'center',toolbar: '#point_info_table_tool_bar',unresize: true}
                    ]]
                });
                //头工具栏事件
                table.on('toolbar(point_info_table_lay_filter)', function(obj){
                    switch(obj.event){
                        case 'addNewPoint':
                            if( mainId==null){
                                layer.msg('请先点击区部信息表格中的“点部”按钮再添加');
                                return;
                            }
                            layer.prompt({title: '输入点部代码，确认后输入点部名称', formType: 0}, function(pointId, index1){
                                layer.close(index1);
                                layer.prompt({title: '输入点部名称，并确认', formType: 0}, function(point_name, index2){
                                    admin.ajax_load_json({
                                        url: 'addNetworkPointInfo',
                                        data: {
                                            mainId:mainId,
                                            pointId:pointId,
                                            point_name:point_name
                                        },
                                        success: function (data) {
                                            if(data.code==0){
                                                layer.close(index2);
                                                layer.msg(data.info,{icon:1});
                                                table.reload('point_info_table', {
                                                    url: 'getAllNetworkpointInfoToLayuiList'
                                                    ,where: {
                                                        mainId:mainId,
                                                        input: $("#input_point").val()
                                                    }
                                                });
                                            }else if(data.code==1){
                                                layer.alert(data.info,{icon:5});
                                            }
                                        }
                                    })
                                });
                            });
                            break;
                    };
                });
                table.on('edit(point_info_table_lay_filter)', function(obj){
                    admin.ajax_load_json({
                        url:"updateNetworkPointInfo",
                        data:{
                            pointId:obj.data.pointId,
                            point_name:obj.value
                        },
                        success: function (data) {
                            if(data.code==0){
                                layer.msg(data.info,{icon:1});
                            }else{
                                layer.alert(data.info,{icon:5});
                            }
                        }
                    })

                });
                table.on('tool(point_info_table_lay_filter)', function (obj) {
                    var data = obj.data;
                    var layEvent = obj.event;
                    pointId = data.pointId;
                    $("#mainId").html(mainId);
                    if (layEvent === 'delete') {
                        layer.open({
                            content: '确认删除此点部信息吗？<br/>为确保床位信息的准确性，删除点部并不会删除该点部下用户的信息！',
                            btn: ['仍然删除', '取消'],
                            yes: function(index, layero){
                               admin.ajax_load_json({
                                   url: 'deleteNetworkPointInfoNotWithOtherInfo',
                                   data: {
                                       pointId:pointId
                                   },
                                   success: function (data) {
                                       if(data.code==0){
                                           layer.msg(data.info,{icon:1});
                                           table.reload('point_info_table', {
                                               url: 'getAllNetworkpointInfoToLayuiList'
                                               ,where: {
                                                   mainId:mainId,
                                                   input: $("#input_point").val()
                                               }
                                           });
                                       }else if(data.code==1){
                                           layer.alert(data.info,{icon:5});
                                       }else{
                                           layer.alert('返回信息异常，无法正常解析',{icon:5});
                                       }
                                   }
                               })
                            }
                        });
                    }
                });
            }
        });




    });

</script>