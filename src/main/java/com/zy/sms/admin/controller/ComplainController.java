package com.zy.sms.admin.controller;

import com.zy.sms.Constant;
import com.zy.sms.admin.entity.ComplainEntity;
import com.zy.sms.admin.entity.ComplainReplyEntity;
import com.zy.sms.admin.service.ComplainService;
import com.zy.sms.base.controller.BaseController;
import com.zy.sms.util.QueryHelper;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/complain")
public class ComplainController extends BaseController {

    @Autowired
    private ComplainService complainService;

    @RequestMapping("/complainListUI.do")
    public ModelAndView listUI(HttpServletRequest request) throws Exception{
        ModelAndView model=new ModelAndView("admin/complain/complainListUI");
        model.addObject("complainStateMap", ComplainEntity.COMPLAIN_STATE_MAP);
        //查询
        QueryHelper queryHelper = new QueryHelper(ComplainEntity.class, "c");
        //是否添加条件
        try {
            int index=0;
            //开始时间
            String startTime=request.getParameter("startTime");
            if(!StringUtils.isEmpty(startTime)){
                queryHelper.addCondition("c.compTime >= ?"+index,
                        DateUtils.parseDate(startTime+" 00:00:00", "yyyy-MM-dd HH:mm:ss"));
                index++;
            }
            //结束时间
            String endTime=request.getParameter("endTime");
            if(!StringUtils.isEmpty(endTime)){
                queryHelper.addCondition("c.compTime <= ?"+index,
                        DateUtils.parseDate(endTime+" 23:59:59", "yyyy-MM-dd HH:mm:ss"));
                index++;
            }
            //标题
            String compTitle=request.getParameter("compTitle");
            if(!StringUtils.isEmpty(compTitle)){
                queryHelper.addCondition("c.compTitle like ?"+index, "%" + compTitle + "%");
                index++;
            }
            //状态
            String state=request.getParameter("state");
            if(!StringUtils.isEmpty(state)){
                for (Map.Entry<String, String> m :ComplainEntity.COMPLAIN_STATE_MAP.entrySet())  {
                    if (m.getValue().equals(state)) {
                        String key = m.getKey();
                        queryHelper.addCondition("c.state=?"+index,key);
                        break;
                    }
                }
            }
            //按照投诉状态升序排序
            queryHelper.addOrderByProperty("c.state", QueryHelper.ORDER_BY_ASC);
            //按照投诉时间升序排序
            queryHelper.addOrderByProperty("c.compTime", QueryHelper.ORDER_BY_ASC);
            String page=request.getParameter("page"); //页数跳转
            if (!StringUtils.isEmpty(page)){
                int curreentPage=Integer.parseInt(page);
                pageResult=complainService.getPageResult(queryHelper,curreentPage,getPageSize());
            }else {
                pageResult = complainService.getPageResult(queryHelper, getCurrentPage(), getPageSize());
            }
            model.addObject("pageResult",pageResult);
        } catch (Exception e) {
            throw new Exception(e);
        }
        return model;
    }

    //跳转到受理页面
    @RequestMapping("/dealUI.do")
    public ModelAndView dealUI(ComplainEntity complain){
        //加载状态集合
        ModelAndView model=new ModelAndView("admin/complain/dealUI");
        if (complain!=null){
            complain=complainService.findObjectById(complain.getCompId());
            if (ComplainEntity.COMPLAIN_STATE_UNDONE.equals(complain.getState())){
                String type=ComplainEntity.COMPLAIN_STATE_MAP.get(ComplainEntity.COMPLAIN_STATE_UNDONE);
                model.addObject("type",type);
            }else if (ComplainEntity.COMPLAIN_STATE_DONE.equals(complain.getState())){
                String type=ComplainEntity.COMPLAIN_STATE_MAP.get(ComplainEntity.COMPLAIN_STATE_DONE);
                model.addObject("type",type);
            }
        }
        model.addObject("complain", complain);
        return model;
    }

    //处理投诉
    @ResponseBody
    @RequestMapping("/dealComplain.do")
    public Map dealComplain(ComplainReplyEntity replyer,HttpServletRequest request) {
        Map<String,String> map=new HashMap<String, String>();
        String compId = request.getParameter("compId");
        if (!StringUtils.isEmpty(compId) && replyer != null) {
            ComplainEntity item = complainService.findObjectById(compId);
            //1、更新投诉的状态为 已受理
            if (!ComplainEntity.COMPLAIN_STATE_DONE.equals(item.getState())) {//更新状态为 已受理
                item.setState(ComplainEntity.COMPLAIN_STATE_DONE);
            }
            //2、保存回复信息
            if (replyer != null) {
                replyer.setComplain(item);
                replyer.setReplyTime(new Timestamp(new Date().getTime()));
                item.getComplainReplies().add(replyer);
            }
            complainService.update(item);
            map.put("tip", "success");
            map.put("msg", Constant.dealComplainSuccess);
        }else {
            map.put("tip", "failure");
            map.put("msg", Constant.dealComplainSuccess);
        }
        return map;
    }

    //处理投诉
   /* @RequestMapping("/dealComplain.do")
    public String dealComplain(ComplainReplyEntity replyer,HttpServletRequest request){
        String compId=request.getParameter("compId");
        if(!StringUtils.isEmpty(compId) && replyer!=null){
            ComplainEntity item = complainService.findObjectById(compId);
            //1、更新投诉的状态为 已受理
            if(!ComplainEntity.COMPLAIN_STATE_DONE.equals(item.getState())){//更新状态为 已受理
                item.setState(ComplainEntity.COMPLAIN_STATE_DONE);
            }
            //2、保存回复信息
            if(replyer != null){
                replyer.setComplain(item);
                replyer.setReplyTime(new Timestamp(new Date().getTime()));
                item.getComplainReplies().add(replyer);
            }
            complainService.update(item);
            request.setAttribute("msg", Constant.dealComplainSuccess);
            return "forward:/complain/complainListUI.do";
        }
        request.setAttribute("msg",Constant.dealComplainFailure);
        return "admin/complain/dealUI";
    }*/
}
