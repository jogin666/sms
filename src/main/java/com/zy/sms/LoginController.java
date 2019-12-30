package com.zy.sms;

import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.admin.entity.UserRoleEntity;
import com.zy.sms.admin.service.UserService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/login")
public class LoginController {


    @Resource(name = "userServiceImpl")
    private UserService userService;

    //登录判断
    @RequestMapping(value = "/login.do",method = RequestMethod.POST)
    public String login(UserEntity userEntity, HttpServletRequest request){
        if (userEntity != null) {
            UserEntity user=userService.findUserByAccountAndPass(userEntity.getAccount(), userEntity.getPassword());
            //用户存在
            if (user != null) {
                //查出用户所有的权限，设置到User中
                List<UserRoleEntity> roles = userService.findUserAndRoleByUserId(user.getId());
                user.setUserRoles(roles);
                //保存到Session域中，使用常量保存。
                request.getSession().setAttribute(Constant.USER, user);
                //保存到日志文件中Log
                Log log = LogFactory.getLog(getClass());
                log.info("用户名称为" + user.getName() + "登陆了系统!");
                //重定向到首页
                return "redirect:/home/showComplainAndInfo.do";
            } else {
                //登陆失败，记载登陆信息
                request.setAttribute("errorMsg","账号或密码错误！");
            }
        }
        //只要不成功的，都回到登陆页面
        return "loginUI";
    }

    //返回登录界面
    @RequestMapping(value = "/loginUI.do",method = RequestMethod.GET)
    public String loginUI() {
        return "loginUI";
    }

    //注销
    @RequestMapping(value = "/loginOut.do",method = RequestMethod.GET)
    public String logout(HttpServletRequest request) {
        //销毁session的值
        request.getSession().removeAttribute(Constant.USER);
        return "loginUI";
    }
}
