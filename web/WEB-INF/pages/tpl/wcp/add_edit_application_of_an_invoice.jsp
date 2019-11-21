<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
	<form class="layui-form" action="" onsubmit="return false" lay-filter="application_of_an_invoice_form_filter" id="application_of_an_invoice_form">
  <div class="layui-form-item" style="display:none">
    <label class="layui-form-label">AID</label>
    <div class="layui-input-block">
      <input type="text" name="aid"  id="aid" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">工号</label>
    <div class="layui-input-block">
      <input type="text" name="user_id"  required  lay-verify="required" id="user_id" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">申请人</label>
    <div class="layui-input-block">
      <input type="text" name="user_name"  id="user_name" required  lay-verify="required" placeholder="由工号自动带出" readOnly="readOnly" disabled autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">地区</label>
    <div class="layui-input-block">
      <input type="text" name="wcp_area" id="wcp_area"  required  lay-verify="required"  placeholder="由工号自动带出" readOnly="readOnly" disabled autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">项目编码</label>
    <div class="layui-input-block">
      <input type="text" name="project_code" required  lay-verify="required"  readOnly="readOnly" disabled autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">项目名称</label>
    <div class="layui-input-block">
      <input type="text" name="project_name" required  lay-verify="required"  readOnly="readOnly" disabled autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">发票类型</label>
    <div class="layui-input-block">
      <select name="invoice_type" lay-verify="required" lay-search>
        <option value=""></option>
        <option value="0">专票</option>
        <option value="1">普票</option>
      </select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">公司名称</label>
    <div class="layui-input-block">
      <input type="text" name="company_name" required  lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">纳税人识别号</label>
    <div class="layui-input-block">
      <input type="text" name="taxpayer_identification_number" required  lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">开户行及银行账号</label>
    <div class="layui-input-block">
      <input type="text" name="bank_and_bank_account_number" required  lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">地址及电话</label>
    <div class="layui-input-block">
      <input type="text" name="address_and_telephone_number" required  lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">开票名称</label>
    <div class="layui-input-block">
      <input type="text" name="name_of_make_out_an_invoice" required  lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">规格型号</label>
    <div class="layui-input-block">
      <input type="text" name="specifications" required  lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">单位</label>
    <div class="layui-input-block">
      <input type="text" name="unit" required  lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">数量</label>
    <div class="layui-input-block">
      <!-- <input type="text" name="number" required  lay-verify="required" autocomplete="off" class="layui-input">-->
      <input  name='number' id="number" class='layui-input layui-input-number'  min='0' step='1' data-prec='0' lay-verify='required'  lay-verType='tips'>
					
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">开票金额（含税）</label>
    <div class="layui-input-block">
      <!-- <input type="text" name="invoice_amount_excluding_tax" required  lay-verify="required" autocomplete="off" class="layui-input">-->
      <input  name='invoice_amount_excluding_tax' id="invoice_amount_excluding_tax" class='layui-input layui-input-number' min='0' step='1' data-prec='2' lay-verify='required'  lay-verType='tips'>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">税率</label>
    <div class="layui-input-block">
      <!-- <input type="text" name="rate" required  lay-verify="required" autocomplete="off" class="layui-input">-->
      <input  name='rate' id="rate" class='layui-input layui-input-number' min='0' step='1' data-prec='2' lay-verify='required'  lay-verType='tips'>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">开票金额（不含税）</label>
    <div class="layui-input-block">
      <input type="text" name="invoice_amount_included_tax" id="invoice_amount_included_tax" required  lay-verify="required" readOnly="readOnly" disabled autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">备注</label>
    <div class="layui-input-block">
      <input type="text" name="note" required  lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit v-bind:style='{ display : display_btn_add }'  id="add_application_of_an_invoice" lay-filter="add_application_of_an_invoice">提交申请</button>
      <button class="layui-btn" lay-submit v-bind:style='{ display : display_btn_update }' id="upload_application_of_an_invoice" lay-filter="upload_application_of_an_invoice">提交修改</button>
    </div>
  </div>
</form>
<script>
  layui.use(['form','jquery','admin','layer','numinput','laytpl'], function(){
    var form = layui.form
    , jquery = layui.jquery
    , admin = layui.admin
    , numinput = layui.numinput
    , layer = layui.layer;
    var vue_data  =  new Vue({
		el: '#application_of_an_invoice_form',
		data: {
			display_btn_add : 'inline',
			display_btn_update: 'none'
		}
	});
	numinput.init({
	    topBtns: 789, // 123：123键置顶, 789：789键置顶
	    rightBtns: true,// 右侧功能按钮
	    listening: true,// 监听键盘事件
	    defaultPrec: '2',// 批量配置默认小数精确度
	    hideEnd:function(){
	    	var invoice_amount_excluding_tax= $("#invoice_amount_excluding_tax").val();
	    	var rate= $("#rate").val();
	    	var invoice_amount_included_tax = (invoice_amount_excluding_tax / (1 + rate)).toFixed(2);
	    	 $("#invoice_amount_included_tax").val(invoice_amount_included_tax);
	    }
	});
    var application_of_an_invoice_data = admin.getTempData('application_of_an_invoice_data');
	var project_code = admin.getTempData('project_code');
	var project_name = admin.getTempData('project_name');
    if(application_of_an_invoice_data!=null&&application_of_an_invoice_data!="N"){
		vue_data.display_btn_add = 'none';
		vue_data.display_btn_update= 'inline';
    	var aoai_data =application_of_an_invoice_data;
        form.val("application_of_an_invoice_form_filter", {
        	"aid": aoai_data.aid,
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
      form.val("application_of_an_invoice_form_filter", {
		  "project_code": project_code
		  ,"project_name": project_name
		})
    }

	 $('#user_id').blur(function () {
		admin.ajax_load_json({
			url : "getUserNameAndWCPAreaByUserId",
			data:{
				user_id : $(this).val()
			},
			success : function(data){
				console.log();
				if(data.code==0){
				 $("#user_name").val(data.info[0].user_name);
				 $("#wcp_area").val(data.info[0].wcp_area);
				
				}else{
					layer.alert(data.info,{icon:5});
				}
			}
		});
	});
 		

    form.on('submit(add_application_of_an_invoice)', function(data){
        admin.ajax_load_json({
	    	url : "addWCP_AOAI_info",
	    	data:{
	    		project_code : project_code,
	    		info : JSON.stringify(data.field)
	    	},
	    	success : function(data){
	    		if(data.code==0){
	    			layer.msg(data.info,{icon:1});
	    			layer.close(admin.getTempData('pending_edit_application_of_an_invoice'));
	    		}else{
					layer.alert(data.info,{icon:5});
	    		}
	    	}
	    }); 		
      return false;
    });
    form.on('submit(upload_application_of_an_invoice)', function(data){
        admin.ajax_load_json({
	    	url : "updateWCP_AOAI_info",
	    	data:{
	    		info : JSON.stringify(data.field)
	    	},
	    	success : function(data){
	    		if(data.code==0){
	    			layer.msg(data.info,{icon:1});
	    			layer.close(admin.getTempData('pending_edit_application_of_an_invoice'));
	    		}else{
					layer.alert(data.info,{icon:5});
	    		}
	    	}
	    }); 		
      return false;
    });
    
  });
</script>