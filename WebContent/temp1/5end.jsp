<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

request.setCharacterEncoding("UTF-8");

// 프로그램 변수 선언 ----------------------------------------------------------------------------------
String result = request.getParameter("result");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>end</title>
</head>
<body>
<h1>process completed</h1>
<p>수신된 전문 : <%=result%></p>
</body>
</html>