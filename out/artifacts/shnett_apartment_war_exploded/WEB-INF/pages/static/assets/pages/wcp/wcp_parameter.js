
layui.use(['layer','form', 'table','admin','tableMerge'], function(){
  var $=layui.jquery
  ,form = layui.form
  ,layer = layui.layer
  ,table= layui.table
  ,tableMerge = layui.tableMerge
  ,admin = layui.admin;
  table.render({
	id:'parameter_table'
	,loading: true
    ,page: false
    ,elem: '#parameter_table'
    ,url: 'queryAllParameterNoparameter'
    ,cols: [[
             {type:'numbers'},
             {field:'pid', merge: true, title: '一级ID',width:80 },
             {field:'type', merge: true, title: '类型',width:120},
             {field:'cid', merge: true, title: '二级ID',width:80 },
             {field:'text',  title: '显示文本',edit: 'text'},
             {field:'value',  title: '值',edit: 'text'},
             {field:'select',  title: '是否选中',templet: '#sexSelected', unresize: true, width: 90},
             {field:'disable',  title: '是否禁用',templet: '#sexDisabled', unresize: true, width: 90 },
             {fixed: 'right',  title: '操作', align:'center', toolbar: '#parameter_table_tool_bar',unresize:true,width:100}
    ]]
    ,done: function(res, page, count) {
	  tableMerge.render(this);
	}
  });
  //监听单元格编辑
  table.on('edit(parameter_table)', function(obj){
    var value = obj.value //得到修改后的值
    ,data = obj.data //得到所在行所有键值
    ,field = obj.field; //得到字段
    layer.msg('[ID: '+ data.cid +'] ' + field + ' 字段更改为：'+ value);
  });
  form.on('submit(quretParameter)', function(data){
	  table.reload('parameter_table',{url: 'queryAllParameterNoparameter'});
  });
  //监听性别操作
  form.on('switch(sexSelected)', function(obj){
    layer.tips(this.value + ' ' + this.cid + '：'+ obj.elem.checked, obj.othis);
  });
  
  //监听性别操作
  form.on('switch(sexDisabled)', function(obj){
    layer.tips(this.value + ' ' + this.cid + '：'+ obj.elem.checked, obj.othis);
  });
  //监听工具条
  table.on('tool(parameter_table_filter)', function (obj) {
      var data = obj.data; //获得当前行数据
      var layEvent = obj.event; //获得 lay-event 对应的值
      if (layEvent === 'edit') {
        
      }else if (layEvent === 'pending') {
      	
	 }
  });

});