<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'inc.jsp' starting page</title>
    <link href="${APP_PATH }/static/js/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${APP_PATH }/static/js/bootstrap/css/bootstrap-multiselect.css" rel="stylesheet" type="text/css"/>
  <script src="${APP_PATH }/static/js/jquery.min.js"></script> 
   <!-- <script src="http://code.jquery.com/jquery-2.1.1.min.js"></script> -->
	<script src="${APP_PATH }/static/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/static/js/bootstrap/js/bootstrap-multiselect.js"></script>
	<script src="${APP_PATH }/static/js/bootstrap/js/bootstrap-treeview.min.js"></script>
	<script src="${APP_PATH }/static/js/common/comm.js"></script>
  </head>
</html>
