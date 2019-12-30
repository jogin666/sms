package com.zy.sms;

import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.common.PermissionCheck;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PrivilegeInterceptor implements HandlerInterceptor {

    @Autowired
    private PermissionCheck pc;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String uri = request.getRequestURI();
        if (uri.contains("admin")) {
            String warningPath = "/home/noPermissionUI.do";

            UserEntity user = (UserEntity) request.getSession().getAttribute(Constant.USER); //判断用户是否有权限
            if (pc.isAccessible(user, Constant.PRIVILEGE_MAP.get(Constant.PRIVILEGE_ADMIN))) {
                return true;
            } else {
                //告知没有权限访问
                response.sendRedirect(request.getContextPath() + warningPath);
                return false;
            }
        }
        return true;
    }
}
