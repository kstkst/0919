<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "bbs.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>와인</title>
</head>
<body>
<%
	String userID =null;
	if (session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
%>
 <!-- 네비게이션  -->
 <nav class="navbar navbar-default">
  <div class="navbar-header">
   <button type="button" class="navbar-toggle collapsed" 
    data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
    aria-expaned="false">
     <span class="icon-bar"></span>
     <span class="icon-bar"></span>
     <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="index.jsp">메인으로 가기</a>
  </div>
  <div class="collapse navbar-collapse" id="#bs-example-navbar-collapse-1">
    <%
    	if(userID == null){
    %>
    <ul class="nav navbar-nav navbar-right">
    	<li class="dropdown">
     		<a href="#" class="dropdown-toggle"
      			data-toggle="dropdown" role="button" aria-haspopup="true"
      			aria-expanded="false">접속하기<span class="caret"></span></a>
     		<ul class="dropdown-menu">
      			<li><a href="login.jsp">로그인</a></li>
      			<li><a href="join.jsp">회원가입</a></li>
         	</ul>
    	</li>
   </ul>
    <%		
    	} else {
    %>
        <ul class="nav navbar-nav navbar-right">
    	<li class="dropdown">
     		<a href="#" class="dropdown-toggle"
      			data-toggle="dropdown" role="button" aria-haspopup="true"
      			aria-expanded="false">회원관리<span class="caret"></span></a>
     		<ul class="dropdown-menu">
      			<li><a href="logoutAction.jsp">로그아웃</a></li>
         	</ul>
    	</li>
   </ul>
    <%	
    	}
    %>
    <%
	// request 내장객체에서 boardDTO get하여 클래스 변수에 저장()
	Bbs bbs = (Bbs)request.getAttribute("bbs");
	
	// edit가 아닌 add인 경우는 DTO 객체 생성
	if(bbs == null) {
		bbs = new Bbs();
	}
%>
  </div> 
 </nav>
 	<div class="container">
 		<div class="row">
 		<form method="post" action="writeAction.jsp">
 		<input type="hidden" name="category" value="notice">
 			<table class = "table table:striped" style="text-align: center; border : 1px solid #dddddd">
 				<thead>
 					<tr>
 						<th colspan="2" style = "background-color :#eeeeee; text-align: center;">게시판 글쓰기 양식</th>
 					</tr>
 				</thead>
 				<tbody>
 					<tr>
 						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
 					</tr>
 					<tr>
 						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px"></textarea></td>
 					</tr>
 				</tbody>
 			</table>
 			<a href="board_list.jsp" class="btn btn-primary">목록</a>
 			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
 		</form>
 		</div>
 	</div>
 <!-- 애니매이션 담당 JQUERY -->
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <!-- 부트스트랩 JS  -->
 <script src="js/bootstrap.js"></script>

</body>
</html>