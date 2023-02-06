<%@page import="java.util.List"%>
<%@page import="bbs.*"%>
<%@page import="user.*" %>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width; inital-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하십시오.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();
		User mf = userDAO.getmyInfo(userID);
		
		if(mf != null) {
	%>
	    <nav class ="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li class="active"><a href="bbs.jsp">게시판</a></li>
            </ul>
            <%
            // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
                if(userID == null)
                {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
            // 로그인이 되어있는 사람만 볼수 있는 화면
                } else {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">회원관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="loginAction.jsp">로그아웃</a></li>
						<li><a href="myPage.jsp">마이페이지</a></li>
                    </ul>
                </li>
            </ul>
            <%
                }
            %>
        </div>
    </nav>
    <fieldset>
    <legend> 회원정보 수정</legend>
		<form action="myPageEditAction.jsp" method = "post" name = "fr">
			아이디: <input type="text" name="userID" value = "<%= mf.getUserID() %>" readonly><br>
			비밀번호: <input type="password" name="userPassword" placeholder="비밀번호를 입력하세요" required><br>
			이름: <input type="text" name="userName" value="<%=mf.getUserName() %>"><br>
			성별: <input type="radio" name="userGender" autocomplete="off" value="남자" <% if(mf.getUserGender().equals("남자")) { %> checked<% } %>>남자
				 <input type="radio" name="userGender" autocomplete="off" value="여자" <% if(mf.getUserGender().equals("여자")) { %> checked<% } %>>여자<br>
			이메일: <input type="text" name="userEmail" value="<%= mf.getUserEmail() %>"><br>
			<input type="submit" value="정보 수정하기">
		</form>
	</fieldset>
	<%
		}
	%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>