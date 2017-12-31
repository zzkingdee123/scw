package com.atguigu.project;

import java.text.SimpleDateFormat;
import java.util.Date;


public class MyStringUtils {

    /**
     * 判断字符串是否为空
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param str
     * @return
     */
    public static boolean isEmpty(String str) {
        if(str == null){
            return true;
        }
        if(str.trim().equals("")){
            return true;
        }
        return false;
    }

    /**
     * 时间格式  yyyy-MM-dd
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param date
     * @return
     */
    public static String formateSimpleDate(Date date) {
        SimpleDateFormat simpleDateFormat =  new SimpleDateFormat("yyyy-MM-dd");
        return simpleDateFormat.format(date);
    }
}
