package com.zy.sms.admin.service;

import com.zy.sms.admin.entity.ComplainEntity;
import com.zy.sms.base.service.BaseService;
import com.zy.sms.base.service.BaseServiceImpl;

public interface ComplainService extends BaseService<ComplainEntity> {

    //自动受理投诉
    void autoDeal();
}
