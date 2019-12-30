package com.zy.sms;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class ExceptionHandlerAdivice {

    @ExceptionHandler(value = Exception.class) //拦截所有的异常
    public ModelAndView showException(Exception e){
        ModelAndView model=new ModelAndView("common/error");
        String exceptionMsg=e.getMessage();
        model.addObject("exceptionMsg",exceptionMsg);
        return model;
    }
}
