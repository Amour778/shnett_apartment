package com.workplan.dao;

import com.workplan.bean.LoginLogBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class LoginLogDao {
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	class LoginLogMapper implements RowMapper<LoginLogBean> {
		public LoginLogBean mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			LoginLogBean info = new LoginLogBean();
			info.setUser_id(rs.getString("user_id"));
			info.setIp_address(rs.getString("ip_address"));
			info.setTime(rs.getString("time"));
			return info;
		}

	}

	public List<LoginLogBean> queryLoginLogWithUserIdOrTime(String user_id, int page, int limit)
			throws Exception {
		String sql;
		List<LoginLogBean> userInfoBean=null;
		if(user_id==null||user_id.equals("")){
			sql = "select * from loginlog ORDER BY time DESC limit ? , ?";
			userInfoBean = jdbcTemplate.query(sql,new Object[]{(page - 1)*limit,limit},new LoginLogMapper());
		}else{
			sql = "select * from loginlog  where user_id like ? ORDER BY time DESC limit ? , ?";
			userInfoBean = jdbcTemplate.query(sql,new Object[]{"%"+user_id+"%",(page - 1)*limit,limit},new LoginLogMapper());
		}
		return userInfoBean;
	}
	
	public int queryLoginLogWithUserIdOrTimeCounts(String user_id) {
		String sql;
		List<LoginLogBean> userInfoBean=null;
		if(user_id==null||user_id.equals("")){
			sql = "select * from loginlog ";
			userInfoBean = jdbcTemplate.query(sql,new LoginLogMapper());
		}else{
			sql = "select * from loginlog where user_id like ?";
			userInfoBean = jdbcTemplate.query(sql,new Object[]{ "%"+user_id+"%"},new LoginLogMapper());
		}
		return userInfoBean.size();
	}

	public boolean addLoginLog(String user_id,String ip_address) {
		String sql = "insert into loginlog(user_id,ip_address) values(?,?)";
		return jdbcTemplate.update(sql, new Object[] { user_id,ip_address}) == 1;
	}
}
