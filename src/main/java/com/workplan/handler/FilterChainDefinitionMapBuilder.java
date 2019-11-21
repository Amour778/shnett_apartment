package com.workplan.handler;

import java.util.LinkedHashMap;

/**
 * 动态添加URL配置项
 * @author 01059101
 *
 */
public class FilterChainDefinitionMapBuilder {
    public LinkedHashMap<String,String> buildFilterChainDefinitionMap(){
    	LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();
    	/*配置哪些页面需要受保护. 
    	以及访问这些页面需要的权限. 
    	1). anon 可以被匿名访问
    	2). authc 必须认证(即登录)后才可能访问的页面. 
    	3). logout 登出
    	4). roles 角色过滤器
    	正常情况这些数据都应该从数据库中导入
    	*/
		map.put("/assets/**", "anon");//通用js
		map.put("/module/**", "anon");//模块组件js
		map.put("/pages/**", "anon");//页面js
		map.put("/login", "anon");
		map.put("/tologin", "anon");
		map.put("/wx/**", "anon");
		map.put("/IdentifyingCode", "anon");//验证码
		map.put("/WeChat_MiNi/**", "anon");//微信小程序

		map.put("/logout", "logout");

		map.put("/index", "authc");
		map.put("/main", "authc");
		map.put("/**", "authc");
    	/**/
    	return map;
    }
}
