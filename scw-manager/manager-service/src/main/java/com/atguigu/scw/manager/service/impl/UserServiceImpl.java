package com.atguigu.scw.manager.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.codec.digest.Md5Crypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.atguigu.project.MD5Util;
import com.atguigu.project.MyStringUtils;
import com.atguigu.scw.manager.bean.TRole;
import com.atguigu.scw.manager.bean.TUser;
import com.atguigu.scw.manager.bean.TUserExample;
import com.atguigu.scw.manager.bean.TUserExample.Criteria;
import com.atguigu.scw.manager.dao.TUserMapper;
import com.atguigu.scw.manager.service.UserService;


@Service
public class UserServiceImpl implements UserService{

    @Autowired
    TUserMapper userMapper;



    /**
     * 注册用户
     */
    @Override
    public boolean register(TUser user) {
        // TODO Auto-generated method stub
        //1.用户密码加密
        user.setUserpswd(MD5Util.digest(user.getUserpswd()));
        //2.将用户其它信息设置成默认值
        user.setUsername(user.getLoginacct());
        user.setCreatetime(MyStringUtils.formateSimpleDate(new Date()));
        //3.保存用户
        int i = 0;
        try {
            i = userMapper.insertSelective(user);
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
        
        return i==1?true:false;
    }


    /**
     * 用户登录
     */
    @Override
    public TUser login(TUser user) {
        // TODO Auto-generated method stub
        //构造查询条件
        TUserExample tUserExample = new TUserExample();
        Criteria criteria = tUserExample.createCriteria();
        criteria.andLoginacctEqualTo(user.getLoginacct());
        criteria.andUserpswdEqualTo(MD5Util.digest(user.getUserpswd()));
        
        //查询结果并返回
        List<TUser> list =  userMapper.selectByExample(tUserExample);
        
        return   list.size()==1?list.get(0):null;
    }


    @Override
    public List<TUser> findAllUser() {
        // TODO Auto-generated method stub
        List<TUser> userList = userMapper.selectByExample(null);
        return userList;
    }


    /**
     * 按条件查询
     */
	@Override
	public List<TUser> findUserByExample(TUserExample example) {
		// TODO Auto-generated method stub
		return userMapper.selectByExample(example);
	}


	/**
	 * 批量删除用户
	 */
	@Override
	public void deleteBatchOrSingle(String ids) {
		// TODO Auto-generated method stub
		if(!MyStringUtils.isEmpty(ids)){
			if(ids.contains(",")){
				String[] idStrings = ids.split(",");
				List<Integer> idList = new ArrayList<Integer>();
				for (String string : idStrings) {
					idList.add(Integer.valueOf(string));
				}
				TUserExample example = new TUserExample();
				Criteria criteria = example.createCriteria();
				criteria.andIdIn(idList);
				userMapper.deleteByExample(example);
			}else{
				userMapper.deleteByPrimaryKey(Integer.valueOf(ids));
			}
		}

		
	}
	
}
