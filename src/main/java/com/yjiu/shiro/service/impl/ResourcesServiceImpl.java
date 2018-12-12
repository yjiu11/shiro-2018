package com.yjiu.shiro.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
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
import com.yjiu.shiro.service.ResourcesService;
@Service
public class ResourcesServiceImpl implements ResourcesService {
	@Autowired
	private SysResourceMapper resoucesM;
	@Autowired
	private SysRoleMapper roleM;
	@Override
	public void insert(SysResource resource) {
		resoucesM.insert(resource);
	}
	@Override
	public void deleteById(long id) {
		resoucesM.deleteByPrimaryKey(id);
	}
	@Override
	public void update(SysResource resource) {
		resoucesM.updateByPrimaryKeySelective(resource);
	}
	@Override
	public SysResource findById(long id) {
		// TODO Auto-generated method stub
		return resoucesM.selectByPrimaryKey(id);
	}
	@Override
	public Map<String, Object> selectResource(PageBounds pageBounds) {
		List<SysResource> resources = resoucesM.selectResource(pageBounds);
		Map<String, Object> map = new HashMap<String, Object>();
		if (resources.size() > 0) {
			PageList pageList = (PageList) resources;
			Paginator paginator = pageList.getPaginator();
			map.put("resources", resources);
			map.put("paginator", paginator);
		}
		return map;
	}
	@Override
	public void deleteBatch(List<Integer> del_ids) {
		resoucesM.deleteBatch(del_ids);
	}
	@Override
	public List<SysResource> selectAll() {
		// TODO Auto-generated method stub
		return resoucesM.selectAll();
	}
	@Override
	public List<SysResource> findResourceByRoleId(String role_id) {
		List<SysResource> resources = new ArrayList<>();
		SysRole role = roleM.selectByPrimaryKey(Long.parseLong(role_id));
		String resourceIds=  role.getResourceIds();
		if(resourceIds.contains(",")){
			String[] rids = resourceIds.split(",");
			for(String id:rids) {
				resources.add(resoucesM.selectByPrimaryKey(Long.parseLong(id)));
			}
		}else resources.add(resoucesM.selectByPrimaryKey(Long.parseLong(resourceIds)));
		
		return resources;
	}
	@Override
	public SysResource getTree() {
		List<SysResource> allResource = resoucesM.selectAll();
		SysResource root = resoucesM.selectByPrimaryKey(Long.parseLong("0"));
		recursion(allResource, root,0);  
		return root;
	}
	private int recursion(List<SysResource> list, SysResource node,int count) {  
        List<SysResource> childList = getChildList(list, node);// 得到子节点列表  
        if (!CollectionUtils.isEmpty(childList)) {  
        	node.setChildren(childList);
            Iterator<SysResource> it = childList.iterator();  
            while (it.hasNext()) {  
            	SysResource n = (SysResource) it.next();  
                count = count+recursion(list, n,count);  
            }  
              
        } else {  
            node.setChildren(null);  
        }  
        //node.setEmpCount(count);  
        return count;  
    }  
      
    private List<SysResource> getChildList(List<SysResource> list, SysResource node) {  
        List<SysResource> nodeList = new ArrayList<SysResource>();  
        Iterator<SysResource> it = list.iterator();  
        while (it.hasNext()) {  
        	SysResource n = (SysResource) it.next();  
            if (n.getParentId().equals(node.getId()) ) {  
                nodeList.add(n);  
            }  
        }  
        return nodeList;  
    }  
}
