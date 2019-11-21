package com.workplan.tools;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 用户未登录时跳转到登陆界面
 * 
 * @author 01059101
 * 
 */
public class LoginInterceptor implements HandlerInterceptor {
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
	}

	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object arg2) throws Exception {
		// 如果是登录页面login||获取验证码identifyingCode||登陆信息提交tologin则放行
		//System.out.println("request.getRequestURL()"+request.getRequestURL());
		if (request.getRequestURL().indexOf("/login") > 0
				|| request.getRequestURL().indexOf("/IdentifyingCode") > 0
				|| request.getRequestURL().indexOf("/tologin") > 0) {
			return true;
		}
		// 如果已经登录过,则放行
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("SESSION_USERNAME");
		if (user != null) {
			return true;
		}
		// 没登录过转发到登录页面
		request.setAttribute("msg", "你还没登录");
		request.getRequestDispatcher("/login").forward(
				request, response);
		return false;
	}
}