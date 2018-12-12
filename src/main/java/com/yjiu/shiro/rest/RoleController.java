package com.yjiu.shiro.rest;

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

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.Paginator;
import com.yjiu.shiro.pojo.Msg;
import com.yjiu.shiro.pojo.SysRole;
import com.yjiu.shiro.pojo.SysUser;
import com.yjiu.shiro.service.RoleService;
import com.yjiu.shiro.service.UserService;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private RoleService roleService;
	/**第一种实现：跳转到list页面，此页面分配资源，使用的multiselect插件
	 * 第二种实现：跳转到list页面，此页面分配资源，使用的treeview插件*/
	@RequestMapping("list")
	public String list(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(required = false, defaultValue = "1") Integer pageNow,
			@RequestParam(required = false, defaultValue = "10") Integer pageRow) { 
		String sortString = "id.desc";
		Order.formString(sortString);
		PageBounds pageBounds = new PageBounds(pageNow, pageRow);
		Map<String, Object> map = roleService.selectRole(pageBounds);
		List<SysRole> roles = (List<SysRole>) map.get("role");
		Paginator paginator = (Paginator) map.get("paginator");
		request.setAttribute("roleList", roles);
		request.setAttribute("paginator", paginator);
		return "role/list";
	}
	@RequestMapping("list_tree")
	public String list_tree(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(required = false, defaultValue = "1") Integer pageNow,
			@RequestParam(required = false, defaultValue = "10") Integer pageRow) { 
		String sortString = "id.desc";
		Order.formString(sortString);
		PageBounds pageBounds = new PageBounds(pageNow, pageRow);
		Map<String, Object> map = roleService.selectRole(pageBounds);
		List<SysRole> roles = (List<SysRole>) map.get("role");
		Paginator paginator = (Paginator) map.get("paginator");
		request.setAttribute("roleList", roles);
		request.setAttribute("paginator", paginator);
		return "role/list_tree";
	}
	@RequestMapping(value="add",method=RequestMethod.POST)
	@ResponseBody
	public Msg Add(@Valid SysRole role,BindingResult result){
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
			role.setAvailable(1);
			roleService.insert(role);
			return Msg.success();
		}
	}
	@RequestMapping(value="getRole",method=RequestMethod.POST)
	@ResponseBody
	public Msg getUser(String role_id) {
		SysRole role = roleService.findById(Long.parseLong(role_id));
		return Msg.success().add("role", role);
	}
	@RequestMapping(value="update",method=RequestMethod.POST)
	@ResponseBody
	public Msg updateUser(SysRole role) {
		System.out.println(role);
		roleService.update(role);
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
			roleService.deleteBatch(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			roleService.deleteById(id);
		}
		return Msg.success();
	}
	/**根据用户名，查找所有角色*/
	@RequestMapping(value="getRoleByUserId",method=RequestMethod.POST)
	@ResponseBody
	public Msg getRoleByUserId(String user_id,HttpServletRequest request) {
		List<SysRole> allRoles = roleService.selectAll();
		List<SysRole> roles = roleService.findRoleByUserId(user_id);
		return Msg.success().add("roles", roles).add("allRoles", allRoles);
	}
	@RequestMapping(value="allow_resource",method=RequestMethod.POST)
	@ResponseBody
	public Msg allow_role(SysRole role) {
		roleService.update(role);
		return Msg.success();
	}
}
