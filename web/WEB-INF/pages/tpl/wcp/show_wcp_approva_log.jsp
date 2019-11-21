<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<table class="layui-table" lay-size="sm" lay-even id="wcp_approva_log_timeline_table"></table>
<script type="text/javascript">
	layui.use(['jquery', 'admin', 'table'], function() {
		var $ = layui.jquery, admin = layui.admin, table = layui.table;
		var item_id = admin.getTempData('item_id');
		table.render( {
			elem : '#wcp_approva_log_timeline_table',
			where : {
				item_id : item_id
			},
			text : {
				none : '暂无审批数据'
			},
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			method : 'POST',
			url : 'queryWCPALogByItemId',
			cols : [ [/* {
				field : 'item_id',
				title : 'ID',
				width : 150
			},*/ {
				field : 'item',
				title : '事项',
				width : 180
			}, {
				field : 'approval_time',
				title : '时间',
				width : 180
			}, {
				field : 'approval_sta',
				title : '状态',
				width : 220
			}, {
				field : 'approval_user',
				title : '节点人',
				width : 150
			}, {
				field : 'remark',
				title : '备注',
				width : 200
			} ] ],
			done : function(res, curr, count) {
				$("[data-field='remark']").children().each(function() {
					if ($(this).text() == 'N') {
						$(this).html('');
					}
				})
				$("[data-field='approval_sta']").children().each(function() {
				//立项
					if ($(this).text() == '1010') {
						$(this).html('<i>提交立项</i>');
					}else if ($(this).text() == '1012') {
						$(this).html('<a style="color:red">大区负责人驳回</a>');
					}else if ($(this).text() == '1020') {
						$(this).html('<a style="color:green">大区负责人通过</a>');
					}else if ($(this).text() == '1022') {
						$(this).html('<a style="color:red">管理员驳回</a>');
					}else if ($(this).text() == '1021') {
						$(this).html('<a style="color:green">管理员通过</a>');
					}else if ($(this).text() == '1030') {
						$(this).html('撤项');
					}
					//成本报销
					else if ($(this).text() == '2010') {
						$(this).html('<i>申请成本报销</i>');
					}else if ($(this).text() == '2012') {
						$(this).html('<a style="color:red">大区负责人驳回</a>');
					}else if ($(this).text() == '2020') {
						$(this).html('<a style="color:green">大区负责人通过</a>');
					}else if ($(this).text() == '2022') {
						$(this).html('<a style="color:red">管理员驳回</a>');
					}else if ($(this).text() == '2030') {
						$(this).html('<a style="color:green">管理员通过</a>');
					}else if ($(this).text() == '2032') {
						$(this).html('<a style="color:red">财务驳回</a>');
					}else if ($(this).text() == '2040') {
						$(this).html('<a style="color:green">财务通过</a>');
					}else if ($(this).text() == '2042') {
						$(this).html('<a style="color:red">BOSS驳回</a>');
					}else if ($(this).text() == '2041') {
						$(this).html('<a style="color:green">BOSS通过</a>');
					}
					
					//付款申请单
					else if ($(this).text() == '2110') {
						$(this).html('<i>申请付款申请单</i>');
					}else if ($(this).text() == '2112') {
						$(this).html('<a style="color:red">大区负责人驳回</a>');
					}else if ($(this).text() == '2120') {
						$(this).html('<a style="color:green">大区负责人通过</a>');
					}else if ($(this).text() == '2122') {
						$(this).html('<a style="color:red">管理员驳回</a>');
					}else if ($(this).text() == '2130') {
						$(this).html('<a style="color:green">管理员通过</a>');
					}else if ($(this).text() == '2132') {
						$(this).html('<a style="color:red">财务驳回</a>');
					}else if ($(this).text() == '2140') {
						$(this).html('<a style="color:green">财务通过</a>');
					}else if ($(this).text() == '2142') {
						$(this).html('<a style="color:red">BOSS驳回</a>');
					}else if ($(this).text() == '2141') {
						$(this).html('<a style="color:green">BOSS通过</a>');
					}
					//申请开票
					else if ($(this).text() == '2210') {
						$(this).html('<i>申请开票</i>');
					}else if ($(this).text() == '2211') {
						$(this).html('<a style="color:green">财务通过</a>');
					}else if ($(this).text() == '2212') {
						$(this).html('<a style="color:red">财务驳回</a>');
					}
		
					
					//申请结项
					else if ($(this).text() == '3010') {
						$(this).html('<i>申请结项</i>');
					}else if ($(this).text() == '3012') {
						$(this).html('<a style="color:red">大区负责人驳回</a>');
					}else if ($(this).text() == '3020') {
						$(this).html('<a style="color:green">大区负责人通过</a>');
					}else if ($(this).text() == '3022') {
						$(this).html('<a style="color:red">财务驳回</a>');
					}else if ($(this).text() == '3030') {
						$(this).html('<a style="color:green">财务通过</a>');
					}else if ($(this).text() == '3032') {
						$(this).html('<a style="color:red">管理员驳回</a>');
					}else if ($(this).text() == '3031') {
						$(this).html('<a style="color:green">管理员通过</a>');
					}
					//申请结项
					else if ($(this).text() == '4010') {
						$(this).html('<i>申请个人奖金分配</i>');
					}else if ($(this).text() == '4012') {
						$(this).html('<a style="color:red">大区负责人驳回</a>');
					}else if ($(this).text() == '4020') {
						$(this).html('<a style="color:green">大区负责人通过</a>');
					}else if ($(this).text() == '4022') {
						$(this).html('<a style="color:red">管理员驳回</a>');
					}else if ($(this).text() == '4030') {
						$(this).html('<a style="color:green">管理员通过</a>');
					}else if ($(this).text() == '4032') {
						$(this).html('<a style="color:red">BOSS驳回</a>');
					}else if ($(this).text() == '4040') {
						$(this).html('<a style="color:green">BOSS通过</a>');
					}else if ($(this).text() == '4042') {
						$(this).html('<a style="color:red">人资驳回</a>');
					}else if ($(this).text() == '4041') {
						$(this).html('<a style="color:green">人资通过</a>');
					}
					
					else if ($(this).text() == '9980') {
						$(this).html('<i>申请质保金回款审批</i>');
					}else if ($(this).text() == '9982') {
						$(this).html('<a style="color:red">质保金回款-财务驳回</a>');
					}else if ($(this).text() == '9998') {
						$(this).html('<b style="color:green">工程已结项-质保金已回款</b>');
					}
					
					else if ($(this).text() == '9999') {
						$(this).html('<b style="color:green">项目已结项</b>');
					}
					
				})
			}
		});
	})
</script>