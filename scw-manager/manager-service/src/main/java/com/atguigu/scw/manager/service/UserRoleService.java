package com.atguigu.scw.manager.service;


public interface UserRoleService {
	/**
	 * 为用户添加角色
	 */
	public void addRoleToUser(String rids,Integer uid);
	
	
	/**
	 * 为用户删除角色
	 */
	public void deleteRoleFromUser(String rids,Integer uid);
}
