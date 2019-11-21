//获取项目名称
window.onload=function(){

var pathName=window.document.location.pathname;
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
var end=false;
var add=false;
//var _ITEMID=document.getElementById('item_id').value;
//var _ITEMSTATE=document.getElementById('item_state').value;
//var _ITEMID=$("#item_id").val();
//var _ITEMSTATE=$("#item_state").val();
layui.use(['layer','laydate','form'],function() {
	var $ = layui.jquery,
	laydate=layui.laydate,
	form=layui.form,
	layer = layui.layer;
	laydate.render({
	    elem: '#item_date'
	    ,type:'date'
	  });
	var _ITEMID=$("#item_id").val();
	var _ITEMSTATE=$("#item_state").val();
	console.log("_ITEMID="+_ITEMID);
	console.log("_ITEMSTATE="+_ITEMSTATE);
	$.getJSON(projectName + "/ProgressInfoBySearchCondition", {
		SearchCondition: _ITEMID
	},function(data) {
		var line="";
		if(data.length == 0 &&(_ITEMID==null||_ITEMID=="")){
			$('#layerDemo').html('');//直接取消按钮而不是设置为不可点击
			//$("#addBtn").attr("class","layui-btn layui-btn-disabled");
			//$("#endBtn").attr("class","layui-btn layui-btn-disabled");
			line = '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe664;</i><div class="layui-timeline-content layui-text">';
			line += '<h3 class="layui-timeline-title">获取关键数据失败，请重新打开本页面</h3></div></li>';
		}else if(data.length == 0){
			line = '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe664;</i><div class="layui-timeline-content layui-text">';
			line += '<h3 class="layui-timeline-title">无相关进程</h3></div></li>';
			$("#endBtn").attr("class","layui-btn layui-btn-disabled");
			add=true;
			//$("#endBtn").attr("class","layui-btn layui-btn-disabled");
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
				$("#addBtn").attr("class","layui-btn layui-btn-disabled");
				$("#endBtn").attr("class","layui-btn layui-btn-disabled");
			}
			
		}
		
		$("#time_linet").html(line);
		form.render();

	});
	
	 //触发按钮事件
	  $('#layerDemo .layui-btn').on('click', function(){
	    var othis = $(this), method = othis.data('method');
	    active[method] ? active[method].call(this, othis) : '';
	   
	  });
	  var active = {
			  addWindow: function(){
		  if(add==true){
			    $("#addform").toggle(200);
			    if($("#addBtn").text()=="添加进程"){
				    $("#addBtn").text("取消添加").attr("class", "layui-btn layui-btn-primary");
			    }else{
				    $("#addBtn").text("添加进程").attr("class", "layui-btn");
				    $("#item_date").val('');
				    $("#item_progress").val('');
				    form.render();
			    }
		  }
	    },
	    endWindow:function(){
	    	if(end==true){
		    	$.post(projectName + "/endProgress", {
		    		item_id: _ITEMID
				},
				function(data) {
					if(data.code==0){
						 layer.msg(data.info, {
		                        icon: 1
		                    });
						add=false;
						end=false;
						$("#addBtn").attr("class","layui-btn layui-btn-disabled");
						$("#endBtn").attr("class","layui-btn layui-btn-disabled");
						$.getJSON(projectName + "/ProgressInfoBySearchCondition", {
							SearchCondition: _ITEMID
						},function(data) {
							var line="";
								$(data).each(function() {
									line += '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe702;</i><div class="layui-timeline-content layui-text">';
									line += '<h3 class="layui-timeline-title">日期：' + this.item_date +' | 编写：'+this.edit_user+ '</h3>';
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
	    $.post(projectName + "/addProgress", {
	    	info: JSON.stringify(data.field)
		},
		function(data) {
			if(data.code==0){
				 layer.msg(data.info, {
                     icon: 1
                 });
				$.getJSON(projectName + "/ProgressInfoBySearchCondition", {
					SearchCondition: _ITEMID
				},function(data) {
					var line="";
						$(data).each(function() {
							line += '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe702;</i><div class="layui-timeline-content layui-text">';
							line += '<h3 class="layui-timeline-title">日期：' + this.item_date +' | 编写：'+this.edit_user+ '</h3>';
							line += '<div style="word-wrap:break-word">' + this.item_progress + '</div></div></li>';
						});
						add=true;
						end=true;
						$("#endBtn").attr("class","layui-btn");
					$("#time_linet").html(line);
					$("#addform").toggle(200);
				    if($("#addBtn").text()=="添加进程"){
					    $("#addBtn").text("取消添加").attr("class", "layui-btn layui-btn-primary");
				    }else{
					    $("#addBtn").text("添加进程").attr("class", "layui-btn");
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
};