<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div class="layui-card">
    <div class="layui-card-body">
        <div class="layui-form toolbar ">
            <div class="layui-form toolbar ">
                <div class="layui-form-item">
                    <div class="layui-inline"  style="width:400px">
                        <label class="layui-form-label">公寓</label>
                        <div class="layui-input-block">
                            <div id="SelectApartment" class="xm-select-demo"></div>
                        </div>
                    </div>
                    <div class="layui-inline" >
                        <label class="layui-form-label">工号</label>
                        <div class="layui-input-block">
                            <input autocomplete="false" class="layui-input" id="user_id">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-normal" data-method="search" id="search">搜索</button>
                        <button class="layui-btn layui-btn-normal" data-method="exportScore"  id="exportScore">导出所有评分</button>
                        </div>
                </div>
            </div>
        </div>
        <table id="score_table" lay-filter="score_table_lay_filter" cellspacing="0" cellpadding="0"
               border="0"
               class="layui-table"></table>
    </div>
</div>
<script type="text/html" id="score_table_tool_bar">
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
        var apa_id=null,user_id=null;

        var xm_Select = xmSelect.render({
            el: '#SelectApartment',
            clickClose: true,
            on({ arr, change, isAdd }){
                //arr:  当前多选已选中的数据
                //change, 此次选择变化的数据,数组
                //isAdd, 此次操作是新增还是删除
                console.log(arr);
                if(arr.length!=0){
                    apa_id=arr[0].value;
                }else{
                    apa_id=null;
                }
            },
            filterable: true,
            radio: true,
            data: []
        });
        axios({
            method: 'get',
            url: 'getAllApartmentInfo',
        }).then(response =>{
            var res = response.data;
        xm_Select.update({
            data: res.data,
            autoRow: true,
        })
    });
        //表格初始化渲染
        table.render({
            id: 'score_table',
            elem: '#score_table',
            loading: true,
            url: 'queryAllScoreInfoByLimit',
            where:{
                apa_id:apa_id,
                user_id:user_id
            },
            page: true,
            cols: [[
                {field: 'apa_name', width: 180, title: '公寓名称'},
                {field: 'user_id', width: 100, title: '用户工号'},
                {field: 'score',  width: 150, title: '评分', templet: '#scoreTpl'},
                {field: 'remark', title: '备注'},
                {field: 'create_date',width: 180, title: '评分日期'}]]
        });

        //按钮
        $('.layui-btn').on('click',
            function () {
                var othis = $(this),
                    method = othis.data('method');
                active[method] ? active[method].call(this, othis) : '';
            });
        var active = {
            search: function () {
                table.reload('score_table', {
                    url: 'queryAllScoreInfoByLimit'
                    , method: 'post',
                    where:{
                        apa_id:apa_id,
                        user_id:$("#user_id").val()
                    }
                });
            },
            exportScore: function () {
                location.href="exportScoreByAPaIdOrUserId";
            }
        }
    });

</script>


<script  type="text/html" id="scoreTpl">
    {{#  if(d.score === 0){ }}
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    {{#  } }}
    {{#  if(d.score === 1){ }}
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    {{#  } }}
    {{#  if(d.score === 2){ }}
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    {{#  } }}
    {{#  if(d.score === 3){ }}
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    {{#  } }}
    {{#  if(d.score === 4){ }}
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate" style="color:#138823;"></i>
    {{#  } }}
    {{#  if(d.score === 5){ }}
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    <i class="layui-icon layui-icon-rate-solid" style="color:#138823;"></i>
    {{#  } }}
</script>
