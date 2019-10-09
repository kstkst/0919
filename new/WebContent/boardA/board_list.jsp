<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ page errorPage="board_error.jsp" %>


<%@ page import= "boardA.*" %>
<%@ page import = "java.util.ArrayList" %>

<!DOCTYPE html>


<html>

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>조회</title>
	
	<link rel="stylesheet" href="../css/st.css" type="text/css" media="screen"/>

	

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

</head>

<jsp:useBean id="boardList" scope="request" class="java.util.ArrayList" />
<!-- ========== 네비게이션  ========== -->

<nav>

	<div class="container nav-container">

	   	<ul class="navbar">

		    <li><a href="sub1.html">국내 와인</a></li>

			<li><a href="sub2.html">해외 와인</a></li>


	    </ul>

	</div>

</nav>


<!-- ========== 소개화면 ========== -->

<div class="home-keyvisual">	

	<img src="../img/mainc.jpg" class="img-responsive">  

</div>


<body>
	<div align=center>


	<form name="form1" method="post" action="board_control.jsp">
		<input type="hidden" name="action" value="list">
		<input type="hidden" name="id" value=0>
	
		<table class="bbsListTbl">
		
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<%
				if(boardList != null) {
				

					for(BoardDTO boardDTO : (ArrayList<BoardDTO>) boardList) {
			%>
						<tr>
							<td class="tit_notice"><%=boardDTO.getId() %></td>
							<td class="tit_notice"><a href="javascript:readcheck(<%=boardDTO.getId() %>)"><%=boardDTO.getTitle() %></a></td>
							<td class="tit_notice"><%=boardDTO.getUser() %></td>
							<td class="tit_notice"><%=boardDTO.getDate() %></td>
						</tr>
			<%	
					}
				}
			%>
			<tr>
				<td colspan=4 align=right>
    				<input type="button" value="조회" onClick="retrivalcheck()">
    				<input type="button" value="글작성" onClick="add()">
				</td>
			</tr>
			</table>
		</form>
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