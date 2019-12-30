package com.zy.sms.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/home")
public class AdminHomeController {

    //跳转到系统首页
    @RequestMapping("/frameUI.do")
    public String frame(){
        return "admin/home/frame";
    }
    //跳转到系统首页-顶部
    @RequestMapping("/topUI.do")
    public String top(){
        return "admin/home/top";
    }
    //跳转到系统首页-左边菜单
    @RequestMapping("/leftUI.do")
    public String left(){
        return "admin/home/left";
    }
    //返回系统的首页
    @RequestMapping("/welcome.do")
    public String welcome(){
        return "admin/home/welcome";
    }
}
