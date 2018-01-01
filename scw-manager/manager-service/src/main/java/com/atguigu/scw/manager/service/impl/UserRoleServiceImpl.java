package com.atguigu.scw.manager.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TUserRole;
import com.atguigu.scw.manager.bean.TUserRoleExample;
import com.atguigu.scw.manager.bean.TUserRoleExample.Criteria;
import com.atguigu.scw.manager.dao.TUserRoleMapper;
import com.atguigu.scw.manager.service.UserRoleService;

@Service
public class UserRoleServiceImpl implements UserRoleService {

	@Autowired
	TUserRoleMapper userRoleMapper;

	@Override
	public void addRoleToUser(String rids, Integer uid) {
		// TODO Auto-generated method stub
	
			String[] split = rids.split(",");
			for (String rid : split) {
				TUserRole record = new TUserRole();
				record.setRoleid(Integer.valueOf(rid));
				record.setUserid(uid);
				userRoleMapper.insertSelective(record);
			}
	}

	@Override
	public void deleteRoleFromUser(String rids, Integer uid) {
		// TODO Auto-generated method stub
		String[] split = rids.split(",");
		for (String rid : split) {
			TUserRole record = new TUserRole();
			record.setRoleid(Integer.valueOf(rid));
			record.setUserid(uid);
			TUserRoleExample example = new TUserRoleExample();
			Criteria criteria = example.createCriteria();
			criteria.andRoleidEqualTo(Integer.valueOf(rid));
			criteria.andUseridEqualTo(uid);
			userRoleMapper.deleteByExample(example);
		}
		
	}

	

}
