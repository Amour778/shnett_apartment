package com.workplan.dao.apartment;

import com.workplan.bean.apartment.SignInBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SignInDao {
    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    String SQL;
    SignInBean info = new SignInBean();
    List<SignInBean> list = new ArrayList<SignInBean>();

    class SignInMapper implements RowMapper<SignInBean> {
        public SignInBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            info = new SignInBean();
            info.setSid(rs.getInt("sid"));
            info.setUser_id(rs.getString("user_id"));
            info.setSign_year(rs.getString("sign_year"));
            info.setSign_month(rs.getString("sign_month"));
            info.setSign_day(rs.getString("sign_day"));
            return info;
        }
    }


    /**
     * 添加签到
     * @param user_id
     * @param sign_year
     * @param sign_month
     * @param sign_day
     * @return
     */
    public boolean addSignIn(String user_id, String sign_year, String sign_month, String sign_day) {
        SQL = "INSERT INTO sign_in (user_id, sign_year, sign_month, sign_day) VALUES (?,?,?,?);";
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.update(SQL, new Object[]{user_id, sign_year, sign_month, sign_day})==1;
    }


    /**
     * 通过用户工号和年月获取签到信息
     *
     * @param user_id
     * @param sign_year
     * @param sign_month
     * @return
     */
    public List<SignInBean> querySignInInfoByUserIdAndYearAndMonth(String user_id, String sign_year, String sign_month) {
        SQL = "SELECT\n" +
                "sign_in.sid,\n" +
                "sign_in.user_id,\n" +
                "sign_in.sign_year,\n" +
                "sign_in.sign_month,\n" +
                "sign_in.sign_day\n" +
                "FROM\n" +
                "sign_in\n" +
                "WHERE\n" +
                "sign_in.user_id = ? AND\n" +
                "sign_in.sign_year = ? AND\n" +
                "sign_in.sign_month = ? \n";
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.query(SQL, new Object[]{user_id, sign_year, sign_month}, new SignInMapper());
    }


    /**
     * 通过用户工号和年月获取签到信息
     * @param user_id
     * @param year_month
     * @param day
     * @param page
     * @param limit
     * @return
     */
    public List<SignInBean> querySignInInfoToLayui(String user_id, String year_month,String day ,int page,int limit) {
        SQL = "SELECT\n" +
                "sign_in.sid,\n" +
                "sign_in.user_id,\n" +
                "sign_in.sign_year,\n" +
                "sign_in.sign_month,\n" +
                "sign_in.sign_day\n" +
                "FROM\n" +
                "sign_in\n" +
                "WHERE 1=1 ";
        if(user_id!=null){
            SQL+=" AND user_id= '"+user_id+"'";
        }
        if(year_month!=null){
            SQL+=" AND sign_year= '"+year_month.split("-")[0]+"' AND sign_month = '"+year_month.split("-")[1]+"'";
        }
        if(day!=null){
            SQL+=" AND sign_day= '"+day+"'";
        }
        SQL+=" limit ? , ?";
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.query(SQL, new Object[]{(page - 1) * limit, limit}, new SignInMapper());
    }


    /**
     * 通过用户工号和年月获取签到信息
     * @param user_id
     * @param year_month
     * @param day
     * @return
     */
    public int querySignInInfoToLayui(String user_id, String year_month,String day) {
        SQL = "SELECT\n" +
                "sign_in.sid,\n" +
                "sign_in.user_id,\n" +
                "sign_in.sign_year,\n" +
                "sign_in.sign_month,\n" +
                "sign_in.sign_day\n" +
                "FROM\n" +
                "sign_in\n" +
                "WHERE 1=1 ";
        if(user_id!=null){
            SQL+=" AND user_id= '"+user_id+"'";
        }
        if(year_month!=null){
            SQL+=" AND sign_year= '"+year_month.split("-")[0]+"' AND sign_month = '"+year_month.split("-")[1]+"'";
        }
        if(day!=null){
            SQL+=" AND sign_day= '"+day+"'";
        }
        System.out.println("SQL=" + SQL);
        return jdbcTemplate.query(SQL,  new SignInMapper()).size();
    }


}