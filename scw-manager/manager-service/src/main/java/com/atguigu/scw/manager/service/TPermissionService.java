package com.atguigu.scw.manager.service;

import java.util.List;

import com.atguigu.scw.manager.bean.TPermission;


public interface TPermissionService {
    
    /**
     * 拿到所有菜单
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    public List<TPermission> getAllMenu();

	public List<TPermission> findPermissionByRoleId(Integer id);
	
	public List<TPermission> getAllPermission();
}
