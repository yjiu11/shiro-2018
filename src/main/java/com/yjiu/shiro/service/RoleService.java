package com.yjiu.shiro.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.yjiu.shiro.pojo.SysRole;

public interface RoleService {
	//（添加）
	public void insert(SysRole role);
	//删除
	public void delete(SysRole role);
	public void deleteById(long id);
	//修改
	public void update(SysRole role);
	//查询
	public SysRole findById(long id);
	public SysRole findByRoleName(String roleName);
	
	public Map<String, Object> selectRole(PageBounds pageBounds);
	public void deleteBatch(List<Integer> del_ids);
	public List<SysRole> findRoleByUserId(String user_id);
	public List<SysRole> selectAll();
}
