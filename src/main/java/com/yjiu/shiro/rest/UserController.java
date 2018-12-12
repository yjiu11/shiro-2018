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
import com.yjiu.shiro.pojo.SysUser;
import com.yjiu.shiro.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@RequestMapping("list")
	public String list(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(required = false, defaultValue = "1") Integer pageNow,
			@RequestParam(required = false, defaultValue = "10") Integer pageRow) { 
		String sortString = "id.desc";
		Order.formString(sortString);
		PageBounds pageBounds = new PageBounds(pageNow, pageRow);
		Map<String, Object> map = userService.selectUser(pageBounds);
		List<SysUser> user = (List<SysUser>) map.get("user");
		Paginator paginator = (Paginator) map.get("paginator");
		request.setAttribute("personList", user);
		request.setAttribute("paginator", paginator);
		return "user/list";
	}
	@RequestMapping(value="add",method=RequestMethod.POST)
	@ResponseBody
	public Msg Add(@Valid SysUser user,BindingResult result){
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
			user.setLocked(2);
			userService.regist(user);
			return Msg.success();
		}
	}
	@RequestMapping(value="getUser",method=RequestMethod.POST)
	@ResponseBody
	public Msg getUser(String user_id) {
		SysUser user = userService.findById(Long.parseLong(user_id));
		return Msg.success().add("user", user);
	}
	@RequestMapping(value="update",method=RequestMethod.POST)
	@ResponseBody
	public Msg updateUser(SysUser users) {
		System.out.println(users);
		userService.update(users);
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
			userService.deleteBatch(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			userService.deleteById(id);
		}
		return Msg.success();
	}
	@RequestMapping(value="allow_role",method=RequestMethod.POST)
	@ResponseBody
	public Msg allow_role(SysUser user) {
		userService.update(user);
		return Msg.success();
	}
}
