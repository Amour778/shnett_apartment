package com.workplan.dao.apartment;

import com.workplan.bean.apartment.ApartmentBedBean;
import com.workplan.bean.apartment.ApartmentRoomBean;
import com.workplan.dao.BaseDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ApartmentRoomDao implements BaseDao {
    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    String SQL;
    ApartmentRoomBean info = new ApartmentRoomBean();
    List<ApartmentRoomBean> list = new ArrayList<ApartmentRoomBean>();

    /**
     * 房间信息：所有数据
     */
    class ApartmentRoomMapper implements RowMapper<ApartmentRoomBean> {
        public ApartmentRoomBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentRoomBean();
            info.setId(rs.getInt("id"));
            info.setApa_id(rs.getString("apa_id"));
            info.setRoo_id(rs.getString("roo_id"));
            info.setRoo_name(rs.getString("roo_name"));
            info.setRoo_floor(rs.getString("roo_floor"));
            info.setRoo_people(rs.getString("roo_people"));
            info.setRoo_remarks(rs.getString("roo_remarks"));
            info.setRoo_price(rs.getString("roo_price"));
            info.setRoo_allocation(rs.getString("roo_allocation"));
            return info;
        }
    }

    /**
     * 房间信息：ID + 名称
     */
    class ApartmentRoomJustIdAndNameMapper implements RowMapper<ApartmentRoomBean> {
        public ApartmentRoomBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentRoomBean();
            info.setRoo_id(rs.getString("roo_id"));
            info.setRoo_name(rs.getString("roo_name"));
            return info;
        }
    }


    /**
     * 获取房间数据：ID + 名称
     *
     * @return
     * @throws Exception
     */
    public List<ApartmentRoomBean> queryAllApartmentRoomByApaIdToList(String apa_id) throws Exception {
        SQL = "select * from apartment_room where apa_id = ?";
        list = jdbcTemplate.query(SQL, new Object[]{apa_id}, new ApartmentRoomJustIdAndNameMapper());
        return list;
    }


    /**
     * 获取所有房间数据
     *
     * @return
     * @throws Exception
     */
    public List<ApartmentRoomBean> getApartmentBedByInputsToLayui(String apa_id, int page, int limit) throws Exception {
        if (apa_id == null) {
            SQL = "select * from apartment_room limit ?,?";
        } else {
            SQL = "select * from apartment_room where apa_id ='" + apa_id + "' limit ?,?";
        }
        list = jdbcTemplate.query(SQL, new Object[]{(page - 1) * limit, limit}, new ApartmentRoomMapper());
        return list;
    }

    /**
     * 获取所有房间数据
     *
     * @return
     * @throws Exception
     */
    public int getApartmentBedByInputsToLayui(String apa_id) throws Exception {
        if (apa_id == null) {
            SQL = "select * from apartment_room";
        } else {
            SQL = "select * from apartment_room where apa_id ='" + apa_id + "'";
        }
        list = jdbcTemplate.query(SQL, new ApartmentRoomMapper());
        return list.size();
    }


    /**
     * 通过房间ID，根据列名修改列值
     *
     * @param roo_id    ID
     * @param col_name  列名
     * @param col_value 列值
     * @return
     * @throws Exception
     */
    public boolean updatRoomColValueByRoomId(String roo_id, String col_name, String col_value) throws Exception {
        SQL = "UPDATE apartment_room SET " + col_name + "= ? WHERE (roo_id=?)";
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.update(SQL, new Object[]{col_value, roo_id}) == 1;
    }

    /**
     * 添加新房间I
     *
     * @param apa_id
     * @param roo_id
     * @param roo_name
     * @param roo_floor
     * @param roo_people
     * @param roo_price
     * @param roo_allocation
     * @param roo_remarks
     * @return
     * @throws Exception
     */
    public boolean addNewRoomWithApaId(String apa_id, String roo_id, String roo_name, String roo_floor, String roo_people, String roo_price, String roo_allocation, String roo_remarks) throws Exception {
        SQL = "INSERT INTO apartment_room (apa_id,roo_id,roo_name,roo_floor,roo_people,roo_price,roo_allocation,roo_remarks) VALUES (?,?,?,?,?,?,?,?)";
        return jdbcTemplate.update(SQL, new Object[]{apa_id, roo_id, roo_name, roo_floor, roo_people, roo_price, roo_allocation, roo_remarks}) == 1;
    }


    /**
     * 根据房间ID删除房间
     *
     * @param roo_id
     * @return
     * @throws Exception
     */
    public int[] deleteRoomByRoomId(String roo_id) throws Exception {
        //通过房间号获取所有床位
        List<ApartmentBedBean> bedList = apartmentBedDao.getApartmentBedByInputsToLayuiNoLimit(roo_id);

        System.out.println("bedList.size()=" + bedList.size());
        //组合
        String[] sql = new String[1 + bedList.size() * 2];
        //循环添加删除床位和对应工号的语句
        for (int a = 0; a < bedList.size(); a++) {
            String bed_id = bedList.get(a).getBed_id();
            sql[a] = "DELETE FROM apartment_bed where bed_id='" + bed_id + "'";
        }
        for (int a = 0; a < bedList.size(); a++) {
            String bed_id = bedList.get(a).getBed_id();
            sql[a + bedList.size()] = "UPDATE userinfo SET user_bed= null WHERE user_bed='" + bed_id + "'";
        }
        // 删除房间的语句
        sql[bedList.size() * 2] = "DELETE FROM apartment_room where roo_id='" + roo_id + "'";
        return jdbcTemplate.batchUpdate(sql);

    }

}