package com.workplan.handler.controller;

import com.workplan.bean.apartment.SignInBean;
import com.workplan.dao.BaseDao;
import com.workplan.tools.GetDateTimeNow;
import com.workplan.tools.ResultMessage;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

@Controller
public class SignInController implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(SignInController.class);
    List<SignInBean> scoreList = new ArrayList<SignInBean>();
    SignInBean scoreBean = new SignInBean();


    /**
     * 通过用户工号和年月获取签到信息
     * @param user_id
     * @param year_month
     * @param day
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value = "/querySignInInfo")
    @ResponseBody
    public String querySignInInfo(String user_id, String year_month,String day ,int page,int limit) {
        if(year_month==""){
            year_month=null;
        }
        if(day==""){
            day=null;
        }else{
            year_month = day.split("-")[0]+"-"+day.split("-")[1];
            day = day.split("-")[2];
        }
        if(user_id.equals("")){
            user_id=null;
        }
        try {
            scoreList = signInDao.querySignInInfoToLayui(user_id, year_month, day, page, limit);
            int count = signInDao.querySignInInfoToLayui(user_id, year_month, day);
             return ResultMessage.ListToLayuiTable(count, scoreList);
        } catch (Exception e) {
            logger.info(e.getMessage());
            return ResultMessage.ListToLayuiTableWithErr("获取数据异常："+e.getMessage());
        }
    }
}