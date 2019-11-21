layui.use(['layer','form', 'table','formSelects','admin','notice'], function(){
  var $=layui.jquery
  ,form = layui.form
  ,layer = layui.layer
  ,formSelects = layui.formSelects
  ,table= layui.table
  ,notice=layui.notice
  ,admin = layui.admin;
  formSelects.data('panorama_selectId', 'server', {
	    url:"getPannramaMultiselect"
	});
  $.post("getTimeOutItemByUserName", {
	},function(data) {
		notice.closeAll();
		if (data.code == 1) {
			if(data.info.soon_expire==null&&data.info.has_expired==null)
				notice.init({
			    	 icon: "layui-icon-tips",
			    	 type: "warm",
			         autoClose: false,
			         title: data.info
			     });
			if(data.info.has_expired!=0){
				notice.init({
			    	 icon: "layui-icon-tips",
			    	 type: "danger", //可选warm,danger,custom,default,默认default
			         autoClose: false,
			         title: "有事项已经过期，请及时处理！事项名称：<br/>"+data.info.has_expired
			     });
			}
			if(data.info.soon_expire!=0){
				notice.init({
			    	 icon: "layui-icon-tips",
			    	 type: "warm",
			         autoClose: false,
			         title: "有事项即将过期，请及时处理！事项名称：<br/>"+data.info.soon_expire
			     });
			}
		}
	},'json');

	//执行渲染
  table.render({
		id: 'pannrama_table'
	  	,toolbar: true
		,loading: true
		,defaultToolbar: ['filter']
	    ,page: true
	    ,elem: '#pannrama_table'
	    ,url: 'queryInfoBySearchCondition'
		//,where: {"SearchCondition":formSelects.value('panorama_selectId', 'valStr')}
  		,where: {"SearchCondition":'WoRk_StAtE|-1,WoRk_StAtE|0'}
	    ,cols: [[
	      {type:'checkbox', fixed: 'left'}
	      ,{field:'superior_item_name',  title: '事项名称(一级)', fixed: 'left', width:250}
	      //,{field:'superior_item_id',  title: '事项名称(一级)ID', width:250}
	      //,{field:'itemId',  title: '事项名称(二级)ID', width:250}
	      ,{field:'itemName',  title: '事项名称(二级)', width:230}
	      ,{field:'state',  title: '状态 ', width:80 }
	      ,{field:'organization',  title: '组织', width:80 }
	      ,{field:'workContent',  title: '工作内容', width:200}
	      ,{field:'step',  title: '步骤',toolbar:'#table_step',unresize:true, width:80}
	      ,{field:'completionCycle',  title: '完成周期', width:100 }
	      ,{field:'personLiable',  title: '责任人', width:100 }
	      ,{field:'partner',  title: '配合人', width:100 }
	      ,{field:'startTime',  title: '开始时间',width:110 }
	      ,{field:'completionTime',  title: '完成时间',width:110 }
	      //,{field:'creationDate',  title: '事项添加日期 ',width:120 }
	      //,{fixed: 'right', width:150, align:'center', toolbar: '#panorama_tool_bar',unresize:true}
	      ,{fixed: 'right', width:170, title: '操作', align:'center', toolbar: '#panorama_tool_bar',unresize:true}
	    ]]
	    ,done: function(res, page, count) {
			$("[data-field='state']").children().each(function() {
				if ($(this).text() == '-1') {
					$(this).html('<span class="layui-badge layui-bg-gray">未开始</span>');
				}else if ($(this).text() == '0') {
					$(this).html('<span class="layui-badge layui-bg-cyan">进行中</span>');
				}else if ($(this).text() == '1') {
					$(this).html('<span class="layui-badge layui-bg-green">完成</span>');
				}
			});
			form.render();
		}
	  });
  

  //表格按钮
  table.on('tool(panorama_table_tool)', function(obj){
	  var data = obj.data;
	  var layEvent = obj.event;
	  if(layEvent === 'detail'){
	    	//详情
			console.log('data.state='+data.state);
			admin.setTableBtnInfo(data.superior_item_id+","+data.itemId);
			admin.putTempData('temp_pannrama_detail_superior_item_name', data.superior_item_name);
			admin.putTempData('temp_pannrama_detail_itemName', data.itemName);
			admin.putTempData('temp_pannrama_detail_itemId', data.itemId);
			admin.putTempData('temp_pannrama_detail_state', ""+data.state);
			admin.putTempData('temp_pannrama_detail_organization', data.organization);
			admin.putTempData('temp_pannrama_detail_workContent', data.workContent);
			admin.putTempData('temp_pannrama_detail_step', data.step);
			admin.putTempData('temp_pannrama_detail_completionCycle', data.completionCycle);
			admin.putTempData('temp_pannrama_detail_personLiable', data.personLiable);
			admin.putTempData('temp_pannrama_detail_partner', data.partner);
			admin.putTempData('temp_pannrama_detail_startTime', data.startTime);
			admin.putTempData('temp_pannrama_detail_completionTime', data.completionTime);
			admin.putTempData('temp_pannrama_detail_creationDate', data.creationDate);
			admin.popupCenter({
			    title: '项目详情',
			    path: 'tpl/pannrama_detail',
			    area: ['500px','600px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	table.reload('pannrama_table', {
						url: "queryInfoBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('panorama_selectId', 'valStr')
						}
					});
			    }
			});
	    } else if(layEvent === 'progress'){
    	//进展
		admin.setTableBtnInfo(data.itemId+","+data.state);
		admin.open({
		    title: '项目时间线',
		    path: 'tpl/progress',
		    area: ['500px','600px'],
		    success: function (layero, index) {
		        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
		    },
		    end: function () {
		    	table.reload('pannrama_table', {
					url: "queryInfoBySearchCondition",
					method:'post',
					where: {
						SearchCondition:  formSelects.value('panorama_selectId', 'valStr')
					}
				});
		    }
		});
    } else if(layEvent === 'del'){
    	layer.confirm('确定删除这个事项吗？', {
  			icon: 3,
  			title: '提示'
  		},
  		function(index) {
  				$.post(admin.base_server + "deleteItemSecond", {
  					item_id: data.itemId
  				},function(data) {
  					if (data.code == 0) {
	  					layer.msg(data.info);
	  			    	table.reload('pannrama_table', {
							url: "queryInfoBySearchCondition",
							method:'post',
							where: {
								SearchCondition:  formSelects.value('panorama_selectId', 'val')
							}
						});
  					} else {
  						layer.msg(data.info);
  					}
  				},'json');
  				layer.close(index);
  		});
    } else if(layEvent === 'edit'){
		admin.putTempData('temp_pannrama_detail_superior_item_id', data.superior_item_id);
		admin.putTempData('temp_pannrama_detail_superior_item_name', data.superior_item_name);
		admin.putTempData('temp_pannrama_detail_itemName', data.itemName);
		admin.putTempData('temp_pannrama_detail_itemId', data.itemId);
		admin.putTempData('temp_pannrama_detail_organization', data.organization);
		admin.putTempData('temp_pannrama_detail_workContent', data.workContent);
		admin.putTempData('temp_pannrama_detail_completionCycle', data.completionCycle);
		admin.putTempData('temp_pannrama_detail_personLiable', data.personLiable);
		admin.putTempData('temp_pannrama_detail_partner', data.partner);
		admin.putTempData('temp_pannrama_detail_startTime', data.startTime);
		admin.putTempData('temp_pannrama_detail_completionTime', data.completionTime);
		admin.putTempData('temp_pannrama_detail_creationDate', data.creationDate);
		admin.popupCenter({
		    title: '修改工作内容',
		    path: 'tpl/edit_panorama',
		    area: ['500px','600px'],
		    success: function (layero, index) {
		        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
		    },
		    end: function () {
		    	table.reload('pannrama_table', {
					url: "queryInfoBySearchCondition",
					method:'post',
					where: {
						SearchCondition:  formSelects.value('panorama_selectId', 'valStr')
					}
				});
		    }
		});
		
    } else if(layEvent === 'step'){
    	if(data.step=="N"){
    		  var that = this;
    		  layer.tips('无数据', that);
    	}else{
    		layer.tab({
    			  area: ['600px', '300px'],
    			  tab: [{
    			    title: data.workContent+"   的具体步骤", 
    			    content:data.step
    			  }],
    			  shadeClose:true
    			});
    	}
    }
  });
  //搜索按钮
  form.on('submit(quretPanorama)',function(data) {
		table.reload('pannrama_table', {
			url: "queryInfoBySearchCondition",
			method:'post',
			where: {
			//SearchCondition:  formSelects.value('panorama_selectId', 'val')
			SearchCondition:  formSelects.value('panorama_selectId', 'valStr')
			}
		});
    return false;
  });
  //触发按钮事件
  $('#layerDemo .layui-btn').on('click', function(){
    var othis = $(this), method = othis.data('method');
    active[method] ? active[method].call(this, othis) : '';
   
  });
  var active = {
		  //添加工作项
	addPanoramaWindow: function(){
	  admin.setTableBtnInfo(null);
		admin.popupCenter({
		    title: '新增工作内容',
		    path: 'tpl/add_panorama',
		    area: ['500px','600px'],
		    success: function (layero, index) {
		        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
		    },
		    end: function () {
		    	table.reload('pannrama_table', {
					url: "queryInfoBySearchCondition",
					method:'post',
					where: {
						SearchCondition:  formSelects.value('panorama_selectId', 'valStr')
					}
				});
		    }
		});
     return false;
    },
	  //添加步骤
    addStepWindow: function(){
  	  admin.setTableBtnInfo(null);
		admin.popupCenter({
		    title: '添加/更新步骤',
		    path: 'tpl/addstep',
		    area: ['500px','600px'],
		    success: function (layero, index) {
		        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
		    },
		    end: function () {
		    	table.reload('pannrama_table', {
					url: "queryInfoBySearchCondition",
					method:'post',
					where: {
						SearchCondition:  formSelects.value('panorama_selectId', 'valStr')
					}
				});
		    }
		});
       return false;
      },
	  //批量删除
      batchPanoramaDelete:function(){
    	var checkStatus = table.checkStatus('pannrama_table');
		console.log(checkStatus.data);
		var data_idList = "";
		if (checkStatus.data != '') {
			layer.confirm('确定删除这些事项吗？', {
				icon: 3,
				title: '提示'
			},
			function(index) {
				for (var a = 0; a < checkStatus.data.length; a++) {
					data_idList += checkStatus.data[a].itemId + ";"
				}
				console.log(data_idList);
				$.post(admin.base_server + "batchDeleteSecondByItemId", {
					item_id: data_idList
				},
				function(data) {
					if (data.code == "0") {
						table.reload('pannrama_table', {
							url: "queryInfoBySearchCondition",
							method:'post',
							where: {
								SearchCondition:  formSelects.value('panorama_selectId', 'valStr')
							}
						});
						layer.msg(data.info);
					} else {
						layer.msg(data.info);
					}
				},'json');
			});
		}else{
			layer.tips('请选择需要删除的行', $('#batchDeletePanorama'), {
				tips: [3, '#5fb878']
			})
		}
    },
    downloadPanorama: function(){
    	layer.open({
			  title:'获取下载地址并开始下载',
			  type: 2, 
			  content: ["ExportExcelPanorama", 'no'],
			  time: 3000
			});
      }
  };

});