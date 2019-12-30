package com.zy.sms.base.service;

import com.zy.sms.common.PageResult;
import com.zy.sms.util.QueryHelper;

import java.io.Serializable;
import java.util.List;

public interface BaseService<T> {

    void save(T entity);
    //更新
    void update(T entity);
    //删除
    void delete(Serializable id);
    //查找
    T findObjectById(Serializable id);
    //查找所有
    List<T> findObjects();
    //条件查询实体列表
    @Deprecated //不推荐使用
    List<T> findObjects(String hql,List<Object> parameters);
    //条件查询实体列表--查询助手queryHelper
    List<T> findObjects(QueryHelper queryHelper);
    //分页条件查询实体列表--查询助手queryHelper
    PageResult getPageResult(QueryHelper queryHelper, int pageNo, int pageSize);
}
