package com.workplan.dao;

import com.workplan.bean.MenuBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class MenuDao {
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
	class MenuMapper implements RowMapper<MenuBean> {
		public MenuBean mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			MenuBean info = new MenuBean();
			info.setID(rs.getLong("ID"));
			info.setTitleId(rs.getString("title_id"));
			info.setIsfather(rs.getLong("isfather"));
			info.setTitle(rs.getString("title"));
			info.setIcon(rs.getString("icon"));
			info.setHref(rs.getString("href"));
			info.setSpread(rs.getString("spread"));
			info.setChildren(rs.getString("children"));
			return info;
		}

	}
	
	/**
	 * 搜索数据，无条件
	 * 
	 * @return List<UserInfoBean>
	 */
	public List<MenuBean> queryMenu() {
		
		String sql = "select * from menu";
		List<MenuBean> fatherMenu=jdbcTemplate.query(sql, new MenuMapper());
		Map<String, String> MenuMap=new HashMap<String, String>();
		for(int a=0;a<fatherMenu.size();a++){
			if (fatherMenu.get(a).getChildren()!=""&&fatherMenu.get(a).getChildren()!=null) {
				MenuMap.put("title", fatherMenu.get(a).getTitle());
				MenuMap.put("icon", fatherMenu.get(a).getIcon());
				MenuMap.put("href", fatherMenu.get(a).getHref());
				MenuMap.put("spread", "false");
			}else {
				MenuMap.put("title", fatherMenu.get(a).getTitle());
				MenuMap.put("icon", fatherMenu.get(a).getTitle());
				MenuMap.put("href", fatherMenu.get(a).getTitle());
				MenuMap.put("spread", "false");
				List<MenuBean> childrenMenu=new ArrayList<MenuBean>();
				Object[] arrObjects=fatherMenu.get(a).getChildren().split(",");
				for(int b=0;b<arrObjects.length;b++){
					sql="select * from menu where isfather=0 and title_id="+arrObjects[b];
					childrenMenu=jdbcTemplate.query(sql ,new MenuMapper());
					String string="{\"title\":\""+childrenMenu.get(a).getTitle()+
					"\",\"icon\":\""+childrenMenu.get(a).getIcon()+
					"\",\"href\":\""+childrenMenu.get(a).getHref()+
					"\",\"spread\":false},";
				}
				
				
				
				fatherMenu.get(a).setChildren("");
			}
		}
		
		return null;
	}
}
