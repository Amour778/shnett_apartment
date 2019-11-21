package com.workplan.handler;

import com.workplan.bean.LoginLogBean;
import com.workplan.dao.LoginLogDao;
import com.workplan.tools.ResultMessage;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
public class LoginLogHandler {
	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	

	public void addLoginLog(String user_id,String ip_address){
		System.out.println("/addLoginLog");
		//System.out.println("user_id="+user_id);
		//System.out.println("ip_address="+ip_address);
		LoginLogDao dao = (LoginLogDao) context.getBean("LoginLogDao");
		dao.addLoginLog(user_id, ip_address);
	}


	@RequestMapping(value = "/queryLoginLog",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String queryLoginLog(String user_id,int page, int limit) {
		System.out.println("/queryLoginLog");
		//System.out.println("user_id="+user_id);
		LoginLogDao dao = (LoginLogDao) context.getBean("LoginLogDao");
		List<LoginLogBean> list = new ArrayList<LoginLogBean>();
		try {
			list=dao.queryLoginLogWithUserIdOrTime(user_id,page,limit);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int Counts=dao.queryLoginLogWithUserIdOrTimeCounts(user_id);
		String reString="";
		reString=ResultMessage.ListToLayuiTable(Counts, list);
		//System.out.println(reString);

		return  ResultMessage.ListToLayuiTable(Counts,list);
		//return new ResultMessage(0,"获取数据成功",Counts,list);
	}
	
}
