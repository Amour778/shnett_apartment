
layui.use(['layer','form', 'table','formSelects','admin','notice','dropdown', 'dtree'], function(){
  var $=layui.jquery
  ,form = layui.form
  ,layer = layui.layer
  ,formSelects = layui.formSelects
  ,table= layui.table
  ,notice=layui.notice
  ,dropdown = layui.dropdown
  ,dtree = layui.dtree
  ,admin = layui.admin;
var _selectGroupItemId=null;
var DemoTree =null;
  formSelects.data('WCPAselect', 'server', {
	    url:"getWeakCurrentProjectsActualExpenditureFormSelectsInfo",
		success: function(id, url, searchVal, result){
	  	formSubmit();
		  }
	});
  form.on('submit(queryWeakCurrentProjectsActualExpenditure)',function(data) {
	  formSubmit();
	    return false;
	  });

  function formSubmit() {
	  layer.load();
	  DemoTree =dtree.render({
		    elem: "#dTree_WCPA",
		    url: "queryWCPAGBySearchCondition?SearchCondition="+formSelects.value('WCPAselect', 'valStr'),
		    method: "post",
		    dataFormat:	'list',
		    accordion: true,
		    dot: false,
		    done: function(data, obj){
		  	    if(data.data.length==0){
		  			  layer.msg("无数据");
		  		  }
		  	  },
			  toolbar:true,
		  	  toolbarScroll:"#dTree_WCPA_div",
		  	  toolbarShow:[],
		  	  menubar:true,
		  	  menubarTips:{
		  	    toolbar:["moveDown","moveUp"],
		  	    group:[]
		  	  }
		  });

	  table.reload('wcp_actual_expenditure_table', {
		  url: 'queryWCPAGByActualId'
		  ,where: {group_id: null}
		});

	  layer.closeAll('loading');
  }
	dtree.on("node('dTree_WCPA')",function(obj) {
		if(obj.param.parentId!=0){
			_selectGroupItemId=obj.param.nodeId;
		  table.render({
			  	id:'wcp_actual_expenditure_table'
				,toolbar: true
				,loading: true
				,defaultToolbar: ['filter']
			    ,page: true
			    ,elem: '#wcp_actual_expenditure_table'
			    ,url: 'queryWCPAGByActualId'
			    ,where: {group_id: obj.param.nodeId }
			    ,cols: [[
			      //{type:'checkbox', fixed: 'left'}
			      //,{field:'id',  title: 'ID'}
			      //,{field:'project_code',  title: '项目编码', width:100 , fixed: 'left'}
			      //{field:'project_name',  title: '项目名称', width:150 , fixed: 'left'}
			      {field:'audit_status',  title: '审核状态 ',width:150, fixed: 'left' }
			      ,{field:'audit_info',  title: '审核备注 ',width:100 }
			      ,{field:'cost_department',  title: '费用所属部门 ',width:110 }
			      ,{field:'item_classification',  title: '项目分类',width:100}
			      ,{field:'cost_matters',  title: '成本事项', width:100}
			      ,{field:'amount_in_original_currency',  title: '价税合计', width:100}
			      ,{field:'idle_stock',  title: '呆料 ', width:100 }
			      ,{field:'tax_rate',  title: '税率', width:100 }
			      ,{field:'amount_of_tax',  title: '税额', width:100 }
			      ,{field:'principal',  title: '本金', width:100 }
			      ,{field:'bill_type',  title: '票据类型', width:100}
			      ,{field:'invoice_number',  title: '发票号码', width:130}
			      ,{field:'date_of_occurrence',  title: '发生日期', width:120 }
			      ,{field:'purpose_of_occurrence',  title: '用途', width:100 }
			      ,{field:'reimbursement_number',  title: '报销工号',width:100 }
			      ,{field:'name_of_applicant',  title: '申请人姓名 ',width:100 }
			      ,{field:'applicant_department',  title: '申请人部门 ',width:100 }
			      ,{field:'date_of_application',  title: '申请日期 ',width:120 }
			      ,{field:'project_leader',  title: '项目负责人 ',width:130 }
			      ,{fixed: 'right', width:80, title: '操作', align:'center', toolbar: '#wcp_actual_expenditure_tool_bar',unresize:true}
			    ]]
			    ,done: function(res, page, count) {
			    	$("[data-field='audit_info']").children().each(function() {
						if ($(this).text() == 'N') {
							$(this).html('');
						}
					});$("[data-field='the_last_time']").children().each(function() {
						if ($(this).text() == 'N') {
							$(this).html('否');
						}else if ($(this).text() == 'Y') {
							$(this).html('是');
						}
					});
					$("[data-field='audit_status']").children().each(function() {
						if ($(this).text() == '2010') {
							$(this).html('<span class="layui-badge layui-bg-gray">大区负责人待审核</span>');
						}else if ($(this).text() == '2012') {
							$(this).html('<span class="layui-badge layui-bg-orange">大区负责人已驳回</span>');
						}else if ($(this).text() == '2020') {
							$(this).html('<span class="layui-badge layui-bg-gray">管理员待审核</span>');
						}else if ($(this).text() == '2022') {
							$(this).html('<span class="layui-badge layui-bg-orange">管理员已驳回</span>');
						}else if ($(this).text() == '2030') {
							$(this).html('<span class="layui-badge layui-bg-gray">财务待审核</span>');
						}else if ($(this).text() == '2032') {
							$(this).html('<span class="layui-badge layui-bg-orange">财务已驳回</span>');
						}else if ($(this).text() == '2040') {
							$(this).html('<span class="layui-badge layui-bg-gray">BOSS待审核</span>');
						}else if ($(this).text() == '2042') {
							$(this).html('<span class="layui-badge layui-bg-orange">BOSS已驳回</span>');
						}else if ($(this).text() == '2041') {
							$(this).html('<span class="layui-badge layui-bg-green">已通过</span>');
						}
					});
				}
			  });
		}
	});

  //监听工具条
  table.on('tool(wcp_actual_expenditure_table_tool)', function (obj) {
      var data = obj.data; //获得当前行数据
      var layEvent = obj.event; //获得 lay-event 对应的值
      if (layEvent === 'edit') {
        	admin.putTempData('id', data.actual_id);
			admin.popupCenter({
			    title: '修改报销内容',
			    path: 'tpl/wcp/edit_wcp_actual_expenditure',
			    area: ['500px','500px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    },
			    end: function () {
    		    	table.reload('wcp_actual_expenditure_table', {
  						url: "queryWCPAGByActualId",
  						method:'post',
  						where: {group_id: _selectGroupItemId }
  					});
			    }
			});
      }else if (layEvent === 'pending') {
      	admin.putTempData('id', data.actual_id);
    		admin.popupCenter({
    		    title: '审核成本报销事项',
    		    path: 'tpl/wcp/pending_wcp_actual_expenditure',
    		    area: ['800px','760px'],
    		    success: function (layero, index) {
    		        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
    		    },
    		    end: function () {
    		    	table.reload('wcp_actual_expenditure_table', {
  						url: "queryWCPAGByActualId",
  						method:'post',
  						where: {group_id: _selectGroupItemId }
  					});
    		    }
    		});
          }else if (layEvent === 'show') {
            	admin.putTempData('id', data.actual_id);
        		admin.popupCenter({
        		    title: '查看成本报销事项',
        		    path: 'tpl/wcp/show_wcp_actual_expenditure',
        		    area: ['500px','700px'],
        		    success: function (layero, index) {
        		        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
        		    }
        		});
          }else if (layEvent === 'show_wcp_approva_log') {
   		   admin.putTempData('item_id', data.actual_id);
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

});