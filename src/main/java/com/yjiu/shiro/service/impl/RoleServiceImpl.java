package com.yjiu.shiro.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.github.miemiedev.mybatis.paginator.domain.Paginator;
import com.yjiu.shiro.mapper.SysResourceMapper;
import com.yjiu.shiro.mapper.SysRoleMapper;
import com.yjiu.shiro.mapper.SysUserMapper;
import com.yjiu.shiro.pojo.SysRole;
import com.yjiu.shiro.pojo.SysUser;
import com.yjiu.shiro.service.RoleService;
@Service
public class RoleServiceImpl implements RoleService {
	@Autowired
	private SysRoleMapper roleM;
	@Autowired
	private SysUserMapper userM;
	@Override
	public void insert(SysRole role) {
		role.setResourceIds("18");//可以显示公共页面
		roleM.insert(role);
	}
	@Override
	public void delete(SysRole role) {
		role = findByRoleName(role.getRole());
		roleM.deleteByPrimaryKey(role.getId());
	}
	@Override
	public void deleteById(long id) {
		roleM.deleteByPrimaryKey(id);
	}
	@Override
	public void update(SysRole role) {
		roleM.updateByPrimaryKeySelective(role);
	}
	@Override
	public SysRole findById(long id) {
		return roleM.selectByPrimaryKey(id);
	}
	@Override
	public SysRole findByRoleName(String roleName) {
		// TODO Auto-generated method stub
		return roleM.findByRoleName(roleName);
	}
	@Override
	public Map<String, Object> selectRole(PageBounds pageBounds) {
		List<SysRole> user = roleM.selectRole(pageBounds);
		Map<String, Object> map = new HashMap<String, Object>();
		if (user.size() > 0) {
			PageList pageList = (PageList) user;
			Paginator paginator = pageList.getPaginator();
			map.put("role", user);
			map.put("paginator", paginator);
		}
		return map;
	}
	@Override
	public void deleteBatch(List<Integer> del_ids) {
		roleM.deleteBatch(del_ids);
	}
	@Override
	public List<SysRole> findRoleByUserId(String user_id) {
		List<SysRole> roles = new ArrayList<>();
		SysUser user = userM.selectByPrimaryKey(Long.parseLong(user_id));
		String roleIds=  user.getRoleIds();
		if(roleIds.contains(",")){
			String[] rids = roleIds.split(",");
			for(String id:rids) {
				roles.add(roleM.selectByPrimaryKey(Long.parseLong(id)));
			}
		}else roles.add(roleM.selectByPrimaryKey(Long.parseLong(roleIds)));
		
		return roles;
	}
	@Override
	public List<SysRole> selectAll() {
		// TODO Auto-generated method stub
		return roleM.selectAll();
	}
}
