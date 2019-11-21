package com.workplan.dao.apartment;

import com.workplan.bean.apartment.ApartmentInfoBean;
import com.workplan.bean.apartment.NetworkBean;
import com.workplan.bean.apartment.ScoreBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


public class ScoreDao{
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	String SQL;

	class ScoreMapper implements RowMapper<ScoreBean> {
		public ScoreBean mapRow(ResultSet rs, int rowNum) throws SQLException {
			ScoreBean info = new ScoreBean();
			info.setSid(rs.getInt("sid"));
			info.setApa_id(rs.getString("apa_id"));
			info.setApa_name(rs.getString("apa_name"));
			info.setUser_id(rs.getString("user_id"));
			info.setUser_name(rs.getString("user_name"));
			info.setScore(rs.getInt("score"));
			info.setCreate_date(rs.getString("create_date"));
			info.setRemark(rs.getString("remark"));
			return info;
		}
	}

	/**
	 * 搜索用户评价
	 * @param user_id
	 * @return
	 */
	public List<ScoreBean> queryAllScoreInfoByUserId(String user_id)
	{
		SQL = "SELECT\n" +
				"apartment_info.apa_name,\n" +
				"userinfo.user_name,\n" +
				"score.sid,\n" +
				"score.apa_id,\n" +
				"score.user_id,\n" +
				"score.score,\n" +
				"score.create_date,\n" +
				"score.remark\n" +
				"FROM\n" +
				"score\n" +
				"INNER JOIN apartment_info ON score.apa_id = apartment_info.apa_id\n" +
				"INNER JOIN userinfo ON score.user_id = userinfo.user_id ";
		if(user_id !=null){
			SQL+=" WHERE score.user_id =  '"+user_id+"'";
		}
		List<ScoreBean> list = jdbcTemplate.query(SQL, new ScoreMapper());
		return list;
	}
	/**
	 * 搜索评价
	 * @return
	 */
	public List<ScoreBean> queryAllScoreInfoByUserId(String apa_id,String user_id,int page,int limit)
	{
		SQL = "SELECT\n" +
				"apartment_info.apa_name,\n" +
				"userinfo.user_name,\n" +
				"score.sid,\n" +
				"score.apa_id,\n" +
				"score.user_id,\n" +
				"score.score,\n" +
				"score.create_date,\n" +
				"score.remark\n" +
				"FROM\n" +
				"score\n" +
				"INNER JOIN apartment_info ON score.apa_id = apartment_info.apa_id\n" +
				"INNER JOIN userinfo ON score.user_id = userinfo.user_id WHERE 1=1 ";
		if(apa_id !=null){
			SQL+=" and score.apa_id =  '"+apa_id+"'";
		}
		if(user_id !=null){
		SQL+=" and score.user_id =  '"+user_id+"'";
		}
		SQL+=" limit ?,?";
		List<ScoreBean> list = jdbcTemplate.query(SQL,new Object[]{(page-1)*page,limit}, new ScoreMapper());
		return list;
	}


	/**
	 * 搜索评价
	 * @return
	 */
	public int queryAllScoreInfoByUserIdCount(String apa_id,String user_id)
	{
		SQL = "SELECT\n" +
				"apartment_info.apa_name,\n" +
				"userinfo.user_name,\n" +
				"score.sid,\n" +
				"score.apa_id,\n" +
				"score.user_id,\n" +
				"score.score,\n" +
				"score.create_date,\n" +
				"score.remark\n" +
				"FROM\n" +
				"score\n" +
				"INNER JOIN apartment_info ON score.apa_id = apartment_info.apa_id\n" +
				"INNER JOIN userinfo ON score.user_id = userinfo.user_id WHERE 1=1 ";
		if(apa_id !=null){
			SQL+=" and score.apa_id =  '"+apa_id+"'";
		}
		if(user_id !=null){
			SQL+=" and score.user_id =  '"+user_id+"'";
		}
		List<ScoreBean> list = jdbcTemplate.query(SQL, new ScoreMapper());
		return list.size();
	}


	/**
	 * 添加评分
	 * @param apa_id
	 * @param user_id
	 * @param score
	 * @param remark
	 * @return
	 */
	public boolean addNewScore(String apa_id, String user_id, int score, String  remark) {
		SQL = "INSERT INTO score ( apa_id, user_id, score, remark) VALUES ( ?, ?, ?, ?);";
		return jdbcTemplate.update(SQL, new Object[]{ apa_id, user_id, score, remark})==1;
	}




	/**
	 * 搜索评价
	 * @return
	 */
	public List<ScoreBean> queryOneScoreByApaIdAndUserId(String apa_id,String user_id)
	{
		SQL = "SELECT\n" +
				"score.sid,\n" +
				"score.apa_id,\n" +
				"score.user_id,\n" +
				"score.score,\n" +
				"score.create_date,\n" +
				"score.remark,\n" +
				"apartment_info.apa_name,\n" +
				"userinfo.user_name\n" +
				"FROM\n" +
				"score\n" +
				"INNER JOIN apartment_info ON score.apa_id = apartment_info.apa_id\n" +
				"INNER JOIN userinfo ON score.user_id = userinfo.user_id\n" +
				"WHERE\n" +
				"score.apa_id = ? AND\n" +
				"score.user_id = ?";
		List<ScoreBean> list = jdbcTemplate.query(SQL, new Object[]{ apa_id, user_id}, new ScoreMapper());
		return list;
	}


	public List<ScoreBean> queryScoreByApaIdOrUserId(String apa_id,String user_id)
	{
		SQL = "SELECT\n" +
				"apartment_info.apa_name,\n" +
				"userinfo.user_name,\n" +
				"score.sid,\n" +
				"score.apa_id,\n" +
				"score.user_id,\n" +
				"score.score,\n" +
				"score.create_date,\n" +
				"score.remark\n" +
				"FROM\n" +
				"score\n" +
				"INNER JOIN apartment_info ON score.apa_id = apartment_info.apa_id\n" +
				"INNER JOIN userinfo ON score.user_id = userinfo.user_id WHERE 1=1 ";
		if(apa_id !=null){
			SQL+=" and apa_id =  '"+apa_id+"'";
		}
		if(user_id !=null){
			SQL+=" and user_id =  '"+user_id+"'";
		}
		List<ScoreBean> list = jdbcTemplate.query(SQL, new ScoreMapper());
		return list;
	}

}
