<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link href="${APP_PATH }/static/js/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
	<link href="${APP_PATH }/static/css/signin.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
      <form class="form-signin">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>

    </div> <!-- /container -->
<script src="${APP_PATH }/static/js/jquery.min.js"></script>
<script src="${APP_PATH }/static/js/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>