package com.zy.sms.admin.dao;

import com.zy.sms.admin.entity.ComplainEntity;
import com.zy.sms.base.dao.BaseDao;

import java.util.List;

public interface ComplainDao extends BaseDao<ComplainEntity> {

    List<Object[]> getAnnualStatisticDataByYear(int year);
}
