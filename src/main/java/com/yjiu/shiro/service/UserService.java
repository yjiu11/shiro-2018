package com.yjiu.shiro.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.yjiu.shiro.pojo.SysResource;
import com.yjiu.shiro.pojo.SysRole;
import com.yjiu.shiro.pojo.SysUser;

public interface UserService {
	//登录
	public SysUser login(SysUser user);
	//注册（添加）
	public void regist(SysUser user);
	//删除
	public void delete(SysUser user);
	public void deleteById(long id);
	public void deleteBatch(List<Integer> del_ids);
	//修改
	public void update(SysUser user);
	public void updatePassword(String password);
	//根据用户查找所有角色
	public Set<String> findRoleStringById(long user_id);
	public List<SysRole> findRolesById(long user_id);
	//根据用户查找所有权限
	public Set<String> findResourceStringById(long user_id);
	public List<SysResource> findResourcesById(long user_id);
	//查询
	public SysUser findById(long id);
	public SysUser findByUsername(String username);
	public Map<String, Object> selectUser(PageBounds pageBounds);
}
