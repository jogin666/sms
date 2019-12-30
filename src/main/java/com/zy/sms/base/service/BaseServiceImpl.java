package com.zy.sms.base.service;

import com.zy.sms.common.PageResult;
import com.zy.sms.base.dao.BaseDao;
import com.zy.sms.util.QueryHelper;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

@Transactional
public class BaseServiceImpl<T> implements BaseService<T> {

    private BaseDao<T> baseBao;

    public void setBaseBao(BaseDao<T> baseBao) {
        this.baseBao = baseBao;
    }

    @Override
    public void save(T entity) {
        baseBao.save(entity);
    }

    @Override
    public void update(T entity) {
        baseBao.update(entity);
    }

    @Override
    public void delete(Serializable id) {
        baseBao.delete(id);
    }

    @Override
    public T findObjectById(Serializable id) {
        return baseBao.findObjectById(id);
    }

    @Override
    public List<T> findObjects() {
        return baseBao.findObjects();
    }

    @Override
    public List<T> findObjects(String hql, List<Object> parameters) {
        return baseBao.findObjects(hql,parameters);
    }

    @Override
    public List<T> findObjects(QueryHelper queryHelper) {
        return baseBao.findObjects(queryHelper);
    }

    @Override
    public PageResult getPageResult(QueryHelper queryHelper, int pageNo, int pageSize) {
        return baseBao.getPageResult(queryHelper,pageNo,pageSize);
    }
}
