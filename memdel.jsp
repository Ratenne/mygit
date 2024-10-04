<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String userid = request.getParameter("key");

//db 연결 설정
String driver = "oracle.jdbc.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String dbuid = "jsp";
String dbpwd = "1234";

Class.forName(driver);
Connection db = DriverManager.getConnection(url, dbuid, dbpwd);
String sql = "";
sql += "DELETE FROM MEMBERS ";
sql += " WHERE USERID =  ?";
PreparedStatement pstmt = db.prepareStatement(sql);
pstmt.setString(1, userid);

pstmt.executeUpdate(); // 자동 commit 실행된다

pstmt.close();
db.close();

response.sendRedirect("list.jsp");
%>
