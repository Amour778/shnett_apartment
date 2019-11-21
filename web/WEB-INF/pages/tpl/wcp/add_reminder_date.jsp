<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"
%>
	<div id="wcp_bonus_shares_div_vue">
		<div class="layui-card">
			<div class="layui-card-body">
				<form class="layui-form" action="" onsubmit="return false" lay-filter="_add_reminder_date_filter" id="_add_reminder_date">
					<div class="layui-form-item">
						<label class="layui-form-label">应回款金额</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input" name="system_returned_money"   readOnly  v-model.number="system_returned_money">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">回款金额</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input" name="returned_money" id="returned_money" lay-verify="equals_system"  v-model.number="returned_money">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">备注</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input" placeholder="回款金额与系统中记录的质保金不符时，必填" 
							v-bind:lay-verify="required_returned_money_remark" name="returned_money_remark" id="returned_money_remark">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">
						</label>
						<div class="layui-input-inline">
							<button class="layui-btn" lay-submit lay-filter="edit_reminder_date_filter">
								提交
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		layui.use(['jquery', 'layer', 'form', 'admin', 'laydate'],
		function() {
			var $ = layui.jquery,
			layer = layui.layer,
			form = layui.form,
			admin = layui.admin,
			laydate = layui.laydate;
			
			var vm =null;
			admin.ajax_load_json({
				url: 'queryWCPDSystemReturnedMoneyByProjectCode',
				data: {
					project_code: admin.getTempData('project_code')
				},
				success: function(obj, status, xhr) {
					if (obj.code == 0) {
					vm = new Vue({
						el: '#_add_reminder_date',
						data: {
							system_returned_money: 0,//系统记录的质保金金额
							returned_money:0,//用户录入的质保金金额
							required_returned_money_remark:'N'
						}
						,watch: {
							returned_money: function(val) {
								console.log("1-this.required_returned_money_remark",this.required_returned_money_remark);
								if(val!=0&&this.system_returned_money!=0&&val!=this.system_returned_money){
									this.required_returned_money_remark="required";
								}else{
								this.required_returned_money_remark="N";
								}
								console.log("2-this.required_returned_money_remark",this.required_returned_money_remark);
							}
						}
					});
					vm.system_returned_money=obj.info*1;
					} else {
						layer.alert(obj.info, {
							icon: 5
						});
					}
				}
			});
			form.on('submit(edit_reminder_date_filter)',function(data) {
				admin.ajax_load_json({
					url: 'updataWCPD_RM_AndRemarkByProjectCode',
					data: {
						project_code: admin.getTempData('project_code'),
						returned_money: data.field.returned_money,
						returned_money_remark: data.field.returned_money_remark
					},
					success: function(obj, status, xhr) {
						if (obj.code == 0) {
							layer.closeAll();
							layer.msg(obj.info, {
								icon: 1
							});

						} else {
							layer.alert(obj.info, {
								icon: 5
							});
						}
					}
				});
				return false;
			});

		});
	</script>