<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<form class="layui-form" action="" onsubmit="return false" lay-filter="formTest">
  <div class="layui-form-item">
    <label class="layui-form-label">事项名称(一级)</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_superior_item_name" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">事项名称(二级)</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_itemName" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">状态</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_state" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">组织</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_organization" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">工作内容</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_workContent" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">步骤</label>
    <div class="layui-input-block">
      <p id="temp_pannrama_detail_step"  class="layui-textarea"></p>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">完成周期</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_completionCycle" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">责任人</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_personLiable" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">配合人</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_partner" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">开始时间</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_startTime" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">完成时间</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_completionTime" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">事项添加日期</label>
    <div class="layui-input-block">
      <input type="text" name="temp_pannrama_detail_creationDate" required  lay-verify="required" readOnly="true" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
		<label class="layui-form-label">
			进程内容
		</label>
		<div class="layui-input-block">
		 <ul class="layui-timeline" id="time_linet" ></ul>  
		</div>
	</div>
</form>
<script type="text/javascript">
layui.use(['layer','form','admin','jquery'],function() {
	var $ = layui.jquery,
	admin = layui.admin,
	form=layui.form,
	layer = layui.layer;
	var sta=admin.getTempData('temp_pannrama_detail_state');
	if(sta==-1)
		sta="未开始";
	else if(sta==0)
		sta="进行中";
	else if(sta==1)
		sta="已完成";
	   var line="";
	   $.getJSON("ProgressInfoBySearchCondition", {
			SearchCondition:admin.getTempData('temp_pannrama_detail_itemId')
		},function (data) {
			if(data.length == 0){
				line = '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe664;</i><div class="layui-timeline-content layui-text">';
				line += '<h3 class="layui-timeline-title">无相关进程</h3></div></li>';
			}else{
				$(data).each(function() {
					line += '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe702;</i><div class="layui-timeline-content layui-text">';
					line += '<h3 class="layui-timeline-title">日期：' + this.item_date +' <编写人：'+this.edit_user+ '></h3>';
					line += '<div style="word-wrap:break-word">' + this.item_progress + '</div></div></li>';
				});
			}
			$("#time_linet").html(line);
		}, 'POST');
	
	
	if(admin.getTempData('temp_pannrama_detail_step')=="N"){
	 	$("#temp_pannrama_detail_step").html('<div class="layui-form-mid layui-word-aux">无数据</div>');
	 }else{
	 $("#temp_pannrama_detail_step").html(admin.getTempData('temp_pannrama_detail_step'));}
	form.val("formTest", {
	  "temp_pannrama_detail_superior_item_name": admin.getTempData('temp_pannrama_detail_superior_item_name')
	  ,"temp_pannrama_detail_itemName":admin.getTempData('temp_pannrama_detail_itemName')
	  ,"temp_pannrama_detail_state":sta
	  ,"temp_pannrama_detail_organization":admin.getTempData('temp_pannrama_detail_organization')
	  ,"temp_pannrama_detail_workContent":admin.getTempData('temp_pannrama_detail_workContent')
	  ,"temp_pannrama_detail_completionCycle":admin.getTempData('temp_pannrama_detail_completionCycle')
	  ,"temp_pannrama_detail_personLiable":admin.getTempData('temp_pannrama_detail_personLiable')
	  ,"temp_pannrama_detail_partner":admin.getTempData('temp_pannrama_detail_partner')
	  ,"temp_pannrama_detail_startTime":admin.getTempData('temp_pannrama_detail_startTime')
	  ,"temp_pannrama_detail_completionTime":admin.getTempData('temp_pannrama_detail_completionTime')
	  ,"temp_pannrama_detail_creationDate":admin.getTempData('temp_pannrama_detail_creationDate')
	});
});
</script>