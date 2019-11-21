package com.workplan.handler;

import com.workplan.bean.PermissionBean;
import com.workplan.bean.RoleBean;
import com.workplan.bean.UserInfoBean;
import com.workplan.dao.BaseDao;
import com.workplan.tools.ResultMessage;
import com.workplan.tools.TransformUtil;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * 权限类
 * 说明：数据库中的数据对应关系：
 * 01              ----主菜单(界面)
 * 02              ----主菜单
 *  |-0201         ----子菜单(界面)
 *       |-020101  ----界面按钮
 *       |-020102  ----界面按钮
 *       |-020103  ----界面按钮
 *       |-020104  ----界面按钮
 *  |-0202         ----子菜单(界面)
 *  
 */
@Controller
public class PermissionHandler  implements BaseDao {
	/**
	 *  此类为获取菜单，不包含界面按钮
	 */
	@RequestMapping(value = "/getMenuByUserMenuId",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getMenuByUserMenuId() throws Exception {
		System.out.println("***********准备获取菜单数据");
		//获取当前用户角色
		String username = (String) SecurityUtils.getSubject().getPrincipal();
		System.out.println("-----------当前登录用户：[ "+username+" ]");
		UserInfoBean userBean = userinfoDao.queryForInfoBean(username);
		if(userBean.getUser_role()==null||userBean.getUser_role().equals("")){
			return "[]";
		}
		//用户所属角色userBean.getUser_role();
		//根据用户角色获取相关菜单ID
		List<RoleBean> roleBean= roleDao.queryForFatherInfoListByRoleIds(userBean.getUser_role());
		String menuIdArray="";//用户拥有的角色ID
		for(RoleBean role:roleBean){
			menuIdArray+=role.getRole_per()+",";
		}
		if (menuIdArray.length()==0) {
			return "[]";
		}
		if(menuIdArray.substring(menuIdArray.length()-1, menuIdArray.length()).equals(","))
			menuIdArray.substring(0,menuIdArray.length()-1);
		String[] menuIdArrayList = menuIdArray.split(",");
		menuIdArrayList= TransformUtil.array_unique(menuIdArrayList);
		//System.out.println("用户拥有权限列去重完成");
		/*for (int i = 0; i < menuIdArrayList.length; i++) {
			System.out.println(menuIdArrayList[i]);
		}*/
		//父菜单ID字符串
		String FatherMenuIdArraryString="";
		//子菜单ID字符串
		String ChildrenMenuIdArraryString="";

		//System.out.println("------------开始分解菜单ID字符结果：");
		List<String> FatherMenuIdArrary=new ArrayList<String>();
		List<String> ChildrenMenuIdArrary=new ArrayList<String>();
		for (int i = 0; i < menuIdArrayList.length; i++){
			if (menuIdArrayList[i].length() == 2) {//这里之所以等于2是因为父菜单为01 02这样的ID
				//System.out.println("父菜单ID：menuIdArrayList["+i+"]="+menuIdArrayList[i]);
				FatherMenuIdArrary.add(menuIdArrayList[i]);
				FatherMenuIdArraryString+="\""+menuIdArrayList[i]+"\",";
			}else if (menuIdArrayList[i].length() == 4){
				//System.out.println("子菜单ID：menuIdArrayList["+i+"]="+menuIdArrayList[i]);
				ChildrenMenuIdArrary.add(menuIdArrayList[i]);
				ChildrenMenuIdArraryString+="\""+menuIdArrayList[i]+"\",";;
			}
		}
		FatherMenuIdArraryString=FatherMenuIdArraryString.substring(0, FatherMenuIdArraryString.length()-1);
		if(!(ChildrenMenuIdArraryString.length()==0))//用户无子菜单权限
			ChildrenMenuIdArraryString=ChildrenMenuIdArraryString.substring(0, ChildrenMenuIdArraryString.length()-1);
		//System.out.println("父菜单ID字符串为："+FatherMenuIdArraryString);
		//System.out.println("子菜单ID字符串为："+ChildrenMenuIdArraryString);
		//System.out.println("父菜单ID字符串长度为："+FatherMenuIdArraryString.length());
		//System.out.println("子菜单ID字符串长度为："+ChildrenMenuIdArraryString.length());
		

		//System.out.println("父菜单ID长度为"+FatherMenuIdArrary.size());
		if(FatherMenuIdArrary.size()==0){
			return "[]";
		}
		//System.out.println("------------开始获取父菜单相关数据");
		List<PermissionBean> father_menu = null;
		father_menu = permissionDao.queryInfoListByMenuIds(FatherMenuIdArraryString);
		//System.out.println("父菜单对应数据库数据长度为："+father_menu.size());
		if(father_menu.size()==0){
			return "[]";
		}
		//System.out.println("------------开始根据父菜单ID搜索出所有菜单相关子菜单并组合最终字符串");
		List<PermissionBean> children_menu = null;
		//最终字符串
		String returnString="";
		
		for (int a = 0; a < father_menu.size(); a++) {
			//通过父菜单ID搜索子菜单 条件使用IN方法 
			//获取到父ID开头的所有相关子ID数据
			String chString = "";
			if(ChildrenMenuIdArraryString.length()==0){
				returnString += "{\"name\":\"" + father_menu.get(a).getName()
				+ "\",\"url\":\"" + father_menu.get(a).getUrl()
				+ "\",\"icon\":\"" + father_menu.get(a).getIcon()
				+ "\"},";
			}else {
				children_menu = permissionDao.queryForChildrenInfoListByMenuIdIsTwoLength(ChildrenMenuIdArraryString,father_menu.get(a).getMenuId());
				//System.out.println("获取到数据后，子菜单数据长度为："+children_menu.size());
				if (children_menu.size() != 0) {
					//该父菜单有子菜单
					for (int b = 0; b < children_menu.size(); b++) {
						//对子菜单进行组合
						chString += "{\"name\":\"" + children_menu.get(b).getName()
								+ "\",\"url\":\"" + children_menu.get(b).getUrl()
								+ "\",\"path\":\"" + children_menu.get(b).getPath()
								+ "\"},";
					}
					returnString += "{\"name\":\"" + father_menu.get(a).getName()
							+ "\",\"url\":\"" + father_menu.get(a).getUrl()
							+ "\",\"icon\":\"" + father_menu.get(a).getIcon()
							+ "\",\"subMenus\":["
							+ chString.substring(0, chString.length() - 1) + "]},";
				} else {
					//该父菜单没有子菜单
					returnString += "{\"name\":\"" + father_menu.get(a).getName()
							+ "\",\"url\":\"" + father_menu.get(a).getUrl()
							+ "\",\"icon\":\"" + father_menu.get(a).getIcon()
							+ "\"},";
				}
			}
			
		}
		returnString="["+returnString.substring(0, returnString.length()-1)+"]";
		//System.out.println("***********------------最终字符串："+returnString);
		return returnString;
	}

	/**
	 * 获取所有权限信息并返回给前台的authtree控件
	 {
	  "code": 0,
	  "msg": "获取成功",
	  "data": {
	    "trees":[
	    	{"name": "主页", "value": "01", "checked": true},
	    	{"name": "系统管理", "value": "02", "checked": false, "list": [
	    		{"name": "用户管理", "value": "0201", "checked": true, "list":[
	    			{"name": "添加用户", "value": "020101", "checked": false},
	    			{"name": "修改用户角色", "value": "020102", "checked": false}
	    		]}
	      ]}
	    ]
	  }
	}
	 * @return
	 */
	@RequestMapping(value = "/getAllPermissionInfoToAuthtree",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getAllPermissionInfoToAuthtree() {
		
		try {
			/*
			 * 大致思路：
			 * 1.获取所有菜单并取出一级菜单
			 * 
			 * 2.for循环一级菜单：
			 * 		通过一级菜单ID获取二级菜单:SELECT *FROM permission WHERE  menuId  like '一级菜单ID__' ORDER BY menuId;
			 * 		IF存在二级菜单：
			 * 			for循环二级菜单:
			 * 				通过二级菜单ID获取按钮菜单:SELECT *FROM permission WHERE  menuId  like '二级菜单ID__' ORDER BY menuId;
			 * 				for循环按钮菜单:
			 * 					IF存在按钮菜单：添加 二级菜单 -- 按钮信息
			 * 					ELSE不存在按钮菜单：添加 二级菜单
			 * 		ELSE不存在二级菜单：添加 一级菜单
			 * 
			 * 3.返回组合好的字符串
			 */
			List<PermissionBean> permissionList =permissionDao.queryForAllInfoList();
			List<PermissionBean> FatherList=new ArrayList<PermissionBean>();
			for(PermissionBean permission : permissionList){
				if(permission.getMenuId().length()==2){
					FatherList.add(permission);
				}
			}
			String reString="";
			for (int i = 0; i < FatherList.size(); i++) {
				List<PermissionBean> ChildrenList=permissionDao.queryForChildrenInfoListByMenuIdIsTwoLength(null, FatherList.get(i).getMenuId());
				if (ChildrenList.size()!=0) {
					reString+="{\"name\": \""+FatherList.get(i).getName()+"\", \"value\": \""+FatherList.get(i).getMenuId()+"\", \"checked\": false,\"list\":[";
					for (int j = 0; j < ChildrenList.size(); j++) {
						List<PermissionBean> ButtonList=permissionDao.queryForChildrenInfoListByMenuIdIsTwoLength(null, ChildrenList.get(j).getMenuId());
						if (ButtonList.size()!=0) {
							reString+="{\"name\": \""+ChildrenList.get(j).getName()+"\", \"value\": \""+ChildrenList.get(j).getMenuId()+"\", \"checked\": false,\"list\":[";
							for (int k = 0; k < ButtonList.size(); k++) {
								reString+="{\"name\": \""+ButtonList.get(k).getName()+"\", \"value\": \""+ButtonList.get(k).getMenuId()+"\", \"checked\": false},";
							}
							reString=reString.substring(0, reString.length()-1)+"]},";
						}else {
							reString+="{\"name\": \""+ChildrenList.get(j).getName()+"\", \"value\": \""+ChildrenList.get(j).getMenuId()+"\", \"checked\": false},";
						}
					}
					reString=reString.substring(0, reString.length()-1)+"]},";
				}else {
					reString+="{\"name\": \""+FatherList.get(i).getName()+"\", \"value\": \""+FatherList.get(i).getMenuId()+"\", \"checked\": false},";
					
				}
			}
			if (reString.substring(reString.length()-1, reString.length()).equals(",")) {
				reString=reString.substring(0, reString.length()-1);
			}
			reString="{\"code\": 0,\"msg\": \"获取成功\",\"data\": {\"trees\":["+reString+"]}}";
			System.out.println(reString);
			return reString;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return "{\"code\": 1,\"msg\": \"获取权限数据失败\"}";
		}
	}
	
	/**
	 * 获取所有权限信息ToLayuiTable
	 * @return
	 */
	@RequestMapping(value = "/get_permission",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getAllPermissionInfoToLayuiTable(String name,int page,int limit) {
		
		List<PermissionBean> roleList;
		try {
			roleList = permissionDao.queryAllInfoWithSearchConditionToLayui(name, page, limit);
			int count=permissionDao.queryAllInfoCountsBySearchCondition(name);
			//return new ResultMessage(0,null,count, roleList);
			return  ResultMessage.ListToLayuiTable(count,roleList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return  ResultMessage.MessageToJson(1,"获取数据异常:"+e.getMessage());
			//return  new ResultMessage(1, "获取数据异常:"+e.getMessage(),0,null);
		}
	}

	/**
	 * 添加角色
	 * @param menuId
	 * @param name
	 * @param url
	 * @param path
	 * @param icon
	 * @return
	 */
	@RequestMapping(value = "/add_permission",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String add_role(String menuId, String name, String url, String path, String icon) {
		if(permissionDao.queryRoleInfoWithMenuId(menuId).size()==0){
			if(permissionDao.add(menuId, name, url, path, icon)){
				return  ResultMessage.MessageToJson(0, "添加成功");
			}else {
	
				return ResultMessage.MessageToJson(1, "添加失败");
			}
		}else {
			return ResultMessage.MessageToJson(1, "权限ID已存在");
		}
	}

	/**
	 * 通过menuId获取角色信息
	 * @param menuId
	 * @return
	 */
	@RequestMapping(value = "/getRoleInfoByMenuId",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getRoleInfoByRoleId(String menuId) {
		System.out.println("menuId="+menuId);
		
		return ResultMessage.ListToJson(0, permissionDao.queryRoleInfoWithMenuId(menuId));

	}

	/**
	 * 通过menuId更新角色信息
	 * @param menuId
	 * @param name
	 * @param url
	 * @param path
	 * @param icon
	 * @return
	 */
	@RequestMapping(value = "/updateRoleInfoByMenuId",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String updateRoleInfoByRoleId(String menuId,String name,String url,String path,String icon) {
		
		if(permissionDao.updata(menuId, name, url, path, icon)){
			return ResultMessage.MessageToJson(0, "修改成功");
		}else {

			return ResultMessage.MessageToJson(1, "修改失败");
		}
	}

	/**
	 * 过menuId删除角色信息
	 * @param menuId
	 * @return
	 */
	@RequestMapping(value = "/del_permission",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String deleteRoleInfoByRoleId(String menuId) {
		System.out.println("menuId="+menuId);
		
		if(permissionDao.del_permission(menuId)){
			return ResultMessage.MessageToJson(0, "删除成功");
		}else {
			return ResultMessage.MessageToJson(1, "删除失败");
		}
	}
	/**
	 * 通过menuId批量删除角色信息
	 * @param menuId
	 * @return
	 */
	@RequestMapping(value = "/batch_del_permission",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String batchdeletePermissionInfoByMenuId(String menuId) {
		System.out.println("role_id="+menuId);
		
		String[] aa = menuId.split(";");
		List<PermissionBean> list = new ArrayList<PermissionBean>();
		PermissionBean bean = new PermissionBean();
		for (int i = 0; i < aa.length; i++) {
			bean = new PermissionBean();
			bean.setMenuId(aa[i]);
			list.add(bean);
		}
		int a=permissionDao.batchDeleteByMenuId(list);
		if(a==0){
			return ResultMessage.MessageToJson(0, "删除成功");
		}else {
			return ResultMessage.MessageToJson(1, "删除失败");
		}
	}
}
