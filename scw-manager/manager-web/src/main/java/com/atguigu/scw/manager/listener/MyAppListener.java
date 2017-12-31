package com.atguigu.scw.manager.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 项目启动的是将常用数据放到application中
 * @ClassName MyAppListener
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author Administrator
 * @Date 2017年12月24日 上午9:47:47
 * @version 1.0.0
 */
public class MyAppListener implements ServletContextListener{

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();
        //将项目路径放到application域里面
        servletContext.setAttribute("ctp", servletContext.getContextPath());
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        //项目关闭销毁一些东西
    }

}
