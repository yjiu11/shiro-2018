package com.yjiu.shiro.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.Paginator;
import com.yjiu.shiro.pojo.Msg;
import com.yjiu.shiro.pojo.SysResource;
import com.yjiu.shiro.service.ResourcesService;

@Controller
@RequestMapping("/resource")
public class ResourceController {
	@Autowired
	private ResourcesService resourceService;
	@RequestMapping("list")
	public String list(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(required = false, defaultValue = "1") Integer pageNow,
			@RequestParam(required = false, defaultValue = "10") Integer pageRow) { 
		String sortString = "id.desc";
		Order.formString(sortString);
		PageBounds pageBounds = new PageBounds(pageNow, pageRow);
		Map<String, Object> map = resourceService.selectResource(pageBounds);
		List<SysResource> resources = (List<SysResource>) map.get("resources");
		Paginator paginator = (Paginator) map.get("paginator");
		request.setAttribute("resourceList", resources);
		request.setAttribute("paginator", paginator);
		return "resource/list";
	}
	@RequestMapping(value="add",method=RequestMethod.POST)
	@ResponseBody
	public Msg Add(@Valid SysResource resource,BindingResult result){
		if(result.hasErrors()){
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			resource.setAvailable(1);
			resourceService.insert(resource);
			return Msg.success();
		}
	}
	@RequestMapping(value="getResource",method=RequestMethod.POST)
	@ResponseBody
	public Msg getResource(String resource_id) {
		SysResource resource = resourceService.findById(Long.parseLong(resource_id));
		return Msg.success().add("resource", resource);
	}
	@RequestMapping(value="getTree",method=RequestMethod.GET)
	@ResponseBody
	public SysResource getTree(HttpServletResponse response) {
		SysResource resource = resourceService.getTree();
		return resource;
		/*response.setCharacterEncoding("utf-8");
		ObjectMapper mapper = new ObjectMapper();
		try {
			mapper.setSerializationInclusion(Include.NON_NULL);  
			String value = mapper.writeValueAsString(resource);
			response.getWriter().write(value);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  */
	}
	@RequestMapping(value="update",method=RequestMethod.POST)
	@ResponseBody
	public Msg updateResource(SysResource resource) {
		System.out.println(resource);
		resourceService.update(resource);
		return Msg.success();
	}
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(String ids) {
		// 批量删除
		if (ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			// 组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			resourceService.deleteBatch(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			resourceService.deleteById(id);
		}
		return Msg.success();
	}
	/**根据角色名称，查找所有资源*/
	@RequestMapping(value="getResourceByRoleId",method=RequestMethod.POST)
	@ResponseBody
	public Msg getRoleByUserId(String role_id,HttpServletRequest request) {
		List<SysResource> allRoles = resourceService.selectAll();
		List<SysResource> roles = resourceService.findResourceByRoleId(role_id);
		return Msg.success().add("resources", roles).add("allResources", allRoles);
	}
	@RequestMapping("/common/test")
	public String test() { 
		return "resource/test";
	}
}
