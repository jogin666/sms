package com.zy.sms.admin.dao.impl;

import com.zy.sms.admin.dao.ComplainDao;
import com.zy.sms.admin.entity.ComplainEntity;
import com.zy.sms.base.dao.BaseDaoImpl;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ComplainDaoImpl extends BaseDaoImpl<ComplainEntity> implements ComplainDao {

    @Override
    public List<Object[]> getAnnualStatisticDataByYear(int year) {
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT imonth, COUNT(comp_id)")
                .append(" FROM tmonth LEFT JOIN complain ON imonth=MONTH(comp_time)")
                .append(" AND YEAR(comp_time)=?")
                .append(" GROUP BY imonth ")
                .append(" ORDER BY imonth");
        SQLQuery sqlQuery = getSession().createSQLQuery(sb.toString());
        sqlQuery.setParameter(0, year);
        return sqlQuery.list();
    }
}
