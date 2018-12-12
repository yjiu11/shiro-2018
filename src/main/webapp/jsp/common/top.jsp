<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/inc.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body>
	<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="${APP_PATH }/user/list"> 
				<img alt="用户管理">
			</a>
			<a class="navbar-brand" href="${APP_PATH }/role/list_tree"> 
				<img alt="角色管理">
			</a>
			<a class="navbar-brand" href="${APP_PATH }/resource/list"> 
				<img alt="资源管理">
			</a>
			<a class="navbar-brand navbar-right" href="${APP_PATH }/logout"> 
				<img alt="退出">
			</a>
		</div>
	</div>
	</nav>
</body>
</html>
