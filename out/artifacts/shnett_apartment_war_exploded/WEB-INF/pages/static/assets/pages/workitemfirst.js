layui.use(['layer','form', 'table','admin'], function(){
  var $=layui.jquery
  ,form = layui.form
  ,layer = layui.layer
  ,admin = layui.admin
  ,table= layui.table;
  table.render({
	  toolbar: true,
	  title:'事项名称(一级)',
	  defaultToolbar: ['filter', 'print', 'exports'],
	    elem: '#workitemfirst_first_teble'
	    ,width:"1000"
	    ,url:"getItemFirstToTable"
	    ,where: {item_name: ''}
  ,method:'post'
	    ,cols: [[
	      {type:'checkbox', fixed: 'left', width:60}
	      ,{field:'itemId',  title: 'ID', width:300}
	      ,{field:'itemName',  title: '事项名称(一级)', width:500}
	      ,{fixed: 'right',  title: '操作', width:120, align:'center', toolbar: '#workitemfirst_table_tool_bar',unresize:true}
	    ]]
	    ,page: true
	  });
  
  
  form.on('submit(quretWorkitemfirst)',function(data) {
	  table.reload('workitemfirst_first_teble', {
		  url: "getItemFirstToTable"
		  ,method:'post'
		,width:"1000"
		  , where: {
		    item_name: data.field.item_name
		  }
		});
  	return false;
	  
  });
  //触发按钮事件
  $('#layerDemo .layui-btn').on('click', function(){
    var othis = $(this), method = othis.data('method');
    active[method] ? active[method].call(this, othis) : '';
   
  });var active = {
			addWorkitemfirstWindow: function() {
		layer.prompt({
			formType: 0,
			title: '请输入要添加的一级事项名称',
		},
		function(value, index, elem) {
			$.ajax({
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				url: "addItemFirst",
				async: false,
				data: {
					item_name: value
				},
				beforeSend: function() {
					layer.load(0);
				},
				success: function(data) {
					layer.closeAll();
					var data = JSON.parse(data);
					if (data.code == 0) {
						layer.msg(data.info);
						layer.close(index);
						table.reload('workitemfirst_first_teble', {
							url: "getItemFirstToTable",
							method: 'post',
							width: "1000",
							where: {
								item_name: ''
							}
						});
					} else {
						layer.msg(data.info);
					}
				},
				complete: function() {
					layer.closeAll('loading');
				}
			});
		})
	},
	batdelWorkitemfirst: function() {
		var checkStatus = table.checkStatus('workitemfirst_first_teble');
		console.log(checkStatus.data);
		var data_idList = "";
		if (checkStatus.data != '') {
			layer.confirm('确定删除这些事项吗？', {
				icon: 3,
				title: '提示'
			},
			function(index) {
				layer.confirm('删除这些事项会<br/>同时删除<br/><font color="red" ><b>事项对应的所有二级事项</b></font><br/>，确定吗？', {
					icon: 0,
					title: '警告'
				},
				function(index) {
					for (var a = 0; a < checkStatus.data.length; a++) {
						data_idList += checkStatus.data[a].itemId + ";"
					}
					console.log(data_idList);
					$.post("batchDeleteFirstByItemId", {
						item_id: data_idList
					},
					function(data) {
						if (data.code == "0") {	
							table.reload('workitemfirst_first_teble', {
								url: "getItemFirstToTable",
								method: 'post',
								width: "1000",
								where: {
									item_name: ''
								}
							});
							layer.msg(data.info);
						} else {
							layer.msg(data.info);
						}
					},'json');
				});
			});
		}else{
			layer.tips('请选择需要删除的行', $('#batchDeleteWorkitemfirst'), {
				tips: [3, '#5fb878']
			})
		}
			

	}
};
  table.on('tool(workitemfirst_table_tool)',function(obj) {
	  	var data = obj.data;
	  	var layEvent = obj.event;
	  	console.log("data.itemId=" + data.itemId);
	  	console.log("data.itemName=" + data.itemName);
	  	if (layEvent === 'detail') {} else if (layEvent === 'del') {
	  		layer.confirm('确定删除这个事项吗？', {
	  			icon: 3,
	  			title: '提示'
	  		},
	  		function(index) {
	  			layer.confirm('删除这个事项会<br/>同时删除<br/><font color="red" ><b>该事项对应的所有二级事项</b></font><br/>，确定吗？', {
	  				icon: 0,
	  				title: '警告'
	  			},
	  			function(index) {
	  				$.getJSON("deleteItemFirst", {
	  					item_id: data.itemId
	  				},
	  				function(data) {
	  					//var data = JSON.parse(data);
	  					if (data.code == 0) {
	  						table.reload('workitemfirst_first_teble', {
	  						  url: "getItemFirstToTable"
	  						  ,method:'post'
	  						,width:"1000"
	  						  , where: {
	  						    item_name: $("#item_name").val()
	  						  }
	  						});
			  				  layer.msg(data.info, {
			                        icon: 1
			                    });
	  					} else {
			  				  layer.msg(data.info, {
			                        icon: 5
			                    });
	  					}
	  				});
	  				layer.close(index);
	  			});
	  		});
	  	} else if (layEvent === 'edit') {
	  		layer.prompt({
	  			formType: 0,
	  			placeholder:data.itemName,
	  			title: '请输入新名称',
	  		},
	  		function(value, index, elem) {
	  			$.post("updataItemFirst", {
	  				item_id: data.itemId,
	  				item_name: value
	  			},
	  			function(data) {
	  				if (data.code == 0) {
	  					 obj.update({
		  						itemName: value
		  					    });
	  				  layer.msg(data.info, {
	                        icon: 1
	                    });
	  				} else {
		  				  layer.msg(data.info, {
		                        icon: 5
		                    });
	  				}
	  			},'json');
	  			layer.close(index);
	  		});
	  	}
	  });

});