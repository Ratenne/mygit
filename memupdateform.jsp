<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//넘어온 정보를 받아서 수정할 정보를 조회
request.setCharacterEncoding("utf-8");
String userid = request.getParameter("userid");

//수정할 ㅅ정보를ㄹ 조회
//db 연결 설정
String driver = "oracle.jdbc.OracleDriver"; //oracle 사용
String url = "jdbc:oracle:thin:@localhost:1521:xe"; //jdbc:mySQL:@localhost:1521:xe, thin은 새 오라클 드라이브
String dbuid = "jsp";
String dbpwd = "1234";

Class.forName(driver);
Connection db = DriverManager.getConnection(url, dbuid, dbpwd);
String sql = "SELECT * FROM MEMBERS";
sql += " WHERE USERID = ?";
PreparedStatement pstmt = db.prepareStatement(sql);
pstmt.setString(1, userid);

String uid = "";
String passwd = "";
String username = "";
String email = "";
String rdate = "";

String html = "";
ResultSet rs = pstmt.executeQuery(); //조회결과를 rs에 담음
if (rs.next()) {
	uid = rs.getString(1); //rs.getString("userid") 조회한 첫번째 칼럼
	passwd = rs.getString(2);
	username = rs.getString(3);
	email = rs.getString(4);
	rdate = rs.getString(5);

}

rs.close();
pstmt.close();
db.close();

//조회한 정보로 수정할 정보 입력화면을 생성
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/common.css" rel="stylesheet" />
<style>
input[type="text"], input[type="password"], input[type="email"] {
	width: 100%;
}

.red {
	color: red;
}
</style>
</head>
<body>
	<div id="main">
		<form action="memupdate.jsp" method="POST">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="userid" id="userid" value="<%=uid%>" readonly /></td> <!-- 서버에 있는 변수 -->
				<!-- readonly: 읽기전용 -->
				</tr>
				<tr>
					<td><span class="red">*</span>비밀번호</td>
					<td><input type="password" name="passwd" id="passwd" /></td>
				</tr>
				<tr>
					<td><span class="red">*</span>이름</td>
					<td><input type="text" name="username" id="username" value="<%=username%>" /></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" id="email" value="<%=email%>" /></td>
				</tr>
				<tr>
					<td>가입일</td>
					<td><input type="text" name="rdate" id="rdate" value="<%=rdate%>" /></td>
				</tr>
				   <tr>
				     <td colspan="2">
				     <input type="submit"  value="수정" />
				     <input type="button"  value="뒤로" onclick="history.back()" />
				     </td>   
				   </tr>  
			</table>
		</form>
	</div>
</body>
</html>