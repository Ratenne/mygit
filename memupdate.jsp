<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

request.setCharacterEncoding("utf-8");


//수정할 정보 조회
String userid = request.getParameter("userid");
String passwd = request.getParameter("passwd");
String username = request.getParameter("username");
String email = request.getParameter("email");

//update 쿼리를 실행한다.
//db 연결 설정
String driver = "oracle.jdbc.OracleDriver"; //oracle 사용
String url = "jdbc:oracle:thin:@localhost:1521:xe"; //jdbc:mySQL:@localhost:1521:xe, thin은 새 오라클 드라이브
String dbuid = "jsp";
String dbpwd = "1234";

Class.forName(driver);
Connection db = DriverManager.getConnection(url, dbuid, dbpwd);
String sql = "UPDATE MEMBERS SET";
sql += " USERNAME = ?";
sql += " ,EMAIL = ?";
sql += " WHERE USERID = ?";
sql += " AND PASSWD = ?";
PreparedStatement pstmt = db.prepareStatement(sql);
pstmt.setString(1, username);
pstmt.setString(2, email);
pstmt.setString(3, userid);
pstmt.setString(4, passwd);

pstmt.executeUpdate();

//돌아간다
response.sendRedirect("list.jsp");
%>