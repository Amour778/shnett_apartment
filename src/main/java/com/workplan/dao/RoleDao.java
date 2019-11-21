package com.workplan.dao;

import com.workplan.bean.RoleBean;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoleDao {
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
	class RoleMapper implements RowMapper<RoleBean> {
		public RoleBean mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			RoleBean info = new RoleBean();
			info.setRole_id(rs.getString("role_id"));
			info.setRole_nickname(rs.getString("role_nickname"));
			info.setRole_name(rs.getString("role_name"));
			info.setRole_per(rs.getString("role_per"));
			return info;
		}

	}

	/**
	 * 通过权限ID获取权限信息ToList
	 * 条件使用IN方法
	 * @param role_id
	 * @return
	 * @throws Exception
	 */
	public List<RoleBean> queryForFatherInfoListByRoleIds(String role_id) throws Exception {
		String sql = "select * from userrole where role_id IN ("+role_id+") order by role_id";
		List<RoleBean> userInfoBean = jdbcTemplate.query(sql,new RoleMapper());
		return userInfoBean;
	}
	
	/**
	 * 获取所有角色
	 * @return
	 * @throws Exception
	 */
	public List<RoleBean> queryAllRoles() throws Exception {
		String sql = "select * from userrole order by role_id";
		List<RoleBean> userInfoBean = jdbcTemplate.query(sql,new RoleMapper());
		return userInfoBean;
	}
	

	/**
	 * 获取所有符合条件的数据
	 * @param role_id
	 * @return
	 */
	public List<RoleBean> queryRoleInfoWithRoleId(String role_id) {
		String sql= "SELECT * FROM userrole WHERE role_id = ?";
		return jdbcTemplate.query(sql, new Object[]{role_id}, new RoleMapper());
	}
	
	/**
	 * 获取所有符合条件的数据
	 * @param user_id
	 * @param page
	 * @param limit
	 * @return
	 */
	public List<RoleBean> queryAllInfoWithSearchConditionToLayui(String role_nickname, int page, int limit) {
		String sql = "";
		if(role_nickname.equals("")){
			sql = "SELECT * FROM userrole limit ? , ?";
			return jdbcTemplate.query(sql, new Object[]{(page - 1)*limit,limit}, new RoleMapper());
		}else{
			sql = "SELECT * FROM userrole  WHERE role_nickname like ? limit ? , ?";
			return jdbcTemplate.query(sql, new Object[]{"%"+role_nickname+"%",(page - 1)*limit,limit}, new RoleMapper());
		}
		
	}
	
	/**
	 * 获取所有符合条件的数据行总数
	 * @param user_id
	 * @return
	 */
	public int queryAllInfoCountsBySearchCondition(String role_nickname) {
		List<RoleBean>  bean_list = new ArrayList<RoleBean>();
		String sql="";
		if(role_nickname.equals("")){
			sql = "SELECT * FROM userrole";
			bean_list=jdbcTemplate.query(sql,  new RoleMapper());
		}else{
			sql = "SELECT * FROM userrole  WHERE role_nickname like ?";
			bean_list=jdbcTemplate.query(sql, new Object[]{"%"+role_nickname+"%"}, new RoleMapper());
		}
		return bean_list.size();
	}

	/**
	 * 添加角色
	 * @param role_id
	 * @param role_nickname
	 * @param role_name
	 * @param role_per
	 * @return
	 */
	public boolean add(String role_id,String role_nickname,String role_name,String role_per) {
		String sql = "insert into userrole(role_id,role_nickname,role_name,role_per) values(?,?,?,?)";
		return jdbcTemplate.update(sql, new Object[] { role_id ,role_nickname,role_name,role_per}) == 1;
	}
	/**
	 * 通过角色ID修改角色信息
	 * @param role_id
	 * @param role_nickname
	 * @param role_name
	 * @param role_per
	 * @return
	 */
	public boolean updata(String role_id,String role_nickname,String role_name,String role_per) {
		String sql = "UPDATE userrole set role_nickname=?,role_name=?,role_per=? where role_id=?";
		return jdbcTemplate.update(sql, new Object[] {  role_nickname,role_name,role_per,role_id}) == 1;
	}
	
	/**
	 * 通过角色ID删除角色信息
	 * @param role_id
	 * @return
	 */
	public boolean del_role(String role_id) {
		String sql = "delete from userrole where role_id=?";
		return jdbcTemplate.update(sql, new Object[] { role_id}) == 1;
	}
	/**
	 * 批量删除
	 * @param list
	 * @return
	 */
	public int batchDeleteByRoleId(final List<RoleBean> list) {
		try {
			String sql = "DELETE from userrole where role_id = ?";
			jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
				public int getBatchSize() {
					return list.size();
				}
				public void setValues(PreparedStatement ps, int i)
						throws SQLException {
					ps.setString(1, list.get(i).getRole_id());
				}
			});
			return 0;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 1;
		}
	}
	
}
