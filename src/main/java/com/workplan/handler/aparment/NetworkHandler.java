package com.workplan.handler.aparment;

import com.workplan.bean.apartment.NetworkBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.wx.jwtToken.annotation.Authorization;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping(value = "/wx")
public class NetworkHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(NetworkHandler.class);
    List<NetworkBean> networkList = new ArrayList<NetworkBean>();
    NetworkBean networkBean = new NetworkBean();


    /**
     * 获取所有分点部
     * @return
     * @throws Exception
     */

    @RequestMapping(value = "/queryAllNetworkInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String queryAllNetworkInfo() throws Exception {
        networkList = networkDao.queryAllNetworkInfo();
        String mess="";
        for (int a= 0;a<networkList.size();a++){
            mess+="{\"apa_name\":\""+networkList.get(a).getMainId()+"-"+networkList.get(a).getPointId()+networkList.get(a).getPoint_name()+"\",\"apa_id\":\""+networkList.get(a).getMainId()+"-"+networkList.get(a).getPointId()+"\",\"isShow\": true},";
        }
        return ResultMessage.ListToFormSelects(mess);
    }


}
