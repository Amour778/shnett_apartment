<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="layui-card">
    <div class="layui-card-header">
        <h2 class="header-title">用户管理</h2>
        <span class="layui-breadcrumb pull-right">
	          <a href="#!home_console">首页</a>
	          <a><cite>用户管理</cite></a>
	        </span>
    </div>
    <div class="layui-card-body">
        <div class="layui-form toolbar">

            <shiro:hasPermission name="get_user">
            <div class="layui-form layui-form-pane">
                <div class="layui-inline">
                    <label class="layui-form-label">
                        用户工号
                    </label>
                    <div class="layui-input-inline" style="width: 200px;">
                        <input type="text" name="item_name" autocomplete="off"
                               id="input_value" class="layui-input" placeholder="">
                    </div>
                    <div class="layui-input-inline">
                        <label class="layui-form-label">账号状态</label>
                        <div class="layui-input-inline">
                            <input type="radio" lay-filter="radio_sta" name="sta" value="1" title="已启用" checked>
                            <input type="radio" lay-filter="radio_sta" name="sta" value="0" title="已禁用">
                        </div>
                    </div>
                    </shiro:hasPermission>
                    <div class="layui-btn-group">
                        <shiro:hasPermission name="get_user">
                            <button class="layui-btn layui-btn-normal" data-method="get_user"><i
                                    class="layui-icon layui-icon-search"></i>搜索
                            </button>
                        </shiro:hasPermission>
                    </div>
                </div>
            </div>
        </div>
        <table id="table_userinfo" lay-filter="table_userinfo_lay_filter" cellspacing="0" cellpadding="0" border="0"
               class="layui-table"></table>
    </div>
</div>
<script type="text/html" id="userBindTpl">
    {{#  if(d.user_wechat_apartment === ''){ }}
    <span style="color: #F581B1;">未绑定</span>
    {{#  } else { }}
    <span style="color: green;">已绑定</span>
    {{#  } }}
</script>

<script type="text/html" id="userSexTpl">
    {{#  if(d.user_sex === 0){ }}
    <span style="color: #F581B1;">女</span>
    {{#  } else  if(d.user_sex === 1){ }}
    <span style="color: green;">男</span>
    {{#  } else { }}
    <span style="color: green;">男</span>
    {{#  } }}
</script>

<script type="text/html" id="userTypeTpl">
    {{#  if(d.user_sex === '0'){ }}
    <span style="color: #F581B1;">社招</span>
    {{#  } else if(d.user_sex === '1'){ }}
    <span style="color: green;">实习生</span>
    {{#  } else { }}
    <span>非新工</span>
    {{#  } }}
</script>

<script type="text/html" id="userStaTpl">
    {{#  if(d.user_id !='shadmin'){ }}
    <input type="checkbox" name="sta" value="{{d.user_id}}" lay-skin="switch" lay-text="启用|禁用" lay-filter="staDemo" {{d.sta== 1 ? 'checked' : '' }}>
    {{#  }  }}
</script>

<!-- 表格 -->
<script type="text/javascript" language="javascript" src="assets/pages/userinfo.js"></script>
<script type="text/javascript" language="javascript" src="module/pace/pace.min.js"></script>
<script type="text/html" id="userinfo_bar">
    {{#  if(d.user_id !='shadmin'){ }}
    <a class="layui-btn layui-btn-xs layui-btn-primary" lay-event="edit_user_id" >修改工号</a>
    {{#  }  }}
</script>