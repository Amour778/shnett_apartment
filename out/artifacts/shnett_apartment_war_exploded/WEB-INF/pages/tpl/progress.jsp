<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;" >
  <legend id="ProgresslayerDemo" >
	<button class="layui-btn" data-method="addProgressWindow" id="addProgressBtn">添加进程</button>
	<button class="layui-btn" data-method="endProgressWindow" id="endProgressBtn">结束进程</button>
</legend>
</fieldset>
<form class="layui-form" id="progress_addform" style="display:none">
 	<input type="hidden" name="item_id" id="progress_item_id">
 	<input type="hidden" name="item_state" id="progress_item_state">
	<div class="layui-form-item">
		<label class="layui-form-label">
			日期
		</label>
		<div class="layui-input-block">
			<input type="text" name="item_date" class="layui-input" autocomplete="off" lay-verify="required" id="item_date" >
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">
			进程内容
		</label>
		<div class="layui-input-block">
		 <textarea name="item_progress" id="item_progress" lay-verify="required" autocomplete="off"  class="layui-textarea"></textarea>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit lay-filter="formDemo">
				立即提交
			</button>
		</div>
	</div>
	<hr/>
</form>
<ul class="layui-timeline" id="time_linet" ></ul>  

<script type="text/javascript">
var end=false;
var add=false;
layui.use(['layer','laydate','form','admin','jquery'],function() {
	var $ = layui.jquery,
	laydate=layui.laydate,
	admin = layui.admin,
	form=layui.form,
	layer = layui.layer;
	laydate.render({
	    elem: '#item_date'
	    ,type:'date'
	  });
	var _ITEMID=admin.getTableBtnInfo().split(",")[0];
	var _ITEMSTATE=admin.getTableBtnInfo().split(",")[1];
	$("#progress_item_id").val(_ITEMID);
	$("#progress_item_state").val(_ITEMSTATE);
	console.log("_ITEMID="+_ITEMID);
	console.log("_ITEMSTATE="+_ITEMSTATE);
	$.getJSON("ProgressInfoBySearchCondition", {
		SearchCondition: _ITEMID
	},function(data) {
		var line="";
		if(data.length == 0 &&(_ITEMID==null||_ITEMID=="")){
			$('#ProgresslayerDemo').html('');//直接取消按钮而不是设置为不可点击
			//$("#addProgressBtn").attr("class","layui-btn layui-btn-disabled");
			//$("#endProgressBtn").attr("class","layui-btn layui-btn-disabled");
			line = '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe664;</i><div class="layui-timeline-content layui-text">';
			line += '<h3 class="layui-timeline-title">获取关键数据失败，请重新打开本页面</h3></div></li>';
		}else if(data.length == 0){
			line = '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe664;</i><div class="layui-timeline-content layui-text">';
			line += '<h3 class="layui-timeline-title">无相关进程</h3></div></li>';
			$("#endProgressBtn").attr("class","layui-btn layui-btn-disabled");
			add=true;
			//$("#endProgressBtn").attr("class","layui-btn layui-btn-disabled");
		}else{
			$(data).each(function() {
				line += '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe702;</i><div class="layui-timeline-content layui-text">';
				line += '<h3 class="layui-timeline-title">日期：' + this.item_date +' <编写人：'+this.edit_user+ '></h3>';
				line += '<div style="word-wrap:break-word">' + this.item_progress + '</div></div></li>';
			});
			if(_ITEMSTATE!="1"){
				add=true;
				end=true;
			}else{
				add=false;
				end=false;
				$("#ProgresslayerDemo").html("<b>事项已完成</b>");
				//$("#ProgresslayerDemo").hide();
				$("#addProgressBtn").attr("class","layui-btn layui-btn-disabled").hide();
				$("#endProgressBtn").attr("class","layui-btn layui-btn-disabled").hide();
			}
			
		}
		
		$("#time_linet").html(line);
		form.render();

	});
	
	 //触发按钮事件
	  $('#ProgresslayerDemo .layui-btn').on('click', function(){
	    var othis = $(this), method = othis.data('method');
	    active[method] ? active[method].call(this, othis) : '';
	   
	  });
	  var active = {
	  	addProgressWindow: function(){
		  if(add==true){
			    $("#progress_addform").toggle(200);
			    if($("#addProgressBtn").text()=="添加进程"){
				    $("#addProgressBtn").text("取消添加").attr("class", "layui-btn layui-btn-primary");
			    }else{
				    $("#addProgressBtn").text("添加进程").attr("class", "layui-btn");
				    $("#item_date").val('');
				    $("#item_progress").val('');
				    form.render();
			    }
		  }
	    },
	    endProgressWindow:function(){
	    	if(end==true){
		    	$.post("endProgress", {
		    		item_id: _ITEMID
				},
				function(data) {
					if(data.code==0){
						 layer.msg(data.info, {
		                        icon: 1
		                    });
						add=false;
						end=false;
						$("#addProgressBtn").attr("class","layui-btn layui-btn-disabled");
						$("#endProgressBtn").attr("class","layui-btn layui-btn-disabled");
						$.getJSON("ProgressInfoBySearchCondition", {
							SearchCondition: _ITEMID
						},function(data) {
							var line="";
								$(data).each(function() {
									line += '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe702;</i><div class="layui-timeline-content layui-text">';
									line += '<h3 class="layui-timeline-title">日期：' + this.item_date +' <编写人：'+this.edit_user+ '></h3>';
									line += '<div style="word-wrap:break-word">' + this.item_progress + '</div></div></li>';
								});
							$("#time_linet").html(line);
							form.render();
						});
					}else{
						 layer.msg(data.info, {
		                        icon: 5
		                    });
					}
				},'json');
	    	}
	    }
	  };
	  
	  //监听提交
	  form.on('submit(formDemo)', function(data){
	    //layer.msg(JSON.stringify(data.field));
	    $.post("addProgress", {
	    	info: JSON.stringify(data.field)
		},
		function(data) {
			if(data.code==0){
				 layer.msg(data.info, {
                     icon: 1
                 });
				$.getJSON("ProgressInfoBySearchCondition", {
					SearchCondition: _ITEMID
				},function(data) {
					var line="";
						$(data).each(function() {
							line += '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe702;</i><div class="layui-timeline-content layui-text">';
							line += '<h3 class="layui-timeline-title">日期：' + this.item_date +' <编写人：'+this.edit_user+ '></h3>';
							line += '<div style="word-wrap:break-word">' + this.item_progress + '</div></div></li>';
						});
						add=true;
						end=true;
						$("#endProgressBtn").attr("class","layui-btn");
					$("#time_linet").html(line);
					$("#progress_addform").toggle(200);
				    if($("#addProgressBtn").text()=="添加进程"){
					    $("#addProgressBtn").text("取消添加").attr("class", "layui-btn layui-btn-primary");
				    }else{
					    $("#addProgressBtn").text("添加进程").attr("class", "layui-btn");
					    $("#item_date").val('');
					    $("#item_progress").val('');
					    form.render();
				    }
					form.render();

				});
			}else{
				 layer.msg(data.info, {
                     icon: 5
                 });
			}
		},'json');
	    return false;
	  });
});
</script>