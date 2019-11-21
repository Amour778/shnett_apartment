layui.define(['layer'], function (exports) {
    var layer = layui.layer;
    var popupRightIndex, popupCenterIndex, popupCenterParam;
    var pathName = window.document.location.pathname;
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    var admin = {
    	base_server: projectName+"/",
    	table_select_btn_info:null,//自定义的参数，用于表格列按钮传递用户ID，相对应的有setTableBtnInfo getTableBtnInfo的 方法进行赋值取值
        isRefresh: false,
    	setTableBtnInfo:function(table_userId){
    	    table_select_btn_info=table_userId;
    	},
    	getTableBtnInfo:function(){
    		return table_select_btn_info;
    	},
        // 设置侧栏折叠
        flexible: function (expand) {
            var isExapnd = $('.layui-layout-admin').hasClass('admin-nav-mini');
            if (isExapnd == !expand) {
                return;
            }
            if (expand) {
                $('.layui-layout-admin').removeClass('admin-nav-mini');
            } else {
                $('.layui-layout-admin').addClass('admin-nav-mini');
            }
        },
        // 设置导航栏选中
        activeNav: function (url) {
            $('.layui-layout-admin .layui-side .layui-nav .layui-nav-item .layui-nav-child dd').removeClass('layui-this');
            $('.layui-layout-admin .layui-side .layui-nav .layui-nav-item').removeClass('layui-this');
            if (url && url != '') {
                $('.layui-layout-admin .layui-side .layui-nav .layui-nav-item').removeClass('layui-nav-itemed');
                var $a = $('.layui-layout-admin .layui-side .layui-nav a[href="#!' + url + '"]');
                $a.parent('li').addClass('layui-this');
                $a.parent('dd').addClass('layui-this');
                $a.parent('dd').parent('.layui-nav-child').parent('.layui-nav-item').addClass('layui-nav-itemed');
            }
        },
        // 右侧弹出
        popupRight: function (path) {
            var param = new Object();
            param.path = path;
            param.id = 'adminPopupR';
            param.title = false;
            param.anim = 2;
            param.isOutAnim = false;
            param.closeBtn = false;
            param.offset = 'r';
            param.shadeClose = true;
            param.area = '336px';
            param.skin = 'layui-layer-adminRight';
            param.end = function () {
                layer.closeAll('tips');
            };
            popupRightIndex = admin.open(param);
            return popupRightIndex;
        },
        // 关闭右侧弹出
        closePopupRight: function () {
            layer.close(popupRightIndex);
        },
        // 中间弹出
        popupCenter: function (param) {
            param.id = 'adminPopupC';
            popupCenterParam = param;
            popupCenterIndex = admin.open(param);
            return popupCenterIndex;
        },
        // 关闭中间弹出并且触发finish回调
        finishPopupCenter: function () {
            layer.close(popupCenterIndex);
            popupCenterParam.finish ? popupCenterParam.finish() : '';
        },
        // 关闭中间弹出
        closePopupCenter: function () {
            layer.close(popupCenterIndex);
        },
        // 封装layer.open
        open: function (param) {
            var sCallBack = param.success;
            param.type = 1;
            param.area = param.area ? param.area : '450px';
            param.offset = param.offset ? param.offset : '120px';
            param.resize ? param.resize : false;
            param.shade ? param.shade : .2;
            param.success = function (layero, index) {
                sCallBack ? sCallBack(layero, index) : '';
                admin.ajax({
                    url: param.path,
                    type: 'GET',
                    dataType: 'html',
                    success: function (result, status, xhr) {
                        $(layero).children('.layui-layer-content').html(result);
                    }
                });
            };
            return layer.open(param);
        },
        // 封装ajax请求，返回数据类型为json
        req: function (url, data, success, method) {
            admin.ajax({
                url: url,
                data: data,
                type: method,
                dataType: 'json',
                success: success
            });
        },
        // 封装ajax请求
        ajax: function (param) {
    		$(".layui-btn").addClass("layui-btn-disabled").attr("disabled", "disabled");
            var successCallback = param.success;
            param.success = function (result, status, xhr) {
                // 判断登录过期和没有权限
                var jsonRs;
                if ('json' == param.dataType.toLowerCase()) {
                    jsonRs = result;
                } else if ('jsp' == param.dataType.toLowerCase() || 'text' == param.dataType.toLowerCase()) {
                    jsonRs = admin.parseJSON(result);
                }
                if (jsonRs) {
                    if (jsonRs.code == 401) {
                        layer.msg(jsonRs.msg, {icon: 2, time: 1500}, function () {
                            location.replace('/login');
                        }, 1000);
                        return;
                    } else if ('jsp' == paramdataType.toLowerCase() && jsonRs.code == 403) {
                        layer.msg(jsonRs.msg, {icon: 2});
                    }
                }
                successCallback(result, status, xhr);

                $('.layui-btn').removeClass('layui-btn-disabled').removeAttr('disabled');
            };
            param.error = function (xhr) {
                param.success({code: xhr.status, msg: xhr.statusText});
            };
            $.ajax(param);
        },
        // 封装ajax请求
        ajax_load: function (param) {
    		$(".layui-btn").addClass("layui-btn-disabled").attr("disabled", "disabled");
            var successCallback = param.success;
            param.success = function (result, status, xhr) {
				layer.closeAll('loading');
                successCallback(result, status, xhr);
                $('.layui-btn').removeClass('layui-btn-disabled').removeAttr('disabled');
            };
            param.error = function (xhr) {
                param.success({code: xhr.status, msg: xhr.statusText});
            };
            param.beforeSend = function() {
				layer.load(0);
			};
            param.complete = function() {
				layer.closeAll('loading');
			};
			param.type ='POST';
			param.contentType = "application/x-www-form-urlencoded; charset=utf-8";
            $.ajax(param);
        },
        // 封装ajax请求
        ajax_load_json: function (param) {
    		$(".layui-btn").addClass("layui-btn-disabled").attr("disabled", "disabled");
            var successCallback = param.success;
            param.success = function (result, status, xhr) {
				layer.closeAll('loading');
                successCallback(result, status, xhr);
                $('.layui-btn').removeClass('layui-btn-disabled').removeAttr('disabled');
            };
            param.error = function (xhr) {
				layer.closeAll('loading');
                param.success({code: xhr.status, msg: xhr.statusText});
            };
            param.beforeSend = function() {
				layer.load(0);
			};
            param.complete = function() {
				layer.closeAll('loading');
			};
			param.dataType = 'json';
			param.type ='POST';
			param.contentType = "application/x-www-form-urlencoded; charset=utf-8";
            $.ajax(param);

            /*
             * 使用方法
             * admin.ajax_load_json({
				url: 'data_url',
				data: {
					a: 'a'
				},
				success: function(result, status, xhr) {
				}
			});
             * */
        },
        // 显示加载动画
        showLoading: function (element) {
        	layer.load(0);
            //$(element).append('<i class="layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop admin-loading"  style="font-size: 100px"></i>');
        },
        // 移除加载动画
        removeLoading: function (element) {
        	layer.closeAll('loading'); //关闭加载层
            //$(element + '>.admin-loading').remove();
        },
        // 缓存临时数据
        putTempData: function (key, value) {
            if (value) {
                layui.sessionData('tempData', {key: key, value: value});
            } else {
                layui.sessionData('tempData', {key: key, remove: true});
            }
        },
        // 获取缓存临时数据
        getTempData: function (key) {
            return layui.sessionData('tempData')[key];
        },
        // 滑动选项卡
        rollPage: function (d) {
            var $tabTitle = $('.layui-layout-admin .layui-body .layui-tab .layui-tab-title');
            var left = $tabTitle.scrollLeft();
            if ('left' === d) {
                $tabTitle.scrollLeft(left - 120);
            } else if ('auto' === d) {
                var autoLeft = 0;
                $tabTitle.children("li").each(function () {
                    if ($(this).hasClass('layui-this')) {
                        return false;
                    } else {
                        autoLeft += $(this).outerWidth();
                    }
                });
                $tabTitle.scrollLeft(autoLeft - 47);
            } else {
                $tabTitle.scrollLeft(left + 120);
            }
        },
        // 刷新主题部分
        refresh: function () {
            admin.isRefresh = true;
            Q.refresh();
        },
        // 判断是否为json
        parseJSON: function (str) {
            if (typeof str == 'string') {
                try {
                    var obj = JSON.parse(str);
                    if (typeof obj == 'object' && obj) {
                        return obj;
                    }
                } catch (e) {
                }
            }
        },
      //数字转中文大写
        numberToCapital:function(str){
            var money = str;
    	    var fraction = ['角','分'];
    	    var digit = ['零','壹','贰','叁','肆','伍','陆','柒','捌','玖'];
    	    var unit = [['元','万','亿'],['','拾','佰','仟']];
    	    var head = money < 0?'欠':'';
    	    money = Math.abs(money);
    	    var s = '';
    	    for (var i = 0; i < fraction.length; i++) {
    	      s += (digit[Math.floor(money * 10 * Math.pow(10, i)) % 10] + fraction[i]).replace(/零./, '');
    	    }
    	    s = s || '整';
    	    money = Math.floor(money);
    	    for (var i = 0; i < unit[0].length && money > 0; i++) {
    	      var p = '';
    	      for (var j = 0; j < unit[1].length && money > 0; j++) {
    	        p = digit[money % 10] + unit[1][j] + p;
    	        money = Math.floor(money / 10);
    	      }
    	      s = p.replace(/(零.)*零$/, '').replace(/^$/, '零') + unit[0][i] + s;
    	    }
    	    var sum= head + s.replace(/(零.)*零元/,'元').replace(/(零.)+/g, '零').replace(/^整$/, '零元整');
    	   return sum;
        }

    };

    // ewAdmin提供的事件
    admin.events = {
        // 折叠侧导航
        flexible: function (e) {
            var expand = $('.layui-layout-admin').hasClass('admin-nav-mini');
            admin.flexible(expand);
        },
        // 刷新主体部分
        refresh: function () {
            admin.refresh();
        },
        //后退
        back: function () {
            history.back();
        },
        // 设置主题
        theme: function () {
            admin.popupRight('tpl/theme');
        },
        // 全屏
        fullScreen: function (e) {
            var ac = 'layui-icon-screen-full', ic = 'layui-icon-screen-restore';
            var ti = $(this).find('i');

            var isFullscreen = document.fullscreenElement || document.msFullscreenElement || document.mozFullScreenElement || document.webkitFullscreenElement || false;
            if (isFullscreen) {
                var efs = document.exitFullscreen || document.webkitExitFullscreen || document.mozCancelFullScreen || document.msExitFullscreen;
                if (efs) {
                    efs.call(document);
                } else if (window.ActiveXObject) {
                    var ws = new ActiveXObject('WScript.Shell');
                    ws && ws.SendKeys('{F11}');
                }
                ti.addClass(ac).removeClass(ic);
            } else {
                var el = document.documentElement;
                var rfs = el.requestFullscreen || el.webkitRequestFullscreen || el.mozRequestFullScreen || el.msRequestFullscreen;
                if (rfs) {
                    rfs.call(el);
                } else if (window.ActiveXObject) {
                    var ws = new ActiveXObject('WScript.Shell');
                    ws && ws.SendKeys('{F11}');
                }
                ti.addClass(ic).removeClass(ac);
            }
        },
        // 左滑动tab
        leftPage: function () {
            admin.rollPage("left");
        },
        // 右滑动tab
        rightPage: function () {
            admin.rollPage();
        },
        // 关闭当前选项卡
        closeThisTabs: function () {
            var $title = $('.layui-layout-admin .layui-body .layui-tab .layui-tab-title');
            if ($title.find('li').first().hasClass('layui-this')) {
                return;
            }
            $title.find('li.layui-this').find(".layui-tab-close").trigger("click");
        },
        // 关闭其他选项卡
        closeOtherTabs: function () {
            $('.layui-layout-admin .layui-body .layui-tab .layui-tab-title li:gt(0):not(.layui-this)').find('.layui-tab-close').trigger('click');
        },
        // 关闭所有选项卡
        closeAllTabs: function () {
            $('.layui-layout-admin .layui-body .layui-tab .layui-tab-title li:gt(0)').find('.layui-tab-close').trigger('click');
        },
        // 关闭所有弹窗
        closeDialog: function () {
            layer.closeAll('page');
        }
    };

    // 所有ew-event
    $('body').on('click', '*[ew-event]', function () {
        var event = $(this).attr('ew-event');
        var te = admin.events[event];
        te && te.call(this, $(this));
    });

    // 移动设备遮罩层点击事件
    $('.site-mobile-shade').click(function () {
        admin.flexible(true);
    });

    // 侧导航折叠状态下鼠标经过显示提示
    $('body').on('mouseenter', '.layui-layout-admin.admin-nav-mini .layui-side .layui-nav .layui-nav-item>a', function () {
        var tipText = $(this).find('cite').text();
        if (document.body.clientWidth > 750) {
            layer.tips(tipText, this);
        }
    }).on('mouseleave', '.layui-layout-admin.admin-nav-mini .layui-side .layui-nav .layui-nav-item>a', function () {
        layer.closeAll('tips');
    });

    // 侧导航折叠状态下点击展开
    $('body').on('click', '.layui-layout-admin.admin-nav-mini .layui-side .layui-nav .layui-nav-item>a', function () {
        if (document.body.clientWidth > 750) {
            layer.closeAll('tips');
            admin.flexible(true);
        }
    });

    // 所有lay-tips处理
    $('body').on('mouseenter', '*[lay-tips]', function () {
        var tipText = $(this).attr('lay-tips');
        var dt = $(this).attr('lay-direction');
        layer.tips(tipText, this, {tips: dt || 1, time: -1});
    }).on('mouseleave', '*[lay-tips]', function () {
        layer.closeAll('tips');
    });

    exports('admin', admin);
});
