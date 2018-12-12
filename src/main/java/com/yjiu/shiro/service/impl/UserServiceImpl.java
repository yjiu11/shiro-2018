package com.yjiu.shiro.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.github.miemiedev.mybatis.paginator.domain.Paginator;
import com.yjiu.shiro.mapper.SysResourceMapper;
import com.yjiu.shiro.mapper.SysRoleMapper;
import com.yjiu.shiro.mapper.SysUserMapper;
import com.yjiu.shiro.pojo.SysResource;
import com.yjiu.shiro.pojo.SysRole;
import com.yjiu.shiro.pojo.SysUser;
import com.yjiu.shiro.service.UserService;
import com.yjiu.shiro.tools.Kit;
@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private SysUserMapper userM;
	@Autowired
	private SysRoleMapper roleM;
	@Autowired
	private SysResourceMapper resoucesM;
	@Override
	public SysUser login(SysUser user) {
		SysUser db_user = userM.findByUsername(user.getUsername());
		if(db_user == null){
			throw new UnknownAccountException("用户名或密码错误");
		}else{
			String db_pass = db_user.getPassword();
			if(db_pass.equals(Kit.generatePass(user))){
				return db_user;
			}else{
				throw new IncorrectCredentialsException("用户名或密码错误");
			}
		}
		
	}

	@Override
	public void regist(SysUser user) {
		String pass = Kit.generatePass(user);
		user.setPassword(pass);
		user.setRoleIds("0");//基础角色
		userM.insert(user);
	}

	@Override
	public void delete(SysUser user) {
		userM.deleteByPrimaryKey(user.getId());
	}

	@Override
	public void deleteById(long id) {
		userM.deleteByPrimaryKey(id);
	}

	@Override
	public void update(SysUser user) {
		userM.updateByPrimaryKeySelective(user);
	}

	@Override
	public void updatePassword(String password) {
		try {
			throw new Exception("暂未实现");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Set<String> findRoleStringById(long user_id) {
		Set<String> roles = new HashSet<String>();
		List<SysRole> rs = findRolesById(user_id);
		for(SysRole r:rs){
			roles.add(r.getRole());
		}
		return roles;
	}

	@Override
	public List<SysRole> findRolesById(long user_id) {
		List<SysRole> roles = new ArrayList<SysRole>();
		SysUser u = userM.selectByPrimaryKey(user_id);
		String roleIds = u.getRoleIds();
		if(roleIds.contains(",")){
			String[] rids = roleIds.split(",");
			for(String id:rids){
				SysRole role = roleM.selectByPrimaryKey(Long.parseLong(id));
				roles.add(role);
			}
		}else{//只有一个角色
			SysRole role = roleM.selectByPrimaryKey(Long.parseLong(roleIds));
			roles.add(role);
		}
		return roles;
	}

	@Override
	public Set<String> findResourceStringById(long user_id) {
		Set<String> result = new HashSet<String>();
		List<SysResource> resources = findResourcesById(user_id);
		for (SysResource r : resources) {
			String url = r.getUrl();
			if ("".equals(url)) {
				continue;
			} else {
				if (url.contains(",")) {
					String urls[] = url.split(",");
					for (String u : urls) {
						result.add(u);
					}
				} else
					result.add(url);
			}
		}
		return result;
	}

	@Override
	public List<SysResource> findResourcesById(long user_id) {
		List<SysResource> result = new ArrayList<SysResource>();
		List<SysRole> lists = findRolesById(user_id);
		for(SysRole a:lists){
			String resouceIds = a.getResourceIds();
			if(resouceIds.contains(",")){
				String[] rids = resouceIds.split(",");
				for(String id:rids){
					SysResource sysRe = resoucesM.selectByPrimaryKey(Long.parseLong(id));
					if(!result.contains(sysRe)){
						result.add(sysRe);
					}
				}
			}else{//只有一个资源
				SysResource sysRe = resoucesM.selectByPrimaryKey(Long.parseLong(resouceIds));
				if(!result.contains(sysRe)){
					result.add(sysRe);
				}
			}
		}
		return result;
	}

	@Override
	public SysUser findById(long id) {
		return userM.selectByPrimaryKey(id);
	}

	@Override
	public SysUser findByUsername(String username) {
		// TODO Auto-generated method stub
		return userM.findByUsername(username);
	}

	@Override
	public Map<String, Object> selectUser(PageBounds pageBounds) {
		List<SysUser> user = userM.selectUser(pageBounds);
		Map<String, Object> map = new HashMap<String, Object>();
		if (user.size() > 0) {
			PageList pageList = (PageList) user;
			Paginator paginator = pageList.getPaginator();
			map.put("user", user);
			map.put("paginator", paginator);
		}
		return map;
	}

	@Override
	public void deleteBatch(List<Integer> del_ids) {
		userM.deleteBatch(del_ids);
	}

}
