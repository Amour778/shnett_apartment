package com.workplan.dao.apartment;

import com.workplan.bean.apartment.NoticeBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


public class NoticeDao {
    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    String SQL;

	class NoticeMapper implements RowMapper<NoticeBean> {
		public NoticeBean mapRow(ResultSet rs, int rowNum) throws SQLException {
			NoticeBean info = new NoticeBean();
			info.setNid(rs.getInt("nid"));
			info.setCreate_date(rs.getString("create_date"));
			info.setInfo(rs.getString("info"));
			return info;
		}
	}

	/**
	 * 搜索通知
	 * @param page
	 * @param limit
	 * @return
	 */
	public List<NoticeBean> queryAllNoticeInfoByLimit(int page,int limit)
	{
		SQL = "SELECT * FROM notice ORDER BY nid DESC limit ?,?";
		List<NoticeBean> list = jdbcTemplate.query(SQL,new Object[]{(page - 1) * limit, limit}, new NoticeMapper());
		return list;
	}
	/**
	 * 搜索通知，获取数据个数
	 * @return
	 */
	public int queryAllNoticeInfoCount()
	{
		SQL = "SELECT * FROM notice order by nid";
		List<NoticeBean> list = jdbcTemplate.query(SQL, new NoticeMapper());
		return list.size();
	}

	/**
	 * 添加通知
	 * @param info
	 * @return
	 */
	public boolean addApplyInfoToIn(String info) {
		SQL = "INSERT INTO notice (info) VALUES (?)";
		return jdbcTemplate.update(SQL, new Object[]{info})==1;
	}

	/**
	 * 删除通知
	 * @param nid
	 * @return
	 */
	public boolean deleteNoticeInfoToIn(int nid) {
		SQL = "DELETE FROM notice WHERE nid = ?";
		return jdbcTemplate.update(SQL, new Object[]{nid})==1;
	}





}
