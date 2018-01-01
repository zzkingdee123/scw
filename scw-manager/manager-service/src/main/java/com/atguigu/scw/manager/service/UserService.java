package com.atguigu.scw.manager.service;


import java.util.List;

import com.atguigu.scw.manager.bean.TUser;
import com.atguigu.scw.manager.bean.TUserExample;

public interface UserService {
    

    public boolean register(TUser user);

    public TUser login(TUser user);

    public List<TUser> findAllUser();
    
    public List<TUser> findUserByExample(TUserExample example);

	public void deleteBatchOrSingle(String ids);
}
