package com.atguigu.scw.manager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.scw.manager.bean.TPermission;
import com.atguigu.scw.manager.constant.Constants;
import com.atguigu.scw.manager.service.TPermissionService;

@Controller
public class DispatcherController {
    
    @Autowired
    TPermissionService tPermissionService;
    
    private  static final  String  MANAGER_MAIN= "manager/main";
    
    /**
     * 伪静态化
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping(value="main.html")
    public String toMainPage(HttpSession session) {
        
        //判断session中是否有这个用户
        if(session.getAttribute(Constants.LOGIN_USER)==null){
            return "redirect:/login.jsp";
        }else{
            if(session.getAttribute(Constants.USER_MENUS)==null){
                //从数据库拿出菜单
                List<TPermission> permissonList =  tPermissionService.getAllMenu();
                session.setAttribute(Constants.USER_MENUS, permissonList);
            }
            return MANAGER_MAIN;
        }
    }
}
