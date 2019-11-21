<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<div style="padding: 20px; background-color: #F2F2F2;" id="apply_info_id">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">用户基础信息</div>
                <div class="layui-card-body">
                    <div class="layui-form-item">
                        <label class="layui-form-label">工号</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.user_id" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">姓名</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.user_name" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">手机号码</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.user_tel" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">所属网点</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.user_point" readOnly
                                   class="layui-input">
                        </div>
                    </div>
<%--                    <div class="layui-form-item">
                        <label class="layui-form-label">性别</label>
                        <div class="layui-input-inline">
                            <input type="text" v-if="ApplyInfo.user_sex==0" value="女" readOnly
                                   class="layui-input">
                            <input type="text" v-else-if="ApplyInfo.user_sex==1" value="男" readOnly
                                   class="layui-input">
                        </div>
                    </div>--%>
                    <div class="layui-form-item">
                        <label class="layui-form-label">用工类型</label>
                        <div class="layui-input-inline">
                            <input type="text" v-if="ApplyInfo.user_type==0" value="社招" readOnly
                                   class="layui-input">
                            <input type="text" v-else-if="ApplyInfo.user_type==1" value="实习生" readOnly
                                   class="layui-input">
                            <input type="text" v-else-if="ApplyInfo.user_type==2" value="非新工" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">退租申请信息</div>
                <div class="layui-card-body">
                    <div class="layui-form-item">
                        <label class="layui-form-label">公寓名称</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.apa_name" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">房间名称</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.roo_name" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">床位名称</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.bed_name" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">退租时间</label>
                        <div class="layui-input-inline">

                            <input type="text" v-model="ApplyInfo.date_move_out" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">退租原因</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.out_reason" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">状态</div>
                <div class="layui-card-body">
                    <form class="layui-form" action="" onsubmit="return false">
                        <div class="layui-form-item">
                            <label class="layui-form-label">审批结果</label>
                            <div class="layui-input-inline">
                                <input type="text" v-if="ApplyInfo.sta==0" value="未审批" readOnly class="layui-input">
                                <input type="text" v-else-if="ApplyInfo.sta==1" value="通过" readOnly class="layui-input">
                                <input type="text" v-else-if="ApplyInfo.sta==2" value="驳回" readOnly class="layui-input">
                                <input type="text" v-else value="未知状态" readOnly class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" v-if="ApplyInfo.sta==0">待审批</label>
                            <label class="layui-form-label" v-else-if="ApplyInfo.sta==1">结果</label>
                            <label class="layui-form-label" v-else-if="ApplyInfo.sta==2">驳回原因</label>
                            <label class="layui-form-label" v-else>未知状态</label>
                            <div class="layui-input-inline">
                                <input type="text" v-if="ApplyInfo.sta==0" value="未审批" readOnly class="layui-input">
                                <input type="text" v-else-if="ApplyInfo.sta==1" value="通过" readOnly class="layui-input">
                                <input type="text" v-else-if="ApplyInfo.sta==2" :value="ApplyInfo.apply_remarks" readOnly class="layui-input">
                                <input type="text" v-else value="未知状态" readOnly class="layui-input">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="layui-col-md12" v-if="ApplyInfo.sta==0">
            <div class="layui-card">
                <div class="layui-card-header">操作</div>
                <div class="layui-card-body">
                    <form class="layui-form" action="" onsubmit="return false">
                        <input name="id" v-model="ApplyInfo.id" readOnly disabled style="display:none">
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <input type="radio" name="sta" value="1" title="同意" checked lay-filter="apply_sta">
                                <input type="radio" name="sta" value="2" title="驳回" lay-filter="apply_sta">
                            </div>
                        </div>
                        <div class="layui-form layui-form-pane">
                            <div class="layui-form-item" v-show="staIsOne==false">
                                <label class="layui-form-label">驳回原因</label>
                                <div class="layui-input-block">
                                    <input type="text" name="apply_remarks" class="layui-input" autocomplete="off"
                                           :lay-verify="apply_remarks_required">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" type="submit" lay-submit
                                            lay-filter="submit_apply_sta">
                                        提交审批
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="layui-col-md12"
             v-if="ApplyInfo.sta==1 && ApplyInfo.admin_arrange!=''&& ApplyInfo.admin_arrange!=null">
            <div class="layui-card">
                <div class="layui-card-header">绑定房间</div>
                <div class="layui-card-body">
                    <form class="layui-form" action="" onsubmit="return false">


                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
</div>


<script type="text/javascript">
    layui.use(['laydate', 'form', 'element', 'layer', 'formSelects'], function () {
        var element = layui.element
            , layer = layui.layer
            , formSelects = layui.formSelects
            , laydate = layui.laydate
            , form = layui.form;
        var apply_type = admin.getTableBtnInfo();
        var apply_id = admin.getTempData('apply_id');
        var vue_data = new Vue({
            el: '#apply_info_id',
            data: {
                ApplyInfo: {
                    //用户基础信息
                    user_id: '',
                    user_name: '',
                    user_tel: '',
                    user_point: '',
                    user_sex: '',
                    user_type: '',

                    //申请信息：退租
                    id: '',
                    apa_name: '',
                    roo_name: '',
                    bed_name: '',
                    date_move_out: '',
                    out_reason: '',

                    //其他信息
                    sta: '',
                    apply_remarks: ''
                },
                staIsOne: true,
                apply_remarks_required: 'false',
            }
        });


        form.render();
        admin.ajax_load_json({
            url: 'queryApplyInfoById',
            data: {
                id: apply_id,
                apply_type: apply_type
            },
            success: function (data) {
                console.log(data);
                form.render();
                vue_data.ApplyInfo = data.info[0];
                console.log('vue_data.ApplyInfo.apply_type=' + vue_data.ApplyInfo.apply_type);
                if (data.code == 0) {
                    if (vue_data.ApplyInfo.apply_type == 0) {

                        form.on('radio(apply_sta)', function (radiodata) {
                            if (radiodata.value == "1") {
                                vue_data.staIsOne = true;
                                vue_data.apartment_required = 'required';
                                vue_data.apply_remarks_required = 'false';
                            } else if (radiodata.value == "2") {
                                vue_data.staIsOne = false;
                                vue_data.apartment_required = 'false';
                                vue_data.apply_remarks_required = 'required';
                            }
                        });
                    } else if (vue_data.ApplyInfo.apply_type == 1) {
                        form.on('radio(apply_sta)', function (radiodata) {
                            if (radiodata.value == "1") {
                                vue_data.staIsOne = true;
                                vue_data.apply_remarks_required = 'false';
                            } else if (radiodata.value == "2") {
                                vue_data.staIsOne = false;
                                vue_data.apply_remarks_required = 'required';
                            }
                        });
                    } else {
                        layer.alert('数据获取成功但是解析异常，未获取到正确的申请类型。apply_type=' + vue_data.ApplyInfo.apply_type, {icon: 5});
                    }

                } else {
                    layer.alert(data.info, {icon: 5});
                }
            }
        });

        form.on('submit(submit_apply_sta)', function (obj) {
            console.log(obj.field);
            admin.ajax_load_json({
                url: 'applicationForExaminationAndApprovalByApplyIdToCheckout',
                data:{
                    id:apply_id,
                    user_id:vue_data.ApplyInfo.user_id,
                    bed_id:vue_data.ApplyInfo.bed_id,
                    sta:obj.field.sta,
                    apply_remarks:obj.field.apply_remarks
                },
                success: function (data) {
                    console.log(data);
                    if (data.code == 0) {
                        layer.closeAll();
                        layer.msg(data.message, {icon: 1});
                    } else {
                        layer.alert(data.message, {icon: 5});
                    }
                }
            });
        });

    });
</script>
