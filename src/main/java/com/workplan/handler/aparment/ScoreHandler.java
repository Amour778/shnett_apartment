package com.workplan.handler.aparment;

import com.workplan.bean.apartment.ApartmentInfoBean;
import com.workplan.bean.apartment.NoticeBean;
import com.workplan.bean.apartment.ScoreBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.wx.jwtToken.annotation.Authorization;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/wx")
public class ScoreHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(ScoreHandler.class);
    List<ScoreBean> scoreList = new ArrayList<ScoreBean>();
    ScoreBean scoreBean = new ScoreBean();

    /**
     * 判断用户是否评价过，如果评价过或未入住则不可评价，如果未评价过，则返回用户的入住信息
     * @param user_id
     * @return
     * @throws Exception
     */
    @Authorization
    @RequestMapping(value = "/checkUserScoreIsHave")
    @ResponseBody
    public String checkUserScoreIsHave(String user_id) throws Exception {
       List<ApartmentInfoBean> apa_list = apartmentInfoDao.getUserCheckInInfo(user_id);
       if(apa_list.size()==0){
           return ResultMessage.MessageToJson(1,"NO");
       }
       String apa_id = apa_list.get(0).getApa_id();
       logger.info("用户工号" +user_id+",入住的公寓ID为:"+apa_id);
        //判断是否已经评价过
       scoreList = scoreDao.queryOneScoreByApaIdAndUserId(apa_id,user_id);
       if(scoreList.size()!=0){
           return ResultMessage.ListToJson(1,scoreList);
       }
       return ResultMessage.ListToJson(0,apa_list);
    }

    /**
     * 添加评价
     * @param apa_id
     * @param user_id
     * @param score
     * @param remark
     * @return
     * @throws Exception
     */
    @Authorization
    @RequestMapping(value = "/addNewScore")
    @ResponseBody
    public String addNewScore(String apa_id, String user_id, int score, String  remark) throws Exception {
        if(scoreDao.addNewScore(apa_id, user_id, score, remark)){
            return ResultMessage.MessageToJson(0,"评价成功");
        }
        return ResultMessage.MessageToJson(1,"评价失败");
    }


}