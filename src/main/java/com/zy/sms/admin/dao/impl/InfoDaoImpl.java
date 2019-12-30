package com.zy.sms.admin.dao.impl;


import com.zy.sms.admin.dao.InfoDao;
import com.zy.sms.admin.entity.InfoEntity;
import com.zy.sms.base.dao.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository("infoDao")
public class InfoDaoImpl extends BaseDaoImpl<InfoEntity> implements InfoDao {
}
