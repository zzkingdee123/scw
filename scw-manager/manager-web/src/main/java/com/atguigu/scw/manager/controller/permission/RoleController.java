package com.atguigu.scw.manager.controller.permission;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.project.MyStringUtils;
import com.atguigu.scw.manager.bean.TRole;
import com.atguigu.scw.manager.bean.TRoleExample;
import com.atguigu.scw.manager.bean.TRoleExample.Criteria;
import com.atguigu.scw.manager.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 角色管理相关
 * @author Administrator
 *
 */
@RequestMapping("/permisson/role")
@Controller
public class RoleController {

	@Autowired
	RoleService roleService;


	@RequestMapping("/findAllRole")
	public String findAllRole(@RequestParam(value="pn",defaultValue="1")Integer pn,
			@RequestParam(value="pz",defaultValue="5")Integer ps,
			@RequestParam(value="searchParam",defaultValue="")String search, 
			Model model) {

		TRoleExample example = new TRoleExample();
		Criteria criteria = example.createCriteria();
		
		if(!MyStringUtils.isEmpty(search)){
			criteria.andNameLike("%"+search+"%");
		}

		PageHelper.startPage(pn,ps);
		List<TRole> roleList = roleService.getRoleByExample(example);
		PageInfo<TRole> pageInfo =  new PageInfo<>(roleList,5);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("searchParam", search);
		return "manager/permission/role";
	}
}
