<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page errorPage="board_error.jsp" %>

<%@ page import = "boardA.*" %>
<%@ page import = "java.util.ArrayList" %>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>


<html>

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>조회</title>
	
	<link rel="stylesheet" href="css/st.css" type="text/css" media="screen"/>

	

	<script type="text/javascript">
		function retrivalcheck() {
			

			document.form1.action.value="list";
			document.form1.submit();
	
			
		}
	
		function readcheck(id) {
		

			document.form1.action.value="read";
			document.form1.id.value=id;
			document.form1.submit();
	
			
		}
		
		function add() {
			

			document.form1.action.value="add";
			document.form1.submit();
	
			
		}
	</script>

	<%

		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값

		String userID =null;
	if (session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

	%>
	<!-- 뷰포트 -->
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<!-- 스타일시트 참조  -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<style type="text/css">
	a, a:hover{
	color : #000000;
	text-decoration : none;
	}
</style>
</head>

<jsp:useBean id="boardList" scope="request" class="java.util.ArrayList" />
<!-- ========== 네비게이션  ========== -->

<nav>

	<div class="container nav-container">
<%
		//로그인안된경우
	if (userID == null) {
	%>

	   	<ul class="navbar">

		    <li><a href="index.jsp">메인으로 이동</a></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>

			<li align="right"><a href="join.jsp">회원 가입</a></li>
			
			<li align="right"><a href="login.jsp">로그인</a></li>


	    </ul>
<%

				} else {

			%>

			<ul class="navbar">

				<li><a href="#" 
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>

				</li>
			
						<li><a href="logoutAction.jsp">로그아웃</a></li>
				</ul>

			<%

				}

			%>

	</div>

</nav>


<!-- ========== 소개화면 ========== -->

<div class="home-keyvisual">	

	<img src="img/mainc.jpg" class="img-responsive">  

</div>


<body>

	<div align=center>


	<div class="container">
 		<div clas="row">
 			<table class = "table table-striped" style="text-align: center; border : 1px solid #dddddd">
 				<thead>
 					<tr>
 						<th width = "10%" style = "background-color :#eeeeee; text-align: center;">번호</th>
 						<th width = "50%" style = "background-color :#eeeeee; text-align: center;">제목</th>
 						<th width = "20%" style = "background-color :#eeeeee; text-align: center;">작성자</th>
 						<th width = "30%" style = "background-color :#eeeeee; text-align: center;">작성일</th>
 					</tr>
 				</thead>
 				<tbody>
 				<%
 					BbsDAO bbsDAO = new BbsDAO();
 					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
 					for(int i=0; i < list.size(); i++){
 				%>	
 					<tr>
 						<td><%= list.get(i).getBbsID() %></td>
 						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID()%>"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></a></td>
 						<td><%= list.get(i).getUserID() %></td>
 						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) +  "시" + list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
 					</tr>
 				<% 					
 					}
 				%>
 				</tbody>
 			</table>
 			<%
 				if(pageNumber != 1){
			%>
			 	<a href="board_list.jsp?pageNumber=<%=pageNumber - 1%>"class="btn btn-success btn-arraw-left">이전</a>
			<%				
 				} if(bbsDAO.nextPage(pageNumber + 1)){
 			%>
 				 <a href="board_list.jsp?pageNumber=<%=pageNumber + 1%>"class="btn btn-success btn-arraw-left">다음</a>
 			<%	 					
 				}
 			%>
 			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
 		</div>
 	</div>
 <!-- 애니매이션 담당 JQUERY -->
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <!-- 부트스트랩 JS  -->
 <script src="js/bootstrap.js"></script>

	</div>
</body>
<!-- ========== 푸터 ========== -->

<footer>


  <div class="container footer-container">

	<p class="footer-copyright">

		copyright jei@jeineungmail.com

		</p>

	</div>


</footer>

</body>

</html>

</html>