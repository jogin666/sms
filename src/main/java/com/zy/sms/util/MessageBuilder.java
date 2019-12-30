package com.zy.sms.util;

import java.util.HashMap;
import java.util.Map;

public class MessageBuilder {

    public static Map<String,String> buildBackMap(String result, String message){
        Map<String,String> map=new HashMap<String, String>();
        map.put("tip",result);
        map.put("msg",message);
        return map;
    }
}
