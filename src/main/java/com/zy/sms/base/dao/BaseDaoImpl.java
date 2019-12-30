package com.zy.sms.base.dao;

import com.zy.sms.PageResult;
import com.zy.sms.util.QueryHelper;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;


public class BaseDaoImpl<T> implements BaseDao<T> {

    @Autowired
    private SessionFactory factory;

    private Class<T> tClass;
    private final ThreadLocal<Session> threadLocal=new ThreadLocal<>();


    public BaseDaoImpl(){
        ParameterizedType pt = (ParameterizedType) getClass().getGenericSuperclass();
        tClass= (Class<T>) pt.getActualTypeArguments()[0];
    }

    @Override
    public void save(Object entity) {
        getSession().save(entity);
    }

    @Override
    public void delete(Serializable id) {
        getSession().delete(id);
    }

    @Override
    public void update(T entity) {
        getSession().update(entity);
    }

    @Override
    public T findObjectById(Serializable id) {
        return (T) getSession().get(tClass,id);
    }

    @Override
    public List<T> findObjects() {
        Session session = getSession();
        return session.createQuery("FROM "+ tClass.getSimpleName()).list();
    }

    @Override
    public List<T> findObjects(String hql, List<Object> parameters) {
        Query query = getSession().createQuery(hql);
        return findObjects(query,parameters);
    }

    @Override
    public List<T> findObjects(QueryHelper queryHelper) {
        String hql = queryHelper.getQueryCountHql();
        Query query = getSession().createQuery(hql);
        return findObjects(query,queryHelper.getParameters());
    }

    @Override
    public PageResult getPageResult(QueryHelper queryHelper, int currentPage, int pageSize) {

        //设置hql
        Session session = getSession();
        String hql=queryHelper.getQueryHQL();
        System.out.println(hql);
        Query query = session.createQuery(hql);
        List<Object> params = queryHelper.getParameters();
        if (params!=null){
            int size = params.size();
            for (int i=0;i<size;i++){
                query.setParameter(i,params.get(i));
            }
        }
        //设置查询范围
        int startIndex=(currentPage-1)*pageSize;
        query.setFirstResult(startIndex);
        query.setMaxResults(pageSize);

        //获取查询的总数
        String count_hql=queryHelper.getQueryCountHql();
        System.out.println(count_hql);
        Query queryCount = session.createQuery(count_hql);
        if (params!=null){
            int size=params.size();
            for (int i=0;i<size;i++){
                queryCount.setParameter(i,params.get(i));
            }
        }

        Long totalCount= (Long) queryCount.uniqueResult();
        if (currentPage<1){
            currentPage=1;
        }
        return new PageResult(totalCount,currentPage,pageSize,query.list());
    }

    //查询全部
    private List<T> findObjects(Query query,List<Object> parameters){
        if (parameters!=null){
            int size = parameters.size();
            for (int i=0;i<size;i++){
                query.setParameter(i,parameters.get(i));
            }
        }
        return query.list();
    }

    //获取会话
    protected Session getSession(){
        Session session = threadLocal.get();
        if (session==null){
            session=factory.openSession();
            threadLocal.set(session);
        }
        return session;
    }

    //关闭会话
    protected void close(){
        Session session = threadLocal.get();
        if (session!=null){
            Transaction transaction = session.beginTransaction();
            transaction.commit();
            session.close();
        }
    }
}


