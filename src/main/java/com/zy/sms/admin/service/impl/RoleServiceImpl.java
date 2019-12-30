package com.zy.sms.admin.service.impl;

import com.zy.sms.admin.dao.RoleDao;
import com.zy.sms.admin.entity.RoleEntity;
import com.zy.sms.admin.service.RoleService;
import com.zy.sms.base.service.BaseServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class RoleServiceImpl extends BaseServiceImpl<RoleEntity> implements RoleService {

    private RoleDao roleDao;

    @Resource(name = "roleDaoImpl")
    public void setRoleDao(RoleDao roleDao) {
        super.setBaseBao(roleDao);
        this.roleDao = roleDao;
    }

    @Override
    public void update(RoleEntity entity) {
        //1、删除该角色对于的所有权限
        roleDao.deleteRolePrivilegeByRoleId(entity.getRoleId());
        //2、更新角色及其权限
        roleDao.update(entity);
    }

    @Override
    public void deleteRoleAndPrivilege(RoleEntity roleEntity) {
        //1、删除该角色对于的所有权限
        roleDao.deleteRolePrivilegeByRoleId(roleEntity.getRoleId());
        //删除角色
        roleDao.delete(roleEntity.getRoleId());
    }
}
