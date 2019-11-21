<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>

<form class="layui-form layui-form-pane" lay-filter="formTest"  id = "cost_estimation">
<div class="layui-row layui-col-space15">
	<div class="layui-col-lg6 layui-col-md6">
		<div class="layui-card">
			<div class="layui-card-header">
				基础信息
			</div>
			<div class="layui-card-body">
				<div class="layui-form-item">
					<label class="layui-form-label">
						项目区部*
					</label>
					<div class="layui-input-block">
							<select name="project_area_department" required lay-verify="required" lay-filter="project_area_department" id="project_area_department"></select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						区部名称*
					</label>
					<div class="layui-input-block">
						<input type="text" name="district_name" required
							lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						项目分类*
					</label>
					<div class="layui-input-block">
						<select name="item_classification" id="item_classification" lay-verify="required"
							lay-search>
						</select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						客户名称*
					</label>
					<div class="layui-input-block">
						<input type="text" name="ustomer_name" required
							lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item" lay-tips="计划启动时间*">
					<label class="layui-form-label">
						计划启动时间*
					</label>
					<div class="layui-input-block" >
						<input type="text" name="planned_start_time" required
							lay-verify="required" autocomplete="off" class="layui-input"
							id="planned_start_time">
					</div>
				</div>
				<div class="layui-form-item"  lay-tips="预计完成时间">
					<label class="layui-form-label">
						预计完成时间
					</label>
					<div class="layui-input-block">
						<input type="text" name="planned_end_time"  autocomplete="off" class="layui-input"
							id="planned_end_time">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						项目名称*
					</label>
					<div class="layui-input-block">
						<input type="text" name="project_name" required
							lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						项目周期
					</label>
					<div class="layui-input-block">
						<input type="text" name="project_cycle" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						项目报价*
					</label>
					<div class="layui-input-block">
						<input type="number" name="project_quotation" required
							lay-verify="required" autocomplete="off"  placeholder="￥" class="layui-input"  v-model.number = "project_quotation">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						税率*
					</label>
					<div class="layui-input-block">
						<select name="simple_tax" id="simple_tax" lay-verify="required"
							lay-search>
						</select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						项目负责人*
					</label>
					<div class="layui-input-block">
						<select name="project_leader" required lay-verify="required" lay-filter="project_leader" id="project_leader"></select>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-lg6 layui-col-md6">
		<div class="layui-card">
			<div class="layui-card-header">
				成本估算
			</div>
			<div class="layui-card-body">
				<div class="layui-form-item">
					<label class="layui-form-label">
						材料
					</label>
					<div class="layui-input-block">
						<input type="number" name="material" required lay-verify="required"
							autocomplete="off"  placeholder="￥" class="layui-input" v-model.number = "material">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label" >
						人工(外请)
					</label>
					<div class="layui-input-block">
						<input type="number" name="labor" required lay-verify="required"
							autocomplete="off"  placeholder="￥" class="layui-input"  v-model.number = "labor">
					</div>
				</div>
				<div class="layui-form-item"   lay-tips="固定资产分摊">
					<label class="layui-form-label">
						固定资产分摊
					</label>
					<div class="layui-input-block">
						<input type="number" name="allocation_of_fixed_assets" required
							lay-verify="required" autocomplete="off" placeholder="￥"  class="layui-input"  v-model.number = "allocation_of_fixed_assets">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						其他项
					</label>
					<div class="layui-input-block">
						<input type="number" name="other_items" required
							lay-verify="required" autocomplete="off" placeholder="￥" class="layui-input"  v-model.number = "other_items">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">
						费用小计
					</label>
					<div class="layui-input-block">
						<input type="number" name="subtotal_cost" required
							lay-verify="required" autocomplete="off" placeholder="￥" class="layui-input"  v-model.number = "subtotal_cost" readonly="readonly" disable="disable">
					</div>
				</div>
			</div>
		</div>
	</div>
<div class="layui-form-item model-form-footer">
	 <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
</div>
</div>
</form>
<script type="text/javascript">
layui.use(['jquery','layer','form','admin','laydate'], function(){
  var $=layui.jquery
  ,layer = layui.layer
  ,form = layui.form
  ,admin = layui.admin
  ,laydate = layui.laydate;
  var project_code=admin.getTempData('project_code');
  //下拉框初始化-费用所属部门
	var cost_department_arr=new Array();
	cost_department_arr[0] = "华东服务部";
	cost_department_arr[1] = "华南服务部";
	cost_department_arr[2] = "华西服务部";
	cost_department_arr[3] = "华北服务部";
	cost_department_arr[4] = "华中服务部";
	cost_department_arr[5] = "盛海办公室";
	var cost_department_select="<option></option>";
	for(var a=0;a<cost_department_arr.length;a++){
		var value=cost_department_arr[a];
		var text=cost_department_arr[a];
		cost_department_select+="<option value="+value+">"+text+"</option>";
	}
	$("#project_area_department").html(cost_department_select);
  	form.on('select(project_area_department)', function(data){
    		  admin.ajax_load_json({
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			url: "queryUserListByWCPArea",
			async:false,
			data: {
				wcp_area : data.value
			},
			beforeSend: function() {
				layer.load(0);
			},
			success: function(data) {
				layer.closeAll('loading');
				var obj = JSON.parse(data);
				if (obj.code == 0) {
					layer.alert("所选大区无成员", {
					icon: 5
				});
				}
				else{
					var project_leader="<option></option>";
					for(var c=0;c<obj.code;c++){
						var value=obj.info[c].user_id;
						var text=obj.info[c].user_name;
						project_leader+="<option value="+value+">"+text+"</option>";
					}
					console.log('project_leader',project_leader);
					$("#project_leader").html(project_leader);
					form.render();
			}
			},
			complete: function() {
				layer.closeAll('loading');
			}
		});
  
});    
  console.log("project_code="+project_code);
  var vm = new Vue({
      el: '#cost_estimation',
      data: {
         material : 0,
         labor : 0,
         allocation_of_fixed_assets : 0,
         other_items : 0,
         subtotal_cost: 0,
         project_quotation : 0
      },
      methods: {
      },
      computed :{
      },
      watch : {
         material : function(val) {
            this.material = val;
            this.subtotal_cost = (val+this.labor*1+this.allocation_of_fixed_assets+this.other_items).toFixed(2);
         },
         labor : function (val) {
            this.labor = val;
            this.subtotal_cost = (this.material+val+this.allocation_of_fixed_assets+this.other_items).toFixed(2);
         },
         allocation_of_fixed_assets : function (val) {
            this.allocation_of_fixed_assets = val;
            this.subtotal_cost = (this.material+this.labor+val+this.other_items).toFixed(2);
         },
         other_items : function (val) {
            this.other_items = val;
            this.subtotal_cost = (this.material+this.labor+this.allocation_of_fixed_assets+val).toFixed(2);
         }
      }
   });
  laydate.render({
    elem: '#planned_start_time' //指定元素
  });
  laydate.render({
    elem: '#planned_end_time' //指定元素
  });
  
  $("#item_classification").html('<option value=""></option><option value="弱电-维保">弱电-维保</option><option value="弱电-项目">弱电-项目</option>');
  $("#simple_tax").html('<option value=""></option>'+
  '<option value="0.03">3%</option>'+
  '<option value="0.06">6%</option>'+
  '<option value="0.09">9%</option>'+
  '<option value="0.1">10%</option>'+
  '<option value="0.13">13%</option>'+
  '<option value="0.16">16%</option>');
  form.render();
   //监听提交
  form.on('submit(formDemo)', function(data){
  	if(project_code!=null&&project_code!='undefined'){
  	//修改
  		  admin.ajax_load_json({
			url: "updataWeakCurrentProjectsSimpleInfoByProjectCode",
			data: {
				info : JSON.stringify(data.field)
				,project_code : project_code
			},
			success: function(obj) {
				if (obj.code == 0) {
					layer.msg(obj.info, {
						icon: 1
					});
				}
				else{
				layer.alert(obj.info, {
					icon: 5
				});
			}
			}
		});
  	}else{
  	//添加
	  admin.ajax_load_json({
			url: "addWeakCurrentProjectsSimple",
			data: {
				info : JSON.stringify(data.field)
			},
			success: function(obj) {
				if (obj.code == 0) {
				layer.closeAll();
					layer.msg(obj.info, {
						icon: 1
					});
				}
				else{
				layer.closeAll('loading');
				layer.alert(obj.info, {
					icon: 5
				});
			}
			}
		});
		}
    return false;
  });
  	if(project_code!=null&&project_code!='undefined'){
  	
  		  admin.ajax_load_json({
			url: "queryProjectInfoByProjectCode",
			data: {
				project_code :project_code
			},
			success: function(obj) {
				if (obj.code == 0) {
					form.val("formTest", {
					  "project_area_department":obj.info[0].project_area_department
					  ,"district_name":obj.info[0].district_name
					  ,"item_classification":obj.info[0].item_classification
					  ,"ustomer_name":obj.info[0].ustomer_name
					  ,"planned_start_time":obj.info[0].planned_start_time
					  ,"planned_end_time":obj.info[0].planned_end_time
					  ,"project_name":obj.info[0].project_name
					  ,"project_cycle":obj.info[0].project_cycle
					  //,"project_quotation":obj.info[0].project_quotation
					  ,"project_leader":obj.info[0].project_leader
					  ,"simple_tax":obj.info[0].simple_tax
					  
					  //,"material":obj.info[0].material
					  //,"labor":obj.info[0].labor
					  //,"allocation_of_fixed_assets":obj.info[0].allocation_of_fixed_assets
					  //,"other_items":obj.info[0].other_items
					  //,"subtotal_cost":obj.info[0].subtotal_cost
					});
			        vm.material=obj.info[0].material;
			        vm.labor=obj.info[0].labor;
			        vm.allocation_of_fixed_assets=obj.info[0].allocation_of_fixed_assets;
			        vm.other_items=obj.info[0].other_items;
			        vm.subtotal_cost=obj.info[0].subtotal_cost;
			        vm.project_quotation=obj.info[0].project_quotation;
				}
				else{
				layer.alert(obj.info, {
					icon: 5
				});
				}
				
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
	          //通常情况下textStatus和errorThrown只有其中一个包含信息
	          layer.alert(textStatus+" || "+errorThrown,{icon:5});
	       }
		});

		//form.render();
	}
 });
</script>