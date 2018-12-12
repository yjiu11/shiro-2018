package com.yjiu.shiro.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.yjiu.shiro.pojo.SysRole;
import org.springframework.stereotype.Repository;

@Repository
public interface SysRoleMapper {
    int deleteByPrimaryKey(Long id);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    SysRole selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);
    SysRole findByRoleName(@Param("role")String roleName);
    List<SysRole> selectRole(PageBounds pageBounds);
	void deleteBatch(List<Integer> ids);

	List<SysRole> selectAll();
}