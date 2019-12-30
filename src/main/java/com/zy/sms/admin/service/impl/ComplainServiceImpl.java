package com.zy.sms.admin.service.impl;

import com.zy.sms.admin.dao.ComplainDao;
import com.zy.sms.admin.entity.ComplainEntity;
import com.zy.sms.admin.service.ComplainService;
import com.zy.sms.base.service.BaseServiceImpl;
import com.zy.sms.util.QueryHelper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.List;

@Service
public class ComplainServiceImpl extends BaseServiceImpl<ComplainEntity> implements ComplainService {

    private ComplainDao complainDao;

    @Resource(name = "complainDaoImpl")
    public void setBaseDao(ComplainDao complainDao){
        super.setBaseBao(complainDao);
        this.complainDao=complainDao;
    }


    @Override
    public void autoDeal() {
        //开始时间
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_MONTH, 1);//设置当前时间的日期为1号
        cal.set(Calendar.HOUR_OF_DAY, 0);//设置当前时间的日期为1号,0时
        cal.set(Calendar.MINUTE, 0);//设置当前时间的日期为1号,0分
        cal.set(Calendar.SECOND, 0);//设置当前时间的日期为1号,0秒

        //查询本月之前的待受理的投诉列表
        QueryHelper queryHelper = new QueryHelper(ComplainEntity.class, "c");
        queryHelper.addCondition("c.state=?1", ComplainEntity.COMPLAIN_STATE_UNDONE);
        queryHelper.addCondition("c.compTime < ?2", cal.getTime());//本月1号0时0分0秒

        List<ComplainEntity> list = findObjects(queryHelper);
        if(list != null && list.size() > 0){
            //更新投诉信息的状态为 已失效
            for(ComplainEntity comp: list){
                comp.setState(ComplainEntity.COMPLAIN_STATE_INVALID);
                update(comp);
            }
        }
    }
}
