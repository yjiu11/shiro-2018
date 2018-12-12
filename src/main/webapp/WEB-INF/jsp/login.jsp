<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%@ include file="/jsp/common/inc.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'login.jsp' starting page</title>
	<%-- <link href="${APP_PATH }/static/js/bootstrap/css/bootstrap.min.css" rel="stylesheet" /> --%>
	<link href="${APP_PATH }/static/css/signin.css" rel="stylesheet" />
  </head>
  
  <body>
 <!--    <form action="login" method="post">
    	用户名：<input type="text" name="username"/><br>
    	密码：<input type="password" name="password"/><br>
    	<input type="submit" value="提交" />
    </form> -->
     <div class="container">
      <form class="form-signin" action="login" method="post">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputEmail" class="sr-only">用户名</label>
        <input type="text" id="inputEmail" name="username" class="form-control" placeholder="请输入用户名!" autofocus>
        <label for="inputPassword" class="sr-only">密码</label>
        <input type="password" id="inputPassword" name="password" class="form-control" placeholder="请输入密码!">
        <div class="checkbox">
          <label>
            <input type="checkbox" name="rm" value="remember-me"> Remember me
          </label>
        </div>
        <button id="btn_sign" class="btn btn-lg btn-primary">Sign in</button>
      </form>
    </div> <!-- /container -->
    <%-- <script src="${APP_PATH }/static/js/jquery.min.js"></script>
	<script src="${APP_PATH }/static/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/static/js/common/comm.js"></script>
	<script src="${APP_PATH }/static/js/login.js"></script> --%>
  </body>

</html>
