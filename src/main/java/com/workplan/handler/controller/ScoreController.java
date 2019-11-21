package com.workplan.handler.controller;

import com.workplan.bean.apartment.ScoreBean;
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
public class ScoreController implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(ScoreController.class);
    List<ScoreBean> scoreList = new ArrayList<ScoreBean>();
    ScoreBean scoreBean = new ScoreBean();

    /**
     * 搜索评价
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value = "/queryAllScoreInfoByLimit")
    @ResponseBody
    public String queryAllScoreInfoByLimit(String apa_id,String user_id ,int page, int limit) {
        try {
            if(apa_id.equals("")){
                apa_id=null;
            }
            if(user_id.equals("")){
                user_id=null;
            }
            scoreList = scoreDao.queryAllScoreInfoByUserId(apa_id, user_id, page, limit);
            int count=scoreDao.queryAllScoreInfoByUserIdCount(apa_id, user_id);
            return ResultMessage.ListToLayuiTable(count,scoreList);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.ListToLayuiTableWithErr("获取数据错误:"+e.getMessage());
        }
    }

    /**
     * 导出公寓服务评价数据
     * @param response
     */
    @RequestMapping(value = "/exportScoreByAPaIdOrUserId", produces = "text/html;charset=UTF-8")
    public void exportScoreByAPaIdOrUserId(HttpServletResponse response) {
        OutputStream oStream = null;
        logger.info("导出准备");
        try {
            String[] headers = {"公寓名称", "用户工号","姓名", "评分", "备注", "评分日期"};
            //创建工作簿
            HSSFWorkbook wb = new HSSFWorkbook();
            //创建sheet
            HSSFSheet sheet = wb.createSheet("公寓服务评价");
            //创建表头
            HSSFRow row = sheet.createRow(0);
            logger.info("循环表头");
            for (int a = 0; a < headers.length; a++) {
                HSSFCell cell = row.createCell(a);
                cell.setCellValue(headers[a]);
            }
            logger.info("获取数据");
            scoreList = scoreDao.queryScoreByApaIdOrUserId(null,null);
            logger.info("获取到目标数据，条数："+scoreList.size());
            logger.info("导出的前期准备工作完成，开始循环数据");
            for (int i = 0; i < scoreList.size(); i++) {
                ScoreBean score = scoreList.get(i);
                //创建表头
                HSSFRow lrow = sheet.createRow(i + 1);
                //创建单元格
                HSSFCell lcell = lrow.createCell(0);
                lcell.setCellValue(score.getApa_name());
                HSSFCell lcell11 = lrow.createCell(1);
                lcell11.setCellValue(score.getUser_id());
                HSSFCell lcell12 = lrow.createCell(2);
                lcell12.setCellValue(score.getUser_name());
                HSSFCell lcell13 = lrow.createCell(3);
                lcell13.setCellValue(score.getScore());
                HSSFCell lcell4 = lrow.createCell(5);
                lcell4.setCellValue(score.getCreate_date());
                HSSFCell lcell5 = lrow.createCell(4);
                lcell5.setCellValue(score.getRemark());

            }
            logger.info("数据循环完成");
            String fileName = "公寓服务评价" + GetDateTimeNow.getDateTimeRandomToID();
            logger.info("导出的表格名称为："+fileName);
            //根据response获取输出流
            response.setContentType("application/force-download"); // 设置下载类型
            response.setHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes("utf-8"),"ISO8859-1")+ ".xls"); // 设置文件的名称
            oStream = response.getOutputStream(); // 输出流
            logger.info("把工作薄写入到输出流");
            //把工作薄写入到输出流
            wb.write(oStream);
            logger.info("完成");
        } catch (Exception e) {
            logger.info("导出异常！"+e.getMessage());
            try {
                oStream.close();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }
    }
}