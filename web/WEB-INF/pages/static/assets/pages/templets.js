//模板取消锁定的密码为：a123a123
layui.use(['layer','table'],function() {
    layer = layui.layer
    ,table = layui.table
    ,$ = layui.jquery;
  //执行渲染
  table.render({
	elem: '#templets_demo'
	,height: '300'
	,width: '500'
	,loading:true
	,url: 'templetsFilesListsServlet'
	//,where: {type: 'selectAllWeb'}
	,even:true
	,cols: [[ //表头
		{field: 'name', width:250,title: '名称'}
		,{fixed: 'right', width:150, align:'center', toolbar: '#templets_barDemo'}
	]]
  });
  
//监听工具条
  table.on('tool(templets_test)', function(obj){
	  var data = obj.data;
	  var layEvent = obj.event;
	  if(layEvent === 'detail'){
		  time(this);
		  layer.open({
			  title:'获取下载地址并开始下载',
			  type: 2, 
			  //content: ["templetsDownLoadServlet?filename="+encodeURIComponent(data.name), 'no'],
			  content: ["templetsDownLoadServlet?filename="+data.name, 'no'],
			  time: 3000
			});
	  }
	});
  
})
var wait=10;
function time(o){
    if (wait==0) {
    	o.disabled=false;
    	o.className ="layui-btn layui-btn-xs";
    o.innerHTML="下载";
    wait=5;
}else{
	o.disabled=true;
	o.className +=" layui-btn-disabled";
    o.innerHTML=wait;
        wait--;
        setTimeout(function(){
            time(o)
        },1000)
    }
}