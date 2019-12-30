package com.zy.sms.admin.dao.impl;

import com.zy.sms.admin.dao.RoleDao;
import com.zy.sms.admin.entity.RoleEntity;
import com.zy.sms.base.dao.BaseDaoImpl;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

@Repository
public class RoleDaoImpl extends BaseDaoImpl<RoleEntity> implements RoleDao {

    @Override
    public void deleteRolePrivilegeByRoleId(String roleId) {
        String hql="DELETE FROM RolePrivilegeEntity WHERE rolePrivilegeEntityPK.role.roleId=:roleId";
        Query query = getSession().createQuery(hql);
        query.setParameter("roleId",roleId);
        query.executeUpdate();
    }
}
