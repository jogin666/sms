package com.zy.sms.admin.service.impl;

import com.zy.sms.admin.dao.UserDao;
import com.zy.sms.admin.dao.impl.UserDaoImpl;
import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.admin.entity.UserRoleEntity;
import com.zy.sms.admin.service.UserService;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class UserServiceImplTest {


    private ApplicationContext act;

    @Before
    public void setUp(){
        act=new ClassPathXmlApplicationContext("conf/application.xml");
    }

    @Test
    public void delete() {
        UserService userService = act.getBean("userServiceImpl",UserServiceImpl.class);
//        UserEntity userEntity = userService.findObjectById("20161113001");
        userService.findUserAndRoleByUserId("20161113001");
       // System.out.println(userEntity);
    }

    @Test
    public void find(){
        UserDao userDao=act.getBean("userDaoImpl", UserDaoImpl.class);
        UserEntity entity = userDao.findObjectById("20161113001");
        Assert.assertNotNull(entity);
    }

    @Test
    public void saveUserAndRole() {
    }
}