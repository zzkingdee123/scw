package com.atguigu.scw.manager.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TPermission;
import com.atguigu.scw.manager.bean.TPermissionExample;
import com.atguigu.scw.manager.bean.TPermissionExample.Criteria;
import com.atguigu.scw.manager.dao.TPermissionMapper;
import com.atguigu.scw.manager.service.TPermissionService;

@Service
public class TPermissionServiceImpl implements TPermissionService{

    @Autowired
    TPermissionMapper tPermissionMapper;
    
    @Override
    public List<TPermission> getAllMenu() {
        // TODO Auto-generated method stub
        
        //取出菜单
        List<TPermission> listPermissions= tPermissionMapper.selectByExample(null);
        
        //存放父菜单的list
        List<TPermission> parentMenuList = new ArrayList<>();
        
        //把菜单放到一个map里面
        Map<Integer, TPermission> map = new HashMap<>();
        
        for (TPermission tPermission : listPermissions) {
            map.put(tPermission.getId(), tPermission);
        }
        
        //组装父子级关系
        for (TPermission tPermission : listPermissions) {
            if(tPermission.getPid() == 0){
                //父菜单
                parentMenuList.add(tPermission);
            }else {
                //子菜单
                Integer pid = tPermission.getPid();
                //拿到该子菜单的父菜单
                TPermission parentMenu =  map.get(pid);
                List<TPermission> childsList=  parentMenu.getChilds();
                if(childsList!=null){
                    childsList.add(tPermission);
                }else {
                    childsList = new ArrayList<TPermission>();
                    childsList.add(tPermission);
                }
                parentMenu.setChilds(childsList);
            }
        }
        return parentMenuList;
    }

	@Override
	public List<TPermission> findPermissionByRoleId(Integer id) {
		// TODO Auto-generated method stub
		return tPermissionMapper.findPermissionByRoleId(id);
	}

	@Override
	public List<TPermission> getAllPermission() {
		// TODO Auto-generated method stub
		return  tPermissionMapper.selectByExample(null);
	}
}
