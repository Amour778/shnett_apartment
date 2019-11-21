<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
	<div class="layui-row" id="wcp_bonus_shares_div_vue">
		<div>
			<div class="layui-card">
			<div class="layui-card-header">
					<span class="layui-badge layui-bg-cyan">
						奖金：{{personal}}-可分配奖金:{{kefenpei}}- 质保金比例：{{returned_money_point}}- 质保金金额：{{(personal*returned_money_point).toFixed(2)}} - 责任人：{{project_leader}}
					</span>
				</div>
				<div class="layui-card-body">
					<table class="layui-hide" id="pending_audit_wcp_bonus_shares_table"></table>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
		layui.use(['form', 'table', 'layer', 'admin', 'jquery'],
		function() {
			var form = layui.form,
			$ = layui.jquery,
			layer = layui.layer,
			admin = layui.admin,
			table = layui.table;
			
			//VUE定义
			var vm = new Vue({
				el: '#wcp_bonus_shares_div_vue',
				data: {
					project_code: admin.getTempData('project_code'),
					kefenpei: 0,
					personal: 0,
					returned_money_point:0,
					project_leader: ''
				}
			})
			
			
			//通过项目编码获取相关信息
			$.post("queryWCProjectsSimpleDetailAllInfoByProjectCode", {
				project_code: admin.getTempData('project_code')
			},
			function(data) {
				if (data.code == 1) {
					layer.msg(data.info);
				} else {
					console.log("data.info[0].personal="+data.info[0].personal);
					vm.personal = data.info[0].personal;
					vm.returned_money_point = data.info[0].returned_money_point;
					vm.kefenpei = (data.info[0].personal-data.info[0].personal * data.info[0].returned_money_point).toFixed(2);
					console.log("vm.personal="+vm.personal);
					vm.project_leader = data.info[0].project_leader;
					//表格初始化
			table.render({
				elem: '#pending_audit_wcp_bonus_shares_table',
				where: {
					project_code: vm.project_code
				},
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				totalRow: true,
				method:'POST',
				url:'queryWeakCurrentProjectsBonusSharesBeanInfoByProjectCodeAndType',
				limit: 999,
				limits:[999],
				cols: [[{
					field: 'user_id',
					title: '工号'
				},
				{
					field: 'user_name',
					title: '姓名'
				},
				{
					field: 'proportion',
					title: '占比',
					totalRow: true
				},
				{
					field: 'money',
					title: '奖金金额',
					totalRow: true
				},
				{
					field: 'returned_money',
					title: '质保金金额',
					totalRow: true
				}]],
				done: function(res, curr, count) {
					var e_money = $("#pending_audit_wcp_bonus_shares_table").next().find('.layui-table-total').find('td[data-field="money"] div').text();
					var e_returned_money = $("#pending_audit_wcp_bonus_shares_table").next().find('.layui-table-total').find('td[data-field="returned_money"] div').text();
					console.log("e_money",e_money);
					console.log("e_returned_money",e_returned_money);
					if ((e_money*1 + e_returned_money*1) != vm.personal) {
						layer.alert("可分配金额("+vm.personal+")与实际分配的总金额("+(e_money*1 + e_returned_money*1)+")不相同，二者相差："+(vm.personal-(e_money*1 + e_returned_money*1)).toFixed(2),{icon:5});
					}

				}
			});
					
				}
			},
			'json');
		});
	</script>