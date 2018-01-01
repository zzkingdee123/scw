package com.atguigu.scw.manager.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TRole;
import com.atguigu.scw.manager.dao.TRoleMapper;
import com.atguigu.scw.manager.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService{

	@Autowired
	TRoleMapper roleMapper;
	
	/**
	 * 查询所有角色
	 * @return
	 */
	@Override
	public List<TRole> getAllRole() {
		// TODO Auto-generated method stub
		return roleMapper.selectByExample(null);
	}

	/**
	 * 查询某个用户的角色
	 */
	@Override
	public List<TRole> getRoleByUser(Integer id) {
		// TODO Auto-generated method stub
		return roleMapper.getRoleByUser(id);
	}

}
