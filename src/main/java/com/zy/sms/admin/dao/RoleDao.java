package com.zy.sms.admin.dao;

import com.zy.sms.admin.entity.RoleEntity;
import com.zy.sms.base.dao.BaseDao;

public interface RoleDao extends BaseDao<RoleEntity> {

    //删除该角色对于的所有权限
    void deleteRolePrivilegeByRoleId(String roleId);
}
