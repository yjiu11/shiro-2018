package com.yjiu.shiro.permission;

import org.apache.shiro.authz.Permission;
import org.apache.shiro.util.AntPathMatcher;
import org.apache.shiro.util.PatternMatcher;

public class UrlPermission implements Permission {
	  private String url;
	  
	  public String getUrl() {
	    return url;
	  }
	  public void setUrl(String url) {
	    this.url = url;
	  }
	  public UrlPermission() {
	  }
	  public UrlPermission(String url) {
	    this.url = url;
	  }
	  @Override
	  public boolean implies(Permission p) {
//	    System.out.println("执行了：UrlPermission类：implies()方法");
	    if(!(p instanceof UrlPermission)) return false;
	    UrlPermission up = (UrlPermission)p;
	    // /admin/role/**
	    PatternMatcher patternMatcher = new AntPathMatcher();
//	    System.out.println(this.getUrl()+","+up.getUrl()+","+patternMatcher.matches(this.getUrl(), up.getUrl()));
	    /***up.getUrl():是用户要访问的地址
	     * 输出：
	     * /user/update,/user/del,false
	     * /user/create,/user/del,false
	     */
	    return up.getUrl().contains("/common")?true:patternMatcher.matches(this.getUrl(), up.getUrl());
	    //patternMatcher.matches(this.getUrl(), up.getUrl());
	  }
	 
	}

