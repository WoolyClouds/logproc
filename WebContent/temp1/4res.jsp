<%
//////////////////////////////////////////////////////////////////
// 페이지 명	: 	4res.jsp 
// 목적 		:	1) 전문 구성  
//					2) 전문 발신
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
String name = "";
String birth = "";
String phnNo = "";
String trNum = request.getParameter("trnum");
String tempUrl = "";
String fullText = "";

// 페이지 변수 선언 -------------------------------------------------------------------------------------
String pageCode = "TEMPRES";
String step = "";
String messege = "";
String currentTime = new SimpleDateFormat("YYYY.MM.dd HH:mm:ss").format(System.currentTimeMillis());

try{
	step = pageCode + "-SS";
	messege = "["+currentTime+"] [INFO] ("+trNum+") ["+step+"] - "+"4res.jsp successfully entered"; 
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
		
// 프로그램 변수 수신 ----------------------------------------------------------------------------------
	step = pageCode + "-01";
	
	messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] - "+"(1)"+" - "+"cannot request params";

	name = request.getParameter("name");       
	birth = request.getParameter("birth");     
	phnNo = request.getParameter("phnno");     
	tempUrl = request.getParameter("tempurl"); 
	
// 유효성 검증 -------------------------------------------------------------------------------------------
	step = pageCode + "-02";

	if(name.equals("")){	
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] - "+"(2-1)"+" - "+"name is null";
		fw.write(messege+"\r\n"); 
		fw.flush();
		fw.close();		
		throw new Exception();      
	}                               
	if(birth.equals("")){           
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] - "+"(2-2)"+" - "+"birth is null";
		fw.write(messege+"\r\n"); 
		fw.flush();
		fw.close();
		throw new Exception();      
	}                               
	if(birth.length() != 6){        
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] - "+"(2-3)"+" - "+"birth.length is not 6 digits";
		fw.write(messege+"\r\n"); 
		fw.flush();
		fw.close();
		throw new Exception();      
	}                               
	if(phnNo.equals("")){           
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] - "+"(2-4)"+" - "+"phnno is null";
		fw.write(messege+"\r\n"); 
		fw.flush();
		fw.close();
		throw new Exception();      
	}                               
	if(phnNo.length() != 11){       
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] - "+"(2-5)"+" - "+"phnno.length is not 11 digits";
		fw.write(messege+"\r\n"); 
		fw.flush();
		fw.close();
		throw new Exception();      
	}                               
	if(tempUrl.equals("")){         
		messege = "["+currentTime+"] [ERR] ("+trNum+") ["+step+"] - "+"(3)"+" - "+"tempurl is null";
		fw.write(messege+"\r\n"); 
		fw.flush();
		fw.close();
		throw new Exception();      
	}

	fullText = name + "|" + birth + "|" + phnNo + "|";
	
	step = pageCode+"-EE";
	
	messege = "["+currentTime+"] [INFO] ("+trNum+") ["+step+"] - "+"fullText send ( "+fullText+" )"; 
	fw.write(messege+"\r\n"); 
	fw.flush();
	
	messege = "["+currentTime+"] [INFO] ("+trNum+") ["+step+"] - "+"4proc.jsp successfully exited"; 
	fw.write(messege+"\r\n"); 
	fw.flush();
	fw.close();

%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="euc-kr">
	<title>res</title>
	<script type="text/javascript">
	
	var result = "";
	
	function toEnd(){
		document.temp.submit();
	}
	</script>
	</head>
	<body onload="toEnd();">
	<form id="temp" name="temp" method="post" action="<%=tempUrl%>">
		<input type="hidden" id="result" name="result" value="<%=fullText%>">
	</form>
	</body>
	</html>
<%
	}catch(Exception e){
		System.out.println(messege);
		response.sendRedirect("/temp_20190607/temp1/99err.jsp");
	}
%>










