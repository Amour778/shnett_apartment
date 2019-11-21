layui.use(['element','layer','form', 'table','formSelects','admin','dropdown'], function(){
  var $=layui.jquery
  ,form = layui.form
  ,layer = layui.layer
  ,formSelects = layui.formSelects
  ,table= layui.table
  ,dropdown = layui.dropdown
  ,element = layui.element
  ,admin = layui.admin;
  formSelects.data('WCPDselect', 'server', {
	    url:"getWCProjectsDetailFormSelectsInfo",
	    success: function(id, url, searchVal, result){
	  	table.render({
		  	id:'wcp_summary_table'
			//,toolbar: true
			,loading: true
			//,defaultToolbar: ['filter']
		    ,page: true
		    ,title:'弱电项目总表'
		    ,height: 'full'
		    ,elem: '#wcp_summary_table'
		    ,toolbar: true
		    ,defaultToolbar: ['filter',  'exports']
		    ,url: 'queryWCProjectsDetailBySearchCondition'
		    ,even:true
			,where: {SearchCondition:  formSelects.value('WCPDselect', 'valStr')}
			,cols:  [
				[
		      	//{type:'checkbox', fixed: 'left', rowspan: 2}
		      	{field:'project_code',  title: '项目编码', width:140, rowspan: 2, fixed: 'left' }
		      	,{field:'project_name',  title: '项目名称', width:100 , rowspan: 2, fixed: 'left' }
		      	,{field:'audit_status',  title: '审核状态 ',width:210 , rowspan: 2, fixed: 'left'}
		      	
		      	,{field:'audit_info',  title: '审核备注 ', rowspan: 2,width:110 }
				,{align: 'center',field: 'project_progress', title: '项目进度', width: 110, rowspan: 2}
		      	,{field:'project_progress_remake',  title: '申请结项备注 ', rowspan: 2,width:110 }
			 	//,{align: 'center',field: 'project_code', title: '项目编码', width: 100, rowspan: 2,fixed: 'left'}
				,{align: 'center',field: 'project_area_department', title: '项目区部', width: 100, rowspan: 2}
				,{align: 'center',field: 'district_name', title: '区部名称', width: 100, rowspan: 2}
				,{align: 'center',field: 'item_classification', title: '项目分类', width: 100, rowspan: 2}
				,{align: 'center',field: 'ustomer_name', title: '客户名称', width: 100, rowspan: 2}
				,{align: 'center',field: 'planned_start_time', title: '计划启动时间', width: 120, rowspan: 2}
				,{align: 'center',field: 'planned_end_time', title: '预计完成时间', width: 120, rowspan: 2}
				//,{align: 'center',field: 'project_name', title: '项目名称', width: 100, rowspan: 2}
				,{align: 'center',field: 'project_cycle', title: '项目周期', width: 100, rowspan: 2}
				,{align: 'center',field: 'project_quotation', title: '项目报价', width: 100, rowspan: 2}
				,{align: 'center',field: 'project_leader', title: '项目负责人', width: 100, rowspan: 2}
				,{align: 'center',title: '成本估算', colspan: 5}
			    ,{align: 'center',title: '税率 ',field:'simple_tax',  width:100, rowspan: 2}
				,{align: 'center',field: 'cost_share', title: '成本占比%', width: 100, rowspan: 2}
				//,{align: 'center',field: 'city', title: '备注', width: 100, rowspan: 2}
				,{align: 'center',field: 'actual_completion_date', title: '实际完工日(验收日)', width: 180, rowspan: 2}
				,{align: 'center',field: 'project_closing_day', title: '项目结单日', width: 100, rowspan: 2}
				,{align: 'center', title: '实际开支', colspan: 7}
				,{align: 'center', title: '税务管理 ', colspan: 3}
				,{align: 'center',field: 'remaining_stock', title: '余材库存', width: 100, rowspan: 2}
				//,{align: 'center',field: 'city', title: '服务名称', width: 100, rowspan: 2}
				//,{align: 'center',field: 'city', title: '发票号', width: 100, rowspan: 2}
				//,{align: 'center',field: 'city', title: '开票日期', width: 100, rowspan: 2}
				,{align: 'center', title: '开票金额', colspan: 3}
				,{align: 'center',field: 'real_gross_profit', title: '实际毛利', width: 100, rowspan: 2, style:'background-color: #baa592; color: #fff;'}
				,{align: 'center',field: 'real_gross_profit_per', title: '实际毛利%', width: 100, rowspan: 2, style:'background-color: #baa592; color: #fff;'}
				,{align: 'center',field: 'net_profit', title: '净利润', width: 100, rowspan: 2, style:'background-color: #baa592; color: #fff;'}
				,{align: 'center',field: 'net_profit_per', title: '净利%', width: 100, rowspan: 2, style:'background-color: #baa592; color: #fff;'}
				,{align: 'center',field: 'surplus_gross_profit', title: '余料毛利', width: 100, rowspan: 2}
				,{align: 'center',field: 'surplus_gross_profit_per', title: '余料毛利%', width: 100, rowspan: 2}
				,{align: 'center',field: 'quality_assurance_funds', title: '质保金', width: 150, rowspan: 2}
				
				,{align: 'center',field:'special_vat_invoice_amount',  title: '可开票增专金额 ',width:140 , rowspan: 2}
				,{align: 'center',field:'ordinary_invoice_amount',  title: '普票金额 ',width:100 , rowspan: 2}
				,{align: 'center',field:'supplier_invoice_tax',  title: '供应商抵扣税率 ',width:140 , rowspan: 2}
				,{align: 'center',field:'supplier_invoice',  title: '供应商开票抵税金额 ',width:180 , rowspan: 2}
				,{align: 'center',field:'predict_gross_profit',  title: '预估毛利 ',width:100 , rowspan: 2}
				,{align: 'center',field:'predict_gross_profit_per',  title: '预估毛利% ',width:100 , rowspan: 2,templet: '#predict_gross_profit_perTpl'}
				,{align: 'center',field:'predict_net_profit',  title: '预估净利润 ',width:140 , rowspan: 2}
				,{align: 'center',field:'predict_net_profit_per',  title: '预估净利润% ',width:140 , rowspan: 2,templet: '#predict_net_profit_perTpl'}
			      
				,{align: 'center',field: 'received_amount', title: '已收款金额', width: 100, rowspan: 2}
				//,{align: 'center',field: 'city', title: '收款(收款日期)', width: 100, rowspan: 2}
				,{align: 'center',field: 'amount_to_be_collected', title: '待收金额', width: 100, rowspan: 2}
				,{align: 'center',field: 'personal',  title: '个人25%', width: 120, rowspan: 2}
				,{align: 'center',field: 'capital_pool', title: '资金池25%', width: 120, rowspan: 2}
				,{align: 'center',field: 'company', title: '公司50%', width: 100, rowspan: 2}
				,{align: 'center',field: 'returned_money_ishave', title: '是否有质保金', width: 180, rowspan: 2}
				,{align: 'center',field: 'returned_money_date', title: '质保金预估回款日期', width: 180, rowspan: 2}
				,{align: 'center',field: 'returned_money_point', title: '质保金点数', width: 100, rowspan: 2}
				,{align: 'center',field: 'reminder_date', title: '质保金实际汇款日期', width: 180, rowspan: 2}
				//,{align: 'center',field: 'city', title: '结单金额', width: 100, rowspan: 2}
				,{align: 'center',field: 'personal_warranty', title: '个人质保金', width: 120, rowspan: 2}
				,{align: 'center',field: 'personal_actual_distribution', title: '个人实际发放', width: 120, rowspan: 2}
			 	,{align: 'center',title: '操作',toolbar: '#wcp_summary_table_bar', width: 150,fixed: 'right'}
			], [
				{align: 'center',field: 'material', title: '材料', width: 100}
				,{align: 'center',field: 'labor', title: '人工(外请)', width: 120}
				,{align: 'center',field: 'allocation_of_fixed_assets', title: '固定资产分摊', width: 120}
				,{align: 'center',field: 'other_items', title: '其他项', width: 100}
				,{align: 'center',field: 'subtotal_cost', title: '费用小计', width: 100}
				
				,{align: 'center',field: 'material_cost_including_tax', title: '材料费(含税)', width: 150}
				,{align: 'center',field: 'tax_credit_amount', title: '抵税金额(增值税专用发票)', width: 200}
				,{align: 'center',field: 'outsourcing_including_tax', title: '外包人工费、水电(含税)', width: 200}
				,{align: 'center',field: 'transport_fees', title: '运杂费', width: 100}
				,{align: 'center',field: 'allocation_of_fixed_assets_of_instruments', title: '工具固定资产分摊', width: 150}
				,{align: 'center',field: 'entertain', title: '招待', width: 100}
				,{align: 'center',field: 'subtotal_labor_material_costs', title: '人工材料费用小计', width: 150}
				
				,{align: 'center',field: 'management_costs', title: '管理成本2%', width: 120}
				,{align: 'center',field: 'tax_reimbursement', title: '(财务填)补税', width: 150}
				,{align: 'center',field: 'subtotal_management_fees_and_taxes', title: '管理费及税务小计', width: 150}
				
				,{align: 'center',field: 'principal', title: '本金', width: 100}
				,{align: 'center',field: 'tax_money', title: '税额 6~11%', width: 120}
				,{align: 'center',field: 'full_amount_of_tax', title: '税价全额', width: 100}
				]
			],done: function(res, page, count) {
				$("[data-field='audit_info']").children().each(function() {
					if ($(this).text() == 'N') {
						$(this).html('');
					}
				});
				$("[data-field='returned_money_ishave']").children().each(function() {
					if ($(this).text() == 'N') {
						$(this).html('否');
					}else if ($(this).text() == 'Y') {
						$(this).html('是');
					}
				});
				$("[data-field='returned_money_point']").children().each(function() {
					if($(this).text()!='质保金点数')
						$(this).html($(this).text()*100+'%');
				});
				

				$("[data-field='audit_status']").children().each(function() {
					if ($(this).text() == '1021') {
						$(this).html('<span class="layui-badge layui-bg-green">立项-已通过</span>');
					}
					
					else if ($(this).text() == '3010') {
						$(this).html('<span class="layui-badge layui-bg-gray">申请结项-大区负责人待审核</span>');
					/*}else if ($(this).text() == '3011') {
						$(this).html('<span class="layui-badge layui-bg-green">申请结项-大区负责人已通过</span>');*/
					}else if ($(this).text() == '3012') {
						$(this).html('<span class="layui-badge layui-bg-badge">申请结项-大区负责人已驳回</span>');
					}else if ($(this).text() == '3020') {
						$(this).html('<span class="layui-badge layui-bg-gray">申请结项-财务待审核</span>');
						/*}else if ($(this).text() == '3021') {
						$(this).html('<span class="layui-badge layui-bg-green">申请结项-财务已通过</span>');*/
					}else if ($(this).text() == '3022') {
						$(this).html('<span class="layui-badge layui-bg-badge">申请结项-财务已驳回</span>');
					}else if ($(this).text() == '3030') {
						$(this).html('<span class="layui-badge layui-bg-gray">申请结项-管理员待审核</span>');
					}else if ($(this).text() == '3031') {
						$(this).html('<span class="layui-badge layui-bg-green">申请结项-管理员已通过</span>');
					}else if ($(this).text() == '3032') {
						$(this).html('<span class="layui-badge layui-bg-badge">申请结项-管理员已驳回</span>');
					}
					
					else if ($(this).text() == '4010') {
						$(this).html('<span class="layui-badge layui-bg-gray">个人奖金-大区负责人待审核</span>');
	/*				}else if ($(this).text() == '4011') {
						$(this).html('<span class="layui-badge layui-bg-green">个人奖金-大区负责人已通过</span>');*/
					}else if ($(this).text() == '4012') {
						$(this).html('<span class="layui-badge layui-bg-badge">个人奖金-大区负责人已驳回</span>');
					}else if ($(this).text() == '4020') {
						$(this).html('<span class="layui-badge layui-bg-gray">个人奖金-管理员待审核</span>');
	/*				}else if ($(this).text() == '4021') {
						$(this).html('<span class="layui-badge layui-bg-green">个人奖金-管理员已通过</span>');*/
					}else if ($(this).text() == '4022') {
						$(this).html('<span class="layui-badge layui-bg-badge">个人奖金-管理员已驳回</span>');
					}else if ($(this).text() == '4030') {
						$(this).html('<span class="layui-badge layui-bg-gray">个人奖金-BOSS待审核</span>');
					/*}else if ($(this).text() == '4031') {
						$(this).html('<span class="layui-badge layui-bg-green">个人奖金-BOSS已通过</span>');*/
					}else if ($(this).text() == '4032') {
						$(this).html('<span class="layui-badge layui-bg-badge">个人奖金-BOSS已驳回</span>');
					}else if ($(this).text() == '4040') {
						$(this).html('<span class="layui-badge layui-bg-gray">个人奖金-人资待审核</span>');
					/*}else if ($(this).text() == '4041') {
						$(this).html('<span class="layui-badge layui-bg-green">个人奖金-人资已通过</span>');*/
					}else if ($(this).text() == '4042') {
						$(this).html('<span class="layui-badge layui-bg-badge">个人奖金-人资已驳回</span>');
					}

					else if ($(this).text() == '9979') {
						$(this).html('<span class="layui-badge layui-bg-gray">工程结项-质保金未回款</span>');
					}
					else if ($(this).text() == '9980') {
						$(this).html('<span class="layui-badge layui-bg-gray">质保金回款-财务待审核</span>');
					}
					else if ($(this).text() == '9982') {
						$(this).html('<span class="layui-badge layui-bg-badge">质保金回款-财务已驳回</span>');
					}
					else if ($(this).text() == '9998') {
						$(this).html('<span class="layui-badge layui-bg-green">工程结项-质保金已回款</span>');
					}
					else if ($(this).text() == '9999') {
						$(this).html('<span class="layui-badge layui-bg-green">工程结项-无质保金</span>');
					}
				});
				$("[data-field='project_progress']").children().each(function() {
					if ($(this).text() == '0') {
						$(this).html('<span class="layui-badge layui-bg-gray">未开工</span>');
					}else if ($(this).text() == '30') {
						$(this).html('<span class="layui-badge layui-bg-gray">已开工30%</span>');
					}else if ($(this).text() == '70') {
						$(this).html('<span class="layui-badge layui-bg-gray">已开工70%</span>');
					}else if ($(this).text() == '90') {
						$(this).html('<span class="layui-badge layui-bg-gray">已竣工</span>');
					}else if ($(this).text() == '99') {
						$(this).html('<span class="layui-badge layui-bg-gray">已验收</span>');
					}else if ($(this).text() == '100') {
						$(this).html('<span class="layui-badge layui-bg-gray">结项</span>');
					}
				});/*
				$("[data-field='isclose']").children().each(function() {
					if ($(this).text() == '0') {
						$(this).html('<span class="layui-badge layui-bg-gray">未结单</span>');
					}else if ($(this).text() == '1011') {
						$(this).html('<span class="layui-badge layui-bg-green">已结单</span>');
					}
				});*/
			}
		  });
  }
	});

  

  //搜索按钮
  form.on('submit(quret_wcp_summary)',function(data) {
		table.reload('wcp_summary_table', {
			url: "queryWCProjectsDetailBySearchCondition",
			method:'post',
			where: {
				SearchCondition:  formSelects.value('WCPDselect', 'valStr')
			}
		});
    return false;
  });

  //表格按钮
  table.on('tool(wcp_summary_table_tool)', function(obj){
	  var data = obj.data;
	  var layEvent = obj.event;
	  console.log("项目编码："+data.project_code);
      if (layEvent === 'wcp_summary_update_progress') {
    	  admin.putTempData('project_code', data.project_code);
    	  admin.putTempData('project_progress', data.project_progress);
    	  admin.putTempData('project_name',data.project_name);
			admin.popupCenter({
			    title: '更新项目进度',
			    path: 'tpl/wcp/update_wcp_progress',
			    area: ['400px',window.screen.height*0.5+'px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});
			    }
			});
      }else if (layEvent === 'wcp_summary_actual_expenditure') {
    	  admin.putTempData('project_code', data.project_code);
    	  //通过ID获取是否存在审核通过并为最后一次报销的数据
	      	admin.ajax_load_json({
				url: "queryIsOrNotTheLastTimeByProjectCode",
				data: {
	      			project_code : data.project_code
				},
				success: function(obj) {
					if (obj.code == 0) {
						var indexpopupCenter=admin.popupCenter({
						    title: '添加成本报销',
						    path: 'tpl/wcp/add_wcp_actual_expenditure',
						    //maxmin: true,
						    area: [window.screen.width-200+'px', window.screen.height-150+'px'],
						    success: function (layero, index) {
						        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
						    },
						    end: function () {
						    	table.reload('wcp_summary_table', {
									url: "queryWCProjectsDetailBySearchCondition",
									method:'post',
									where: {
										SearchCondition:  formSelects.value('WCPDselect', 'valStr')
									}
								});
						    }
						});
						layer.full(indexpopupCenter);
					} else {
						layer.alert(obj.info, {
							icon: 5
						});
					}
				}
			});
	  }else if (layEvent === 'advance_payment_request_list') {
    	  admin.putTempData('project_code', data.project_code);
    	  admin.popupCenter({
			    title: '提前付款申请总表',
			    path: 'tpl/wcp/advance_payment_request_list',
			    area: [window.screen.width*0.5+'px',window.screen.height*0.5+'px'],
			    //area: ['600px','500px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    }
			});
	  }else if (layEvent === 'wcp_bonus_shares') {
    	  admin.putTempData('project_code', data.project_code);
    	  var add_wcp_bonus_sharespopupCenter=admin.popupCenter({
			    title: '项目奖金分配',
			    path: 'tpl/wcp/add_wcp_bonus_shares',
			    area: [window.screen.width*0.9+'px', window.screen.height*0.9+'px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});
			    }
			});
    	  console.log("FULL",formSelects.value('WCPDselect', 'valStr'));
    	  layer.full(add_wcp_bonus_sharespopupCenter);
	  }else if (layEvent === 'show_wcp_summary') {//查看结项内容
		  admin.putTempData('project_code', data.project_code);
		  admin.popupCenter({
			    title: '项目内容',
			    path: 'tpl/wcp/show_wcp_summary',
			    area: ['600px','500px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	/*table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});*/
			    }
			});
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
	   }else if (layEvent === 'show_wcp_files') {//查看已上传文件
			  admin.putTempData('project_code', data.project_code);
			  admin.putTempData('project_progress', data.project_progress);
			  admin.popupCenter({
			    title: '已上传文件',
			    path: 'tpl/wcp/show_wcp_files',
				area: '600px',
			});
	  }else if (layEvent === 'application_closing') {
		  admin.putTempData('project_code', data.project_code);
		  admin.popupCenter({
			    title: '审核-申请结项',
			    path: 'tpl/wcp/pending_audit_wcp_summary',
			    area: ['700px', window.screen.height*0.7+'px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});
			    }
			});
	  }else if (layEvent === 'personal_bonus_Finance') {//个人奖金-财务待审核
    	  admin.putTempData('project_code', data.project_code);
    	  admin.putTempData('user_permission', 'ruod');
		  admin.popupCenter({
			    title: '大区负责人审核-项目奖金分配',
			    path: 'tpl/wcp/pending_audit_wcp_bonus_shares',
			    area: ['1000px','500px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});
			    }
			});
	  }else if (layEvent === 'personal_bonus_Administrator') {//个人奖金-管理员待审核
    	  admin.putTempData('project_code', data.project_code);
    	  admin.putTempData('user_permission', 'ruoa');
		  admin.popupCenter({
			    title: '管理员审核-项目奖金分配',
			    path: 'tpl/wcp/pending_audit_wcp_bonus_shares',
			    area: ['1000px','500px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});
			    }
			});
	  }else if (layEvent === 'personal_bonus_Boss_resources') {//个人奖金-人资待审核
    	  admin.putTempData('project_code', data.project_code);
    	  admin.putTempData('user_permission', 'ruob');
		  admin.popupCenter({
			    title: 'BOSS审核-项目奖金分配',
			    path: 'tpl/wcp/pending_audit_wcp_bonus_shares',
			    area: ['1000px','500px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});
			    }
			});
	  }else if (layEvent === 'personal_bonus_Human_resources') {//个人奖金-人资待审核
    	  admin.putTempData('project_code', data.project_code);
    	  admin.putTempData('user_permission', 'ruoh');
		  admin.popupCenter({
			    title: '人资审核-项目奖金分配',
			    path: 'tpl/wcp/pending_audit_wcp_bonus_shares',
			    area: ['1000px','500px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});
			    }
			});
	  }else if (layEvent=="show_wcp_bonus_shares"){
    	  admin.putTempData('project_code', data.project_code);
    	  admin.putTempData('user_permission', null);
		  admin.popupCenter({
			    title: '项目奖金分配明细',
			    path: 'tpl/wcp/show_wcp_bonus_shares',
			    area: ['1000px','500px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
			    	/*table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});*/
			    }
			});
	  }else if (layEvent=="returned_money"){
    	  admin.putTempData('project_code', data.project_code);
		  admin.popupCenter({
			    title: '质保金已回款申请',
			    path: 'tpl/wcp/add_reminder_date',
			    area: ['600px','300px'],
			    end: function () {
				  	table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});
			    }
			});
	  }else if (layEvent=="reminder_date"){
    	  admin.putTempData('project_code', data.project_code);
		  admin.popupCenter({
			    title: '财务审批-质保金已回款',
			    path: 'tpl/wcp/pending_reminder_date',
			    area: ['300px','300px'],
			    end: function () {
				  	table.reload('wcp_summary_table', {
						url: "queryWCProjectsDetailBySearchCondition",
						method:'post',
						where: {
							SearchCondition:  formSelects.value('WCPDselect', 'valStr')
						}
					});
			    }
			});
	  }else if (layEvent=="pending_aoai"){
    	  admin.putTempData('project_code', data.project_code);
		    admin.ajax_load_json({
		    	url : "pendingWCP_AOAI_info",
		    	data:{
		    		project_code : data.project_code
		    	},
		    	success : function(data){
		    		if(data.code==0){
		    			admin.putTempData('application_of_an_invoice_data',data.info);
		    			if(data.info!='N'){
			    		var pending_edit_application_of_an_invoice = admin.open({
						    title: '审核开票申请',
						    path: 'tpl/wcp/pending_application_of_an_invoice',
					    	area: [window.screen.width*0.3+'px', window.screen.height*0.5+'px'],
					    	success: function (layero, index) {
						        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
						    },
						    end: function () {}
						});
						admin.putTempData('pending_edit_application_of_an_invoice',pending_edit_application_of_an_invoice);
		    			}
		    		}else{
		    			layer.alert(data.info,{icon:5});
		    		}
		    	}
		    });
	  }
		
  });
});