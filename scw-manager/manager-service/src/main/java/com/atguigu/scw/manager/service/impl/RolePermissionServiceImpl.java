package com.atguigu.scw.manager.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TRolePermission;
import com.atguigu.scw.manager.bean.TRolePermissionExample;
import com.atguigu.scw.manager.bean.TRolePermissionExample.Criteria;
import com.atguigu.scw.manager.dao.TRolePermissionMapper;
import com.atguigu.scw.manager.service.RolePermissionService;

@Service
public class RolePermissionServiceImpl implements RolePermissionService{
    @Autowired
    TRolePermissionMapper rolePermissionMapper;

    @Override
    public boolean updateRolePermission(Integer rid, String pids) {
        //1.删除角色的权限
        TRolePermissionExample example = new TRolePermissionExample();
        Criteria criteria = example.createCriteria();
        criteria.andRoleidEqualTo(rid);
        rolePermissionMapper.deleteByExample(example);
        
        //2.插入角色的权限
        
        // TODO Auto-generated method stub
        String[] split = pids.split(",");
        if(split!=null && split.length>=1){
            for (String pid : split) {
                TRolePermission tRolePermission = new TRolePermission();
                tRolePermission.setPermissionid(Integer.valueOf(pid));
                tRolePermission.setRoleid(rid);
                rolePermissionMapper.insertSelective(tRolePermission);
            }
            return true;
        }
        return false;
    }

}
