<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
	<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
		<form class="layui-form  model-form" action="" id="up_div">
			<div class="layui-form-item">
				<label class="layui-form-label">
					选择进度
				</label>
				<div class="layui-input-block">
					<select name="project_progress" lay-verify="required" lay-filter="project_progress"
					id="project_progress">
					</select>
				</div>
			</div>
			<div id="is_have_returned_money_div" v-show="project_progress == 100">
				<div class="layui-form-item">
					<label class="layui-form-label">
						是否有质保金
					</label>
					<div class="layui-input-block">
						<input type="radio" name="returned_money_ishave" value="N" title="否" lay-filter="wcp_update_progress_radio"
						checked>
						<input type="radio" name="returned_money_ishave" value="Y" title="是" lay-filter="wcp_update_progress_radio">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						余料库存
					</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" v-bind:lay-verify="finshrequired"
						id="remaining_stock" name="remaining_stock" lay-verType="tips" autocomplete="off">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						已收款金额
					</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" v-bind:lay-verify="finshrequired"
						id="received_amount" name="received_amount" v-model.number="received_amount"
						lay-verType="tips" autocomplete="off">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						待收金额
					</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input layui-disabled" disabled  v-bind:lay-verify="finshrequired"
						id="amount_to_be_collected" v-model.number="amount_to_be_collected" name="amount_to_be_collected"
						lay-verType="tips" autocomplete="off" readOnly>
					</div>
				</div>
				<div v-show="checked == 'Y'">
					<div class="layui-form-item">
						<label class="layui-form-label">
							预估回款日期
						</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input" v-bind:lay-verify="required" id="returned_money_date"
							name="returned_money_date" lay-verType="tips">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">
							质保金点数
						</label>
						<div class="layui-input-block">
							<select name="returned_money_point" lay-filter="returned_money_point"
							id="returned_money_point" v-bind:lay-verify="required" lay-verType="tips"
							lay-search>
							</select>
						</div>
					</div>
				</div>
				<div>
					<div class="layui-form-item">
						<label class="layui-form-label">
							开票金额
						</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input layui-disabled" disabled placeholder="=本金+税额6~11%"
							v-model:number="kp" id="kp">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">
							项目报价
						</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input layui-disabled" disabled v-model:number="project_quotation"
							id="project_quotation">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">
							备注
						</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input" v-bind:placeholder="remark_placeholder"
							v-bind:lay-verify="remark_required" id="remark" name="remark" lay-verType="tips">
						</div>
					</div>
				</div>
			</div>
			<div class="layui-form-item model-form-footer">
				<button class="layui-btn btn_class" lay-filter="user-form-submit" id="save_btn"
				lay-submit>
					保存进度
				</button>
				<button class="layui-btn  layui-btn-primary btn_class" lay-filter="user-form-submit" id="advance_payment_request_btn">
					提前付款申请
				</button>
			</div>
		</form>
		<script type="text/html" id="upload_files_table_bar">
			<a class = "layui-btn layui-btn-danger layui-btn-xs  btn_class" lay-event="del"> 删除 </a>
		</script>
		<script type="text/javascript">
			layui.use(['laydate', 'carousel', 'layer', 'form', 'admin', 'jquery'],
			function() {

				var $ = layui.jquery,
				laydate = layui.laydate,
				carousel = layui.carousel,
				admin = layui.admin,
				form = layui.form,
				layer = layui.layer;

				var project_code = admin.getTempData('project_code');
				var project_progress = admin.getTempData('project_progress');
				var vm = new Vue({
					el: '#up_div',
					data: {
						project_progress: project_progress,
						required: 'N',
						remark_required: 'N',
						checked: 'N',
						finshrequired: 'N',
						remark_required: 'N',
						amount_to_be_collected: 0,
						received_amount: 0,
						remark_placeholder: ''
						//,full_amount_of_tax:0
						,
						kp: 0,
						project_quotation: 0
					},
					watch: {
						received_amount: function(val) {
							this.amount_to_be_collected = (this.project_quotation - val).toFixed(2);
						}
					},
					computed: {

					},
				});

				//通过项目编码获取相关信息
				$.post("queryWCProjectsSimpleDetailAllInfoByProjectCode", {
					project_code: admin.getTempData('project_code')
				},function(data) {
					if (data.code == 1) {
						layer.msg(data.info);
					} else {
						//vm.full_amount_of_tax = data.info[0].full_amount_of_tax;
						vm.kp = (data.info[0].principal * 1 + data.info[0].tax_money * 1).toFixed(2);
						vm.project_quotation = data.info[0].project_quotation;
						vm.amount_to_be_collected = vm.project_quotation;
						if (vm.kp != vm.project_quotation) {
							remark_required = 'required';
							this.remark_placeholder = '[开票金额]与[项目报价]不一致，请说明原因';
						} else {
							remark_required = 'N';
						}
					}
				},'json');
				var select = "";
				var dis = true;

				//下拉框初始化
				var mycars = new Array();
				mycars[0] = "0,未开工";
				mycars[1] = "30,已开工30%";
				mycars[2] = "70,已开工70%";
				mycars[3] = "90,已竣工";
				mycars[4] = "99,已验收";
				mycars[5] = "100,结项";
				for (var a = 0; a < mycars.length; a++) {
					var value = mycars[a].split(",")[0];
					var text = mycars[a].split(",")[1];
					if (dis == true) {
						if (project_progress == value) {
							select += "<option value=" + value + " selected>" + text + "</option>";
							dis = false;
							if (value == 100) {
								$("#save_btn").text("申请结项");
								vm.finshrequired = "required";
								//通过项目编码获取相关信息
								$.post("querySimpleInfoByProject_code", {
									project_code: admin.getTempData('project_code')
								},
								function(data) {
									if (data.code == 1) {
										layer.alert(data.info);
										$("#save_btn").addClass("layui-btn-disabled").attr("disabled", "disabled");
									}
								},
								'json');
							} else {
								$("#save_btn").text("保存进度");
								vm.finshrequired = "N";
							}
						} else {
							select += "<option value=" + value + " disabled>" + text + "</option>";
						}
					} else {
						select += "<option value=" + value + ">" + text + "</option>";
					}
				}
				$("#project_progress").html(select);
				//下拉框初始化
				var returned_money_poin_select = "<option></option>";
				for (var a = 0; a < 100; a++) {
					var value = a * 0.01;
					var text = a + "%";
					if (value == 0.05) {
						returned_money_poin_select += "<option value=" + value + " selected>" + text + "</option>";
					} else {
						returned_money_poin_select += "<option value=" + value + ">" + text + "</option>";
					}
				}
				$("#returned_money_point").html(returned_money_poin_select);
				form.render();
				//下拉框事件
				form.on('select(project_progress)',
				function(data) {
					project_progress = data.value;
					vm.project_progress = data.value;
					if (data.value == 100) {
						//通过项目编码获取相关信息
						$("#save_btn").text("申请结项");
						vm.finshrequired = "required";
						$.post("querySimpleInfoByProject_code", {
							project_code: admin.getTempData('project_code')
						},
						function(data) {
							if (data.code == 1) {
								layer.alert(data.info);
								$("#save_btn").addClass("layui-btn-disabled").attr("disabled", "disabled");
							}else{
								$("#save_btn").removeClass("layui-btn-disabled").removeAttr("disabled");
							}
						},
						'json');
					} else {
						$("#save_btn").text("保存");
						vm.finshrequired = "N";
					}
				});
				form.on('select(returned_money_point)',
				function(data) {
					vm.returned_money_point = data.value;
				});
				//单选框事件
				form.on('radio(wcp_update_progress_radio)',
				function(data) {
					console.log(data.value);
					vm.checked = data.value;
					console.log("单选框事件vm.checked=" + vm.checked);
					if (data.value == "N") {
						vm.required = 'N';
					} else if (data.value == "Y") {
						vm.required = 'required';
					}
					console.log('单选框事件vm.project_progress=' + vm.project_progress);
					console.log('单选框事件vm.required=' + vm.required);

					laydate.render({
						elem: '#returned_money_date',
						istime: false,
						value: new Date()
					});
				});

				//提交更新
				form.on('submit(user-form-submit)',
				function(data) {
					var returned_money_ishave = null,
					returned_money_date = null,
					returned_money_point = null;
					if (project_progress == 100) {
						if (vm.required == 'N') {
							returned_money_ishave = data.field.returned_money_ishave;
						} else {
							returned_money_ishave = data.field.returned_money_ishave;
							returned_money_date = data.field.returned_money_date;
							returned_money_point = data.field.returned_money_point;
						}
						if (vm.amount_to_be_collected < 0 || vm.amount_to_be_collected == 'NaN') {
							layer.msg("[待收金额]数据异常");
							return false;
						}
						if (data.field.returned_money_ishave == 'Y') {
							if ((vm.amount_to_be_collected / vm.kp).toFixed(2) != data.field.returned_money_point) {
								if (data.field.remark == '') {
									layer.alert("[待收金额" + vm.amount_to_be_collected + "]÷[开票金额" + vm.kp + "]=" + (vm.amount_to_be_collected / vm.kp).toFixed(2) + ",不等于所选择的质保金比例:" + data.field.returned_money_point + ",请说明原因");
									//this.remark_placeholder='[待收金额]÷[开票金额]不等于5%，请说明原因';
									return false;
								}
							}
						}
						if (data.field.returned_money_ishave == 'N' && vm.amount_to_be_collected != 0) {
							if (data.field.remark == '') {

								layer.msg("无质保金，待收金额不为0,请说明原因");
								return false;
							}
						}
					}
					console.log("returned_money_ishave=" + returned_money_ishave);
					console.log("returned_money_date=" + returned_money_date);
					console.log("returned_money_point=" + returned_money_point);
					admin.ajax_load_json({
						url: 'updataWeakCurrentProjectsDetailProgressByProjectCode',
						data: {
							project_progress: project_progress,
							project_code: project_code,
							returned_money_ishave: returned_money_ishave,
							returned_money_date: returned_money_date,
							returned_money_point: returned_money_point,
							remaining_stock: data.field.remaining_stock,
							received_amount: data.field.received_amount,
							amount_to_be_collected: data.field.amount_to_be_collected,
							project_progress_remake: data.field.remark
						},
						success: function(data) {
							if (data.code == 0) {
								layer.closeAll();
								layer.msg(data.info, {
									icon: 1
								});
							} else {
								layer.closeAll('loading');
								layer.alert(data.info, {
									icon: 5
								});
							}
						}
					});
					return false;
				});
				function keepTwoDecimal(num) {
					var result = parseFloat(num);
					result = Math.round(num * 100) / 100;
					return result;
				}

			});
</script>