<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="layui-card">
    <div class="layui-card-body">
        <div class="layui-form toolbar">

            <div class="layui-form layui-form-pane">
                <div class="layui-form-item">
                    <label class="layui-form-label">房间</label>
                    <div class="layui-input-block">
                        <select name="SelectUserRoom" xm-select="SelectUserRoom" lay-verify="required"
                                lay-verType="tips"
                                class="layui-input-block"
                                xm-select-radio=""
                                xm-select-search=""
                                xm-select-search-type="dl"
                                xm-select-direction="auto" ,
                                xm-select-skin="default">
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-form layui-form-pane">
                <div class="layui-form-item">
                    <label class="layui-form-label">床位</label>
                    <div class="layui-input-block">
                        <select name="SelectUserBed" xm-select="SelectUserBed" lay-verify="required"
                                lay-verType="tips"
                                class="layui-input-block"
                                xm-select-radio=""
                                xm-select-search=""
                                xm-select-search-type="dl"
                                xm-select-direction="auto"
                                xm-select-skin="default">
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <button class="layui-btn layui-btn-lg layui-btn-normal" id="checkIn" type="button">提交</button>
    </div>
</div>
<script>
    layui.use(['layer', 'formSelects', 'admin', 'jquery'], function () {
        var layer = layui.layer
            , $ = layui.jquery
            , admin = layui.admin
            , formSelects = layui.formSelects;
        var apply_id = admin.getTempData('apply_id');
        var admin_arrange = admin.getTempData('admin_arrange');
        var user_id = admin.getTempData('user_id');
        //var admin_arrange = admin.getTableBtnInfo();
        console.log('apply_id', apply_id)
        console.log('admin_arrange', admin_arrange)
        console.log('user_id', user_id)

        var roo_id = null, bed_id = null;
        formSelects.data('SelectUserRoom', 'server', {
            url: "getAllApartmentRoomByApaId",
            data: {
                apa_id: admin_arrange
            }
        });
        //监听用户选择房间
        formSelects.on('SelectUserRoom', function (id, vals, val, isAdd, isDisabled) {
            roo_id = formSelects.value('SelectUserRoom', 'valStr');
            console.log('roo_id=' + roo_id);
            if (roo_id != '' && roo_id != null) {
                formSelects.data('SelectUserBed', 'server', {
                    url: "getAllApartmentBedByRoomId",
                    data: {
                        roo_id: roo_id
                    },
                    beforeSuccess: function (id, url, searchVal, result) {
                        if(result.code==1){
                            layer.msg(result.info);
                            formSelects.render("SelectUserBed");
                        }

                        return result;
                    },

                });

                //监听用户选择床位
                formSelects.on('SelectUserBed', function (id, vals, val, isAdd, isDisabled) {
                    bed_id = formSelects.value('SelectUserBed', 'valStr');
                    console.log('bed_id=' + bed_id);
                }, true);
            }
        }, true);



        $("#checkIn").on('click', function () {
            console.log('roo_id=' + roo_id);
            console.log('bed_id=' + bed_id);
            if (roo_id == '' || roo_id == null) {
                layer.msg('请选择房间');
                return;
            }
            if (bed_id == '' || bed_id == null) {
                layer.msg('请选择床位');
                return;
            }
            admin.ajax_load_json({
                url: 'checkInWithUserIdAndBedId',
                data: {
                    bed_id: bed_id,
                    user_id: user_id,
                    apply_id: apply_id,
                },
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
        })
    });
</script>