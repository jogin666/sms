package com.zy.sms.base.dao;

import com.zy.sms.common.PageResult;
import com.zy.sms.util.QueryHelper;

import java.io.Serializable;
import java.util.List;

public interface BaseDao<T>{

    //新增
    void save(T entity);
    //根据id删除
    void delete(Serializable id);
    //更新
    void update(T entity);
    //根据id查找
    T findObjectById(Serializable id);
    //查找列表
    List<T> findObjects();
    //条件查询列表
    List<T> findObjects(String hql,List<Object> parameters);
    //条件查询实体列表--查询助手queryHelper
    List<T> findObjects(QueryHelper queryHelper);
    //分页条件查询实体列表--查询助手queryHelper
    PageResult getPageResult(QueryHelper queryHelper, int currentPage, int pageSize);
}
