<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"
%>
	<div>
		<div class="layui-card">
			<div class="layui-card-body">
				<form class="layui-form" action="" onsubmit="return false" lay-filter="_edit_reminder_date_form">
					<div class="layui-form-mid layui-word-aux" id="returned_money_date">
					</div>
					<div class="layui-form-item">
					<div class="layui-form-mid layui-word-aux">
						质保金回款的日期
					</div>
						<div class="layui-input-inline disabled">
							<input type="text" class="layui-input" name="reminder_date" id="reminder_date">
						</div>
					</div>
				</form>
			</div>
		</div>
		 <div class="layui-form-item model-form-footer" id="pending_reminder_date_btn" style="float:right">
		     <button class="layui-btn" data-method="pending_agree" type="button">通过</button>
		     <button class="layui-btn layui-btn-danger" data-method="pending_reject">驳回</button>
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
			var user_select_date="";
			admin.ajax_load_json({
				url: 'queryWCPSDReturnedMoneyDateInfoByProjectCode',
				data: {
					project_code: admin.getTempData('project_code')
				},
				success: function(obj, status, xhr) {
					if (obj.code == 0) {
						var arr = obj.info.split(",");
						var returned_money_date = arr[0]; //预计回款日期
						$("#returned_money_date").html("预计回款日期:" + returned_money_date);
						var reminder_date = arr[1]; //实际回款日期
						if (reminder_date != "") {
							laydate.render({
								elem: '#reminder_date',
								value: new Date(),
								done: function(value, date, endDate){
								    user_select_date=value;
								}
							})
						} else {
							laydate.render({
								elem: '#reminder_date',
								value: reminder_date,
								done: function(value, date, endDate){
								    user_select_date=value;
								}
							})
						}

					} else {
						layer.alert(obj.info, {
							icon: 5
						});
					}
				}
			});
			$('#pending_reminder_date_btn .layui-btn').on('click', function(){
		    var othis = $(this), method = othis.data('method');
		    active[method] ? active[method].call(this, othis) : '';
		  });
		  //触发事件
		  var active = {
		   pending_agree: function(){
		   		ajax_info(user_select_date, "9998");
		   }
		   ,pending_reject: function(){
		   	layer.confirm('确定驳回吗？', {btn: ['确定','取消']}, function(){
		   		ajax_info("", "9982");
		     })
		   }
		   }

		function ajax_info(reminder_date, audit_status){
		      	admin.ajax_load_json({
					url: "updataWCPD_RD_ByProjectCode",
					data: {
						audit_status : audit_status,
						reminder_date :reminder_date,
						project_code : admin.getTempData('project_code')
					},
					beforeSend: function() {
						layer.load(0);
					},
					success: function(obj) {
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
		}
		});
	</script>