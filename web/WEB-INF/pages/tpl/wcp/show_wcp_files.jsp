<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<button type="button" class="layui-btn btn_class" id="upload_file_wcp_progress">
	<i class="layui-icon layui-icon-upload-drag"></i>上传附件
</button>
<button class="layui-btn layui-btn-normal downLoadZipFilesLists"></button>
<button class="layui-btn refresh"><i class="layui-icon layui-icon-refresh-1"></i></button>
<div>单个文件大小不可超过50MB，合同不可分多个文件上传</div>

<table id="show_wcp_files_table" lay-filter="show_wcp_files_table"></table>

<script type="text/html" id="show_wcp_files_table_bar">
<a class="layui-btn layui-btn-xs btn_class layui-btn-normal" lay-event="download" >下载</a>
<a class = "layui-btn layui-btn-danger layui-btn-xs btn_class" lay-event="delete" >删除</a>
</script>
<script type="text/javascript">

layui.use(['layer','table','admin','upload'],function() {
    layer = layui.layer
    ,table = layui.table
    ,admin = layui.admin
    ,upload = layui.upload
    ,$ = layui.jquery;
    var project_code=admin.getTempData('project_code');
    var project_progress=admin.getTempData('project_progress');
	//上传文件
	upload.render({
		elem: '#upload_file_wcp_progress',
		accept: 'file',
		multiple: false,
		//是否允许多文件上传
		size: 50 * 1024,
		multiple:true,
		number:0,//同时可上传的文件数量,0（即不限制）
		drag:false,
		url: 'doUploadFiles/wcp/' + project_code + '_' + project_progress,
		before: function(obj) {
			layer.load();
		},
		error: function(index, upload) {
			layer.closeAll('loading');
			layer.msg('上传失败');
		},
		done: function(res) {
			layer.closeAll('loading');
			 table.reload('show_wcp_files_table',{
				loading:true
				,url: 'showFilesLists/wcp/'
				,where: {project_code: project_code}
				,done:function(res, curr, count){
					if(res.msg=="无数据"){
						$(".downLoadZipFilesLists").addClass("layui-btn-disabled").attr("disabled", "disabled");
						$(".downLoadZipFilesLists").text("没有上传过文件)");
					}else{
						$('.downLoadZipFilesLists').removeClass("layui-btn-disabled").removeAttr("disabled");
						$(".downLoadZipFilesLists").text("打包下载("+res.data.length+"个文件)");
					}
				}
			  });
		}
	});
	
	
  table.render({
	elem: '#show_wcp_files_table'
	,id:'show_wcp_files_table'
	,loading:true
	,height: 312
	,url: 'showFilesLists/wcp/'
	,where: {project_code: project_code}
	,even:true
	,cols: [[
		{fixed: 'left', width:120, align:'center', toolbar: '#show_wcp_files_table_bar'}
		,{field: 'name', title: '名称'}
	]]
	,done: function(res, curr, count){
					if(res.msg=="无数据"){
			$(".downLoadZipFilesLists").addClass("layui-btn-disabled").attr("disabled", "disabled");
						$(".downLoadZipFilesLists").text("没有上传过文件)");
		}else{
			$('.downLoadZipFilesLists').removeClass("layui-btn-disabled").removeAttr("disabled");
			$(".downLoadZipFilesLists").text("打包下载("+res.data.length+"个文件)");
		}
	}
  });
	//监听工具条
	table.on('tool(show_wcp_files_table)',
	function(obj) {
		var data = obj.data;
		var layEvent = obj.event;
		if (layEvent === 'download') {
			time(this,10);
			window.location.href = "downLoadFilesLists/wcp/"+project_code+"?filename=" + data.name;
		} else if (layEvent === 'delete') {
			layer.confirm('确定删除吗',
			function(index) {
				admin.ajax_load_json({
					url: 'doDeleteFiles/wcp',
					data: {
						file_name: data.name,
						project_code: project_code
					},
					success: function(data, status, xhr) {
						layer.close(index);
						if (data.code == 0) {
							  table.reload('show_wcp_files_table',{
								loading:true
								,url: 'showFilesLists/wcp/'
								,where: {project_code: project_code}
								,done:function(res, curr, count){
					if(res.msg=="无数据"){
										$(".downLoadZipFilesLists").addClass("layui-btn-disabled").attr("disabled", "disabled");
						$(".downLoadZipFilesLists").text("没有上传过文件)");
									}else{
										$('.downLoadZipFilesLists').removeClass("layui-btn-disabled").removeAttr("disabled");
										$(".downLoadZipFilesLists").text("打包下载("+res.data.length+"个文件)");
									}
									
								}
							  });
							layer.msg(data.info, {
								icon: 1
							});
						} else {
							layer.alert(data.info, {
								icon: 5
							});
						}
					}
				});
	
			});
		}
	});
	
	$('.refresh').on('click', function(){
		 table.reload('show_wcp_files_table',{
			loading:true
			,url: 'showFilesLists/wcp/'
			,where: {project_code: project_code}
			,done:function(res, curr, count){
					if(res.msg=="无数据"){
						$(".downLoadZipFilesLists").addClass("layui-btn-disabled").attr("disabled", "disabled");
						$(".downLoadZipFilesLists").text("没有上传过文件)");
					}else{
						$(".downLoadZipFilesLists").text("打包下载("+res.data.length+"个文件)");
					}
				}
		  });
	});
	
	$('.downLoadZipFilesLists').on('click', function(){
		$(".downLoadZipFilesLists").addClass("layui-btn-disabled").attr("disabled", "disabled");
    	window.location.href = "downLoadZipFiles/wcp/"+project_code;
		setTimeout('$(".downLoadZipFilesLists").removeClass("layui-btn-disabled").removeAttr("disabled")',10000);
  });
  
	
		
	function time(o,wait){
		console.log();
		if (wait==0) {
		    	o.disabled=false;
		    	o.className ="layui-btn layui-btn-xs";
		    	o.innerHTML="下载";
		}else{
			o.disabled=true;
			o.className +=" layui-btn-disabled";
		    o.innerHTML=wait;
	        wait--;
	        setTimeout(function(){
	            time(o,wait)
	        },1000)
	    }
	} 
	})
	
</script>