package com.yjiu.shiro.mapper;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.yjiu.shiro.pojo.SysResource;
import com.yjiu.shiro.pojo.SysRole;
import org.springframework.stereotype.Repository;

@Repository
public interface SysResourceMapper {
    int deleteByPrimaryKey(Long id);

    int insert(SysResource record);

    int insertSelective(SysResource record);

    SysResource selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(SysResource record);

    int updateByPrimaryKey(SysResource record);
    List<SysResource> selectResource(PageBounds pageBounds);
	void deleteBatch(List<Integer> ids);
	List<SysResource> selectAll();
}