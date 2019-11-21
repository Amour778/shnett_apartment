
layui.use(['layer', 'form', 'table', 'upload','admin'],
function() {
	layer = layui.layer,
	table = layui.table,
	form = layui.form,
	upload = layui.upload,
	admin = layui.admin,
	$ = layui.jquery;
	
	  
	//执行渲染
	table.render({
		id: 'table_permission',
		elem: '#table_permission',
		loading: true,
		url: 'get_permission',
		where: {"name": ""},
		limit:200,
		limits:[200,500,1000],
		page: true,
		loading: true,
		cols: [[{field: null,type: 'checkbox',sort: true},
		{field: 'menuId',title: 'ID'},
		{field: 'name',title: '名称'},
		{field: 'url',title: 'URL'},
		{field: 'path',title: '相关页面路径'},
		{field: 'icon',title: '图标'},
		{fixed: 'right',title: '操作',align: 'center',toolbar: '#permission_bar',fixed: 'right'}]],
		done: function(res, page, count) {
		}
	});
	var active = {
		get_permission: function() {
			  table.reload('table_permission', {
				  url: admin.base_server+'get_permission'
				  ,method:'post'
				  , where: {
				  	name:  $("#permission_name").val()
				  }
				});
		},
		add_permission: function() {
			admin.setTableBtnInfo(null);
			admin.popupCenter({
			    title: '添加权限',
			    path: 'tpl/add_edit_permission',
			    end: function () {
			    	table.reload('table_permission', {
						  url: 'get_permission'
						  ,method:'post'
						  , where: {
					  	name:  $("#permission_name").val()
						  }
						});
			    }
			});
			
		},
		batch_del_permission: function() {
			var checkStatus = table.checkStatus('table_permission');
			if (checkStatus.data != '') {
				var data_idList = "";
				for (var a = 0; a < checkStatus.data.length; a++) {
					data_idList += checkStatus.data[a].menuId + ";"
				}
				layer.confirm('确定删除吗？', {
					btn: ['确定', '取消']
				},
				function(index, layero) {
					$.ajax({
						type: "POST",
						contentType: "application/x-www-form-urlencoded; charset=utf-8",
						url: "batch_del_permission",
						data: {
							menuId: data_idList
						},
						beforeSend: function() {
							layer.load(0);
						},
						success: function(data) {
							layer.closeAll();
							var obj = JSON.parse(data);
							if (obj.code == 0) {
								layer.msg(obj.info, {
									icon: 1
								});
								
							} else {
								layer.alert(obj.info, {
									icon: 5
								});
							}
							table.reload('table_permission', {
								  url: 'get_permission'
								  ,method:'post'
								  , where: {
							  			name:  $("#permission_name").val()
								  }
								});
						},
						complete: function() {
							layer.closeAll('loading');
						}
					});
				});
			} else {
				layer.tips('请选择需要删除的行', $('#batch_del_permission'), {
					tips: [3, '#5fb878']
				})
			}
		}
	}
	

	table.on('tool(table_permission_lay-filter)',function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		var objdata = obj.data; //获得当前行数据
		var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
		var tr = obj.tr; //获得当前行 tr 的DOM对象
		if (layEvent === 'del_permission') { //删除
			layer.confirm('真的删除么',function(index) {
				$.ajax({
					type: "POST",
					contentType: "application/x-www-form-urlencoded; charset=utf-8",
					url: "del_permission",
					data: {
						menuId: objdata.menuId
					},
					beforeSend: function() {
						layer.load(0);
					},
					success: function(data) {
						layer.closeAll('loading');
						var datas = JSON.parse(data);
						if (datas.code == 0) {
							layer.msg("删除成功!", {
								icon: 1
							});
							obj.del();
							layer.close(index);
						} else {
							layer.alert(datas.info, {
								icon: 5
							});
						}
					},
					complete: function() {
						layer.closeAll('loading');
					}
				});
			});
		}else if (layEvent === 'edit_permission'){
			admin.setTableBtnInfo(objdata.menuId);
			admin.popupCenter({
			    title: '修改权限',
			    path: 'tpl/add_edit_permission',
			    end: function () {
			    	table.reload('table_permission', {
						  url: 'get_permission'
						  ,method:'post'
						  , where: {
					  			name:  $("#permission_name").val()
						  }
						});
			    }
			});
			
		}
	});


	$('.layui-btn').on('click',
	function() {
		var othis = $(this),
		method = othis.data('method');
		active[method] ? active[method].call(this, othis) : '';
	});
});