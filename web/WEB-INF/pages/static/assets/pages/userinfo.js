layui.use(['layer', 'form', 'table', 'upload', 'admin'],
    function () {
        layer = layui.layer,
            table = layui.table,
            form = layui.form,
            upload = layui.upload,
            admin = layui.admin,
            $ = layui.jquery;
        form.render();
        var radio_sta = 1;
        //鼠标悬停提示
        $("#upload_file").hover(function () {
            layer.tips('导入的文件需要为.xls格式', '#upload_file', {tips: 1});
        }, function () {
            layer.closeAll();
        });
        //执行渲染
        table.render({
            id: 'userinfo_table',
            elem: '#table_userinfo',
            loading: true,
            url: 'get_user',
            where: {"user_id": "", "sta": 1},
            page: true,
            cols: [[{field: null, type: 'checkbox', sort: true},
                {field: 'user_id', title: '用户工号', width:100},
                {field: 'user_name',edit:'text', title: '姓名', width:100},
                {field: 'sta', title: '账号状态', unresize: true, width:100,templet: '#userStaTpl'},
                {field: 'user_wechat_apartment', title: '微信绑定', width:100, templet: '#userBindTpl'},
                {field: 'user_main',edit:'text', title: '所属大区', width:100},
                {field: 'user_point',edit:'text', title: '所属网点', width:100},
                {field: 'user_tel',edit:'text', title: '联系方式', width:100},
                {field: 'user_cardid',edit:'text', title: '身份证号', width:100},
                {field: 'user_sex',title: '用户性别', templet: '#userSexTpl'},
                {field: 'user_integral', title: '用户积分', width:100},
                {field: 'user_bed', title: '床位ID', width:100},
                {field: 'date_entry',title: '入职日期', width:110},
                {field: 'user_type',title: '用工类型', templet: '#userTypeTpl', width:100},
                {fixed: 'right', title: '操作', align: 'center', toolbar: '#userinfo_bar', fixed: 'right', width: 100}]],
            done: function (res, page, count) {
                if (res.code == "1")
                    layer.msg(res.msg);
                curr = page;
            }
        });
        //监听工号状态操作
        form.on('switch(staDemo)', function(obj){
            var sta=0;
            if(obj.elem.checked==true){
                sta=1;
            }
            if(obj.elem.checked==false){
                sta=0;
            }
            admin.ajax_load_json({
                url:'changeUserInfoByColumnNames',
                data:{
                    column_names:'sta',
                    column_value:sta,
                    user_id:this.value
                },
                success:function(res){
                    if(res.code==0){
                        layer.msg(res.info,{icon:1});
                    }else if(res.code==1){
                        layer.alert(res.info,{icon:5});
                    }else{
                        layer.alert("返回值异常",{icon:5});
                    }
                }
            })
        });

        form.on('radio(radio_sta)', function (data) {
            radio_sta = data.value;
        });
        //监听表格编辑
        table.on('edit(table_userinfo_lay_filter)', function(obj){
            admin.ajax_load_json({
                url:'changeUserInfoByColumnNames',
                data:{
                    column_names:obj.field,
                    column_value:obj.value,
                    user_id:objdata.user_id
                },
                success:function(res){
                    if(res.code==0){
                        layer.msg(res.info,{icon:1});
                    }else if(res.code==1){
                        layer.alert(res.info,{icon:5});
                    }else{
                        layer.alert("返回值异常",{icon:5});
                    }
                }
            })
        });

        /**
         * 更新工号
         */
        table.on('tool(table_userinfo_lay_filter)', function (obj) {
            var objdata = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if (layEvent === 'edit_user_id') {
                layer.prompt({
                        formType: 0,
                        title: '请输入新的工号',
                    },
                    function (value, index, elem) {
                        if (value.length <= 4) {
                            layer.tips('工号长度需要4位以上', ".layui-layer-input");
                            return;
                        }
                        admin.ajax_load_json({
                            url:'changeUserIdByPid',
                            data:{
                                user_id:value,
                                pid:objdata.pid
                            },
                            success:function(res){
                                if(res.code==0){
                                    layer.msg(res.info,{icon:1});
                                }else if(res.code==1){
                                    layer.alert(res.info,{icon:5});
                                }else{
                                    layer.alert("返回值异常",{icon:5});
                                }
                            }
                        })

                    })
            }
        });


        $('.layui-btn').on('click',
            function () {
                var othis = $(this),
                    method = othis.data('method');
                active[method] ? active[method].call(this, othis) : '';
            });
        var active = {
            get_user: function () {
                table.reload('userinfo_table', {
                    url: 'get_user'
                    , method: 'post'
                    , where: {
                        user_id: $("#input_value").val(),
                        sta: radio_sta
                    }
                });
            }
        }

    });