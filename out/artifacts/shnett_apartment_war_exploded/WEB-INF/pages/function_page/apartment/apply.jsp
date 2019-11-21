<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<div class="layui-card">
    <div class="layui-card-body">
        <div class="layui-form toolbar ">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">工号</label>
                    <div class="layui-input-block">
                        <input type="text" autocomplete="off" id="user_id" class="layui-input search-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">日期</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="create_date">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">类型</label>
                    <div class="layui-input-inline">
                        <select name="apply_type" lay-filter="apply_type">
                            <option value="0">入住</option>
                            <option value="1">退租</option>
                            <option value="2" selected>全部</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">审核状态</label>
                    <div class="layui-input-inline">
                        <select name="sta"  lay-filter="apply_sta">
                            <option value="0" selected>待审核</option>
                            <option value="1">已通过</option>
                            <option value="2">已驳回</option>
                            <option value="3">全部</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">入住状态</label>
                    <div class="layui-input-inline">
                        <select name="is_check" lay-filter="is_check">
                            <option value="0">未入住</option>
                            <option value="1">已入住</option>
                            <option value="2" selected>全部</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layui-btn-normal" data-method="get_apply">搜索</button>
                </div>
            </div>
        </div>
        <table id="apply_table" lay-filter="apply_table_lay_filter" cellspacing="0" cellpadding="0" border="0"
               class="layui-table"></table>
    </div>
</div>
<script type="text/html" id="apply_type">
    {{#  if(d.apply_type === 0){ }}
    <b style="color:#009688">入住</b>
    {{#  } }}
    {{#  if(d.apply_type === 1){ }}
    <b style="color:#2F4056">退租</b>
    {{#  } }}
</script>

<script type="text/html" id="sta">
    {{#  if(d.sta === 0){ }}
    <b style="color:#393D49"><i class="layui-icon layui-icon-help"></i>待审</b>
    {{#  } }}
    {{#   if(d.sta === 1){ }}
    <b style="color:#009688"><i class="layui-icon layui-icon-ok"></i>通过</b>
    {{#  } }}
    {{#  if(d.sta === 2){ }}
    <b style="color:#FF5722"><i class="layui-icon layui-icon-close"></i>驳回</b>
    {{#  } }}
</script>

<script type="text/html" id="is_check">
    {{#  if(d.is_check === 0 && d.apply_type === 0){ }}
    <b style="color:#393D49">未入住</b>
    {{#  } }}
    {{#   if(d.is_check === 1  && d.apply_type === 0){ }}
    <b style="color:#009688">已入住</b>
    {{#  } }}
</script>

<script type="text/html" id="apply_table_tool_bar">
    <div class="layui-btn-group">
        {{# if(d.sta === 0){ }}
        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="apply">审批</a>
        {{# } }}
        {{# if(d.sta === 1 ||d.sta === 2 ){ }}
        <a class="layui-btn layui-btn-xs" lay-event="show">查看</a>
        {{# } }}
        {{# if(d.sta === 1  && d.is_check === 0 && d.apply_type === 0){ }}
        <a class="layui-btn layui-bg-cyan layui-btn-xs" lay-event="checkIn">入住登记</a>
        {{# } }}
    </div>
</script>
<script>
    layui.use(['layer', 'form', 'table', 'admin', 'laydate'],
        function () {
            layer = layui.layer,
                form = layui.form,
                table = layui.table,
                admin = layui.admin,
                laydate = layui.laydate,
                $ = layui.jquery;
            form.render();
            var apply_sta = 0;//申请状态
            var apply_type = 2;//申请类型
            var is_check = 2;//入住状态
            var create_date = '';//申请日期段
            laydate.render({
                elem: '#create_date'
                , range: true
                , done: function (value, date, endDate) {
                    create_date = value; //得到日期生成的值
                }
            });


            form.on('select(apply_sta)', function (data) {
                apply_sta = data.value;
            });
            form.on('select(apply_type)', function (data) {
                apply_type = data.value;
            });
            form.on('select(is_check)', function (data) {
                is_check = data.value;
            });

            var apply_type_temp=[];
            //执行渲染
            table.render({
                id: 'apply_table',
                elem: '#apply_table',
                loading: true,
                url: 'queryApplyInfo',
                where: {
                    user_id: "",
                    sta: apply_sta,
                    apply_type:apply_type,
                    is_check:is_check,
                    create_date: ""
                },
                page: true,
                cols: [[
                    {field: 'user_id', title: '工号'},
                    {field: 'user_name', title: '姓名'},
                    {field: 'apply_type', title: '申请类型', templet: '#apply_type'},
                    {field: 'sta', title: '状态', templet: '#sta'},
                    {field: 'is_check', title: '是否入住', templet: '#is_check'},
                    {field: 'create_date', title: '提交日期'},
                    {
                        fixed: 'right',
                        width: 120,
                        title: '操作',
                        align: 'center',
                        toolbar: '#apply_table_tool_bar',
                        unresize: true
                    }
                ]],
                done: function (res, page, count) {
                    console.log(res)
                    curr = page;
                    apply_type_temp=res.data;
                    console.log(apply_type_temp)
                }
            });
            $('.layui-btn').on('click',
                function () {
                    var othis = $(this),
                        method = othis.data('method');
                    active[method] ? active[method].call(this, othis) : '';
                });
            var active = {
                get_apply: function () {
                    table.reload('apply_table', {
                        url: 'queryApplyInfo'
                        , method: 'post'
                        , where: {
                            user_id: $("#user_id").val(),
                            sta: apply_sta,
                            apply_type:apply_type,
                            is_check:is_check,
                            create_date: create_date
                        }
                    });
                }
            }
            table.on('tool(apply_table_lay_filter)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                admin.setTableBtnInfo(data.apply_type);//admin.setTableBtnInfo存在未知异常，赋值后重新获取的值为'undefined'，故采用此方法
                admin.putTempData('apply_id', data.id);
                if (layEvent === 'apply') {
                    var type=null,title=null;
                    if(data.apply_type==0){
                        type="applyCheckInInfo";
                        title="-入住申请";
                    }else if(data.apply_type==1){
                        type="applyCheckOutInfo";
                        title="-退租申请";
                    }else{
                        layer.alert("获取申请类型错误，请刷新数据后重试",{icon:5});
                        return;
                    }
                    //admin.popupRight('tpl/apartment/applyInfo');
                    admin.popupCenter({
                        title: '审批'+title,
                        path: 'tpl/apartment/'+type,
                        //area: [(window.screen.width*0.5)+'px', (window.screen.height*0.5)+'px'],
                        area: ['500px', (window.screen.height * 0.6) + 'px'],
                        success: function (layero, index) {
                            $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
                        },
                        end: function () {
                            table.reload('apply_table', {
                                url: "queryApplyInfo",
                                method: 'post',
                                where: {
                                    user_id: $("#user_id").val(),
                                    sta: apply_sta,
                                    apply_type:apply_type,
                                    is_check:is_check,
                                    create_date: create_date
                                }
                            });
                        }
                    });
                } else if (layEvent === 'show') {
                    var type=null,title=null;
                    if(data.apply_type==0){
                        type="applyCheckInInfo";
                        title="-入住申请";
                    }else if(data.apply_type==1){
                        type="applyCheckOutInfo";
                        title="-退租申请";
                    }else{
                        layer.alert("获取申请类型错误，请刷新数据后重试",{icon:5});
                        return;
                    }
                    //admin.popupRight('tpl/apartment/applyInfo');
                    admin.popupCenter({
                        title: '查看'+title,
                        path: 'tpl/apartment/'+type,
                        //area: [(window.screen.width*0.5)+'px', (window.screen.height*0.5)+'px'],
                        area: ['500px', (window.screen.height * 0.6) + 'px'],
                        success: function (layero, index) {
                            $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
                        },
                        end: function () {
                            table.reload('apply_table', {
                                url: "queryApplyInfo",
                                method: 'post',
                                where: {
                                    user_id: $("#user_id").val(),
                                    sta: apply_sta,
                                    apply_type:apply_type,
                                    is_check:is_check,
                                    create_date: create_date
                                }
                            });
                        }
                    });
                } else if (layEvent === 'checkIn') {
                    //admin.setTableBtnInfo(data.admin_arrange);//admin.setTableBtnInfo存在未知异常，赋值后重新获取的值为'undefined'，故采用此方法

                    admin.putTempData('admin_arrange',data.admin_arrange);
                    admin.putTempData('user_id',data.user_id);
                    admin.popupCenter({
                        title: '提交入住信息',
                        path: 'tpl/apartment/checkIn',
                        //area: [(window.screen.width*0.5)+'px', (window.screen.height*0.5)+'px'],
                        area: ['500px', '500px'],
                        success: function (layero, index) {
                            $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
                        },
                        end: function () {
                            table.reload('apply_table', {
                                url: "queryApplyInfo",
                                method: 'post',
                                where: {
                                    user_id: $("#user_id").val(),
                                    sta: apply_sta,
                                    apply_type:apply_type,
                                    is_check:is_check,
                                    create_date: create_date
                                }
                            });
                        }
                    });
                }

            });
        });
</script>
