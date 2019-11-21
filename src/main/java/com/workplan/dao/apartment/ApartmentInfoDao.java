package com.workplan.dao.apartment;

import com.workplan.bean.apartment.ApartmentBedBean;
import com.workplan.bean.apartment.ApartmentInfoBean;
import com.workplan.bean.apartment.ApartmentRoomBean;
import com.workplan.dao.BaseDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ApartmentInfoDao implements BaseDao {
    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    String SQL;
    ApartmentInfoBean info = new ApartmentInfoBean();
    List<ApartmentInfoBean> list = new ArrayList<ApartmentInfoBean>();

    /**
     * 公寓信息：所有数据
     */
    class ApartmentInfoMapper implements RowMapper<ApartmentInfoBean> {
        public ApartmentInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentInfoBean();
            info.setId(rs.getInt("id"));
            info.setApa_id(rs.getString("apa_id"));
            info.setApa_name(rs.getString("apa_name"));
            info.setApa_province(rs.getString("apa_province"));
            info.setApa_city(rs.getString("apa_city"));
            info.setApa_area(rs.getString("apa_area"));
            info.setApa_address(rs.getString("apa_address"));
            info.setApa_user(rs.getString("apa_user"));
            info.setApa_tel(rs.getString("apa_tel"));
            info.setApa_local(rs.getString("apa_local"));
            info.setApa_remarks(rs.getString("apa_remarks"));
            return info;
        }
    }

    /**
     * 公寓信息：ID + 名称
     */
    class ApartmentInfoJustIdAndNameMapper implements RowMapper<ApartmentInfoBean> {
        public ApartmentInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentInfoBean();
            info.setApa_id(rs.getString("apa_id"));
            info.setApa_name(rs.getString("apa_name"));
            return info;
        }
    }

    /**
     * 公寓经纬度和用户工号
     */
    class ApartmentLocalAndUserIdMapper implements RowMapper<ApartmentInfoBean> {
        public ApartmentInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentInfoBean();
            info.setUser_id(rs.getString("user_id"));
            info.setApa_local(rs.getString("apa_local"));
            return info;
        }
    }


    /**
     * 获取所有[公寓->房间->床位->员工]数据
     */
    class LinkApartmentAndUserMapper implements RowMapper<ApartmentInfoBean> {
        public ApartmentInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            //INFO
            info = new ApartmentInfoBean();
            info.setApa_id(rs.getString("apa_id"));
            info.setApa_name(rs.getString("apa_name"));
            //ROOM
            info.setRoo_id(rs.getString("roo_id"));
            info.setRoo_name(rs.getString("roo_name"));
            //BED
            info.setBed_id(rs.getString("bed_id"));
            info.setBed_name(rs.getString("bed_name"));
            //USER
            info.setUser_id(rs.getString("user_id"));
            //info.setUser_password(rs.getString("user_password"));
            info.setUser_name(rs.getString("user_name"));
            info.setUser_tel(rs.getString("user_tel"));
            return info;
        }
    }

    /**
     * 获取所有[公寓->房间->床位->员工]数据，用于导出数据
     */
    class LinkApartmentAndUserToExportMapper implements RowMapper<ApartmentInfoBean> {
        public ApartmentInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            //INFO
            info = new ApartmentInfoBean();
            //info.setApa_id(rs.getString("apa_id"));
            info.setApa_name(rs.getString("apa_name"));
            info.setApa_province(rs.getString("apa_province"));
            info.setApa_city(rs.getString("apa_city"));
            info.setApa_area(rs.getString("apa_area"));
            info.setApa_address(rs.getString("apa_address"));
            info.setApa_user(rs.getString("apa_user"));
            info.setApa_tel(rs.getString("apa_tel"));
            info.setApa_local(rs.getString("apa_local"));
            info.setApa_remarks(rs.getString("apa_remarks"));
            //ROOM
            //info.setId(rs.getInt("id"));
            //info.setApa_id(rs.getString("apa_id"));
            //info.setRoo_id(rs.getString("roo_id"));
            info.setRoo_name(rs.getString("roo_name"));
            info.setRoo_floor(rs.getString("roo_floor"));
            info.setRoo_people(rs.getString("roo_people"));
            info.setRoo_remarks(rs.getString("roo_remarks"));
            info.setRoo_price(rs.getString("roo_price"));
            info.setRoo_allocation(rs.getString("roo_allocation"));
            //BED
            //info.setId(rs.getInt("id"));
            //info.setRoo_id(rs.getString("roo_id"));
            //info.setBed_id(rs.getString("bed_id"));
            info.setBed_name(rs.getString("bed_name"));
            //info.setBed_people(rs.getString("bed_people"));
            //USER
            //info.setPid(rs.getInt("pid"));
            info.setUser_id(rs.getString("user_id"));
            //info.setUser_password(rs.getString("user_password"));
            info.setUser_name(rs.getString("user_name"));
            info.setUser_cardid(rs.getString("user_cardid"));
            info.setUser_tel(rs.getString("user_tel"));
            //info.setUser_role(rs.getString("user_role"));
            //info.setUser_wechat_apartment(rs.getString("user_wechat_apartment"));
            info.setUser_main(rs.getString("user_main"));
            info.setUser_point(rs.getString("user_point"));
            //info.setCreate_date(rs.getString("create_date"));
            //info.setSta(rs.getInt("sta"));
            //info.setUser_sex(rs.getInt("user_sex"));
            //info.setUser_integral(rs.getInt("user_integral"));
            //info.setUser_bed(rs.getString("user_bed"));
            info.setDate_entry(rs.getString("date_entry"));
            //info.setUser_type(rs.getInt("user_type"));
            return info;
        }
    }


    /**
     * WX:获取[公寓->房间->床位->员工]数据
     */
    class ApartmentToUserInfoMapper implements RowMapper<ApartmentInfoBean> {
        public ApartmentInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            //INFO
            info = new ApartmentInfoBean();
            //info.setId(rs.getInt("id"));
            info.setApa_id(rs.getString("apa_id"));
            info.setApa_name(rs.getString("apa_name"));
            info.setRoo_id(rs.getString("roo_id"));
            info.setRoo_name(rs.getString("roo_name"));
            info.setBed_id(rs.getString("bed_id"));
            info.setBed_name(rs.getString("bed_name"));
            info.setUser_id(rs.getString("user_id"));
            info.setUser_name(rs.getString("user_name"));
            //info.setUser_bed(rs.getString("user_bed"));
            return info;
        }
    }


    /**
     * 获取公寓数据：ID + 名称
     *
     * @return
     * @throws Exception
     */
    public List<ApartmentInfoBean> queryAllApartmentInfoForList() throws Exception {
        SQL = "select * from apartment_info ";
        list = jdbcTemplate.query(SQL, new ApartmentInfoJustIdAndNameMapper());
        return list;
    }


    /**
     * 获取所有公寓数据
     *
     * @return
     * @throws Exception
     */
    public List<ApartmentInfoBean> getApartmentInfoByInputsToLayui(String apa_name, int page, int limit) throws Exception {
        if (apa_name == null) {
            SQL = "select * from apartment_info limit ?,?";
        } else {
            SQL = "select * from apartment_info where apa_name like '%" + apa_name + "%'  limit ?,?";
        }
        list = jdbcTemplate.query(SQL, new Object[]{(page - 1) * limit, limit}, new ApartmentInfoMapper());
        return list;
    }

    /**
     * 获取所有公寓数据
     *
     * @return
     * @throws Exception
     */
    public int getApartmentInfoByInputsToLayui(String apa_name) throws Exception {
        if (apa_name == null) {
            SQL = "select * from apartment_info";
        } else {
            SQL = "select * from apartment_info where apa_name like '%" + apa_name + "%' ";
        }
        list = jdbcTemplate.query(SQL, new ApartmentInfoMapper());
        return list.size();
    }


    /**
     * 添加新的公寓数据
     *
     * @param apa_id
     * @param apa_name
     * @param apa_province
     * @param apa_city
     * @param apa_area
     * @param apa_address
     * @param apa_user
     * @param apa_tel
     * @param apa_local
     * @param apa_remarks
     * @return
     * @throws Exception
     */
    public boolean addNewApartmentInfo(String apa_id, String apa_name, String apa_province, String apa_city, String apa_area,
                                       String apa_address, String apa_user, String apa_tel, String apa_local, String apa_remarks) throws Exception {
        SQL = "INSERT INTO apartment_info ( apa_id, apa_name, apa_province, apa_city, apa_area, apa_address, apa_user, apa_tel, apa_local, apa_remarks) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(SQL, new Object[]{apa_id, apa_name, apa_province, apa_city, apa_area, apa_address, apa_user, apa_tel, apa_local, apa_remarks}) == 1;

    }

    /**
     * 更新公寓数据
     *
     * @param apa_id
     * @param apa_name
     * @param apa_province
     * @param apa_city
     * @param apa_area
     * @param apa_address
     * @param apa_user
     * @param apa_tel
     * @param apa_local
     * @param apa_remarks
     * @return
     * @throws Exception
     */
    public boolean updateApartmentInfoByApartmentId(String apa_id, String apa_name, String apa_province, String apa_city, String apa_area,
                                                    String apa_address, String apa_user, String apa_tel, String apa_local, String apa_remarks) throws Exception {
        SQL = "UPDATE apartment_info SET apa_name=?, apa_province=?, apa_city=?, apa_area=?, apa_address=?, apa_user=?, apa_tel=?, apa_local=?, apa_remarks=? WHERE (apa_id=?)";
        return jdbcTemplate.update(SQL, new Object[]{apa_name, apa_province, apa_city, apa_area, apa_address, apa_user, apa_tel, apa_local, apa_remarks, apa_id}) == 1;
    }


    /**
     * 删除公寓信息
     *
     * @param apa_id
     * @return
     * @throws Exception
     */
    public int[] deleteApartmentInfo(String apa_id) throws Exception {
        ArrayList sql_list = new ArrayList();
        //通过房间号获取所有床位
        List<ApartmentRoomBean> roomList = apartmentRoomDao.queryAllApartmentRoomByApaIdToList(apa_id);
        for (int r = 0; r < roomList.size(); r++) {
            String roo_id = roomList.get(r).getRoo_id();
            List<ApartmentBedBean> bedList = apartmentBedDao.getApartmentBedByInputsToLayuiNoLimit(roo_id);
            sql_list.add("DELETE FROM apartment_room where roo_id='" + roo_id + "'");
            //循环添加删除床位和对应工号的语句
            for (int a = 0; a < bedList.size(); a++) {
                String bed_id = bedList.get(a).getBed_id();
                sql_list.add("DELETE FROM apartment_bed where bed_id='" + bed_id + "'");
                sql_list.add("UPDATE userinfo SET user_bed= null WHERE user_bed='" + bed_id + "'");
            }
        }
        sql_list.add("DELETE FROM apartment_info where apa_id='" + apa_id + "'");
        String[] sql = (String[]) sql_list.toArray(new String[0]);
        for (int a = 0; a < sql.length; a++) {
            System.out.println(sql[a]);
        }
        return jdbcTemplate.batchUpdate(sql);

    }

    /**
     * 通过用户工号获取用户的入住信息
     *
     * @param user_id
     * @return
     * @throws Exception
     */
    public List<ApartmentInfoBean> getUserCheckInInfo(String user_id) throws Exception {
        SQL = "SELECT\n" +
                //"userinfo.user_bed,\n" +
                "apartment_info.apa_name,\n" +
                "apartment_info.apa_id,\n" +
                //"apartment_room.apa_id,\n" +
                "apartment_room.roo_id,\n" +
                "apartment_room.roo_name,\n" +
                "apartment_bed.bed_id,\n" +
                //"apartment_bed.roo_id,\n" +
                "apartment_bed.bed_name,\n" +
                "userinfo.user_name,\n" +
                "userinfo.user_id\n" +
                "FROM\n" +
                "userinfo\n" +
                "INNER JOIN apartment_bed ON userinfo.user_bed = apartment_bed.bed_id\n" +
                "INNER JOIN apartment_room ON apartment_bed.roo_id = apartment_room.roo_id\n" +
                "INNER JOIN apartment_info ON apartment_room.apa_id = apartment_info.apa_id\n" +
                "WHERE\n" +
                "userinfo.user_id = ?";
        list = jdbcTemplate.query(SQL, new Object[]{user_id}, new ApartmentToUserInfoMapper());
        return list;
    }

    /**
     * 通过公寓ID 和 员工ID 获取对应数据[公寓->房间->床位->员工]
     *
     * @param apa_id  公寓ID
     * @param user_id 员工ID
     * @return
     * @throws Exception
     */
    public List<ApartmentInfoBean> getApartmentToUserInfoByApaIdAndUserId(String apa_id, String user_id, int page, int limit) throws Exception {
        SQL = "SELECT\n" +
                "apartment_info.apa_id,\n" +
                "apartment_info.apa_name,\n" +
                "apartment_room.roo_id,\n" +
                "apartment_room.roo_name,\n" +
                "apartment_bed.bed_id,\n" +
                "apartment_bed.bed_name,\n" +
                "userinfo.user_id,\n" +
                "userinfo.user_name,\n" +
                "userinfo.user_tel\n" +
                "FROM\n" +
                "apartment_info\n" +
                "LEFT JOIN apartment_room ON apartment_info.apa_id = apartment_room.apa_id\n" +
                "LEFT JOIN apartment_bed ON apartment_room.roo_id = apartment_bed.roo_id\n" +
                "LEFT JOIN userinfo ON userinfo.user_bed = apartment_bed.bed_id\n" +
                "WHERE 1=1\n";
        if (apa_id != null && !apa_id.equals("")) {
            SQL += " AND apartment_info.apa_id ='" + apa_id + "'\n";
        }
        if (user_id != null && !user_id.equals("")) {
            SQL += " AND userinfo.user_id ='" + user_id + "'\n";
        }
        SQL += "ORDER BY apartment_info.apa_id ASC limit ?,? ";
        list = jdbcTemplate.query(SQL, new Object[]{(page - 1) * limit, limit}, new LinkApartmentAndUserMapper());
        return list;
    }

    /**
     * 通过公寓ID 和 员工ID 获取对应数据[公寓->房间->床位->员工]
     *
     * @param apa_id  公寓ID
     * @param user_id 员工ID
     * @return
     * @throws Exception
     */
    public int getApartmentToUserInfoByApaIdAndUserId(String apa_id, String user_id) throws Exception {
        SQL = "SELECT\n" +
                "apartment_info.apa_id,\n" +
                "apartment_info.apa_name,\n" +
                "apartment_room.roo_id,\n" +
                "apartment_room.roo_name,\n" +
                "apartment_bed.bed_id,\n" +
                "apartment_bed.bed_name,\n" +
                "userinfo.user_id,\n" +
                "userinfo.user_name,\n" +
                "userinfo.user_tel\n" +
                "FROM\n" +
                "apartment_info\n" +
                "LEFT JOIN apartment_room ON apartment_info.apa_id = apartment_room.apa_id\n" +
                "LEFT JOIN apartment_bed ON apartment_room.roo_id = apartment_bed.roo_id\n" +
                "LEFT JOIN userinfo ON userinfo.user_bed = apartment_bed.bed_id\n" +
                "WHERE 1=1\n";
        if (apa_id != null && !apa_id.equals("")) {
            SQL += " AND apartment_info.apa_id ='" + apa_id + "'\n";
        }
        if (user_id != null && !user_id.equals("")) {
            SQL += " AND userinfo.user_id ='" + user_id + "'\n";
        }
        SQL += "ORDER BY apartment_info.apa_id ASC";
        return jdbcTemplate.query(SQL, new LinkApartmentAndUserMapper()).size();
    }

    /**
     * 导出数据
     * @return
     * @throws Exception
     */
    public List<ApartmentInfoBean> LinkApartmentAndUserToExport() throws Exception {
        SQL = "SELECT\n" +
                "apartment_info.apa_name,\n" +
                "apartment_info.apa_province,\n" +
                "apartment_info.apa_city,\n" +
                "apartment_info.apa_area,\n" +
                "apartment_info.apa_address,\n" +
                "apartment_info.apa_user,\n" +
                "apartment_info.apa_tel,\n" +
                "apartment_info.apa_local,\n" +
                "apartment_info.apa_remarks,\n" +
                "apartment_room.roo_name,\n" +
                "apartment_room.roo_floor,\n" +
                "apartment_room.roo_people,\n" +
                "apartment_room.roo_remarks,\n" +
                "apartment_room.roo_price,\n" +
                "apartment_room.roo_allocation,\n" +
                "apartment_bed.bed_name,\n" +
                "userinfo.user_id,\n" +
                "userinfo.user_name,\n" +
                "userinfo.user_cardid,\n" +
                "userinfo.user_tel,\n" +
                "userinfo.user_main,\n" +
                "userinfo.user_point,\n" +
                "userinfo.sta,\n" +
                "userinfo.user_sex,\n" +
                "userinfo.user_integral,\n" +
                "userinfo.date_entry,\n" +
                "userinfo.user_type\n" +
                "FROM\n" +
                "apartment_info\n" +
                "LEFT JOIN apartment_room ON apartment_room.apa_id = apartment_info.apa_id\n" +
                "LEFT JOIN apartment_bed ON apartment_bed.roo_id = apartment_room.roo_id\n" +
                "LEFT JOIN userinfo ON userinfo.user_id = apartment_bed.bed_people\n";
        list = jdbcTemplate.query(SQL, new LinkApartmentAndUserToExportMapper());
        return list;
    }

    /**
     * 导出数据：以人员为基础
     * @return
     * @throws Exception
     */
    public List<ApartmentInfoBean> LinkUserAndApartmentToExport() throws Exception {
        SQL = "SELECT\n" +
                "userinfo.user_id,\n" +
                "userinfo.user_name,\n" +
                "userinfo.user_cardid,\n" +
                "userinfo.user_tel,\n" +
                "userinfo.user_main,\n" +
                "userinfo.user_point,\n" +
                "userinfo.user_sex,\n" +
                "userinfo.date_entry,\n" +
                "userinfo.user_type,\n" +
                "userinfo.sta,\n" +
                "userinfo.user_integral,\n" +
                "apartment_bed.bed_name,\n" +
                "apartment_room.roo_name,\n" +
                "apartment_room.roo_floor,\n" +
                "apartment_room.roo_people,\n" +
                "apartment_room.roo_remarks,\n" +
                "apartment_room.roo_price,\n" +
                "apartment_room.roo_allocation,\n" +
                "apartment_info.apa_name,\n" +
                "apartment_info.apa_province,\n" +
                "apartment_info.apa_city,\n" +
                "apartment_info.apa_area,\n" +
                "apartment_info.apa_address,\n" +
                "apartment_info.apa_user,\n" +
                "apartment_info.apa_tel,\n" +
                "apartment_info.apa_local,\n" +
                "apartment_info.apa_remarks\n" +
                "FROM\n" +
                "userinfo\n" +
                "LEFT JOIN apartment_bed ON userinfo.user_bed = apartment_bed.bed_id\n" +
                "LEFT JOIN apartment_room ON apartment_bed.roo_id = apartment_room.roo_id\n" +
                "LEFT JOIN apartment_info ON apartment_room.apa_id = apartment_info.apa_id\n";
        list = jdbcTemplate.query(SQL, new LinkApartmentAndUserToExportMapper());
        return list;
    }

    /**
     * 通过用户工号，获取用户的入住公寓经纬度
     * @param user_id
     * @return
     * @throws Exception
     */
    public List<ApartmentInfoBean> queryApartmentLocalAndUserIdMapper(String user_id) throws Exception {
    SQL="SELECT\n"+
            "userinfo.user_id,\n"+
            "apartment_info.apa_local\n"+
            "FROM\n"+
            "userinfo\n"+
            "LEFT JOIN apartment_bed ON userinfo.user_bed = apartment_bed.bed_id\n"+
            "LEFT JOIN apartment_room ON apartment_bed.roo_id = apartment_room.roo_id\n"+
            "LEFT JOIN apartment_info ON apartment_room.apa_id = apartment_info.apa_id\n"+
            "WHERE userinfo.user_id = ?";
    list = jdbcTemplate.query(SQL, new Object[]{user_id}, new ApartmentLocalAndUserIdMapper());
        return list;
}
}