<%
//////////////////////////////////////////////////////////////////
// 페이지 명	: 	2req.jsp 
// 목적 		:	1) 전문 수신 
// 					2) 전문 split
//					
//////////////////////////////////////////////////////////////////
%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
File f = new File("C:/temp/tempLog.txt");
FileWriter fw = new FileWriter(f, true);
%>
<%
request.setCharacterEncoding("UTF-8");

// 프로그램 변수 선언 ----------------------------------------------------------------------------------
String fullText = "";
String name = "";
String birth = "";
String phnNo = "";
String trNum = request.getParameter("trnum");
String tempUrl = "";

// 페이지 변수 선언 -------------------------------------------------------------------------------------
String pageCode = "TEMPREQ";
String step = "";
String messege = "";
String currentTime = new SimpleDateFormat("YYYY.MM.dd HH:mm:ss").format(System.currentTimeMillis());

try{
	fw.write("-------------------------------------------------------------------------------------------------------------------"+"\r\n"); 
	fw.flush();
	
	step = pageCode + "-SS";
	messege = "["+currentTime+"] [INFO] ("+trNum+") ["+step+"] - "+"2req.jsp successfully entered"; 
	fw.write(messege+"\r\n"); 
	fw.flush();

// 트랜잭션키 검증 --------------------------------------------------------------------------------------
	step = pageCode + "-00";

	if(trNum.equals("")){
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] - "+"transaction key is null"; 
		fw.write(messege+"\r\n"); 
		fw.flush();
		fw.close();
		throw new Exception();
	}
	if(trNum.length() != 20){
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] - "+"transaction key is not 20 digits"; 
		fw.write(messege+"\r\n"); 
		fw.flush();
		fw.close();
		throw new Exception();
	}
	
// 전문 split ----------------------------------------------------------------------------------------------
	step = pageCode + "-01";
	
	fullText = request.getParameter("fulltext");
	
	messege = "["+currentTime+"] [INFO] ("+trNum+") ["+step+"] - "+"received fullText ( "+fullText+" )"; 
	fw.write(messege+"\r\n"); 
	fw.flush();

	if(fullText.equals("|||")){
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] "+"(1)"+" - "+"fullText is null";
		fw.write(messege+"\r\n"); 
		fw.flush();
		fw.close();
		throw new Exception();
	}

	int point1 = fullText.indexOf("|",0);
	int point2 = fullText.indexOf("|",point1+1);
	int point3 = fullText.indexOf("|",point2+1);
	int point4 = fullText.indexOf("|",point3+1);
	
// 유효성 검증 -------------------------------------------------------------------------------------------
	step = pageCode + "-02";

	name = fullText.substring(0, point1).trim();
	
	if(name.equals("")){	
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] "+"(2-1)"+" - "+"name is null";
		fw.write(messege+"\r\n");
		fw.flush();
		fw.close();
		throw new Exception();
	}
	
	birth = fullText.substring(point1+1, point2).trim();
	
	if(birth.equals("")){
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] "+"(2-2)"+" - "+"birth is null";
		fw.write(messege+"\r\n");
		fw.flush();
		fw.close();
		throw new Exception();
	}
	if(birth.length() != 6){
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] "+"(2-3)"+" - "+"birth.length is not 6 digits";
		fw.write(messege+"\r\n");
		fw.flush();
		fw.close();
		throw new Exception();
	}
	
	phnNo = fullText.substring(point2+1, point3).trim();
	
	if(phnNo.equals("")){
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] "+"(2-4)"+" - "+"phnno is null";
		fw.write(messege+"\r\n");
		fw.flush();
		fw.close();
		throw new Exception();
	}
	if(phnNo.length() != 11){
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] "+"(2-5)"+" - "+"phnno.length is not 11 digits";
		fw.write(messege+"\r\n");
		fw.flush();
		fw.close();
		throw new Exception();
	}
	tempUrl = request.getParameter("tempurl");
	if(tempUrl.equals("")){
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] "+"(3)"+" - "+"tempurl is null";
		fw.write(messege+"\r\n");
		fw.flush();
		fw.close();
		throw new Exception();
	}

	step = pageCode+"-EE";
	messege = "["+currentTime+"] [INFO] ("+trNum+") ["+step+"] - "+"2req.jsp successfully exited"; 
	fw.write(messege+"\r\n"); 
	fw.flush();
	fw.close();
%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="euc-kr">
	<title>req</title>
	<script type="text/javascript">
	function toProc(){
		document.temp.submit();
	}
	</script>
	</head>
	<body onload="toProc();">
	<form id="temp" name="temp" method="post" action="/temp_20190607/temp1/3proc.jsp">
		<input type="hidden" id="name" name="name" value="<%=name%>">
		<input type="hidden" id="birth" name="birth" value="<%=birth%>">
		<input type="hidden" id="phnno" name="phnno" value="<%=phnNo%>">
		<input type="hidden" id="trnum" name="trnum" value="<%=trNum%>">
		<input type="hidden" id="tempurl" name="tempurl" value="<%=tempUrl%>">
	</form>
	</body>
	</html>
<%
	}catch(Exception e){
		System.out.println(messege);
		response.sendRedirect("/temp_20190607/temp1/99err.jsp");
	}
%>










