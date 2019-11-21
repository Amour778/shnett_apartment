<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div class="layui-card">
    <div class="layui-card-body">
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
                    <button class="layui-btn layui-btn-normal" data-method="exportByApartment"  id="exportByApartment">导出(以公寓信息为主导)</button>
                    <button class="layui-btn layui-btn-normal" data-method="exportByApartment"  id="exportByUser">导出(以员工信息为主导)</button>
                </div>
            </div>
        </div>
        <table id="apartment_to_user_table" lay-filter="apartment_to_user_table_lay_filter" cellspacing="0" cellpadding="0"
               border="0"
               class="layui-table"></table>
    </div>
</div>
<script src="assets\libs\xm-select\xm-select.js"></script>
<script src="assets\libs\axios.min.js"></script>
<script>

    var apa_id=null;
    layui.use(['laydate', 'layer', 'table',  'admin', 'tableMerge', 'jquery','formSelects'], function () {
        var layer = layui.layer
            , table = layui.table
            , laydate = layui.laydate
            , admin = layui.admin
            , $ = layui.jquery
            , tableMerge = layui.tableMerge
            , formSelects = layui.formSelects
            , form = layui.form;
        /*formSelects.data('SelectApartment', 'server', {
            url: "getAllApartmentInfo"
        });
        formSelects.on('SelectApartment', function (id, vals, val, isAdd, isDisabled) {
            apa_id = formSelects.value('SelectApartment', 'valStr');
        }, true);*/

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
        table.render({
			id: 'apartment_to_user_table',
            elem: '#apartment_to_user_table'
            /*, url: 'getApartmentToUserInfoByApaIdAndUserId'
            , where: {
                apa_id: '',
                user_id:''
              }*/
			,data:[]
            ,limit:50
            , page: true
            , cols: [[
                //{field: 'apa_id', title: '公寓ID'},
                 {field: 'apa_name', merge: true, title: '公寓'}
                //, {field: 'roo_id', title: '房间ID'}
                , {field: 'roo_name', merge: true, title: '房间'}
                //, {field: 'bed_id', title: '床位ID'}
                , {field: 'bed_name', merge: true, title: '床位'}
                , {field: 'user_id', title: '工号'}
                , {field: 'user_name', title: '姓名'}
                , {field: 'user_tel', title: '手机号'}
                //, {field: 'user_point', title: '用户网点'}
                //, {field: 'user_sex', title: '用户性别'}
                //, {field: 'date_entry', title: '入职日期'}
                //, {field: 'user_type', title: '用工类型'}
            ]]
            , done: function () {
                tableMerge.render(this)
            }
        });


        $("#search").on('click',function () {
            table.reload('apartment_to_user_table', {
                url: 'getApartmentToUserInfoByApaIdAndUserId'
                , method: 'post'
                , where: {
                    apa_id:apa_id,
                    user_id: $("#user_id").val()
                }
            });
        });

        $("#exportByApartment").on('click',function () {
            location.href="LinkApartmentAndUserToExport";
        });

        $("#exportByUser").on('click',function () {
            location.href="LinkUserAndApartmentToExport";
        });
    });
</script>