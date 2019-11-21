<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
	<form class="layui-form" action="" onsubmit="return false" lay-filter="application_of_an_invoice_form_filter" id="application_of_an_invoice_form">
  <div class="layui-form-item">
    <label class="layui-form-label">工号</label>
    <div class="layui-input-block">
      <input type="text" name="user_id"     id="user_id" readOnly="readOnly" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">申请人</label>
    <div class="layui-input-block">
      <input type="text" name="user_name"  id="user_name"    readOnly="readOnly" disabled autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">地区</label>
    <div class="layui-input-block">
      <input type="text" name="wcp_area" id="wcp_area"      readOnly="readOnly" disabled autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">项目编码</label>
    <div class="layui-input-block">
      <input type="text" name="project_code"     readOnly="readOnly" disabled autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">项目名称</label>
    <div class="layui-input-block">
      <input type="text" name="project_name"     readOnly="readOnly" disabled autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">发票类型</label>
    <div class="layui-input-block">
      <select name="invoice_type"  lay-search >
        <option value=""></option>
        <option value="0">专票</option>
        <option value="1">普票</option>
      </select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">公司名称</label>
    <div class="layui-input-block">
      <input type="text" name="company_name"    autocomplete="off" readOnly="readOnly" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">纳税人识别号</label>
    <div class="layui-input-block">
      <input type="text" name="taxpayer_identification_number"    readOnly="readOnly" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">开户行及银行账号</label>
    <div class="layui-input-block">
      <input type="text" name="bank_and_bank_account_number"    readOnly="readOnly" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">地址及电话</label>
    <div class="layui-input-block">
      <input type="text" name="address_and_telephone_number"    readOnly="readOnly" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">开票名称</label>
    <div class="layui-input-block">
      <input type="text" name="name_of_make_out_an_invoice"    readOnly="readOnly" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">规格型号</label>
    <div class="layui-input-block">
      <input type="text" name="specifications"    readOnly="readOnly" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">单位</label>
    <div class="layui-input-block">
      <input type="text" name="unit"    autocomplete="off" readOnly="readOnly" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">数量</label>
    <div class="layui-input-block">
      <input type="text" name="number"    autocomplete="off" readOnly="readOnly"  class="layui-input">
					
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">开票金额（含税）</label>
    <div class="layui-input-block">
     <input type="text" name="invoice_amount_excluding_tax"    readOnly="readOnly"  autocomplete="off" class="layui-input">
     </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">税率</label>
    <div class="layui-input-block">
      <!-- <input type="text" name="rate"    autocomplete="off" class="layui-input">-->
      <input  name='rate' id="rate" class='layui-input layui-input-number' min='0' step='1' data-prec='2' lay-verify='' readOnly="readOnly"  lay-verType='tips'>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">开票金额（不含税）</label>
    <div class="layui-input-block">
      <input type="text" name="invoice_amount_included_tax" id="invoice_amount_included_tax"    readOnly="readOnly" disabled autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">备注</label>
    <div class="layui-input-block">
      <input type="text" name="note"    autocomplete="off" readOnly="readOnly" class="layui-input">
    </div>
  </div>
  
  <div class="layui-form-item">
    <div class="layui-input-block">
		<button class="layui-btn layui-btn-radius" id="pending_agree_aoai"><i class="layui-icon layui-icon-ok"></i>同意</button>
		<button class="layui-btn layui-btn-radius layui-btn-danger" id="pending_reject_aoai"><i class="layui-icon layui-icon-close"></i>驳回</button>
	</div>
  </div>
</form>
<script>
  layui.use(['form','jquery','admin','layer','numinput','laytpl'], function(){
    var form = layui.form
    , jquery = layui.jquery
    , admin = layui.admin
    , layer = layui.layer;
    var application_of_an_invoice_data = admin.getTempData('application_of_an_invoice_data');
    var aid = application_of_an_invoice_data.aid;
    var project_code = application_of_an_invoice_data.project_code;
    if(application_of_an_invoice_data!=null&&application_of_an_invoice_data!="N"){
    	var aoai_data =application_of_an_invoice_data;
        form.val("application_of_an_invoice_form_filter", {
		    "user_id": aoai_data.user_id,
		    "user_name": aoai_data.user_name,
		    "wcp_area": aoai_data.wcp_area,
		    "project_code": aoai_data.project_code,
		    "project_name": aoai_data.project_name,
		    "invoice_type": aoai_data.invoice_type,
		    "company_name": aoai_data.company_name,
		    "taxpayer_identification_number": aoai_data.taxpayer_identification_number,
		    "bank_and_bank_account_number": aoai_data.bank_and_bank_account_number,
		    "address_and_telephone_number": aoai_data.address_and_telephone_number,
		    "name_of_make_out_an_invoice": aoai_data.name_of_make_out_an_invoice,
		    "specifications": aoai_data.specifications,
		    "unit": aoai_data.unit,
		    "number":aoai_data.number,
		    "invoice_amount_excluding_tax": aoai_data.invoice_amount_excluding_tax,
		    "rate": aoai_data.rate,
		    "invoice_amount_included_tax": aoai_data.invoice_amount_included_tax,
		    "note": aoai_data.note
		})
    }else{
     layer.alert("获取开票数据失败",{icon:5});
     $('#pending_agree_aoai').addClass("layui-btn-disabled").attr("disabled", "disabled");
     $('#pending_reject_aoai').addClass("layui-btn-disabled").attr("disabled", "disabled");
    }

	//同意
	$('#pending_agree_aoai').click(function() {
		admin.ajax_load_json({
			url: 'updateWCP_AOAI_AuditStatusAndAuditInfoByAid',
			data: {
				aid: aid,
				project_code: project_code,
				audit_status: 2211,
				audit_info: 'N'
			},
			success: function(data) {
				if (data.code == 0) {
					layer.msg(data.info, {
						icon: 1
					});
	    			layer.close(admin.getTempData('pending_edit_application_of_an_invoice'));
				} else {
					layer.alert(data.info, {
						icon: 5
					});
				}
			}
		});
	});

	//驳回
	$('#pending_reject_aoai').click(function() {
		layer.prompt({
			formType: 0,
			title: '请输入驳回理由',
		},
		function(value, index, elem) {
			admin.ajax_load_json({
				url: 'updateWCP_AOAI_AuditStatusAndAuditInfoByAid',
				data: {
					aid: aid,
					project_code: project_code,
					audit_status: 2212,
					audit_info: value
				},
				success: function(data) {
					if (data.code == 0) {
						layer.msg(data.info, {
							icon: 1
						});
					layer.close(index);
	    			layer.close(admin.getTempData('pending_edit_application_of_an_invoice'));
					} else {
						layer.alert(data.info, {
							icon: 5
						});
					}
				}
			});
		});
	});
 		
   
  });
</script>