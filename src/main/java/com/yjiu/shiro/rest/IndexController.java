package com.yjiu.shiro.rest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class IndexController {
	@RequestMapping("/page/{page}")
	public String page(@PathVariable("page") String page){
		return page;
	}
	@RequestMapping("/page/user/{page}")
	public String UserPage(@PathVariable("page") String page){
		return "user/"+page;
	}
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String loginPage() {
		return "redirect:/login";
	}
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
}
