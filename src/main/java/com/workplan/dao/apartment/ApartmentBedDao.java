package com.workplan.dao.apartment;

import com.workplan.bean.apartment.ApartmentBedBean;
import com.workplan.bean.apartment.ApartmentBedBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class ApartmentBedDao {
    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    String SQL;
    ApartmentBedBean info = new ApartmentBedBean();
    List<ApartmentBedBean> list = new ArrayList<ApartmentBedBean>();

    /**
     * 床位信息：所有数据
     */
    class ApartmentBedMapper implements RowMapper<ApartmentBedBean> {
        public ApartmentBedBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentBedBean();
            info.setId(rs.getInt("id"));
            info.setRoo_id(rs.getString("roo_id"));
            info.setBed_id(rs.getString("bed_id"));
            info.setBed_name(rs.getString("bed_name"));
            info.setBed_people(rs.getString("bed_people"));
            return info;
        }
    }

    /**
     * 床位信息：ID + 名称
     */
    class ApartmentBedJustIdAndNameMapper implements RowMapper<ApartmentBedBean> {
        public ApartmentBedBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentBedBean();
            info.setBed_id(rs.getString("bed_id"));
            info.setBed_name(rs.getString("bed_name"));
            info.setBed_people(rs.getString("bed_people"));
            return info;
        }
    }

    /**
     * 获取床位数据：ID + 名称
     *
     * @return
     * @throws Exception
     */
    public List<ApartmentBedBean> queryAllApartmentBedByApaIdToList(String roo_id) throws Exception {
        SQL = "select * from apartment_bed where roo_id = ?";
        list = jdbcTemplate.query(SQL, new Object[]{roo_id}, new ApartmentBedJustIdAndNameMapper());
        return list;
    }


    /**
     * 获取所有床位数据Layui
     *
     * @return
     * @throws Exception
     */
    public List<ApartmentBedBean> getApartmentBedByInputsToLayui(String roo_id, int page, int limit) throws Exception {
        if (roo_id == null) {
            SQL = "select * from apartment_bed limit ?,?";
        } else {
            SQL = "select * from apartment_bed where roo_id ='" + roo_id + "' limit ?,?";
        }
        list = jdbcTemplate.query(SQL, new Object[]{(page - 1) * limit, limit}, new ApartmentBedMapper());
        return list;
    }

    /**
     * 获取所有床位数据Layui
     *
     * @return
     * @throws Exception
     */
    public int getApartmentBedByInputsToLayui(String roo_id) throws Exception {
        if (roo_id == null) {
            SQL = "select * from apartment_bed";
        } else {
            SQL = "select * from apartment_bed where roo_id ='" + roo_id + "'";
        }
        list = jdbcTemplate.query(SQL, new ApartmentBedMapper());
        return list.size();
    }


    /**
     * 获取所有床位数据ToLayuiNoLimit
     *
     * @return
     * @throws Exception
     */
    public List<ApartmentBedBean> getApartmentBedByInputsToLayuiNoLimit(String roo_id) {
        if (roo_id == null) {
            SQL = "select * from apartment_bed";
        } else {
            SQL = "select * from apartment_bed where roo_id ='" + roo_id + "'";
        }
        System.out.println(SQL);
        list = jdbcTemplate.query(SQL, new ApartmentBedMapper());
        return list;
    }

    /**
     * 根据床位ID修改床位所在员工
     *
     * @param bed_people_new 新的员工号
     * @param bed_people_old 旧的员工号
     * @param bed_id         床位号
     * @return
     * @throws Exception
     */
    public int[] updateBedPeopleByRoomId(String bed_people_new, String bed_people_old, String bed_id) throws Exception {
        String[] sql = new String[3];
        //解绑
        if (bed_people_new == null && bed_people_old != null) {
            sql[0] = "UPDATE apartment_bed SET bed_people= null WHERE (bed_id='" + bed_id + "')";//床位设置为空
            sql[1] = "UPDATE userinfo SET user_bed= null WHERE (user_id='" + bed_people_old + "')";//旧员工设置床位为空
        } else if (bed_people_new != null && bed_people_old == null) {//添加绑定
            sql[0] = "UPDATE apartment_bed SET bed_people= '" + bed_people_new + "' WHERE (bed_id='" + bed_id + "')";//床位绑定员工工号
            sql[1] = "UPDATE userinfo SET user_bed= '" + bed_id + "' WHERE (user_id='" + bed_people_new + "')";//员工绑定床位
        } else if (bed_people_new != null && bed_people_old != null) {//更新绑定
            sql[0] = "UPDATE apartment_bed SET bed_people= '" + bed_people_new + "' WHERE (bed_id='" + bed_id + "')";//床位绑定新员工
            sql[1] = "UPDATE userinfo SET user_bed= '" + bed_id + "' WHERE (user_id='" + bed_people_new + "')";//绑定新员工
            sql[2] = "UPDATE userinfo SET user_bed= null WHERE (user_id='" + bed_people_old + "')";//解除旧员工绑定
        }
        return jdbcTemplate.batchUpdate(sql);
    }

    /**
     * 添加新床位
     *
     * @param roo_id
     * @param bed_id
     * @param bed_name
     * @return
     * @throws Exception
     */
    public boolean addNewBedByRoomId(String roo_id, String bed_id, String bed_name) throws Exception {
        SQL = "INSERT INTO apartment_bed (roo_id, bed_id, bed_name) VALUES (?,?,?)";
        return jdbcTemplate.update(SQL, new Object[]{roo_id, bed_id, bed_name}) == 1;
    }

    /**
     * 根据床位ID删除床位
     *
     * @param bed_id
     * @return
     * @throws Exception
     */
    public int[] deleteBedByBedId(String bed_id) throws Exception {
        String[] sql = new String[2];
        sql[0] = "DELETE FROM apartment_bed where bed_id='" + bed_id + "'";
        sql[1] = "UPDATE userinfo SET user_bed= null WHERE user_bed='" + bed_id + "'";
        return jdbcTemplate.batchUpdate(sql);
    }

    /**
     * 用户入住
     * @param bed_id  入住的床位ID
     * @param user_id 入住人工号
     * @param apply_id 更新审批申请的入住状态
     * @return
     * @throws Exception
     */
    public int[] checkInWithUserIdAndBedId(String bed_id, String user_id, String apply_id) throws Exception {
        String[] sql = new String[3];
        sql[0] = "UPDATE apartment_bed SET bed_people= '" + user_id + "' WHERE (bed_id='" + bed_id + "')";//床位绑定新员工
        sql[1] = "UPDATE userinfo SET user_bed= '" + bed_id + "' WHERE (user_id='" + user_id + "')";//绑定新员工
        sql[2] = "UPDATE apartment_apply SET is_check= 1 WHERE (id='" + apply_id + "')";//绑定新员工
        return jdbcTemplate.batchUpdate(sql);
    }


    /**
     * 用户退租
     * @param bed_id
     * @param user_id
     * @return
     * @throws Exception
     */
    public int[] checkOutWithUserIdAndBedId(String bed_id, String user_id) throws Exception {
        String[] sql = new String[2];
        sql[0] = "UPDATE apartment_bed SET bed_people= null WHERE (bed_id='" + bed_id + "')";//床位设置为空
        sql[1] = "UPDATE userinfo SET user_bed= null WHERE (user_id='" + user_id + "')";//旧员工设置床位为空
        return jdbcTemplate.batchUpdate(sql);
    }


    /**
     * 床位入住信息
     * @param isnull
     * @return
     */
    public int getBedCheckInCounts(Boolean isnull) {
        if(isnull)
            SQL = "SELECT * FROM apartment_bed WHERE bed_people IS NULL OR bed_people=''";
        else
            SQL = "SELECT * FROM apartment_bed WHERE bed_people IS NOT NULL AND bed_people!=''" ;

        return jdbcTemplate.query(SQL,new ApartmentBedJustIdAndNameMapper()).size();
    }

    /**
     * 床位入住信息
     * @param isnull
     * @return
     */
    public int getBedCheckInCounts(Boolean isnull,String apa_id) {
        if(isnull)
            SQL = "SELECT\n" +
                    "apartment_bed.id,\n" +
                    "apartment_bed.roo_id,\n" +
                    "apartment_bed.bed_id,\n" +
                    "apartment_bed.bed_name,\n" +
                    "apartment_bed.bed_people\n" +
                    "FROM\n" +
                    "apartment_bed\n" +
                    "INNER JOIN apartment_room ON apartment_bed.roo_id = apartment_room.roo_id\n" +
                    "INNER JOIN apartment_info ON apartment_room.apa_id = apartment_info.apa_id\n" +
                    "WHERE\n" +
                    "(apartment_bed.bed_people IS NULL OR apartment_bed.bed_people='')\n";

        else
            SQL = "SELECT\n" +
                    "apartment_bed.id,\n" +
                    "apartment_bed.roo_id,\n" +
                    "apartment_bed.bed_id,\n" +
                    "apartment_bed.bed_name,\n" +
                    "apartment_bed.bed_people\n" +
                    "FROM\n" +
                    "apartment_bed\n" +
                    "INNER JOIN apartment_room ON apartment_bed.roo_id = apartment_room.roo_id\n" +
                    "INNER JOIN apartment_info ON apartment_room.apa_id = apartment_info.apa_id\n" +
                    "WHERE\n" +
                    "apartment_bed.bed_people IS NOT NULL AND apartment_bed.bed_people!=''\n";;
        if(apa_id!=null){
            SQL+= "AND apartment_info.apa_id = '"+apa_id+"'";
        }
        return jdbcTemplate.query(SQL,new ApartmentBedJustIdAndNameMapper()).size();
    }


}