package com.yjiu.shiro.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.yjiu.shiro.pojo.SysResource;
import com.yjiu.shiro.pojo.SysRole;

public interface ResourcesService {
	//（添加）
	public void insert(SysResource resource);
	//删除
	public void deleteById(long id);
	//修改
	public void update(SysResource resource);
	//查询
	public SysResource findById(long id);
	
	public Map<String, Object> selectResource(PageBounds pageBounds);
	public void deleteBatch(List<Integer> del_ids);
	public List<SysResource> selectAll();
	public List<SysResource> findResourceByRoleId(String role_id);
	public SysResource getTree();
}
