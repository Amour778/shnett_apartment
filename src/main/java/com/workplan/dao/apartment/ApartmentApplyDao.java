package com.workplan.dao.apartment;

import com.workplan.bean.UserInfoBean;
import com.workplan.bean.apartment.ApartmentApplyBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ApartmentApplyDao {
    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    String SQL;
    ApartmentApplyBean info = new ApartmentApplyBean();
    List<ApartmentApplyBean> list = new ArrayList<ApartmentApplyBean>();

    /**
     * 申请入住/退租：所有数据
     */
    class ApartmentApplyAllInfoMapper implements RowMapper<ApartmentApplyBean> {
        public ApartmentApplyBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentApplyBean();
            info.setId(rs.getInt("id"));
            info.setUser_id(rs.getString("user_id"));
            info.setUser_intention(rs.getString("user_intention"));
            info.setAdmin_arrange(rs.getString("admin_arrange"));
            info.setIn_reason(rs.getString("in_reason"));
            info.setCheck_in_type(rs.getInt("check_in_type"));
            info.setApply_type(rs.getInt("apply_type"));
           /* info.setUpdate_time(rs.getString("update_time"));
            info.setApply_time(rs.getString("apply_time"));*/
            info.setDate_check_in(rs.getString("date_check_in"));
            info.setDate_move_out(rs.getString("date_move_out"));
            info.setApa_id(rs.getString("apa_id"));
            info.setRoo_id(rs.getString("roo_id"));
            info.setBed_id(rs.getString("bed_id"));
            info.setOut_reason(rs.getString("out_reason"));
            info.setSta(rs.getInt("sta"));
            info.setApply_remarks(rs.getString("apply_remarks"));
            info.setCreate_date(rs.getString("create_date"));
            info.setIs_check(rs.getInt("is_check"));
            return info;
        }
    }

    /**
     * 申请列表：显示人员和申请内容的部分信息
     */
    class ApartmentApplyAndUserInfoToListMapper implements RowMapper<ApartmentApplyBean> {
        public ApartmentApplyBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentApplyBean();
            info.setUser_name(rs.getString("user_name"));

            info.setAdmin_arrange(rs.getString("admin_arrange"));
            info.setId(rs.getInt("id"));
            info.setUser_id(rs.getString("user_id"));
            info.setIn_reason(rs.getString("in_reason"));
            info.setOut_reason(rs.getString("out_reason"));
            info.setCheck_in_type(rs.getInt("check_in_type"));
            info.setApply_type(rs.getInt("apply_type"));
            info.setSta(rs.getInt("sta"));
            info.setCreate_date(rs.getString("create_date").substring(0, 19));
            info.setIs_check(rs.getInt("is_check"));
            return info;
        }
    }

    /**
     * 申请详情+人员信息:入住
     */
    class ApartmentApplyCheckInAndUserInfoMapper implements RowMapper<ApartmentApplyBean> {
        public ApartmentApplyBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentApplyBean();
            info.setUser_id(rs.getString("user_id"));
            info.setUser_name(rs.getString("user_name"));
            info.setUser_cardid(rs.getString("user_cardid"));
            info.setUser_tel(rs.getString("user_tel"));
            info.setUser_main(rs.getString("user_main"));
            info.setUser_point(rs.getString("user_point"));
            info.setUser_sex(rs.getInt("user_sex"));
            info.setDate_entry(rs.getString("date_entry"));
            info.setUser_type(rs.getInt("user_type"));

            info.setId(rs.getInt("id"));
            info.setUser_intention(rs.getString("user_intention"));
            info.setAdmin_arrange(rs.getString("admin_arrange"));
            info.setIn_reason(rs.getString("in_reason"));
            info.setCheck_in_type(rs.getInt("check_in_type"));
            info.setApply_type(rs.getInt("apply_type"));
            info.setDate_check_in(rs.getString("date_check_in"));
            info.setDate_move_out(rs.getString("date_move_out"));
            info.setSta(rs.getInt("sta"));
            info.setApply_remarks(rs.getString("apply_remarks"));
            info.setCreate_date(rs.getString("create_date"));
            info.setIs_check(rs.getInt("is_check"));
            return info;
        }
    }

    /**
     * 申请详情+人员信息:退租
     */
    class ApartmentApplyCheckOutAndUserInfoMapper implements RowMapper<ApartmentApplyBean> {
        public ApartmentApplyBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new ApartmentApplyBean();
            info.setUser_id(rs.getString("user_id"));
            info.setUser_name(rs.getString("user_name"));
            info.setUser_tel(rs.getString("user_tel"));
            info.setUser_point(rs.getString("user_point"));

            info.setId(rs.getInt("id"));
            info.setApply_type(rs.getInt("apply_type"));
            info.setDate_move_out(rs.getString("date_move_out"));
            info.setApa_id(rs.getString("apa_id"));
            info.setApa_name(rs.getString("apa_name"));
            info.setRoo_id(rs.getString("roo_id"));
            info.setRoo_name(rs.getString("roo_name"));
            info.setBed_id(rs.getString("bed_id"));
            info.setBed_name(rs.getString("bed_name"));
            info.setOut_reason(rs.getString("out_reason"));
            info.setSta(rs.getInt("sta"));
            info.setApply_remarks(rs.getString("apply_remarks"));
            info.setCreate_date(rs.getString("create_date"));
            return info;
        }
    }


    /**
     * 添加入住宿舍申请
     *
     * @param user_id        用户工号
     * @param user_intention 员工意向宿舍ID
     * @param check_in_type  入住或搬出：0新住，1续住
     * @param in_reason      入住事由
     * @param date_check_in  入住日期
     * @param date_move_out  到期日期
     * @param apply_type     申请类型：0入住
     * @return
     */
    public int addApplyInfoToIn(String user_id, String user_intention, String in_reason, String check_in_type, String apply_type, String date_check_in, String date_move_out) {
        SQL = "INSERT INTO apartment_apply (user_id, user_intention, in_reason, check_in_type, apply_type,  date_check_in, date_move_out) VALUES (?,?,?,?,?,?,?);";

        return jdbcTemplate.update(SQL, new Object[]{user_id, user_intention, in_reason, check_in_type, apply_type, date_check_in, date_move_out});
    }

    /**
     * 添加退租宿舍申请
     *
     * @param user_id       用户工号
     * @param apa_id        公寓ID
     * @param roo_id        房间ID
     * @param bed_id        床位ID
     * @param out_reason    退租理由
     * @param date_move_out 退租日期
     * @param apply_type    申请类型：1搬出
     * @return
     */
    public int addApplyInfoToOut(String user_id,String apa_id,String roo_id, String bed_id,String out_reason,String date_move_out,String apply_type) {
        SQL = "insert into apartment_apply (user_id, apa_id, roo_id, bed_id, out_reason, date_move_out, apply_type) values (?,?,?,?,?,?,?)";
        return jdbcTemplate.update(SQL, new Object[]{user_id, apa_id, roo_id, bed_id, out_reason, date_move_out, apply_type});
    }


    /**
     * 审批申请:入住
     *
     * @param id            流程ID
     * @param sta           审批结果
     * @param apply_remarks 审批备注
     * @param admin_arrange 管理员分配的宿舍ID
     * @param date_check_in (管理员要求的)入住日期
     * @param date_move_out (管理员要求的)退租日期
     * @return
     */
    public boolean updateApplyStaById(String id, String sta, String apply_remarks, String admin_arrange, String date_check_in, String date_move_out) {
        SQL = "UPDATE apartment_apply set sta = ?, apply_remarks = ? ,admin_arrange = ?,date_check_in = ?,date_move_out=? where id=?";
        return jdbcTemplate.update(SQL, new Object[]{sta, apply_remarks, admin_arrange, date_check_in, date_move_out, id}) == 1;
    }

    /**
     * 审批申请:退租
     *
     * @param id            流程ID
     * @param user_id       用户工号
     * @param bed_id        床位ID
     * @param sta           审批结果
     * @param apply_remarks 审批备注
     * @return
     */
    public int[] updateApplyStaById(String id, String user_id, String bed_id, String sta, String apply_remarks) {
            String[] sql = new String[3];
            if(sta.equals("1")){
                sql[0] = "UPDATE apartment_bed SET bed_people= null WHERE (bed_id='" + bed_id + "')";//床位设置为空
                sql[1] = "UPDATE userinfo SET user_bed= null WHERE (user_id='" + user_id + "')";//员工设置床位为空
            }
        //sql[2] = "UPDATE apartment_apply set user_id = '"+user_id+"', bed_id = '"+bed_id+"' ,sta = '"+sta+"',apply_remarks = '"+apply_remarks+"' where id='"+id+"'";//申请内容更新
        sql[2] = "UPDATE apartment_apply set sta = '"+sta+"',apply_remarks = '"+apply_remarks+"' where id='"+id+"'";//申请内容更新
        return jdbcTemplate.batchUpdate(sql);
    }

    /**
     * 通过用户工号和page，limit获取数据
     *
     * @param user_id
     * @param page
     * @param limit
     * @return
     */
    public List<ApartmentApplyBean> queryApplyInfoByLimitAndUserIdWithRoleUser(String user_id, int page, int limit, String apply_type, String apply_sta) {
        SQL = "select apartment_apply.*,userinfo.user_name from apartment_apply INNER JOIN userinfo ON apartment_apply.user_id = userinfo.user_id where apartment_apply.user_id = ? ";
        if (!apply_type.equals("") && apply_type != null && !apply_type.equals("2")) {
            SQL += " and apartment_apply.apply_type = " + apply_type;
        }
        if (!apply_sta.equals("") && apply_sta != null && !apply_sta.equals("3")) {
            SQL += " and apartment_apply.sta = " + apply_sta;
        }
        SQL += " ORDER BY apartment_apply.id DESC limit ? , ?";
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.query(SQL, new Object[]{user_id, (page - 1) * limit, limit}, new ApartmentApplyAndUserInfoToListMapper());
    }

    /**
     * 通过用户所属大区和page，limit获取数据
     *
     * @param user_main
     * @param page
     * @param limit
     * @return
     */
    public List<ApartmentApplyBean> queryApplyInfoByLimitAndUserIdWithRoleAdmin(String user_main, int page, int limit, String apply_type, String apply_sta) {
        SQL = "select apartment_apply.*,userinfo.user_name from apartment_apply INNER JOIN userinfo ON apartment_apply.user_id = userinfo.user_id where userinfo.user_main = ? ";
        if (!apply_type.equals("") && apply_type != null && !apply_type.equals("2")) {
            SQL += " and apartment_apply.apply_type = " + apply_type;
        }
        if (!apply_sta.equals("") && apply_sta != null && !apply_sta.equals("3")) {
            SQL += " and apartment_apply.sta = " + apply_sta;
        }
        SQL += " ORDER BY apartment_apply.id DESC limit ? , ?";
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.query(SQL, new Object[]{user_main, (page - 1) * limit, limit}, new ApartmentApplyAndUserInfoToListMapper());
    }


    /**
     * 通过申请ID获取数据：入住
     *
     * @param id
     * @return
     */

    public List<ApartmentApplyBean> queryCheckInApplyInfoById(String id) {
        SQL = "SELECT\n" +
                "userinfo.user_name,\n" +
                "userinfo.user_cardid,\n" +
                "userinfo.user_tel,\n" +
                "userinfo.user_point,\n" +
                "userinfo.user_main,\n" +
                "userinfo.user_sex,\n" +
                "userinfo.date_entry,\n" +
                "userinfo.user_type,\n" +
                "apartment_apply.id,\n" +
                "apartment_apply.user_id,\n" +
                "(SELECT CONCAT_WS('_',apartment_info.apa_name,apartment_info.apa_id)FROM apartment_info WHERE apartment_info.apa_id = apartment_apply.user_intention) AS user_intention,\n" +
                "(SELECT CONCAT_WS('_',apartment_info.apa_name,apartment_info.apa_id)FROM apartment_info WHERE apartment_info.apa_id = apartment_apply.admin_arrange) AS admin_arrange,\n" +
                "apartment_apply.in_reason,\n" +
                "apartment_apply.check_in_type,\n" +
                "apartment_apply.apply_type,\n" +
                "apartment_apply.date_check_in,\n" +
                "apartment_apply.date_move_out,\n" +
                "apartment_apply.sta,\n" +
                "apartment_apply.apply_remarks,\n" +
                "apartment_apply.create_date,\n" +
                "apartment_apply.is_check\n" +
                "FROM\n" +
                "apartment_apply\n" +
                "INNER JOIN userinfo ON apartment_apply.user_id = userinfo.user_id\n" +
                "WHERE apartment_apply.id= ? ";
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.query(SQL, new Object[]{id}, new ApartmentApplyCheckInAndUserInfoMapper());
    }

    /**
     * 通过申请ID获取数据：退租
     *
     * @param id
     * @return
     */
    public List<ApartmentApplyBean> queryCheckOutApplyInfoById(String id) {
        SQL = "SELECT " +
                "apartment_apply.id, " +
                "apartment_apply.user_id, " +
                "apartment_apply.date_move_out, " +
                "apartment_apply.apa_id, " +
                "(SELECT apartment_info.apa_name FROM apartment_info WHERE apartment_apply.apa_id = apartment_info.apa_id) AS apa_name, "+
                "apartment_apply.roo_id, " +
                "(SELECT apartment_room.roo_name FROM apartment_room WHERE apartment_apply.roo_id = apartment_room.roo_id) AS roo_name, "+
                "apartment_apply.bed_id, " +
                "(SELECT apartment_bed.bed_name FROM apartment_bed WHERE apartment_apply.bed_id = apartment_bed.bed_id) AS bed_name, "+
                "apartment_apply.out_reason, " +
                "apartment_apply.sta, " +
                "apartment_apply.apply_remarks, " +
                "apartment_apply.create_date, " +
                "apartment_apply.apply_type, " +
                "userinfo.user_name, " +
                "userinfo.user_tel, " +
                "userinfo.user_point " +
                "FROM " +
                "apartment_apply " +
                "INNER JOIN userinfo ON apartment_apply.user_id = userinfo.user_id " +
                "WHERE " +
                "apartment_apply.id = ?";
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.query(SQL, new Object[]{id}, new ApartmentApplyCheckOutAndUserInfoMapper());
    }


    /**
     * 通过以下条件获取符合的数据列表
     * @param user_id
     * @param sta
     * @param apply_type
     * @param StartDate
     * @param EndDate
     * @param page
     * @param limit
     * @return
     */
    public List<ApartmentApplyBean> queryApplyInfoToLayuiList(String user_id, int sta,int apply_type, int is_check,String StartDate, String EndDate, int page, int limit) {
        SQL = "select apartment_apply.*,(select user_name from userinfo where userinfo.user_id =apartment_apply.user_id )as user_name from apartment_apply where  1=1 ";
        if (user_id != null) {
            SQL += " and user_id like'%" + user_id + "%' ";
        }
        if (sta != 3) {
            SQL += " and sta = " + sta + " ";
        }
        if (apply_type != 2) {
            SQL += " and apply_type = " + apply_type + " ";
        }
        if (is_check != 2) {
            SQL += " and is_check = " + is_check + " ";
        }
        if (StartDate != null && EndDate != null) {
            SQL += " and create_date between  '" + StartDate + " 00:00:00' and  '" + EndDate+" 23:59:59'";
        }
        SQL += " limit ? , ?";
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.query(SQL, new Object[]{(page - 1) * limit, limit}, new ApartmentApplyAndUserInfoToListMapper());
    }

    /**
     * 通过以下条件获取符合的数据条数
     * @param user_id
     * @param sta
     * @param apply_type
     * @param StartDate
     * @param EndDate
     * @return
     */
    public int queryApplyInfoToLayuiList(String user_id, int sta,int apply_type,int is_check, String StartDate, String EndDate) {
        SQL = "select apartment_apply.*,(select user_name from userinfo where userinfo.user_id =apartment_apply.user_id )as user_name from apartment_apply where 1=1 ";
        if (user_id != null) {
            SQL += " and user_id like'%" + user_id + "%' ";
        }
        if (sta != 3) {
            SQL += " and sta = " + sta + " ";
        }
        if (apply_type != 2) {
            SQL += " and apply_type = " + apply_type + " ";
        }
        if (is_check != 2) {
            SQL += " and is_check = " + is_check + " ";
        }
        if (StartDate != null && EndDate != null) {
            SQL += " and create_date between  '" + StartDate + " 00:00:00' and  '" + EndDate+" 23:59:59'";
        }
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.query(SQL, new Object[]{}, new ApartmentApplyAndUserInfoToListMapper()).size();
    }


    /**
     * 提交退租申请
     *
     * @param user_id       用户工号
     * @param bed_id        床位ID
     * @param date_move_out 退租日期
     * @param out_reason    退租原因
     * @param apply_type    申请类型0入住，1退租
     * @return
     * @throws Exception
     */
    public boolean checkOutWithUserIdAndBedId(String user_id, String bed_id, String date_move_out, String out_reason, String apply_type) throws Exception {
        SQL = "insert into apartment_apply (user_id, bed_id, date_move_out, out_reason,apply_type) values (?,?,?,?,?)";
        return jdbcTemplate.update(SQL, new Object[]{user_id, bed_id, date_move_out, out_reason, apply_type}) == 1;
    }



    /**
     * 通过用户工号判断用户是否存在未审批的申请
     *
     * @param user_id       用户工号
     * @return
     * @throws Exception
     */
    public int  checkUserIsHaveAApplyNotAdopt(String user_id) throws Exception {
        SQL = "SELECT * FROM apartment_apply WHERE apartment_apply.sta = 0 AND apartment_apply.user_id = ? ";
        return jdbcTemplate.query(SQL,new Object[]{user_id}, new ApartmentApplyAllInfoMapper()).size();
    }

}