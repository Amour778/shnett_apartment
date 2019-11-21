<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<div style="padding: 20px; background-color: #F2F2F2;" id="apply_apartment_id" class="layui-form"
     lay-filter="apply_apartment_lay_filter">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body">
                    <div class="layui-form-item" style="display: none" >
                        <label class="layui-form-label">*公寓ID</label>
                        <div class="layui-input-block">
                            <input type="text"  name="apa_id" required readonly disabled  :lay-verify="apa_id_required"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">*公寓名称</label>
                        <div class="layui-input-block">
                            <input type="text"  name="apa_name" required  lay-verify="required"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">省</label>
                        <div class="layui-input-block">
                            <input type="text"  name="apa_province"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">市</label>
                        <div class="layui-input-block">
                            <input type="text"  name="apa_city"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">区</label>
                        <div class="layui-input-block">
                            <input type="text"  name="apa_area"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">*具体地址</label>
                        <div class="layui-input-block">
                            <input type="text"  name="apa_address" required  lay-verify="required"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">*公寓联系人</label>
                        <div class="layui-input-block">
                            <input type="text"  name="apa_user" required  lay-verify="required"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">*联系号码</label>
                        <div class="layui-input-block">
                            <input type="text"  name="apa_tel" required  lay-verify="required"
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">备注</label>
                        <div class="layui-input-block">
                            <input type="text" name="apa_remarks"
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">公寓所在地址经纬度</label>
                        <div class="layui-input-block">
                            <input type="text"  name="apa_local" v-model="apa_local"
                                   class="layui-input">
                            <iframe id="mapPage" width="100%" height="400px" frameborder=0
                                    src="https://apis.map.qq.com/tools/locpicker?search=1&type=1&key=OHMBZ-3E76U-DGKVQ-2NO55-UUYRO-UHFDO&referer=shnett_apartment">
                            </iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-md12">
            <button v-if="saveBtnShow" class="layui-btn" style="float:right" type="submit" lay-submit lay-filter="submit_add_apartment_info">
                添加
            </button>
            <button v-if="updateBtnShow" class="layui-btn" style="float:right" type="submit" lay-submit lay-filter="submit_update_apartment_info">
                保存修改
            </button>
        </div>
    </div>
</div>

<script charset="utf-8" src="https://map.qq.com/api/gljs?v=1.exp&key=OHMBZ-3E76U-DGKVQ-2NO55-UUYRO-UHFDO"></script>
<script type="text/javascript">
    layui.use(['laydate', 'form', 'element', 'layer', 'formSelects', 'admin'], function () {
        var element = layui.element
            , layer = layui.layer
            , admin = layui.admin
            , form = layui.form;

        var vue_data = new Vue({
            el: '#apply_apartment_id',
            data: {
                apa_id_required:'false',
                saveBtnShow:false,
                updateBtnShow:false,
                apa_local:null
            }
        });
        window.addEventListener('message', function(event) {
            // 接收位置信息，用户选择确认位置点后选点组件会触发该事件，回传用户的位置信息
            var loc = event.data;
            if (loc && loc.module == 'locationPicker') {//防止其他应用也会向该页面post信息，需判断module是否为'locationPicker'
                console.log('location', loc);
                vue_data.apa_local = loc.latlng.lat+','+loc.latlng.lng;
            }
        }, false);

        //vue_data.ApartmentInfo = admin.getTempData('apartmentInfo');
        if(admin.getTempData('apartmentInfo')==null){
            vue_data.saveBtnShow=true;
        }else{
            vue_data.updateBtnShow=true;
            vue_data.apa_id_required="required";
            //给表单赋值
            vue_data.apa_local =admin.getTempData('apartmentInfo').apa_local;
            form.val("apply_apartment_lay_filter", admin.getTempData('apartmentInfo'));
        }
        //数据提交
        form.on('submit(submit_update_apartment_info)', function (obj) {
            admin.ajax_load_json({
                url: 'updateApartmentInfoByApartmentId',
                data: obj.field,
                success: function (data) {
                    console.log(data);
                    if (data.code == 0) {
                        layer.closeAll();
                        layer.msg(data.info, {icon: 1});
                    } else {
                        layer.alert(data.info, {icon: 5});
                    }
                }
            });
        });
        //数据提交
        form.on('submit(submit_add_apartment_info)', function (obj) {
            admin.ajax_load_json({
                url: 'addNewApartmentInfo',
                data: obj.field,
                success: function (data) {
                    console.log(data);
                    if (data.code == 0) {
                        layer.closeAll();
                        layer.msg(data.info, {icon: 1});
                    } else {
                        layer.alert(data.info, {icon: 5});
                    }
                }
            });
        });

    });
</script>
