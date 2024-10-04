<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//java로 oracle 조회 -> 오라클은 서버에 있다(자바)
//db 연결 설정
String driver = "oracle.jdbc.OracleDriver"; //oracle 사용
String url = "jdbc:oracle:thin:@localhost:1521:xe"; //jdbc:mySQL:@localhost:1521:xe, thin은 새 오라클 드라이브
String dbuid = "jsp";
String dbpwd = "1234";

// 넘어온 정보에 대해 한글 인코딩 처리
request.setCharacterEncoding("utf-8");

Class.forName(driver);
Connection db = DriverManager.getConnection(url, dbuid, dbpwd);
String sql = "SELECT USERID,";
sql += "PASSWD,";
sql += "USERNAME,";
sql += "EMAIL,";
sql += "TO_CHAR(RDATE, 'YYYY-MM-DD HH24:MI:SS PM') RDATE";
sql += " FROM MEMBERS";
sql += " ORDER BY USERID ASC";


PreparedStatement pstmt = db.prepareStatement(sql);


ResultSet rs = pstmt.executeQuery(); //조회 결과를 resultset에 담음
String html = "<table>";
html += "<tr>";
html += "<th>아이디</th>";
html += "<th>이름</th>";
html += "<th>이메일</th>";
html += "<th>가입일</th>";
html += "<th>삭제</th>";
html += "</tr>";
while (rs.next()) {
	String userid = rs.getString("userid");
	String username = rs.getString("username");
	String email = rs.getString("email").toLowerCase();
	String rdate = rs.getString("rdate");

	String fmt = "<tr>";
	fmt += "<td>%s</td>";
	fmt += "<td><a href='memupdateform.jsp?userid=%s'>%s</a></td>";
	fmt += "<td>%s</td>";
	fmt += "<td>%s</td>";
	fmt += "<td><a href='memdel.jsp?key=%s'>x</a></td>";
	fmt += "</tr>";
	html += String.format(fmt, userid, userid, username, email, rdate, userid );
}
html+="</table>";
rs.close();
pstmt.close();
db.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="../css/common.css" rel="stylesheet" />
<style>
   .menu { text-align:right;  }
</style>
</head>
<body>
	<div id="main">
		<h2>사용자 목록</h2>
		<p class="menu"><a href="memregform.html">회원가입</a></p>
		<p class="menu"><a href="loginform.html">로그아웃</a></p>
		<%=html%>
	</div>
</body>
</html>