<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div class="layui-row" id="layer-photos-demo">
	<div class="layui-col-xs6" v-for="item in items">
		<img :layer-pid="item.src" :layer-src="item.src" :src="item.src"
			:alt="item.src" style="width: 100%">
	</div>
</div>
<script type="text/javascript">
layui.use(['laytpl','jquery',  'form', 'layer', 'admin'], function(){
	var $ = layui.jquery;
	var form = layui.form;
	var layer = layui.layer;
	var admin = layui.admin;
	var laytpl = layui.laytpl;
	var IMG_ID = admin.getTempData('IMG_ID');
	var arrImgId=IMG_ID.split(",");
	var listarrImgId="";
	for(var a=0 ;a <arrImgId.length;a++){
		var timestamp = (new Date()).valueOf();
		listarrImgId+="{\"src\":\"WeChat_MiNi/showWeChatPic/"+arrImgId[a]+"?timestamp="+timestamp+"\"},";
	}
	var list=$.parseJSON("["+listarrImgId.substring(0,listarrImgId.length-1)+"]");
	console.log("list",list);
	var example1 = new Vue({
	  el: '#layer-photos-demo',
	  data: {
	    items : list
	  }
	})
	layer.photos({
	  photos: '#layer-photos-demo'
	  ,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
	}); 

});
</script>
