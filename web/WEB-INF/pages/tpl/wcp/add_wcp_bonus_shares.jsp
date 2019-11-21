<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="layui-row layui-col-space15" id="wcp_add_bonus_shares_div_vue">
	<div class="layui-col-xs4 layui-col-md4">
		<div class="layui-card">
			<div class="layui-card-header">
				<span class="layui-badge layui-bg-cyan">
					奖金：{{personal}}-可分配奖金:{{kefenpei}}-质保金比例：{{returned_money_point}}
					- 责任人：{{project_leader}} </span>
			</div>
			<div class="layui-card-body">
				<div class="layui-step">
					<div class="layui-step-content layui-clear">
						<div class="layui-step-content-item">
							<form class="layui-form" action="" onsubmit="return false">
						<div class="layui-form-item">
							<label class="layui-form-label">
								用户工号
							</label>
							<div class="layui-input-inline">
								<input type="text" name="user_id" required lay-verify="required" autocomplete="off"
								class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								用户姓名
							</label>
							<div class="layui-input-inline">
								<input type="text" name="user_name" required lay-verify="required" autocomplete="off"
								class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								占比
							</label>
							<div class="layui-input-inline">
								<input type="text" name="proportion" required lay-verify="required|max_num"
								placeholder="请输入标题" autocomplete="off" class="layui-input"
								v-model.number="input_proportion">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								奖金金额
							</label>
							<div class="layui-input-inline">
								<input type="text" name="money" required lay-verify="required" autocomplete="off"
								class="layui-input" v-model.number="input_money" disabled>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">
								质保金金额
							</label>
							<div class="layui-input-inline">
								<input type="text" name="returned_money" required lay-verify="required" autocomplete="off"
								class="layui-input" v-model.number="input_returned_money" disabled>
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-input-block">
								<button class="layui-btn layui-btn-disabled" lay-submit lay-filter="add_wcp_bonus_shares_table_formdemo"
								id="add_to_table" disabled>
									可分配奖金为0
								</button>
							</div>
						</div>
					</form>
							<div class="layui-step-btn">
								<div class="layui-btn-group">
									<button class="layui-btn next">
										下一步
									</button>
								</div>
							</div>
						</div>
						<div class="layui-step-content-item">
							按组分配，分配比例=剩余分配比例/组员人数
							<form id="addUser_Form">
								<div class="layui-form-item">
									<label class="layui-form-label">
										组员人数
									</label>
									<div class="layui-input-inline">
										<input type="number" name="userCounts" id="userCounts" required
											lay-verify="required" autocomplete="off" class="layui-input">
										<button class="layui-btn addUser  layui-btn-primary" id="creatButtonAndClear">
											生成输入框
										</button>
									</div>
								</div>
								<hr />
								<div id="addUser_Div">
								</div>
								<div class="layui-step-btn">
								<div class="layui-btn-group">
									<button class="layui-btn prev layui-btn-primary ">
										上一步
									</button>
									<button class="layui-btn" lay-submit
										lay-filter="formDemoaddUser">
										下一步
									</button>
								</div>
							</div>
							</form>
							
						</div>
						<div class="layui-step-content-item">
							<div class="layui-step-btn">
								<div class="layui-btn-group">
									<button class="layui-btn  layui-btn-primary goFirst">
										第一步
									</button>
									<button class="layui-btn  layui-btn-primary prev">
										上一步
									</button>
									<button class="layui-btn layui-btn-disabled"
										data-type="getCheckData"
										id="getTableInfoToAdd_wcp_actual_expenditure" disabled>
										分配完成
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs8 layui-col-md8">
		<div class="layui-card">
			<div class="layui-card-header">
				<span class="layui-badge layui-bg-cyan"> 已分配
					{{people_number}} 人 - 剩余可分配比例：{{max_number}} </span>
			</div>
			<div class="layui-card-body">
				
				<table class="layui-hide" id="add_wcp_bonus_shares_table" lay-filter="add_wcp_bonus_shares_table_filter">
					</table>
			</div>
		</div>
	</div>
</div>

	<script type="text/html" id="barDemo">
		<a class = "layui-btn layui-btn-danger layui-btn-xs" lay-event = "del" > 删除 </a>
	</script>
<script type="text/javascript">
		layui.use(['form', 'table', 'layer', 'admin', 'jquery','step'],
		function() {
			var form = layui.form,
			$ = layui.jquery,
			layer = layui.layer,
			admin = layui.admin,
			step = layui.step,
			table = layui.table;
			//表格缓存数据:用于存放添加或删除表格数据操作时的数据
			var add_wcp_bonus_shares_table_oldData;
			//表格缓存数据数组
			var add_wcp_bonus_shares_table_tableData = new Array();
			//步骤插件
			step.render({
				elem: '.layui-step',
				description: ["按个人分配", "按组分配 ", "提交数据"],
				currentStep: 1,
				//canIconClick: true,
				isOpenStepLevel: true
			});
			//个人奖金
			var personal = 0;
			
			
			
			//VUE定义
			var vm = new Vue({
				el: '#wcp_add_bonus_shares_div_vue',
				data: {
					project_code: admin.getTempData('project_code'),
					max_number: 100.00,
					people_number: 0,
					personal: personal,
					input_money: 0,
					input_proportion: 0,
					input_returned_money:0,
					group_input_returned_money:0,
					data_field_money: 0,//提交数据时负责人的金额
					data_field_returned_money: 0,
					project_leader: '',
					returned_money_point:0,
					returned_money:0,
					kefenpei:0,
					sum_money:0,
				},
				watch: {
					input_proportion: function(val) {
						this.input_proportion = val;
						this.input_money = (val * this.kefenpei * 0.01).toFixed(2);
						this.input_returned_money = (val * this.returned_money * 0.01).toFixed(2);
					}
				}
			})
			//表格初始化
			table.render({
	    		id: 'add_wcp_bonus_shares_table',
				elem: '#add_wcp_bonus_shares_table',
				data: add_wcp_bonus_shares_table_tableData,
				totalRow: true,
				page: true,
				limit: 999 //设置每页显示条数
				,
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
				},
				{
					field: null,
					title: '操作',
					templet: '#barDemo',
				}]],
				done: function(res, curr, count) {
					var e_proportion=$("#add_wcp_bonus_shares_table").next().find('.layui-table-total').find('td[data-field="proportion"] div').text()*1;
					var e_money = $("#add_wcp_bonus_shares_table").next().find('.layui-table-total').find('td[data-field="money"] div').text()*1;
					var e_returned_money = $("#add_wcp_bonus_shares_table").next().find('.layui-table-total').find('td[data-field="returned_money"] div').text()*1;
					vm.sum_money=e_money+e_returned_money;
					differential_value=(vm.sum_money-vm.personal).toFixed(2);
					if (vm.max_number==0&&vm.sum_money!=vm.personal) {
						if(vm.sum_money>vm.personal){
						layer.alert("总奖金("+vm.personal+")比实际分配金额("+vm.sum_money+")少"+(vm.sum_money-vm.personal).toFixed(2)+"，提交数据后会自动从负责人奖金中扣除");
							//vm.data_field_money = vm.data_field_money-(vm.sum_money-vm.personal).toFixed(2);
						}else{
						layer.alert("总奖金("+vm.personal+")比实际分配金额("+vm.sum_money+")多"+(vm.personal-vm.sum_money).toFixed(2)+"，提交数据后会自动加到负责人奖金中");
							//vm.data_field_money = vm.data_field_money+(vm.personal-vm.sum_money).toFixed(2);
						}
						//console.log("负责人的奖金vm.data_field_money",vm.data_field_money);
					}else if(vm.max_number==0){
						$('#add_to_table').addClass("layui-btn-disabled").attr("disabled", "disabled");
						$('#getTableInfoToAdd_wcp_actual_expenditure').removeClass("layui-btn-disabled").removeAttr("disabled");
					}
				}
			});
			//监听工具条
			table.on('tool(add_wcp_bonus_shares_table_filter)',
			function(obj) {
				var data = obj.data;
				if (obj.event === 'del') {
					layer.confirm('确定删除吗',
					function(index) {
						obj.del();
						$("#addUser_Div").html('');
						$("#userCounts").val('');
						addUserCount = 0;
						errCount=0;
						$("#userCounts").removeClass("class", "layui-disabled").attr("class", "layui-input").removeAttr("disabled");
						$("#creatButtonAndClear").text("生成输入框");
						vm.max_number = vm.max_number* 1 + data.proportion * 1;
						vm.people_number--;
						layer.close(index);
						add_wcp_bonus_shares_table_oldData = table.cache["add_wcp_bonus_shares_table"];
						table.reload('add_wcp_bonus_shares_table', {
							data: add_wcp_bonus_shares_table_oldData,
							page: false
						});
						form.verify({
							max_num: function(value, item) {
								if (value*1 <= 0 || value*1 > vm.max_number*1) {
									return '分配比例不可小于等于0或大于' + vm.max_number*1;
								}
							}
						});
						if(vm.max_number!=0){
							$('#add_to_table').removeClass("layui-btn-disabled").removeAttr("disabled");
							$('#getTableInfoToAdd_wcp_actual_expenditure').addClass("layui-btn-disabled").attr("disabled", "disabled");
						}
					});
				}
			});
			//通过项目编码获取相关信息
			$.post("queryWCProjectsSimpleDetailAllInfoByProjectCode", {
				project_code: admin.getTempData('project_code')
			},
			function(data) {
				if (data.code == 1) {
					layer.msg(data.info);
				} else {
					personal = data.info[0].personal;
					vm.project_leader = data.info[0].project_leader;
					vm.personal = data.info[0].personal;
					vm.returned_money_point=data.info[0].returned_money_point;
					vm.returned_money=(personal*vm.returned_money_point).toFixed(2);
					vm.kefenpei = (personal - personal*vm.returned_money_point).toFixed(2);
					if (personal > 0) {
						$('#add_to_table').removeClass("layui-btn-disabled").removeAttr("disabled").text("添加到表格");
					}
				}
			},
			'json');
			//是否进行过奖金分配
			$.post("isHaveWeakCurrentProjectsBonusSharesBean", {
				project_code: vm.project_code
			},
			function(data) {
				if (data.code == 1) {
					layer.alert(data.info, {
								icon:5
							});
				} else {
					if(data.info!=0){
					layer.alert("已进行过奖金分配，如果再次分配，会将上次分配的方案取消", {icon: 0});
					}
				}
			},
			'json');
			

			
			form.verify({
				max_num: function(value, item) {
					if (value*1 <= 0 || value*1 > vm.max_number*1) {
						return '分配比例不可小于0或大于' + vm.max_number*1;
					}
				}
			});

			//添加个人分配数据到表格
			form.on('submit(add_wcp_bonus_shares_table_formdemo)',function(data) {
				add_wcp_bonus_shares_table_oldData = table.cache["add_wcp_bonus_shares_table"];
				var isHave = false;
				for (var a = 0; a < add_wcp_bonus_shares_table_oldData.length; a++) {
					if (data.field.user_id == add_wcp_bonus_shares_table_oldData[a].user_id) {
						layer.msg("用户工号" + data.field.user_id + "已存在");
						isHave = true;
					}
				}
				if (!isHave) {
				console.log(data.field.user_id +" == "+ vm.project_leader + "="+(data.field.user_id == vm.project_leader));
					var data1 = {};
					/*//添加的用户为负责人
					if (data.field.user_name == vm.project_leader) {
						console.log("添加的用户为负责人");
						vm.data_field_money = data.field.money;
					}*/
					data1 = {
						"user_id": data.field.user_id,
						"user_name": data.field.user_name,
						"proportion": data.field.proportion,
						"money": data.field.money,
						"returned_money": data.field.returned_money
					}
					add_wcp_bonus_shares_table_oldData.push(data1);
					table.reload('add_wcp_bonus_shares_table', {
						data: add_wcp_bonus_shares_table_oldData,
						page: false
					});
					vm.max_number = (vm.max_number*1 - data.field.proportion * 1).toFixed(2);
					vm.people_number++;
					form.verify({
							max_num: function(value, item) {
								if (value*1 <= 0 || value*1 > vm.max_number*1) {
									return '分配比例不可小于等于0或大于' + vm.max_number*1;
								}
							}
					});
					if (vm.max_number*1 == 0) {
						$('#getTableInfoToAdd_wcp_actual_expenditure').removeClass("layui-btn-disabled").removeAttr("disabled");
						$('#add_to_table').addClass("layui-btn-disabled").attr("disabled", "disabled");
					}
					$("input").val("");
					vm.input_proportion=0;
					vm.input_money=0;
					vm.input_returned_money=0;
				}
				return false;
			});
			
			
			//组成员人数
			var addUserCount = 0;
			//组成员人数数据错误的数量
			var errCount=0;
			//组员数据
			var time = "";
			$(".addUser").on("click",
			function() {
			if(($("#creatButtonAndClear").text().trim()=="生成输入框")){
				if(vm.max_number==0){
					step.goLast();
					$("#userCounts").val('');
					layer.msg('可分配比例为0，不可再添加组员');
					return false;
				}
				var userCounts = $("#userCounts").val();
				if(userCounts==""){
					layer.msg('组员人数不可为空');
					return false;
				}else{
					var div = "";
					for (; addUserCount < userCounts; addUserCount++) {
						div += '<div id="' + addUserCount + '">' + '<div class="layui-form-item" >' + '<label class="layui-form-label">用户工号</label>' + '<div class="layui-input-inline">' + '<input type="text" name="user_id' + addUserCount + '"  id="user_id' + addUserCount + '" required lay-verify="required" autocomplete="off" class="layui-input">' + '</div>' + '</div>' + '<div class="layui-form-item"><label class="layui-form-label">用户姓名</label>' + '<div class="layui-input-inline">' + '<input type="text" name="user_name' + addUserCount + '"  id="user_name' + addUserCount + '" required lay-verify="required" autocomplete="off" class="layui-input">' + '</div>' + '</div></div><hr/>';
					}
					$("#addUser_Div").html(div);
					$("#userCounts").attr("class", "layui-input layui-disabled").attr("disabled","disabled");
					$("#creatButtonAndClear").text("清空");
				}
			}else if(($("#creatButtonAndClear").text().trim()=="清空")){
				$("#addUser_Div").html('');
				$("#userCounts").val('');
				addUserCount = 0;
				errCount=0;
				$("#userCounts").removeClass("class", "layui-disabled").attr("class", "layui-input").removeAttr("disabled");
				$("#creatButtonAndClear").text("生成输入框");
			}
				return false;
			});
			$(".goFirst").on("click",//第一步
			function() {
				step.goFirst();
			});
			$(".prev").on("click",//上一步
			function() {
				step.prev();
			});
			$(".next").on("click",//下一步
			function() {
				step.next();
				if(vm.max_number==0){
					step.goLast();
				}
				$("#addUser_Div").html('');
				$("#userCounts").val('');
				addUserCount = 0;
				errCount=0;
				$("#userCounts").removeClass("class", "layui-disabled").attr("class", "layui-input").removeAttr("disabled");
				$("#creatButtonAndClear").text("生成输入框");
			});
			$(".goLast").on("click",//最后一步
			function() {
				step.goLast();
			});

			//监听组成员提交按钮
			form.on('submit(formDemoaddUser)',
			function(data) {
				time = "";
				for (var a = 0; a < addUserCount; a++) {
					if(typeof($("#user_id" + a).val())=="undefined"||typeof($("#user_name" + a).val())=="undefined"){
						//数据不存在
					}else if($("#user_id" + a).val()==""||$("#user_name" + a).val()==""){
						errCount++;
					}else{
						time+=$("#user_id" + a).val()+","+$("#user_name" + a).val()+"<br/>";
					}
				}
				if(time==""&&errCount!=0){
					layer.msg("组员信息填写不完整");
				}else if(time!=""&&errCount!=0){
					layer.msg("组员信息填写不完整");
				}else if(time!=""&&errCount==0){
					//添加表格现有数据
					add_wcp_bonus_shares_table_oldData = table.cache["add_wcp_bonus_shares_table"];
					//分配到每个组员的比例
					console.log('vm.max_number',vm.max_number);
					console.log('$("#userCounts").val();',$("#userCounts").val());
					var proportion=(vm.max_number/$("#userCounts").val()).toFixed(2),
					money=(vm.kefenpei*proportion*0.01).toFixed(2),
					returned_money=(proportion * vm.returned_money * 0.01).toFixed(2);
					var data1 = {};
					for (var a = 0; a < addUserCount; a++) {
						data1 = {
						"user_id": $("#user_id" + a).val(),
						"user_name": $("#user_name" + a).val(),
						"proportion": proportion,
						"money": money,
						"returned_money": returned_money
						};
						vm.people_number++;
						add_wcp_bonus_shares_table_oldData.push(data1);
					}
					//添加数据到表格
					console.log('add_wcp_bonus_shares_table_oldData',add_wcp_bonus_shares_table_oldData);
					table.reload('add_wcp_bonus_shares_table', {
						data: add_wcp_bonus_shares_table_oldData,
						page: false
					});
					vm.max_number = 0;
					
					form.verify({
						max_num: function(value, item) {
							if (value*1 <= 0 || value*1 > vm.max_number*1) {
								return '分配比例不可小于等于0或大于' + vm.max_number*1;
							}
						}
					});
					if (vm.max_number*1 == 0) {
						$('#getTableInfoToAdd_wcp_actual_expenditure').removeClass("layui-btn-disabled").removeAttr("disabled");
						$('#add_to_table').addClass("layui-btn-disabled").attr("disabled", "disabled");
					}
					step.next();
				}else if(time==""&&errCount==0){
					step.next();
				}
				return false;
			});

			//提交表格数据
			$("#getTableInfoToAdd_wcp_actual_expenditure").click(function() {
				for(var i= 0 ; i< add_wcp_bonus_shares_table_oldData.length;i++){
				   if(add_wcp_bonus_shares_table_oldData[i] == "" || typeof(add_wcp_bonus_shares_table_oldData[i]) == "undefined")
                    {
                        add_wcp_bonus_shares_table_oldData.splice(i,1);
                        i= i-1;
                    }
				}
				console.log("add_wcp_bonus_shares_table_oldData",add_wcp_bonus_shares_table_oldData);
				var up_str = "{\"project_code\":\"" + vm.project_code + 
				"\",\"sum_money\":\"" + vm.sum_money +
				 "\",\"personal\":\"" + vm.personal + 
				 "\",\"project_leader\":\"" + vm.project_leader + 
				 "\",\"data\":" + arrayToJson(add_wcp_bonus_shares_table_oldData) + "}";
				console.log(up_str);
				admin.ajax_load_json({
					url: "addWeakCurrentProjectsBonusSharesBean",
					data: {
						info: up_str
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
				
				return false;
			});

		});
		
		//数组转json
		function arrayToJson(o) {
			//console.log("o",o);
			var r = [];
			if (typeof o == "string"){
				return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
			}
			if (typeof o == "object") {
				if (!o.sort) {
					for (var i in o) r.push("\"" + i + "\":" + arrayToJson(o[i]));
					if ( !! document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
						r.push("toString:" + o.toString.toString());
					}
					r = "{" + r.join() + "}";
				} else {
					for (var i = 0; i < o.length; i++) {
						r.push(arrayToJson(o[i]));
					}
					r = "[" + r.join() + "]";
				}
				return r;
			}
			return o.toString();
		}
	</script>