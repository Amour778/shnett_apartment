<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<form class="layui-form" action="" id="form1"  style="width:90%">
  <div class="layui-form-item">
      <label class="layui-form-label">工作内容</label>
      <div class="layui-input-block">
       <select name="item_id"  lay-verify="required" lay-filter="required"  id="selectLevel" lay-search ></select>   
  <div class="layui-form-mid layui-word-aux">只可对"未开始"和"进行中"的事项进行添加/更新步骤</div>  
    </div>
  </div>
  
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">步骤</label>
    <div class="layui-input-block">
    <textarea id="step_id" name="step" style="display: none;"></textarea>
    </div>
  </div>
  
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
    </div>
  </div>
</form>
<script charset="utf-8">
layui.use(['layedit','layer', 'form'],
function() {
	var $ = layui.jquery,
	layedit = layui.layedit,
	form = layui.form,
	layer = layui.layer;
	var edit;
	//获取工作内容
	$.getJSON("queryWorkContentWithFirstIdAndSecondId", {},
	function(data) {
		$("#selectLevel").append($("<option/>").text("请选择").attr("value", ""));
		$(data).each(function() {
			$("#selectLevel").append($("<option/>").text(this.itemName+'-'+this.workContent).attr("value", this.itemId));
		});
		form.render();
	});
	form.on('select(required)', function(data){
  console.log(data.value);
  $.getJSON("queryStepByItemId", {item_id:data.value},
	function(data) {
		if(data.code==0){
			console.log(data.info);
			if(data.info=="N"){
		 		$("#step_id").val("");
			}else{
		 		$("#step_id").val(data.info);
		 		}
		edit= layedit.build('step_id', {tool: ['strong','italic']});
		}else{
			layer.tips(data.info,'.layui-layedit',{tips: 1});
		}
		
	});
});      

	//提交添加的数据
	form.on('submit(formDemo)',function(data) {
		if(layedit.getText(edit)==""){
			var that = this;
			layer.tips('请填写步骤内容','.layui-layedit',{tips: 1});
		}else{
        $.ajax({
            type: "POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url: "addStepByItemId",
            async: false,
            data: {
            	item_id:data.field.item_id,
            	step:layedit.getContent(edit)
            },
            beforeSend: function() {
                layer.load(0);
            },
            success: function(data) {
                layer.closeAll();
                var data = JSON.parse(data);
                if (data.code == 0) {
                  	document.getElementById("form1").reset();
                    layer.msg(data.info, {
                        icon: 1
                    });
                    //layedit.setContent(edit,"");
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
	}
		return false;
	});
});
</script>