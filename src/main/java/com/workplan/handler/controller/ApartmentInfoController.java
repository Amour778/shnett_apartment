package com.workplan.handler.controller;

import com.workplan.bean.apartment.ApartmentInfoBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.ExportExcelUtil;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ApartmentInfoController implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(ApartmentInfoController.class);
    List<ApartmentInfoBean> apartmentInfoList = new ArrayList<ApartmentInfoBean>();
    ApartmentInfoBean apartmentInfoBean = new ApartmentInfoBean();

    /**
     * 根据公寓名称获取公寓信息
     *
     * @param apa_name
     * @param page
     * @param limit
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getApartmentInfoByInputs", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getApartmentInfoByInputs(String apa_name, int page, int limit) throws Exception {
        if (apa_name.replaceAll(" ", "").equals("")) {
            apa_name = null;
        }
        apartmentInfoList = apartmentInfoDao.getApartmentInfoByInputsToLayui(apa_name, page, limit);
        int count = apartmentInfoDao.getApartmentInfoByInputsToLayui(apa_name);
        return ResultMessage.ListToLayuiTable(count, apartmentInfoList);
    }

    /**
     * 获取所有公寓
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getAllApartmentInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getAllApartmentInfo() throws Exception {
        apartmentInfoList = apartmentInfoDao.queryAllApartmentInfoForList();
        String apartment_info = "";
        for (int a = 0; a < apartmentInfoList.size(); a++) {
            apartment_info += "{\"name\":\"" + apartmentInfoList.get(a).getApa_name() + "\" ,\"value\":\"" + apartmentInfoList.get(a).getApa_id() + "\"},";
        }
        return ResultMessage.ListToFormSelects(apartment_info);
    }

    /**
     * 更新公寓信息
     *
     * @param apa_id       公寓唯一ID
     * @param apa_name     公寓名称
     * @param apa_province 公寓地址：省
     * @param apa_city     公寓地址：市
     * @param apa_area     公寓地址：区
     * @param apa_address  具体地址
     * @param apa_user     公寓联系人
     * @param apa_tel      联系号码
     * @param apa_local    公寓所在地址经纬度
     * @param apa_remarks  备注
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateApartmentInfoByApartmentId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String updateApartmentInfoByApartmentId(String apa_id, String apa_name, String apa_province, String apa_city, String apa_area,
                                                   String apa_address, String apa_user, String apa_tel, String apa_local, String apa_remarks) throws Exception {
        try {
            if (apa_id == null) {
                return ResultMessage.MessageToJson(1, "公寓ID获取异常");
            }
            if (apartmentInfoDao.updateApartmentInfoByApartmentId(apa_id, apa_name, apa_province, apa_city, apa_area, apa_address, apa_user, apa_tel, apa_local, apa_remarks)) {
                return ResultMessage.MessageToJson(0, "更新成功");
            } else {
                return ResultMessage.MessageToJson(1, "更新失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "更新失败:" + e.getMessage());
        }

    }

    /**
     * 添加公寓信息
     *
     * @param apa_name     公寓名称
     * @param apa_province 公寓地址：省
     * @param apa_city     公寓地址：市
     * @param apa_area     公寓地址：区
     * @param apa_address  具体地址
     * @param apa_user     公寓联系人
     * @param apa_tel      联系号码
     * @param apa_local    公寓所在地址经纬度
     * @param apa_remarks  备注
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addNewApartmentInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addNewApartmentInfo(String apa_name, String apa_province, String apa_city, String apa_area,
                                      String apa_address, String apa_user, String apa_tel, String apa_local, String apa_remarks) {
        try {
            String apa_id = "A" + GetDateTimeNow.getDateTimeRandomToID();
            if (apartmentInfoDao.addNewApartmentInfo(apa_id, apa_name, apa_province, apa_city, apa_area, apa_address, apa_user, apa_tel, apa_local, apa_remarks)) {
                return ResultMessage.MessageToJson(0, "添加成功");
            } else {
                return ResultMessage.MessageToJson(1, "添加失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "添加失败:" + e.getMessage());
        }
    }

    /**
     * 删除公寓信息
     *
     * @param apa_id 公寓ID
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteApartmentInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteApartmentInfo(String apa_id) {
        try {
            apartmentInfoDao.deleteApartmentInfo(apa_id);
            return ResultMessage.MessageToJson(0, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "删除失败:" + e.getMessage());
        }
    }

    /**
     * 通过公寓ID 和 员工ID 获取对应数据[公寓->房间->床位->员工]
     *
     * @param apa_id  公寓ID
     * @param user_id 员工ID
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getApartmentToUserInfoByApaIdAndUserId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getApartmentToUserInfoByApaIdAndUserId(String apa_id, String user_id, int page, int limit) {
        try {
            apartmentInfoList = apartmentInfoDao.getApartmentToUserInfoByApaIdAndUserId(apa_id, user_id, page, limit);
            int count = apartmentInfoDao.getApartmentToUserInfoByApaIdAndUserId(apa_id, user_id);
            return ResultMessage.ListToLayuiTable(count, apartmentInfoList);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "获取数据异常");
        }
    }

    /**
     * 导出：以公寓为基础
     * @param response
     */
    @RequestMapping(value = "/LinkApartmentAndUserToExport", produces = "text/html;charset=UTF-8")
    public void LinkApartmentAndUserToExport(HttpServletResponse response) {
        OutputStream oStream = null;
        logger.info("导出准备");
        try {
            /*String[] headers = {"公寓名称", "省", "市", "区", "具体地址", "公寓联系人", "联系号码", "经纬度", "公寓备注信息", "房间名称", "楼层", "几人间 ", "房间备注", "房间价格", "房间配置", "床位",
                    "用户工号", "用户姓名", "身份证号", "手机号码", "所属大区", "所属网点", "状态", "性别", "用户积分", "入职日期", "用工类型"};
*/
            String[] headers = {"公寓名称", "省", "市", "区", "具体地址", "公寓联系人", "联系号码", "经纬度", "公寓备注信息", "房间名称", "楼层", "几人间 ", "房间备注", "房间价格", "房间配置", "床位",
                    "用户工号", "用户姓名", "身份证号", "手机号码", "所属大区", "所属网点","入职日期"};
            //创建工作簿
            HSSFWorkbook wb = new HSSFWorkbook();
            //创建sheet
            HSSFSheet sheet = wb.createSheet("公寓入住详情-床位对应工号");
            //创建表头
            HSSFRow row = sheet.createRow(0);
            logger.info("循环表头");
            for (int a = 0; a < headers.length; a++) {
                HSSFCell cell = row.createCell(a);
                cell.setCellValue(headers[a]);
            }
            logger.info("获取数据");
            apartmentInfoList = apartmentInfoDao.LinkApartmentAndUserToExport();
            logger.info("获取到目标数据，条数："+apartmentInfoList.size());
            logger.info("导出的前期准备工作完成，开始循环数据");
            for (int i = 0; i < apartmentInfoList.size(); i++) {
                ApartmentInfoBean apa = apartmentInfoList.get(i);
                //创建表头
                HSSFRow lrow = sheet.createRow(i + 1);
                //创建单元格
                HSSFCell lcell = lrow.createCell(0);
                lcell.setCellValue(apa.getApa_name());
                HSSFCell lcell1 = lrow.createCell(1);
                lcell1.setCellValue(apa.getApa_province());
                HSSFCell lcell2 = lrow.createCell(2);
                lcell2.setCellValue(apa.getApa_city());
                HSSFCell lcell3 = lrow.createCell(3);
                lcell3.setCellValue(apa.getApa_area());
                HSSFCell lcell4 = lrow.createCell(4);
                lcell4.setCellValue(apa.getApa_address());
                HSSFCell lcell5 = lrow.createCell(5);
                lcell5.setCellValue(apa.getApa_user());
                HSSFCell lcell6 = lrow.createCell(6);
                lcell6.setCellValue(apa.getApa_tel());
                HSSFCell lcell7 = lrow.createCell(7);
                lcell7.setCellValue(apa.getApa_local());
                HSSFCell lcell8 = lrow.createCell(8);
                lcell8.setCellValue(apa.getApa_remarks());

                HSSFCell lcell9 = lrow.createCell(9);
                lcell9.setCellValue(apa.getRoo_name());
                HSSFCell lcell10 = lrow.createCell(10);
                lcell10.setCellValue(apa.getRoo_floor());
                HSSFCell lcell11 = lrow.createCell(11);
                lcell11.setCellValue(apa.getRoo_people());
                HSSFCell lcell12 = lrow.createCell(12);
                lcell12.setCellValue(apa.getRoo_remarks());
                HSSFCell lcell13 = lrow.createCell(13);
                lcell13.setCellValue(apa.getRoo_price());
                HSSFCell lcell14 = lrow.createCell(14);
                lcell14.setCellValue(apa.getRoo_allocation());

                HSSFCell lcell15 = lrow.createCell(15);
                lcell15.setCellValue(apa.getBed_name());

                HSSFCell lcell16 = lrow.createCell(16);
                lcell16.setCellValue(apa.getUser_id());
                HSSFCell lcell17 = lrow.createCell(17);
                lcell17.setCellValue(apa.getUser_name());
                HSSFCell lcell18 = lrow.createCell(18);
                lcell18.setCellValue(apa.getUser_cardid());
                HSSFCell lcell19 = lrow.createCell(19);
                lcell19.setCellValue(apa.getUser_tel());
                HSSFCell lcell20 = lrow.createCell(20);
                lcell20.setCellValue(apa.getUser_main());
                HSSFCell lcell21 = lrow.createCell(21);
                lcell21.setCellValue(apa.getUser_point());
                HSSFCell lcell22 = lrow.createCell(22);
                lcell22.setCellValue(apa.getDate_entry());
               /* HSSFCell lcell22 = lrow.createCell(22);
                if (apa.getSta() == 0) {
                    lcell22.setCellValue("禁用");
                } else if (apa.getSta() == 1) {
                    lcell22.setCellValue("启用");
                } else {
                    lcell22.setCellValue("未知");
                }
                HSSFCell lcell23 = lrow.createCell(23);
                if (apa.getUser_sex() == 0) {
                    lcell23.setCellValue("女");
                } else if (apa.getUser_sex() == 1) {
                    lcell23.setCellValue("男");
                } else {
                    lcell23.setCellValue("未知");
                }
                HSSFCell lcell24 = lrow.createCell(24);
                lcell24.setCellValue(apa.getUser_integral());
                HSSFCell lcell25 = lrow.createCell(25);
                lcell25.setCellValue(apa.getDate_entry());
                HSSFCell lcell26 = lrow.createCell(26);
                if (apa.getUser_type() == 0) {
                    lcell26.setCellValue("社招");
                } else if (apa.getUser_type() == 1) {
                    lcell26.setCellValue("实习生");
                } else if (apa.getUser_type() == 2) {
                    lcell26.setCellValue("非新工");
                } else {
                    lcell26.setCellValue("未知");
                }
*/
            }
            logger.info("数据循环完成");
            String fileName = "公寓入住详情" + GetDateTimeNow.getDateTimeRandomToID();
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


    /**
     * 导出：以工号为基础
     * @param response
     */
    @RequestMapping(value = "/LinkUserAndApartmentToExport", produces = "text/html;charset=UTF-8")
    public void LinkUserAndApartmentToExport(HttpServletResponse response) {
        OutputStream oStream = null;
        logger.info("导出准备");
        try {
            /*String[] headers = {"公寓名称", "省", "市", "区", "具体地址", "公寓联系人", "联系号码", "经纬度", "公寓备注信息", "房间名称", "楼层", "几人间 ", "房间备注", "房间价格", "房间配置", "床位",
                    "用户工号", "用户姓名", "身份证号", "手机号码", "所属大区", "所属网点", "状态", "性别", "用户积分", "入职日期", "用工类型"};
*/
            String[] headers = { "用户工号", "用户姓名", "身份证号", "手机号码", "所属大区", "所属网点","入职日期",
                    "床位",
                    "房间名称", "楼层", "几人间 ", "房间备注", "房间价格", "房间配置",
                    "公寓名称", "省", "市", "区", "具体地址", "公寓联系人", "联系号码", "经纬度", "公寓备注信息"};
            //创建工作簿
            HSSFWorkbook wb = new HSSFWorkbook();
            //创建sheet
            HSSFSheet sheet = wb.createSheet("公寓入住详情-工号对应床位");
            //创建表头
            HSSFRow row = sheet.createRow(0);
            logger.info("循环表头");
            for (int a = 0; a < headers.length; a++) {
                HSSFCell cell = row.createCell(a);
                cell.setCellValue(headers[a]);
            }
            logger.info("获取数据");
            apartmentInfoList = apartmentInfoDao.LinkUserAndApartmentToExport();
            logger.info("获取到目标数据，条数："+apartmentInfoList.size());
            logger.info("导出的前期准备工作完成，开始循环数据");
            for (int i = 0; i < apartmentInfoList.size(); i++) {
                ApartmentInfoBean apa = apartmentInfoList.get(i);
                //创建表头
                HSSFRow lrow = sheet.createRow(i + 1);
                //创建单元格
                HSSFCell lcell16 = lrow.createCell(0);
                lcell16.setCellValue(apa.getUser_id());
                HSSFCell lcell17 = lrow.createCell(1);
                lcell17.setCellValue(apa.getUser_name());
                HSSFCell lcell18 = lrow.createCell(2);
                lcell18.setCellValue(apa.getUser_cardid());
                HSSFCell lcell19 = lrow.createCell(3);
                lcell19.setCellValue(apa.getUser_tel());
                HSSFCell lcell20 = lrow.createCell(4);
                lcell20.setCellValue(apa.getUser_main());
                HSSFCell lcell21 = lrow.createCell(5);
                lcell21.setCellValue(apa.getUser_point());
                HSSFCell lcell22 = lrow.createCell(6);
                lcell22.setCellValue(apa.getDate_entry());


                HSSFCell lcell15 = lrow.createCell(7);
                lcell15.setCellValue(apa.getBed_name());


                HSSFCell lcell9 = lrow.createCell(8);
                lcell9.setCellValue(apa.getRoo_name());
                HSSFCell lcell10 = lrow.createCell(9);
                lcell10.setCellValue(apa.getRoo_floor());
                HSSFCell lcell11 = lrow.createCell(10);
                lcell11.setCellValue(apa.getRoo_people());
                HSSFCell lcell12 = lrow.createCell(11);
                lcell12.setCellValue(apa.getRoo_remarks());
                HSSFCell lcell13 = lrow.createCell(12);
                lcell13.setCellValue(apa.getRoo_price());
                HSSFCell lcell14 = lrow.createCell(13);
                lcell14.setCellValue(apa.getRoo_allocation());

                HSSFCell lcell = lrow.createCell(14);
                lcell.setCellValue(apa.getApa_name());
                HSSFCell lcell1 = lrow.createCell(15);
                lcell1.setCellValue(apa.getApa_province());
                HSSFCell lcell2 = lrow.createCell(16);
                lcell2.setCellValue(apa.getApa_city());
                HSSFCell lcell3 = lrow.createCell(17);
                lcell3.setCellValue(apa.getApa_area());
                HSSFCell lcell4 = lrow.createCell(18);
                lcell4.setCellValue(apa.getApa_address());
                HSSFCell lcell5 = lrow.createCell(19);
                lcell5.setCellValue(apa.getApa_user());
                HSSFCell lcell6 = lrow.createCell(20);
                lcell6.setCellValue(apa.getApa_tel());
                HSSFCell lcell7 = lrow.createCell(21);
                lcell7.setCellValue(apa.getApa_local());
                HSSFCell lcell8 = lrow.createCell(22);
                lcell8.setCellValue(apa.getApa_remarks());




               /* HSSFCell lcell22 = lrow.createCell(22);
                if (apa.getSta() == 0) {
                    lcell22.setCellValue("禁用");
                } else if (apa.getSta() == 1) {
                    lcell22.setCellValue("启用");
                } else {
                    lcell22.setCellValue("未知");
                }
                HSSFCell lcell23 = lrow.createCell(23);
                if (apa.getUser_sex() == 0) {
                    lcell23.setCellValue("女");
                } else if (apa.getUser_sex() == 1) {
                    lcell23.setCellValue("男");
                } else {
                    lcell23.setCellValue("未知");
                }
                HSSFCell lcell24 = lrow.createCell(24);
                lcell24.setCellValue(apa.getUser_integral());
                HSSFCell lcell25 = lrow.createCell(25);
                lcell25.setCellValue(apa.getDate_entry());
                HSSFCell lcell26 = lrow.createCell(26);
                if (apa.getUser_type() == 0) {
                    lcell26.setCellValue("社招");
                } else if (apa.getUser_type() == 1) {
                    lcell26.setCellValue("实习生");
                } else if (apa.getUser_type() == 2) {
                    lcell26.setCellValue("非新工");
                } else {
                    lcell26.setCellValue("未知");
                }
*/
            }
            logger.info("数据循环完成");
            String fileName = "公寓入住详情" + GetDateTimeNow.getDateTimeRandomToID();
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


    /**
     * 获取床位入住率-人员为基准
     * @return
     */
    @RequestMapping(value = "/getUserCheckInCounts", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getUserCheckInCounts() {
        int in = 0 ,not_in=0;
        try {
            in =userinfoDao.getUserCheckInCounts(false);
            not_in =userinfoDao.getUserCheckInCounts(true);
            return ResultMessage.MessageToJson(0,in+"",not_in+"");
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"code\": 1,\"info\":\"获取数据异常：" + e.getMessage() + "\"}";

        }
    }

    /**
     * 获取床位入住率-公寓为基准
     * @return
     */
    @RequestMapping(value = "/getBedCheckInCounts", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getBedCheckInCounts(String apa_id) {
        if (apa_id.equals("")) {
            apa_id = null;
        }
        int in = 0 ,not_in=0;
        try {
            in = apartmentBedDao.getBedCheckInCounts(false,apa_id);
            not_in = apartmentBedDao.getBedCheckInCounts(true,apa_id);
            return ResultMessage.MessageToJson(0,in+"",not_in+"");
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"code\": 1,\"info\":\"获取数据异常：" + e.getMessage() + "\"}";

        }
    }
}
