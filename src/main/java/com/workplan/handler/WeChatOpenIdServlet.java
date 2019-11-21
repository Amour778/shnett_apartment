package com.workplan.handler;

import com.google.gson.Gson;
import com.workplan.bean.UserInfoBean;
import com.workplan.bean.WxMiniProjectBean;
import com.workplan.dao.UserInfoDao;
import com.workplan.tools.HttpRequestUtil;
import com.workplan.tools.ResultMessage;
import com.workplan.tools.sqlHelper;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * 微信小程序 通过OPENID获取用户工号
 * 
 * @author 01059101
 * 
 */

@Controller
public class WeChatOpenIdServlet {
	sqlHelper sqlHelper=new sqlHelper();
	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	UserInfoDao dao = (UserInfoDao) context.getBean("UserInfoDao");
	

	@RequestMapping(value="/WeChat_MiNi/UserIsLogin",produces="text/html;charset=UTF-8")
	@ResponseBody
		public String UserIsLogin(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String sessionid = request.getParameter("sessionid");
		HttpSession session = request.getSession();
		if(session.getSessionContext().getSession(sessionid)!=null){
			//用户已登录
		}else {
			//用户未登录
		}
		return sessionid;
		
	}
	
	/**
	 * 获取用户OPENID并验证是否已经绑定工号
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value="/WeChat_MiNi/OpenIdServlet",produces="text/html;charset=UTF-8")
	@ResponseBody
		public ResultMessage OpenIdServlet(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		System.out.println("OpenIdServlet");
		String code = request.getParameter("code");
		String APP_ID = "wx8aa07791fab4ceaa";
		String APP_SECRET = "ec55e44d68e34647261c41e02b41841e";
		String APP_GRANT_TYPE = "authorization_code";

		String requestUrl = "https://api.weixin.qq.com/sns/jscode2session";
		/*Map<String, String> requestUrlParam = new HashMap<String, String>();
		requestUrlParam.put("appid", APP_ID);
		requestUrlParam.put("secret", APP_SECRET);
		requestUrlParam.put("js_code", code);
		requestUrlParam.put("grant_type", APP_GRANT_TYPE);*/
		Gson gson = new Gson();
		String json = HttpRequestUtil.sendGet(requestUrl, "appid=" + APP_ID
				+ "&secret=" + APP_SECRET + "&js_code=" + code + "&grant_type="
				+ APP_GRANT_TYPE);
		System.out.println("json=" + json);
		//HttpSession session = request.getSession();
		WxMiniProjectBean result = gson.fromJson(json, WxMiniProjectBean.class);
		//String openId=result.getOpenid();//openId
		//String session_key=result.getSession_key();//session_key
		if (result.getErrcode() == null) {
			String OPENID = result.getOpenid();
			System.out.println("OPENID=" + OPENID);
			List<UserInfoBean> list =null;// dao.querySimpleUserSimpleInfoByOPENID(OPENID);
			//System.out.println("list.size()=" + list.size());
			if (list.size() == 0) {
				System.out.println("MESSAGE=" + "BIND");
				return new ResultMessage(0, OPENID);
			} else if (list.size() ==1) {
				System.out.println("MESSAGE=" + "正常获取用户信息");
				return new ResultMessage(1, list.get(0).getUser_name());
			} else{
				System.out.println("MESSAGE=" + "用户OPENID存在多个绑定工号");
				return new ResultMessage(2, "用户OPENID存在多个绑定工号");
			}
		} else {
			System.out.println("MESSAGE=" + "获取用户OPENID失败");
			return new ResultMessage(2, "获取用户OPENID失败");
		}
	}
	
	/**
	 * 绑定用户OPENID和工号
	 * @param user_id
	 * @param openId
	 * @return
	 */
	@RequestMapping(value="/WeChat_MiNi/BindUserId",produces="text/html;charset=UTF-8")
	@ResponseBody
		public String BindUserId(String user_id,String openId){
	/*	System.out.println("/BindUserId");
		if(dao.changeUserOpenId(openId, user_id)){
			List<UserInfoBean> list = dao.querySimpleUserSimpleInfoByOPENID(openId);
			if (list.size() ==1) {
				System.out.println("MESSAGE=" + "正常获取用户信息");
				return resultMessage.ListToJson(0, list);
			} else{
				System.out.println("MESSAGE=" + "用户OPENID存在多个绑定工号");
				return resultMessage.MessageToJson(1, "绑定异常");
			}
		}else {
			return resultMessage.MessageToJson(1, "绑定失败,工号不存在");
		}*/
	return null;
	}

    
}