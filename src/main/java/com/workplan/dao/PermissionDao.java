package com.workplan.dao;

import com.workplan.bean.PermissionBean;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class PermissionDao {
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	/**
	 * 数据模板
	 * 
	 * @author 01059101
	 * 
	 */
	class PermissionMapper implements RowMapper<PermissionBean> {
		public PermissionBean mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			PermissionBean info = new PermissionBean();
			info.setMenuId(rs.getString("menuId"));
			info.setName(rs.getString("name"));
			info.setUrl(rs.getString("url"));
			info.setPath(rs.getString("path"));
			info.setIcon(rs.getString("icon"));
			return info;
		}

	}

	/**
	 * 搜索：通过菜单ID获取所有符合条件数据
	 * @param menuId 菜单ID,使用IN方法IN(01,02,0201...)
	 * @return
	 * @throws Exception
	 */
	public List<PermissionBean> queryInfoListByMenuIds(String menuId) throws Exception {
		String sql = "select * from permission where menuId IN ("+menuId+") order by menuId";
		List<PermissionBean> userInfoBean = jdbcTemplate.query(sql,new PermissionMapper());
		return userInfoBean;
	}
	

	
	/**
	 * 通过父菜单ID搜索子菜单
	 * 条件使用IN方法
	 * 父ID ： 01,02,03
	 * 获取到的子菜单经过排序，为 ： 0101 0102 0103
	 * @param menuId
	 * @return
	 * @throws Exception
	 * 
	 */
	public List<PermissionBean> queryForChildrenInfoListByMenuIdIsTwoLength(String ChildrenMenuIdArraryString,String FathermenuId) throws Exception {
		String sql ="";
		List<PermissionBean> userInfoBean =null;
		if(ChildrenMenuIdArraryString==""||ChildrenMenuIdArraryString==null){
			sql = "SELECT *FROM permission WHERE  menuId  like ? ORDER BY menuId";
			 userInfoBean =jdbcTemplate.query(sql,new Object[]{FathermenuId+"__"},new PermissionMapper());
		}else {
			sql = "SELECT *FROM permission WHERE  menuId IN ("+ChildrenMenuIdArraryString+") and menuId  like ? ORDER BY menuId";
			 userInfoBean =jdbcTemplate.query(sql,new Object[]{FathermenuId+"__"},new PermissionMapper());
		}
		return userInfoBean;
	}
	
	/**
	 * 通过子菜单ID获取按钮ID数据
	 * @param ChildrenMenuIdArraryString
	 * @param FathermenuId
	 * @return
	 * @throws Exception
	 */
	public List<PermissionBean> queryForButtonInfoListByMenuIdIsFourLength(String ChildrenMenuIdArraryString,String FathermenuId) throws Exception {
		String sql = "SELECT *FROM permission WHERE  menuId  like ? ORDER BY menuId";
			return jdbcTemplate.query(sql,new Object[]{FathermenuId+"__"},new PermissionMapper());
	}
	
	 

	/**
	 * 获取所有菜单信息Bean
	 * @return
	 * @throws Exception
	 */
	public PermissionBean queryForAllInfoBean() throws Exception {
		String sql = "select * from permission";
		PermissionBean userInfoBean = jdbcTemplate.queryForObject(sql, new PermissionMapper());
		return userInfoBean;
	}
	/**
	 * 获取所有菜单信息List , order By menuId
	 * @return
	 * @throws Exception
	 */
	public List<PermissionBean> queryForAllInfoList() throws Exception {
		String sql = "select * from permission order By menuId";
		List<PermissionBean> permissionList = jdbcTemplate.query(sql, new PermissionMapper());
		return permissionList;
	}

	/**
	 * 获取所有符合条件的数据
	 * @param role_id
	 * @return
	 */
	public List<PermissionBean> queryRoleInfoWithMenuId(String menuId) {
		String sql= "SELECT * FROM permission WHERE menuId = ?";
		return jdbcTemplate.query(sql, new Object[]{menuId}, new PermissionMapper());
	}
	
	/**
	 * 获取所有符合条件的数据
	 * @param name
	 * @param page
	 * @param limit
	 * @return
	 */
	public List<PermissionBean> queryAllInfoWithSearchConditionToLayui(String name,int page,int limit) {
		String sql = "";
		if(name.equals("")){
			sql = "SELECT * FROM permission order by menuId DESC limit ? , ? ";
			return jdbcTemplate.query(sql, new Object[]{(page - 1)*limit,limit}, new PermissionMapper());
		}else{
			sql = "SELECT * FROM permission  WHERE name like ? order by menuId DESC limit ? , ? ";
			return jdbcTemplate.query(sql, new Object[]{"%"+name+"%",(page - 1)*limit,limit}, new PermissionMapper());
		}
		
	}
	
	/**
	 * 获取符合条件总行数
	 * @param name
	 * @return
	 */
	public int queryAllInfoCountsBySearchCondition(String name) {
		List<PermissionBean>  bean_list = new ArrayList<PermissionBean>();
		String sql="";
		if(name.equals("")){
			sql = "SELECT * FROM permission";
			bean_list=jdbcTemplate.query(sql,  new PermissionMapper());
		}else{
			sql = "SELECT * FROM permission  WHERE name like ?";
			bean_list=jdbcTemplate.query(sql, new Object[]{"%"+name+"%"}, new PermissionMapper());
		}
		return bean_list.size();
	}

	/**
	 * 添加权限
	 * @param menuId
	 * @param name
	 * @param url
	 * @param path
	 * @param icon
	 * @return
	 */
	public boolean add(String menuId,String name,String url,String path,String icon) {
		String sql = "insert into permission(menuId,name,url,path,icon) values(?,?,?,?,?)";
		return jdbcTemplate.update(sql, new Object[] { menuId,name,url,path,icon}) == 1;
	}
	/**
	 * 通过menuid更新权限
	 * @param menuId
	 * @param name
	 * @param url
	 * @param path
	 * @param icon
	 * @return
	 */
	public boolean updata(String menuId,String name,String url,String path,String icon) {
		String sql = "UPDATE permission set name=?,url=?,path=?,icon=? where menuId=?";
		return jdbcTemplate.update(sql, new Object[] {  name,url,path,icon,menuId}) == 1;
	}
	
	/**
	 * 通过menuid删除权限信息
	 * @param role_id
	 * @return
	 */
	public boolean del_permission(String menuId) {
		String sql = "DELETE from permission where menuId=?";
		return jdbcTemplate.update(sql, new Object[] { menuId}) == 1;
	}
	
	/**
	 * 批量删除权限信息
	 * @param list
	 * @return
	 */
	public int batchDeleteByMenuId(final List<PermissionBean> list) {
		try {
			String sql = "DELETE from permission where menuId=?";
			jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
				public int getBatchSize() {
					return list.size();
				}
				public void setValues(PreparedStatement ps, int i)
						throws SQLException {
					ps.setString(1, list.get(i).getMenuId());
				}
			});
			
			return 0;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 1;
		}
	}
	
}
