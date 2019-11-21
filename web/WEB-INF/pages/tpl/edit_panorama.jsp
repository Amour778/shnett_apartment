<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<hr/>
<form class="layui-form" action="" id="form1" style="width:90%"  lay-filter="formTest">
  <div class="layui-form-item">
      <label class="layui-form-label">事项名称（一级）*</label>
      <div class="layui-input-block superior_item_id">
       <select name="superior_item_id" id="superior_item_id"    xm-select="superior_item_id" xm-select-max="1" lay-verify="required" xm-select-search="" xm-select-search-type="dl" xm-select-radio=""></select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">事项名称（二级）</label>
    <div class="layui-input-block">
      <input type="text" name="item_name" autocomplete="off" class="layui-input"  lay-verType="tips"  lay-verify="required|itemName_length" >
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">组织</label>
    <div class="layui-input-block">
      <input type="text" name="organization"  autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">工作内容*</label>
    <div class="layui-input-block">
      <input type="text" name="work_content"  lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">完成周期</label>
    <div class="layui-input-block">
      <input type="text" name="completion_cycle"   autocomplete="off" class="layui-input">
    </div>
  </div>
  
  <div class="layui-form-item">
    <label class="layui-form-label">责任人*</label>
    <div class="layui-input-block person_liable">
      <select name="person_liable"  id="person_liable"  xm-select="person_liable" xm-select-max="1" lay-verify="required" xm-select-search="" xm-select-search-type="dl" xm-select-radio=""></select>

    </div>
  </div>
  
  <div class="layui-form-item">
    <label class="layui-form-label">配合人</label>
    <div class="layui-input-block">
      <select name="partner"  id="partner" xm-select="partner" xm-select-search="" xm-select-search-type="dl" xm-select-show-count="3"></select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">开始时间*</label>
    <div class="layui-input-block">
     <input type="text" class="layui-input" id="start_time"  autocomplete="off" name="start_time" lay-verify="required">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">完成时间*</label>
    <div class="layui-input-block">
     <input type="text" class="layui-input" id="completion_time"  autocomplete="off" name="completion_time" lay-verify="required" >
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button name="cont" class="layui-btn" lay-submit lay-filter="formDemo" onClick="document.register.cont.value='正在提交,请稍后';document.register.cont.disabled=true;document.the_form.submit();">立即提交</button>
    </div>
  </div>
</form>
 
		<script charset="utf-8"><!--
		layui.use(['layedit','layer', 'form', 'table', 'laydate','admin','formSelects'],
function() {
	var $ = layui.jquery,
	layedit = layui.layedit,
	admin = layui.admin,
	form = layui.form,
	laydate = layui.laydate,
	formSelects = layui.formSelects,
	layer = layui.layer;
	
	laydate.render({
		elem: '#start_time'
	});
	laydate.render({
		elem: '#completion_time'
	});
	console.log("SPID="+admin.getTempData('temp_pannrama_detail_superior_item_id'));
		form.val("formTest", {
		  "item_name":admin.getTempData('temp_pannrama_detail_itemName')
		  ,"organization":admin.getTempData('temp_pannrama_detail_organization')
		  ,"work_content":admin.getTempData('temp_pannrama_detail_workContent')
		  ,"completion_cycle":admin.getTempData('temp_pannrama_detail_completionCycle')
		  ,"start_time":admin.getTempData('temp_pannrama_detail_startTime')
		  ,"completion_time":admin.getTempData('temp_pannrama_detail_completionTime')
		});
		 formSelects.data('superior_item_id', 'server', {
	         url: "getItemFirst",
	         keyName: 'itemName',
	         keyVal: 'itemId',
	         success: function(id, url, searchVal, result){
	               formSelects.value('superior_item_id', [admin.getTempData('temp_pannrama_detail_superior_item_id')]);
	         }
	     });
		$.getJSON("queryPersonLiableOrPartnerByItemId", {item_id: admin.getTempData('temp_pannrama_detail_itemId')},
			function(data) {
			    console.log(data);
			    formSelects.data('person_liable', 'server', {
			        url: "getAllUserInfoToFormSelects",
			        success: function(id, url, searchVal, result) {
			            formSelects.value('person_liable', [data.person_liable]);
			        }
			    });
			    formSelects.data('partner', 'server', {
			        url: "getAllUserInfoToFormSelects",
			        success: function(id, url, searchVal, result) {
			        for (var i = 0; i < data.partner.length; i++) {
			        	formSelects.value('partner', [data.partner[i].value], true);
			        }
			        	
			        }
			    });
			});
		
	 formSelects.maxTips('person_liable', function(id, vals, val, max){
		 layer.tips('责任人只能选择一个', '.person_liable', {
			  tips: 1
			});
     });
    
	 formSelects.maxTips('superior_item_id', function(id, vals, val, max){
		 layer.tips('一级事项只能选择一个', '.superior_item_id', {
			  tips: 1
			});
     });
    
    
    
	     

	//提交添加的数据
	form.on('submit(formDemo)',function(data) {
        $.ajax({
            type: "POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: "updataItemSecond",
            async: false,
            data: {
	            item_id:admin.getTempData('temp_pannrama_detail_itemId'),
	            superior_item_id:data.field.superior_item_id,
	            item_name:data.field.item_name,
	            organization:data.field.organization,
	            work_content:data.field.work_content,
				completion_cycle:data.field.completion_cycle,
				person_liable:data.field.person_liable,
				partner:data.field.partner,
				start_time:data.field.start_time,
				completion_time:data.field.completion_time
            },
            beforeSend: function() {
                layer.load(0);
            },
            success: function(data) {
                layer.closeAll();
                var data = JSON.parse(data);
                if (data.code == 0) {
                    layer.msg(data.info, {
                        icon: 1
                    });
                } else{
                    layer.alert(data.info, {
                        icon: 5
                    });
                }
            },
            complete: function() {
                layer.closeAll('loading');
            }
        });
		return false;
	});
	form.verify({
 itemName_length: function(value){
      if(value.length > 20){
        return "名称不能超过20个字，当前长度："+value.length;
      }
    }
});      
	 
});
</script>