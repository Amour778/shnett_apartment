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
                        <label class="layui-form-label">身份证号</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.user_cardid" readOnly
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
                    <div class="layui-form-item">
                        <label class="layui-form-label">入职日期</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.date_entry" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">性别</label>
                        <div class="layui-input-inline">
                            <input type="text" v-if="ApplyInfo.user_sex==0" value="女" readOnly
                                   class="layui-input">
                            <input type="text" v-else-if="ApplyInfo.user_sex==1" value="男" readOnly
                                   class="layui-input">
                        </div>
                    </div>
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
                <div class="layui-card-header">申请信息</div>
                <div class="layui-card-body">
                    <div class="layui-form-item">
                        <label class="layui-form-label">入住事由</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.in_reason" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">入住日期</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.date_check_in" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">结束日期</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.date_move_out" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">申请类型</label>
                        <div class="layui-input-inline">
                            <input type="text" v-if="ApplyInfo.apply_type==0" value="新住" readOnly
                                   class="layui-input">
                            <input type="text" v-else-if="ApplyInfo.apply_type==1" value="续住" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">公寓意向</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.user_intention" readOnly
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">申请时间</label>
                        <div class="layui-input-inline">
                            <input type="text" v-model="ApplyInfo.create_date" readOnly
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
                                <input type="text" v-if="ApplyInfo.sta==0" value="未审批" readOnly
                                       class="layui-input">
                                <input type="text" v-else-if="ApplyInfo.sta==1" style="color:#009688"  value="通过" readOnly
                                       class="layui-input">
                                <input type="text" v-else-if="ApplyInfo.sta==2" value="驳回" readOnly
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" v-if="ApplyInfo.sta==0">待审批</label>
                            <label class="layui-form-label" v-else-if="ApplyInfo.sta==1">分配的公寓</label>
                            <label class="layui-form-label" v-else-if="ApplyInfo.sta==2">驳回原因</label>
                            <label class="layui-form-label" v-else>未知状态</label>
                            <div class="layui-input-inline">
                                <input type="text" v-if="ApplyInfo.sta==0" readOnly class="layui-input">
                                <input type="text" v-else-if="ApplyInfo.sta==1"
                                       v-model="ApplyInfo.admin_arrange" readOnly class="layui-input">
                                <input type="text" v-else-if="ApplyInfo.sta==2"
                                       v-model="ApplyInfo.apply_remarks" readOnly class="layui-input">
                                <input type="text" n v-else value="未知状态" readOnly class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" v-if="ApplyInfo.apply_type==0">是否入住</label>
                            <div class="layui-input-inline">
                                <input type="text" v-if="ApplyInfo.is_check==0"readOnly class="layui-input" value="未入住">
                                <input type="text" v-else-if="ApplyInfo.is_check==1" style="color:#009688"  readOnly class="layui-input" value="已入住">
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
                            <div v-show="staIsOne==true">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">分配公寓</label>
                                    <div class="layui-input-block">
                                        <select name="admin_arrange" xm-select="ApartmentInfoSelect" id="admin_arrange"
                                                lay-verType="tips"
                                                class="layui-input-block"
                                                xm-select-radio=""
                                                xm-select-search=""
                                                xm-select-search-type="dl" xm-select-show-count="3"
                                                xm-select-direction="up"
                                                xm-select-skin="default">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item" v-show="staIsOne==false">
                                <label class="layui-form-label">驳回原因</label>
                                <div class="layui-input-block">
                                    <input type="text" name="apply_remarks" class="layui-input" id="apply_remarks"
                                           autocomplete="off">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">入住日期</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" id="date_check_in" name="date_check_in"
                                           placeholder="yyyy-MM-dd" lay-verify="required">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">结束日期</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" id="date_move_out" name="date_move_out"
                                           placeholder="yyyy-MM-dd" lay-verify="required">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" type="submit" lay-submit lay-filter="submit_apply_sta">
                                        提交审批
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
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
                    user_cardid: '',
                    user_tel: '',
                    user_point: '',
                    user_sex: '',
                    date_entry: '',
                    user_type: '',
                    //申请信息
                    id: '',
                    user_intention: '',
                    in_reason: '',
                    check_in_type: '',
                    apply_type: '',
                    date_check_in: '',
                    date_move_out: '',
                    create_date: '',
                    //其他信息
                    sta: '',
                    admin_arrange: '',
                    apply_remarks: '',
                    is_check: ''
                },
                staIsOne: true,
                showApplyBtn: false, //显示管理员审批按钮
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
                if (data.code == 0) {
                    vue_data.ApplyInfo = data.info[0];
                    laydate.render({
                        elem: '#date_check_in',
                        value: vue_data.ApplyInfo.date_check_in
                    });
                    laydate.render({
                        elem: '#date_move_out',
                        value: vue_data.ApplyInfo.date_move_out
                    });
                    formSelects.data('ApartmentInfoSelect', 'server', {
                        url: "getAllApartmentInfo"
                    });
                } else {
                    layer.alert(data.info, {icon: 5});
                }
            }
        });


        form.on('radio(apply_sta)', function (radiodata) {
            formSelects.value('ApartmentInfoSelect', []);
            $("#apply_remarks").val('');
            if (radiodata.value == "1" || radiodata.value == 1) {
                vue_data.staIsOne = true;
            } else if (radiodata.value == "2" || radiodata.value == 2) {
                vue_data.staIsOne = false;
            }
        });
        form.on('submit(submit_apply_sta)', function (obj) {
            console.log(obj.field);
            var admin_arrange = formSelects.value('ApartmentInfoSelect', 'valStr');
            if (vue_data.staIsOne && (admin_arrange == [] || admin_arrange == null)) {
                console.log('选中的公寓，但是没有值:vue_data.staIsOne=' + vue_data.staIsOne + ',admin_arrange=' + admin_arrange + '&');
                layer.msg('请选择需要分配给用户的公寓');
                return;
            }
            var apply_remarks = $("#apply_remarks").val();
            if (!vue_data.staIsOne && (apply_remarks == '' || apply_remarks == null)) {
                console.log('选中的驳回，但是没有值:vue_data.staIsOne=' + vue_data.staIsOne + ',apply_remarks=' + apply_remarks + '&');
                layer.msg('请输入驳回的理由');
                return;
            }
            admin.ajax_load_json({
                url: 'applicationForExaminationAndApprovalByApplyIdToCheckIn',
                data: obj.field,
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
