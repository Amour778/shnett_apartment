layui.use(['layer','form', 'table','formSelects','admin','notice','dropdown'], function(){
  var $=layui.jquery
  ,form = layui.form
  ,layer = layui.layer
  ,formSelects = layui.formSelects
  ,table= layui.table
  ,notice=layui.notice
  ,dropdown = layui.dropdown
  ,admin = layui.admin;
  formSelects.data('WCPSselect', 'server', {
	    url:"getWeakCurrentProjectsSimpleFormSelectsInfo",
	    success: function(id, url, searchVal, result){
	  table.render({
		  	id:'weak_current_project_table'
			,toolbar: true
			,loading: true
			,defaultToolbar: ['filter']
		    ,page: true
		    ,elem: '#weak_current_project_table'
		    ,url: 'queryWeakCurrentProjectsSimple'
			,where: {"SearchCondition":formSelects.value('WCPSselect', 'valStr')}
		    ,cols: [[
		      {type:'checkbox', fixed: 'left'}
		      ,{field:'project_code',  title: '项目编码', fixed: 'left', width:130}
		      ,{field:'audit_status',  title: '审核状态',width:150 , fixed:'left'}
		      ,{field:'project_name',  title:'项目名称', width:100 , fixed:'left'}
		      //,{field:'project_progress',  title:'项目进度',width:100 , fixed:'left'}
		      ,{field:'audit_info',  title:'审核备注', width:100}
		      ,{field:'project_area_department',  title:'项目区部', width:100}
		      ,{field:'district_name',  title:'区部名称', width:100 }
		      ,{field:'item_classification',  title:'项目分类', width:100 }
		      ,{field:'ustomer_name',  title:'客户名称', width:100}
		      ,{field:'planned_start_time',  title:'计划启动时间', width:130}
		      ,{field:'planned_end_time',  title:'预计完成时间', width:130 }
		      ,{field:'project_cycle',  title:'项目周期', width:100 }
		      ,{field:'project_quotation',  title:'项目报价',width:100 }
		      ,{field:'project_leader',  title:'项目负责人',width:100 }
		      ,{field:'material',  title:'材料',width:100 }
		      ,{field:'labor',  title:'人工(外请)',width:100 }
		      ,{field:'allocation_of_fixed_assets',  title:'固定资产分摊',width:130 }
		      ,{field:'other_items',  title:'其他项',width:100 }
		      ,{field:'subtotal_cost',  title:'费用小计',width:100 }
		      ,{field:'simple_tax',  title:'税率',width:100 }

		      ,{field:'special_vat_invoice_amount',  title:'可开票增专金额',width:100 }
		      ,{field:'ordinary_invoice_amount',  title:'普票金额',width:100 }
		      ,{field:'supplier_invoice_tax',  title:'供应商抵扣税率',width:100 }
		      ,{field:'supplier_invoice',  title:'供应商开票抵税金额',width:100 }
		      ,{field:'predict_gross_profit',  title:'预估毛利',width:100 }
		      ,{field:'predict_gross_profit_per',  title:'预估毛利%',width:100 }
		      ,{field:'predict_net_profit',  title:'预估净利润',width:100 }
		      ,{field:'predict_net_profit_per',  title:'预估净利润%',width:100 }
		      ,{field:'edit_remark',  title:'项目备注',width:100 }
		      
		      ,{field:'submitter',  title:'提交人',width:100 }
		      ,{field:'submission_time',  title:'提交时间',width:120 }
		      //,{field:'isclose',  title:'是否结单',width:100 }
		      ,{fixed:'right', width:80, title:'操作', align:'center', toolbar:'#weak_current_project_tool_bar',unresize:true}
		    ]]
		    ,done: function(res, page, count) {
				$("[data-field='audit_info']").children().each(function() {
					if ($(this).text() == 'N') {
						$(this).html('');
					}
				});
				$("[data-field='audit_status']").children().each(function() {
					if ($(this).text() == '1010') {
						$(this).html('<span class="layui-badge layui-bg-gray">大区负责人待审核</span>');
					}else if ($(this).text() == '1012') {
						$(this).html('<span class="layui-badge layui-bg-orange">大区负责人已驳回</span>');
					}else if ($(this).text() == '1020') {
						$(this).html('<span class="layui-badge layui-bg-gray">管理员待审核</span>');
					}else if ($(this).text() == '1021') {
						$(this).html('<span class="layui-badge layui-bg-green">已立项</span>');
					}else if ($(this).text() == '1022') {
						$(this).html('<span class="layui-badge layui-bg-orange">管理员已驳回</span>');
					}else if ($(this).text() == '1030') {
						$(this).html('<span class="layui-badge">已撤项</span>');
					}
				});
				$("[data-field='isclose']").children().each(function() {
					if ($(this).text() == '0') {
						$(this).html('<span class="layui-badge layui-bg-gray">未结单</span>');
					}else if ($(this).text() == '1011') {
						$(this).html('<span class="layui-badge layui-bg-green">已结单</span>');
					}
				});
				//form.render();
			}
		  });
  		}
	});


  $('#layerDemo .layui-btn').on('click', function(){
    var othis = $(this), method = othis.data('method');
    active[method] ? active[method].call(this, othis) : '';
   
  });
  //监听工具条
  table.on('tool(weak_current_project_table_tool)', function (obj) {
      var data = obj.data; //获得当前行数据
      var layEvent = obj.event; //获得 lay-event 对应的值
      console.log("项目编码："+data.project_code);
      if (layEvent === 'edit') {
        	admin.putTempData('project_code', data.project_code);
			admin.popupCenter({
			    title: '修改立项内容',
			    path: 'tpl/wcp/add_edit_weak_current_project',
			    area: ['800px','600px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	table.reload('weak_current_project_table', {
						url: "queryWeakCurrentProjectsSimple",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPSselect', 'valStr')
						}
					});
			    }
			});
      }else if (layEvent === 'show_wcp_simple') {
    	  admin.putTempData('project_code', data.project_code);
			admin.popupCenter({
			    title: '查看立项内容',
			    path: 'tpl/wcp/show_wcp_simple',
			    area: ['800px','600px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	table.reload('weak_current_project_table', {
						url: "queryWeakCurrentProjectsSimple",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPSselect', 'valStr')
						}
					});
			    }
			});
    }else if (layEvent === 'revoke') {
 	   layer.confirm('确定撤项吗？<br/>撤项将会删除项目编码：'+data.project_code+'相关的"项目总表、成本报销、奖金分配"等数据', {btn: ['确定','取消']}, function(){
 		  admin.ajax_load_json({
				url: "revokeWeakCurrentProjectsSimpleByProjectCode",
				data: {
					project_code : data.project_code
				},
				success: function(obj) {
					if (obj.code == 0) {
						layer.closeAll();
						layer.msg(obj.info, {
							icon: 1
						});
						table.reload('weak_current_project_table', {
							url: "queryWeakCurrentProjectsSimple",
							method:'post',
							where: {
								SearchCondition:  formSelects.value('WCPSselect', 'valStr')
							}
						});
					} else {
						layer.alert(obj.info, {
							icon: 5
						});
					}
				}
			});
	     })
   }else if (layEvent === 'show_wcp_approva_log') {
	   admin.putTempData('item_id', data.project_code);
		admin.popupCenter({
		    title: '审批历史',
		    path: 'tpl/wcp/show_wcp_approva_log',
		    area: [(window.screen.width*0.5)+'px', (window.screen.height*0.5)+'px'],
		    success: function (layero, index) {
		        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
		    },
		    end: function () {
		    }
		});
   }
      
  });

  var active = {
	addWeakCurrentProjectWindow: function(){
	  console.log("新增立项内容");
  		admin.putTempData('project_code', null);
		admin.popupCenter({
		    title: '新增立项内容',
		    path: 'tpl/wcp/add_edit_weak_current_project',
		    area: [(window.screen.width*0.5)+'px', (window.screen.height*0.8)+'px'],
		    success: function (layero, index) {
		        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
		    },
		    end: function () {
		    	formSelects.render('WCPSselect');
		    	formSelects.data('WCPSselect', 'server', {
		    		    url:"getWeakCurrentProjectsSimpleFormSelectsInfo"
		    		});
		    	table.reload('weak_current_project_table', {
					url: "queryWeakCurrentProjectsSimple",
					method:'post',
					where: {
						SearchCondition:  formSelects.value('WCPSselect', 'valStr')
					}
				});
		    }
		});
	  }
  }
  
  form.on('submit(quretWeakCurrentProjectSimple)',function(data) {
	  table.reload('weak_current_project_table', {
			url: "queryWeakCurrentProjectsSimple",
			method:'post',
			where: {
				SearchCondition:  formSelects.value('WCPSselect', 'valStr')
			}
		});
	    return false;
	  });
});