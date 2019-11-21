package com.workplan.dao.apartment;

import com.workplan.bean.apartment.NetworkBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


public class NetworkDao {
    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    String SQL;

    /**
     * 所有信息
     */
    class NetworkMapper implements RowMapper<NetworkBean> {
        public NetworkBean mapRow(ResultSet rs, int rowNum) throws SQLException {
            NetworkBean info = new NetworkBean();
            info.setMainId(rs.getString("mainId"));
            info.setMain_name(rs.getString("main_name"));
			/*info.setDistrictId(rs.getString("districtId"));
			info.setDistrict_name(rs.getString("district_name"));*/
            info.setPointId(rs.getString("pointId"));
            info.setPoint_name(rs.getString("point_name"));
            return info;
        }

    }

    /**
     * 区部ID + 区部名称
     */
    class NetworkMainInfoMapper implements RowMapper<NetworkBean> {
        public NetworkBean mapRow(ResultSet rs, int rowNum) throws SQLException {
            NetworkBean info = new NetworkBean();
            info.setMainId(rs.getString("mainId"));
            info.setMain_name(rs.getString("main_name"));
            return info;
        }
    }

    /**
     * 点部ID + 点部名称
     */
    class NetworkPointInfoMapper implements RowMapper<NetworkBean> {
        public NetworkBean mapRow(ResultSet rs, int rowNum) throws SQLException {
            NetworkBean info = new NetworkBean();
            info.setPointId(rs.getString("pointId"));
            info.setPoint_name(rs.getString("point_name"));
            return info;
        }
    }

    /**
     * 获取所有大区分点部信息
     */
    public List<NetworkBean> queryAllNetworkInfo(){
        SQL="SELECT\n" +
                "network_main.mainId,\n" +
                "network_main.main_name,\n" +
                "network_point.pointId,\n" +
                "network_point.point_name\n" +
                "FROM\n" +
                "network_main\n" +
                "INNER JOIN network_point ON network_main.mainId = network_point.mainId";
        List<NetworkBean> list = jdbcTemplate.query(SQL, new NetworkMapper());
        return list;
    }

	/**
	 * 获取所有大区信息
	 *
	 * @return List<NetworkBean> NetworkMapper
	 * @throws Exception
	 */
	public List<NetworkBean> queryAllNetworkMainInfo()
	{
		SQL = "SELECT * FROM  network_main ";
		List<NetworkBean> list = jdbcTemplate.query(SQL,new Object[]{}, new NetworkMainInfoMapper());
		return list;
	}

	public List<NetworkBean> queryAllNetworkMainInfo(String mainId)
	{
		SQL = "SELECT * FROM  network_main where mainId = ?";
		List<NetworkBean> list = jdbcTemplate.query(SQL,new Object[]{mainId}, new NetworkMainInfoMapper());
		return list;
	}
	/**
	 * 获取所有大区信息
	 *
	 * @return List<NetworkBean> NetworkMapper
	 * @throws Exception
	 */
	public List<NetworkBean> getAllNetworkMainInfoToLayuiList(String input,int page,int limit)
	{
		SQL = "SELECT * FROM  network_main";
		if(input!=null){
			SQL+=" WHERE mainId like '%"+input+"%' OR  main_name like '%"+input+"%'";
		}
		SQL+=" LIMIT ?,?";
		List<NetworkBean> list = jdbcTemplate.query(SQL,new Object[]{(page - 1) * limit, limit}, new NetworkMainInfoMapper());
		return list;
	}

	/**
	 * 获取所有大区信息
	 *
	 * @return List<NetworkBean> NetworkMapper
	 * @throws Exception
	 */
	public int getAllNetworkMainInfoToLayuiList(String input)
	{
		SQL = "SELECT * FROM  network_main";
		if(input!=null){
			SQL+=" WHERE mainId like '%"+input+"%' OR  main_name like '%"+input+"%'";
		}
		List<NetworkBean> list = jdbcTemplate.query(SQL,new Object[]{}, new NetworkMainInfoMapper());
		return list.size();
	}



	/**
	 * 获取所有分点部信息
	 *
	 * @return List<NetworkBean> NetworkMapper
	 * @throws Exception
	 */
	public List<NetworkBean> getAllNetworkpointInfoToLayuiList(String mainId,String input,int page,int limit)
	{
		SQL = "SELECT " +
				"network_main.mainId, " +
				"network_main.main_name, " +
				"network_point.pointId, " +
				"network_point.point_name " +
				"FROM " +
				"network_main " +
				"INNER JOIN network_point ON network_main.mainId = network_point.mainId WHERE network_main.mainId = ?";
		if(input!=null){
			SQL+=" AND (network_point.pointId like '%"+input+"%' OR  network_point.point_name like '%"+input+"%')";
		}
		SQL+=" LIMIT ?,?";
		List<NetworkBean> list = jdbcTemplate.query(SQL,new Object[]{mainId,(page - 1) * limit, limit}, new NetworkMapper());
		return list;
	}

	/**
	 * 获取所有分点部信息
	 *
	 * @return List<NetworkBean> NetworkMapper
	 * @throws Exception
	 */
	public int getAllNetworkpointInfoToLayuiList(String mainId,String input)
	{
		SQL = "SELECT " +
				"network_main.mainId, " +
				"network_main.main_name, " +
				"network_point.pointId, " +
				"network_point.point_name " +
				"FROM " +
				"network_main " +
				"INNER JOIN network_point ON network_main.mainId = network_point.mainId WHERE network_main.mainId = ?";
		if(input!=null){
			SQL+=" AND (network_point.pointId like '%"+input+"%' OR  network_point.point_name like '%"+input+"%')";
		}
		List<NetworkBean> list = jdbcTemplate.query(SQL,new Object[]{mainId}, new NetworkMapper());
		return list.size();
	}

	/**
	 * 通过大区ID获取所有信息
	 *
	 * @param mainId
	 * @return List<NetworkBean> NetworkMapper
	 * @throws Exception
	 */
	public List<NetworkBean> queryAllNetworkMainAndPointInfoByMainId(String mainId)
			{
		SQL = "SELECT " +
				"network_main.mainId, " +
				"network_main.main_name, " +
				"network_point.pointId, " +
				"network_point.point_name " +
				"FROM " +
				"network_main " +
				"INNER JOIN network_point ON network_main.mainId = network_point.mainId WHERE network_main.mainId = ?";
		List<NetworkBean> list = jdbcTemplate.query(SQL,
				new Object[]{mainId}, new NetworkMapper());
		return list;
	}

	/**
	 * 通过大区ID获取所有点部信息
	 *
	 * @param mainId
	 * @return
	 * @throws Exception
	 */
	public List<NetworkBean> queryNetworkPointInfoByMainId(String mainId)
	{
		SQL = "SELECT  " +
				"network_point.pointId, " +
				"network_point.point_name " +
				"FROM " +
				"network_point  WHERE network_point.mainId = ?";
		List<NetworkBean> list = jdbcTemplate.query(SQL,
				new Object[]{mainId}, new NetworkPointInfoMapper());
		return list;
	}


	public List<NetworkBean> queryNetworkPointInfoByMainId(String mainId,String pointId)
	{
		SQL = "SELECT  * FROM " +
				"network_point  WHERE mainId = ? And pointId= ?";
		List<NetworkBean> list = jdbcTemplate.query(SQL,
				new Object[]{mainId,pointId}, new NetworkPointInfoMapper());
		return list;
	}


	/**
     * 通过点部ID获取对应点部的相关信息，也可用于添加时判断点部信息是否存在
     *
     * @param pointId
     * @return NetworkBean
     * @throws Exception
     */
    public NetworkBean queryAllNetworkInfoByPointId(String pointId)
            {
        SQL = "SELECT " +
                "network_point.pointId, " +
                "network_point.point_name, " +
                "network_point.mainId, " +
                "network_main.main_name " +
                "FROM " +
                "network_point " +
                "INNER JOIN network_main ON network_point.mainId = network_main.mainId WHERE network_point.pointId = ?";
        return jdbcTemplate.queryForObject(SQL,
                new Object[]{pointId}, new NetworkMapper());
    }

	/**
	 * 删除区部信息，将同时删除点部信息
	 *
	 * @param mainId
	 * @return
	 * @throws Exception
	 */
	public void deleteNetworkMainAndPointInfoByMainId(String mainId) {
		String[] sql = new String[3];
		sql[0]="DELETE FROM network_main WHERE mainId = '"+mainId+"'";
		sql[1]="DELETE FROM network_point WHERE mainId = '"+mainId+"'";
		sql[2]="DELETE FROM userinfo WHERE user_main = '"+mainId+"'";
		int[] deleteInfo = jdbcTemplate.batchUpdate(sql);
		System.out.println(deleteInfo);
	}
	/**
	 * 删除点部信息
	 * @param pointId
	 * @return
	 * @throws Exception
	 */
	public void deleteNetworkPointInfoByPointId(String pointId) {
		String[] sql = new String[2];
		sql[0]="DELETE FROM network_point WHERE pointId = '"+pointId+"'";
		sql[1]="DELETE FROM userinfo WHERE user_point = '"+pointId+"'";
		int[] deleteInfo = jdbcTemplate.batchUpdate(sql);
		System.out.println(deleteInfo);
	}
	/**
	 * 删除区部信息，同时删除点部信息，但是不会删除用户信息
	 *
	 * @param mainId
	 * @return
	 * @throws Exception
	 */
	public void deleteNetworkMainInfoNotWithUserInfo(String mainId) {
		String[] sql = new String[2];
		sql[0]="DELETE FROM network_main WHERE mainId = '"+mainId+"'";
		sql[1]="DELETE FROM network_point WHERE mainId = '"+mainId+"'";
		int[] deleteInfo = jdbcTemplate.batchUpdate(sql);
		System.out.println(deleteInfo);
	}

	/**
	 * 删除点部信息，不会删除其他相关信息
	 *
	 * @param pointId
	 * @return
	 * @throws Exception
	 */
	public boolean deleteNetworkPointInfoNotWithOtherInfo(String pointId) {
		SQL="DELETE FROM network_point WHERE pointId = ?";
		return jdbcTemplate.update(SQL,new Object[]{pointId})==1;
	}

	/**
	 * 添加区部数据
	 *
	 * @param mainId
	 * @param main_name
	 * @return
	 */
	public boolean addNetworkMainInfo(String mainId, String main_name) {
		String sql = "INSERT INTO network_main (mainId, main_name) VALUES (?, ?)";
		return jdbcTemplate.update(sql, new Object[]{mainId, main_name}) == 1;
	}
	/**
	 * 添加点部数据
	 *
	 * @param mainId
	 * @param pointId
	 * @param point_name
	 * @return
	 */
	public boolean addNetworkPointInfo(String mainId,  String pointId, String point_name) {
		String sql = "INSERT INTO network_point (mainId, pointId, point_name) VALUES (?, ?, ?)";
		return jdbcTemplate.update(sql, new Object[]{mainId,  pointId, point_name}) == 1;
	}

	/**
	 * 通过区部ID 更新区部名称
	 *
	 * @param mainId
	 * @param main_name
	 * @return
	 */
	public boolean updateNetworkMainInfo(String mainId, String main_name) {
		String sql = "UPDATE network_main set main_name = ? where mainId=?";
		return jdbcTemplate.update(sql, new Object[]{main_name, mainId}) == 1;
	}

	/**
	 * 通过pointId更新点部信息
	 * @param pointId 点部ID
	 * @param point_name 新的点部名称
	 * @return
	 */
	public boolean updateNetworkPointInfo(String pointId, String point_name) {
		String sql = "UPDATE network_point set  point_name = ? where pointId=?";
		return jdbcTemplate.update(sql, new Object[]{point_name,pointId}) == 1;
	}


}
