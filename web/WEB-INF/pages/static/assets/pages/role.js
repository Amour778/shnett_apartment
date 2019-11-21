
layui.use(['layer', 'form', 'table', 'upload','admin'],
function() {
	layer = layui.layer,
	table = layui.table,
	form = layui.form,
	upload = layui.upload,
	admin = layui.admin;
	
	  
	//执行渲染
	table.render({
		id: 'table_role',
		elem: '#table_role',
		loading: true,
		url: admin.base_server+'get_role',
		where: {"role_nickname": ""},
		page: true,
		loading: true,
		cols: [[{field: null,type: 'checkbox',sort: true},
		{field: 'role_id',title: '角色ID'},
		{field: 'role_nickname',title: '角色昵称'},
		{field: 'role_name',title: '角色名称'},
		{fixed: 'right',title: '操作',align: 'center',toolbar: '#role_bar',fixed: 'right'}]],
		done: function(res, page, count) {
		}
	});
	var active = {
		get_role: function() {
			var role_nickname = $("#role_nickname").val();
			  table.reload('table_role', {
				  url: admin.base_server+'get_role'
				  ,method:'post'
				  , where: {
				  		role_nickname: role_nickname
				  }
				});
		},
		add_role: function() {
			admin.setTableBtnInfo(null);
			admin.popupCenter({
			    title: '添加角色',
			    path: 'tpl/add_edit_role',
			    area: ['500px','800px'],
			    success: function (layero, index) {
					$(layero).children('.layui-layer-content').css('overflow', 'auto');
			    },
			    end: function () {
			    	table.reload('table_role', {
						  url: 'get_role'
						  ,method:'post'
						  , where: {
						  		role_nickname: $("#role_nickname").val()
						  }
						});
			    }
			});
			
		},
		batch_del_role: function() {
			var checkStatus = table.checkStatus('table_role');
			if (checkStatus.data != '') {
				var data_idList = "";
				for (var a = 0; a < checkStatus.data.length; a++) {
					data_idList += checkStatus.data[a].role_id + ";"
				}
				layer.confirm('确定删除吗？', {
					btn: ['确定', '取消']
				},
				function(index, layero) {
					$.ajax({
						type: "POST",
						contentType: "application/x-www-form-urlencoded; charset=utf-8",
						url: "batch_del_role",
						data: {
							role_id: data_idList
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
							table.reload('table_role', {
								  url: 'get_role'
								  ,method:'post'
								  , where: {
								  		role_nickname: $("#role_nickname").val()
								  }
								});
						},
						complete: function() {
							layer.closeAll('loading');
						}
					});
				});
			} else {
				layer.tips('请选择需要删除的行', $('#batch_del_role'), {
					tips: [3, '#5fb878']
				})
			}
		}
	}
	

	table.on('tool(table_role_lay-filter)',function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		var objdata = obj.data; //获得当前行数据
		var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
		var tr = obj.tr; //获得当前行 tr 的DOM对象
		if (layEvent === 'del_role') { //删除
			layer.confirm('真的删除么',function(index) {
				$.ajax({
					type: "POST",
					contentType: "application/x-www-form-urlencoded; charset=utf-8",
					url: "del_role",
					data: {
					role_id: objdata.role_id
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
		}else if (layEvent === 'edit_role_permission'){
			admin.setTableBtnInfo(objdata.role_id);
			admin.popupCenter({
			    title: '修改角色',
			    path: 'tpl/add_edit_role',
			    area: ['500px','800px'],
			    success: function (layero, index) {
					$(layero).children('.layui-layer-content').css('overflow', 'auto');
			    },
			    end: function () {
			    	table.reload('table_role', {
						  url: 'get_role'
						  ,method:'post'
						  , where: {
						  		role_nickname: $("#role_nickname").val()
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