<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 넘어온 정보 처리 
request.setCharacterEncoding("utf-8"); // 한글처리 필수
String userid = request.getParameter("userid");
String passwd = request.getParameter("passwd");
String username = request.getParameter("username");
String email = request.getParameter("email");

System.out.println(userid);
System.out.println(passwd);
System.out.println(username);
System.out.println(email);

// db 연결 설정
String driver = "oracle.jdbc.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String dbuid = "jsp";
String dbpwd = "1234";

Class.forName(driver);
Connection db = DriverManager.getConnection(url, dbuid, dbpwd);
String sql = "";
sql += "INSERT INTO MEMBERS ( USERID, PASSWD, USERNAME, EMAIL) ";
sql += " VALUES ( ?, ?, ?, ? )";
PreparedStatement pstmt = db.prepareStatement(sql);
pstmt.setString(1, userid);
pstmt.setString(2, passwd);
pstmt.setString(3, username);
pstmt.setString(4, email);

pstmt.executeUpdate(); // 자동 commit 실행된다

pstmt.close();
db.close();

//jsp 에서 페이지 이동   == location.href = 'list.jsp'
response.sendRedirect("list.jsp");
%>
<script>
	// js 의 페이지 이동 
	// location.href = 'list.jsp';
</script>










