package com.workplan.handler;

import com.workplan.bean.RoleBean;
import com.workplan.dao.RoleDao;
import com.workplan.tools.ResultMessage;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * 角色类
 * @author 01059101
 *
 */
@Controller
public class RoleHandler {

	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	/**
	 * 获取所有角色信息并返回给前台的formSelects控件
	 * @return
	 */
	
	@RequestMapping(value = "/getAllRole",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getAllRole() {
		RoleDao dao = (RoleDao) context.getBean("RoleDao");
		List<RoleBean> list=null;
		try {
			list = dao.queryAllRoles();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String reString="";
		for(RoleBean role : list){
			reString+="{\"name\":\""+role.getRole_nickname()+"\",\"value\":\""+role.getRole_id()+"\",\"selected\":\"\",\"disabled\":\"\"},";
		}
		reString="{\"code\":0,\"msg\":\"success\",\"data\":["+reString.substring(0, reString.length()-1)+"]}";
		return reString;
	}

	/**
	 * 获取所有角色，其中会通过用户前端传递的用户ID默认勾选用户已拥有权限
	 * @param keyword
	 * @return
	 */
	@RequestMapping(value = "/getAllRoleWithUserIdToFromSelect",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getAllRoleWithUserIdToFromSelect(String keyword) {
		RoleDao dao = (RoleDao) context.getBean("RoleDao");
		List<RoleBean> userlist = new ArrayList<RoleBean>();
		UserInfoHandler userInfoHandler = new UserInfoHandler();
		List<String> user_role_list = userInfoHandler.getRoleListByUserId("name", keyword);
		String resString = "";
		try {
			userlist = dao.queryAllRoles();
			for (RoleBean role : userlist) {
				System.out.println(role.getRole_nickname());
				int a = 0;
				for (String userhavaRole : user_role_list) {
					System.out.println(userhavaRole);
					if (userhavaRole.equals(role.getRole_nickname())) {
						resString += "{\"name\":\""
								+ role.getRole_nickname()
								+ "\",\"value\":"
								+ role.getRole_id()
								+ ",\"selected\":\"selected\",\"disabled\":\"\"},";
						a++;
					}
				}
				if (a == 0)
					resString += "{\"name\":\"" + role.getRole_nickname()
							+ "\",\"value\":" + role.getRole_id()
							+ ",\"selected\":\"\",\"disabled\":\"\"},";
			}
			if (resString.substring(resString.length() - 1, resString.length())
					.equals(","))
				resString = resString.substring(0, resString.length() - 1);
			resString = ResultMessage.ListToFormSelects(resString);
		} catch (Exception e) {
			resString = ResultMessage.ListToFormSelects("[]");
			e.printStackTrace();
		}
		System.out.println("用户已有权限和所有权限的 返回值:" + resString);
		return resString;
	}
	

	/**
	 * 获取所有角色信息ToLayuiTable
	 * @return
	 */
	@RequestMapping(value = "/get_role",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getAllRoleInfoToLayuiTable(String role_nickname,int page,int limit) {
		System.out.println("role_nickname="+role_nickname);
		System.out.println("page="+page);
		System.out.println("limit="+limit);
		RoleDao dao = (RoleDao) context.getBean("RoleDao");
		List<RoleBean> roleList;
		try {
			roleList = dao.queryAllInfoWithSearchConditionToLayui(role_nickname, page, limit);
			int count=dao.queryAllInfoCountsBySearchCondition(role_nickname);
			return ResultMessage.ListToLayuiTable(count, roleList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ResultMessage.ListToJson(1, null);
		}
	}

	/**
	 * 添加角色
	 * @param role_id
	 * @param role_nickname
	 * @param role_name
	 * @param role_per
	 * @return
	 */
	@RequestMapping(value = "/add_role",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String add_role(String role_id,String role_nickname,String role_name,String role_per) {
		System.out.println("role_id="+role_id);
		System.out.println("role_nickname="+role_nickname);
		System.out.println("role_name="+role_name);
		System.out.println("role_per="+role_per);
		RoleDao dao = (RoleDao) context.getBean("RoleDao");
		if(dao.queryRoleInfoWithRoleId(role_id).size()==0){
			if(dao.add(role_id, role_nickname, role_name, role_per)){
				return ResultMessage.MessageToJson(0, "添加成功");
			}else {
	
				return ResultMessage.MessageToJson(1, "添加失败");
			}
		}else {
			return ResultMessage.MessageToJson(1, "角色ID已存在");
		}
	}

	/**
	 * 通过角色ID获取角色信息
	 * @param role_id
	 * @return
	 */
	@RequestMapping(value = "/getRoleInfoByRoleId",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getRoleInfoByRoleId(String role_id) {
		System.out.println("role_id="+role_id);
		RoleDao dao = (RoleDao) context.getBean("RoleDao");
		return ResultMessage.ListToJson(0, dao.queryRoleInfoWithRoleId(role_id));

	}
	/**
	 * 通过角色ID更新角色信息
	 * @param role_id
	 * @return
	 */
	@RequestMapping(value = "/updateRoleInfoByRoleId",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String updateRoleInfoByRoleId(String role_id,String role_nickname,String role_name,String role_per) {
		System.out.println("role_id="+role_id);
		RoleDao dao = (RoleDao) context.getBean("RoleDao");
		if(dao.updata(role_id, role_nickname, role_name, role_per)){
			return ResultMessage.MessageToJson(0, "修改成功");
		}else {

			return ResultMessage.MessageToJson(1, "修改失败");
		}
	}
	/**
	 * 通过角色ID删除角色信息
	 * @param role_id
	 * @return
	 */
	@RequestMapping(value = "/del_role",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String deleteRoleInfoByRoleId(String role_id) {
		System.out.println("role_id="+role_id);
		RoleDao dao = (RoleDao) context.getBean("RoleDao");
		if(dao.del_role(role_id)){
			return ResultMessage.MessageToJson(0, "删除成功");
		}else {

			return ResultMessage.MessageToJson(1, "删除失败");
		}
	}
	/**
	 * 通过角色ID批量删除角色信息
	 * @param role_id
	 * @return
	 */
	@RequestMapping(value = "/batch_del_role",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String batchdeleteRoleInfoByRoleId(String role_id) {
		System.out.println("role_id="+role_id);
		RoleDao dao = (RoleDao) context.getBean("RoleDao");
		String[] aa = role_id.split(";");
		List<RoleBean> list = new ArrayList<RoleBean>();
		RoleBean bean = new RoleBean();
		for (int i = 0; i < aa.length; i++) {
			bean = new RoleBean();
			bean.setRole_id(aa[i]);
			list.add(bean);
		}
		int a=dao.batchDeleteByRoleId(list);
		if(a==0){
			return ResultMessage.MessageToJson(0, "删除成功");
		}else {
			return ResultMessage.MessageToJson(1, "删除失败");
		}
	}
}
