<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String currentTime = new SimpleDateFormat("YYYYMMddHHmmss").format(System.currentTimeMillis());
Random ran = new Random();
int numLength = 6;
String randomStr = "";
for (int i = 0; i < numLength; i++) {
    randomStr += ran.nextInt(10);
}
String trNum = currentTime + randomStr;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>start</title>
<script type="text/javascript">

var fulltext = "";

function full_text(){
	fulltext = document.getElementById("name").value + "|" + document.getElementById("birth").value + "|" + document.getElementById("phnno").value + "|";
	document.getElementById("fulltext").value = fulltext;
	document.temp.submit();
}
</script>
</head>
<body>
<form id="temp" name="temp" method="post" action="/temp_20190607/temp1/2req.jsp">
<table>
	<tr><td>이름		</td><td><input type="text" id="name" name="name" placeholder="이름"></td></tr>
	<tr><td>생년월일	</td><td><input type="text" id="birth" name="birth"  placeholder="ex) 930220"></td></tr>
	<tr><td>번호(010)	</td><td><input type="text" id="phnno" name="phnno"  placeholder="01048074908"></td></tr>
	<input type="hidden" id="fulltext" name="fulltext" value="">
	<input type="hidden" id="trnum" name="trnum" value="<%=trNum%>">
	<input type="hidden" id="tempurl" name="tempurl" value="/temp_20190607/temp1/5end.jsp">
</table>
<button type="button" onclick="full_text();">전송</button>
</form>
</body>
</html>