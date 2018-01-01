package com.atguigu.scw.manager.controller.permission;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.project.MyStringUtils;
import com.atguigu.scw.manager.bean.TUser;
import com.atguigu.scw.manager.bean.TUserExample;
import com.atguigu.scw.manager.bean.TUserExample.Criteria;
import com.atguigu.scw.manager.constant.Constants;
import com.atguigu.scw.manager.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 后台管理员的逻辑跳转
 * @ClassName UserController
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author Administrator
 * @Date 2017年12月24日 上午10:52:27
 * @version 1.0.0
 */
@Controller
@RequestMapping("/permisson/user")
public class UserController {

    @Autowired
    UserService userService;
    /**
     * 用户注册
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param user
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/reg")
    public String reg(TUser user,Model model,HttpSession session) {
        //System.out.println(user);
        boolean flag = userService.register(user);

        if(flag==true){
            //注册成功
            //修改mybatis生成的mapper文件，让其使用自动生成的id
            session.setAttribute(Constants.LOGIN_USER, user);
            return "redirect:/main.html";
        }else {
            //注册失败，表单回显
            model.addAttribute("registerError", "用户名被使用");
            return "forward:/reg.jsp";
        }
    }


    /**
     * 用户登录
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/login")
    public String login(TUser user,HttpSession session){
        //登录
        TUser login =  userService.login(user);
        //2.登录失败，跳转到登录页面，用户信息回显
        if(login==null){
            session.setAttribute("errorUser", user);
            session.setAttribute("errormsg", "登录失败");
            return "redirect:/login.jsp";
        }

        //3.登录成功则跳转到后台管理页面,session中保存用户信息
        session.setAttribute(Constants.LOGIN_USER, login);
        return "redirect:/main.html";
    }

    /**
     * 查询用户,按账号或者名称过滤
     */
    @RequestMapping("/findAllUser")
    public String findAllUser(@RequestParam(value="pn",defaultValue="1")Integer pn,
    		@RequestParam(value="pz",defaultValue="5")Integer ps,
    		@RequestParam(value="searchParam",defaultValue="")String search, 
    		Model model) {
       // System.out.println("分页");
    	PageHelper.startPage(pn,ps);
        
        TUserExample example = new TUserExample();
        Criteria criteria1 = example.createCriteria();
        Criteria criteria2 = example.createCriteria();
        if(!MyStringUtils.isEmpty(search)){
        	criteria1.andLoginacctLike("%"+search+"%");
        	criteria2.andUsernameLike("%"+search+"%");
        }
        example.or(criteria2);
        
		//List<TUser> userList =  userService.findAllUser();
        List<TUser> userList =  userService.findUserByExample(example);
        //每页显示5页
        PageInfo<TUser> pageInfo  =  new  PageInfo<TUser>(userList,5);
        model.addAttribute("pageInfo", pageInfo);
        
        //回显查询条件
        model.addAttribute("searchParam", search);
        return "manager/permission/user";
    }
    
    /**
     * 批量删除
     */
    @RequestMapping("/delBatch")
    public String delBatch(@RequestParam(value="ids")String ids){
    			userService.deleteBatchOrSingle(ids);
    	return "redirect:/permisson/user/findAllUser";
    }
}
