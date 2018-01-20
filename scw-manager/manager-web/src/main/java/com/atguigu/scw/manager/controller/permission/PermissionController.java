package com.atguigu.scw.manager.controller.permission;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.scw.manager.bean.TPermission;
import com.atguigu.scw.manager.service.TPermissionService;

@RequestMapping("/permisson")
@Controller
public class PermissionController {
	
	@Autowired
	TPermissionService tPermissionService;
	
	@ResponseBody
	@RequestMapping("/findPermissionByRoleId")
	public List<TPermission> findPermissionByRoleId(@RequestParam("roleid")Integer id) {
		return tPermissionService.findPermissionByRoleId(id);
	}
	
	@ResponseBody
	@RequestMapping("/getAllPermission")
	public List<TPermission> getAllPermission() {
		return tPermissionService.getAllPermission();
	}
}
