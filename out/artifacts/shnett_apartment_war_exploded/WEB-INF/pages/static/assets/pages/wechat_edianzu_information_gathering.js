layui.use(['layer','form', 'table','formSelects','admin','notice','dropdown','laydate'], function(){
  var $=layui.jquery
  ,form = layui.form
  ,layer = layui.layer
  ,formSelects = layui.formSelects
  ,notice=layui.notice
  ,dropdown = layui.dropdown
  ,laydate = layui.laydate
  ,table= layui.table
  ,admin = layui.admin;
  var DATE = null;
  formSelects.data('WeChatEdianzuselect', 'server', {
	    url:"getWeChatEdianzuFormSelectsInfo",
	    success: function(id, url, searchVal, result){
	      table.render({
	  	  	id:'wechat_edianzu_information_gathering_table'
	  		,toolbar: true
	  		,loading: true
	  		,defaultToolbar: ['filter', 'exports']
	  	    ,page: true
	  	    ,method:'POST'
	  	    ,elem: '#wechat_edianzu_information_gathering_table'
	  	    ,url: 'queryWeChatEdianzuToLayuiTable'
	  	    ,where:{
	  			  SearchCondition : formSelects.value('WeChatEdianzuselect','valStr'),
	  			  date : DATE
	  		 }
	  	    ,cols: [[
	  	      {field:'event_type',  title: '上门类型', width:100}
	  	      ,{field:'startDate',  title: '到场日期 ',width:110}
	  	      ,{field:'startTime',  title: '到场时间', width:100}
	  	      ,{field:'endDate',  title: '完成日期 ', width:110 }
	  	      ,{field:'endTime',  title: '完成时间', width:100 }
	  	      ,{field:'company_name',  title: '公司名称', width:100}
	  	      ,{field:'region_province',  title: '省', width:100}
	  	      ,{field:'region_city',  title: '市', width:100}
	  	      ,{field:'region_area',  title: '区', width:100}
	  	      ,{field:'company_address',  title: '公司地址', width:100}
	  	      ,{field:'company_contacts',  title: '公司联系人', width:100 }
	  	      ,{field:'company_contact_phone',  title: '联系人联系方式', width:150 }
	  	      ,{field:'orders_number',  title: '单子数量', width:100 }
	  	      ,{field:'name_of_engineer',  title: '工程师姓名',width:100 }
	  	      ,{field:'courier_number',  title: '租返单号',width:100 }
	  	      ,{field:'number_of_inspection',  title: '巡检设备数量 ',width:110 }
	  	      ,{field:'car_fare',  title: '交通费 ',width:100 }
	  	      ,{field:'area_of_engineer',  title: '地区 ',width:100 }
	  	      ,{field:'insert_userid',  title: '工号 ',width:100 }
	  	      ,{field:'name_of_engineer',  title: '姓名 ',width:100 }
	  	      ,{field:'insert_time',  title: '录入时间',width:160 }
	  	      ,{fixed: 'right', width:80, title: '图片', align:'center', toolbar: '#wechat_edianzu_information_gathering_table_tool_bar',unresize:true}
	  	    ]]
	  	  });
		  }
	});
 
  laydate.render({
	    elem: '#WeChatEdianzuDataRange'
	    ,type: 'date'
	    ,range: '~'
	    ,format: 'yyyy-MM-dd'
	    ,done: function(value, date, endDate){
	    console.log(value); //得到日期生成的值，如：2017-08-18
	    DATE=value;
	  }
	});


  //监听工具条
  table.on('tool(wechat_edianzu_information_gathering_table_tool)', function (obj) {
      var data = obj.data; //获得当前行数据
      var layEvent = obj.event; //获得 lay-event 对应的值
      if (layEvent === 'detail') {
        	admin.putTempData('IMG_ID', data.images);
			admin.popupCenter({
			    title: '查看图片',
			    path: 'tpl/show_wechat_edianzu_img',
			    area: ['800px','500px'],
			    success: function (layero, index) {
			        $(layero).children('.layui-layer-content').css('overflow-y', 'scroll');
			    }
			});
      }
  });
  $('#layerDemo .layui-btn').on('click', function(){
	    var othis = $(this), method = othis.data('method');
	    active[method] ? active[method].call(this, othis) : '';
	});
  var active = {
	quretWeChatEdianzuInformationGathering : function() {
		table.reload('wechat_edianzu_information_gathering_table',
		{
			url : "queryWeChatEdianzuToLayuiTable",
			method : 'post',
			where : {
				SearchCondition : formSelects.value('WeChatEdianzuselect','valStr'),
				date : DATE
			}
		});
	}
  ,exportExcelWeChatEdianzu: function(){
	  time(this);
	  /*layer.open({
		  title:'获取下载地址并开始下载',
		  type: 2, 
		  content: ["ExportExcelWeChatEdianzu?SearchCondition="+formSelects.value('WeChatEdianzuselect','valStr')+"&date="+DATE, 'no'],
		  time: 3000
		});*/
	  var SearchCondition=formSelects.value('WeChatEdianzuselect','valStr').replace(/\|/g, "%7C");
	  //console.log("SearchCondition",SearchCondition);
	  window.location.href = "ExportExcelWeChatEdianzu?SearchCondition="+SearchCondition+"&date="+DATE;
  	}
  }
});
	var wait=5;
	function time(o){
	    if (wait==0) {
	    	o.disabled=false;
	    	o.className ="layui-btn";
	    o.innerHTML='<i class="layui-icon layui-icon-download-circle"></i>导出数据';
	    wait=5;
	}else{
		o.disabled=true;
		o.className +=" layui-btn-disabled";
	    o.innerHTML="请稍等..."+wait;
	        wait--;
	        setTimeout(function(){
	            time(o)
	        },1000)
	    }
	}