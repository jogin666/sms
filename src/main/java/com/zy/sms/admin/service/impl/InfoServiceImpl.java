package com.zy.sms.admin.service.impl;


import com.zy.sms.admin.dao.InfoDao;
import com.zy.sms.admin.entity.InfoEntity;
import com.zy.sms.admin.service.InfoService;
import com.zy.sms.base.service.BaseServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("infoServiceImpl")
public class InfoServiceImpl extends BaseServiceImpl<InfoEntity> implements InfoService {

    private InfoDao infoDao;

    @Resource(name = "infoDao")
    public void setInfoDao(InfoDao infoDao) {
        super.setBaseBao(infoDao);
        this.infoDao = infoDao;
    }
}
