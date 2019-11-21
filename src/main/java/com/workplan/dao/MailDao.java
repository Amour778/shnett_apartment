package com.workplan.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.workplan.bean.MailBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class MailDao {
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
	class MailMapperHasPassword implements RowMapper<MailBean> {
		public MailBean mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			MailBean info = new MailBean();
			info.setMail_type(rs.getInt("mail_type"));
			info.setMail_templateid(rs.getInt("mail_templateid"));
			info.setMail_protocol(rs.getString("mail_protocol"));
			info.setMail_host(rs.getString("mail_host"));
			info.setMail_port(rs.getInt("mail_port"));
			info.setMail_auth(rs.getString("mail_auth"));
			info.setMail_ssl(rs.getString("mail_ssl"));
			info.setMail_debug(rs.getString("mail_debug"));
			info.setMail_from(rs.getString("mail_from"));
			info.setMail_password(rs.getString("mail_password"));
			info.setMail_title(rs.getString("mail_title"));
			info.setMail_template(rs.getString("mail_template"));
			return info;
		}
	}
	class MailMapperNoPassword implements RowMapper<MailBean> {
		public MailBean mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			MailBean info = new MailBean();
			info.setMail_type(rs.getInt("mail_type"));
			info.setMail_templateid(rs.getInt("mail_templateid"));
			info.setMail_protocol(rs.getString("mail_protocol"));
			info.setMail_host(rs.getString("mail_host"));
			info.setMail_port(rs.getInt("mail_port"));
			info.setMail_auth(rs.getString("mail_auth"));
			info.setMail_ssl(rs.getString("mail_ssl"));
			info.setMail_debug(rs.getString("mail_debug"));
			info.setMail_from(rs.getString("mail_from"));
			info.setMail_title(rs.getString("mail_title"));
			info.setMail_template(rs.getString("mail_template"));
			return info;
		}
	}

	/**
	 * 返回包含密码且符合TYPE和TEMPLATEID的数据
	 * @param mail_type
	 * @param mail_templateid
	 * @return List<MailBean>
	 */
	public List<MailBean> queryMailByType(int mail_type, int mail_templateid) {
		String sql = "select * from mail where mail_type = ? And mail_templateid = ?";
		List<MailBean> Mail=jdbcTemplate.query(sql,new Object[]{mail_type,mail_templateid}, new MailMapperHasPassword());
		return Mail;
	}

	/**
	 * 返回无密码且符合TYPE和TEMPLATEID的数据
	 * @param mail_type
	 * @param mail_templateid
	 * @return List<MailBean>
	 */
	public List<MailBean> queryMailByTypeNoPassword(int mail_type,int mail_templateid) {
		String sql = "select mail_type, mail_templateid, mail_protocol, mail_host, mail_port, mail_auth, mail_ssl, mail_debug, mail_from, mail_title, mail_template from mail where mail_type = ? And mail_templateid = ?";
		List<MailBean> Mail=jdbcTemplate.query(sql,new Object[]{mail_type,mail_templateid}, new MailMapperNoPassword());
		return Mail;
	}

	
}
