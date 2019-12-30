package com.zy.sms.admin.dao.impl;

import com.zy.sms.admin.dao.UserDao;
import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.admin.entity.UserRoleEntity;
import com.zy.sms.base.dao.BaseDaoImpl;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.List;

@Repository
public class UserDaoImpl extends BaseDaoImpl<UserEntity> implements UserDao {

    @Override
    public void saveUserRole(UserRoleEntity userRole) {
        getSession().save(userRole);
    }

    @Override
    public void deleteUserRoleByUserId(Serializable id) {
        String hql="delete from UserRoleEntity where userRoleEntityPk.userId=:id";
        Query query=getSession().createQuery(hql);
        query.setParameter("id",id);
        query.executeUpdate();
    }

    @Override
    public List<UserRoleEntity> getUserRoleByUserId(String id) {
        String hql="from UserRoleEntity where userRoleEntityPk.userId=:id";
        Query query = getSession().createQuery(hql);
        query.setParameter("id",id);
        return query.list();
    }

    @Override
    public UserEntity findUserByAccountAndPass(String account, String password) {
        String hql="from UserEntity where account=:account and password=:password";
        Query query=getSession().createQuery(hql);
        query.setParameter("account",account);
        query.setParameter("password",password);
        return (UserEntity) query.uniqueResult();
    }

    @Override
    public boolean exit(String account){
        String hql="from UserEntity where account=:account";
        Query query=getSession().createQuery(hql);
        query.setParameter("account",account);
        UserEntity entity= (UserEntity) query.uniqueResult();
        if (entity!=null){
            return true;
        }
        return false;
    }
}
