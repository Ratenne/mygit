<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//db 연결 설정
String driver = "oracle.jdbc.OracleDriver"; //oracle 사용
String url = "jdbc:oracle:thin:@localhost:1521:xe"; //jdbc:mySQL:@localhost:1521:xe
String dbuid = "jsp";
String dbpwd = "1234";

//넘어온 parameter정보 처리 userid, passwd
//넘어온 정보에 대해 한글 인코딩 처리
request.setCharacterEncoding("utf-8");
String userid=request.getParameter("userid");
String passwd=request.getParameter("passwd");
System.out.println(userid);


//db조회
Class.forName(driver);
Connection db=DriverManager.getConnection(url,dbuid,dbpwd);
String sql = "SELECT USERID";
sql += ", USERNAME";
sql += ", EMAIL";
sql += ", TO_CHAR(RDATE,'YYYY-MM-DD HH:MI:SS PM') RDATE ";//TO_CHAR(RDATE, 'YYYY-MM-DD HH24:MI:SS') 불가
sql += "FROM MEMBERS ";
sql += "WHERE USERID = ? ";
sql += "AND PASSWD = ?";

PreparedStatement pstmt=db.prepareStatement(sql);
pstmt.setString(1, userid);
pstmt.setString(2, passwd);

ResultSet rs = pstmt.executeQuery();
String html="";
//조회결과가 1개이거나 없다.
if(rs.next()){ //아이디가 존재한다.
	html+="<h2>회원정보</h2>";
	html+="<div>아이디:"+ rs.getString("userid")+"</div>";
	html+="<div>이름:"+ rs.getString("username")+"</div>";
	html+="<div>이메일:"+ rs.getString("email")+"</div>";
	html+="<div>가입일:"+ rs.getString("rdate")+"</div>"; 
	html+="<div><a href='javascript:history.back()''>뒤로</a></div>";
}else{ //없는 회원
	html+="<h2>존재하지 않는 회원입니다.</h2>";
	html+="<a href='memregform.html'>회원가입</a>";
	html+="<div><a href='javascript:history.back()'>뒤로</a></div>";
}
rs.close();
pstmt.close();
db.close();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<%=html %>
</body>
</html>