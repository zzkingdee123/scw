package com.atguigu.scw.manager.service;

import java.util.List;

import com.atguigu.scw.manager.bean.TRole;
import com.atguigu.scw.manager.bean.TRoleExample;

public interface RoleService {
	
	/**
	 * 查询所有角色
	 * @return
	 */
	public List<TRole> getAllRole();
	
	/**
	 * 查询某个用户的角色
	 */
	public List<TRole> getRoleByUser(Integer id);
	
	/**
	 * 根据条件查询角色
	 */
	public List<TRole> getRoleByExample(TRoleExample example);
}
