<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> <!-- userdao의 클래스 가져옴 -->
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SNOW WHITE</title>
</head>
<body>
	<%		
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'board_list.jsp'");
			script.println("</script>");
		} else {
						BbsDAO bbsDAO = new BbsDAO(); //인스턴스생성
	 					int result = bbsDAO.hitUpdate(bbsID);
						//회원가입실패
						if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert(' 글 수정에 실패했습니다.')");
							script.println("history.back()");
							script.println("</script>");	
						}
						//회원가입 성공
						else{
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'board_list.jsp'");
							script.println("</script>");
						}
					}		
	%>
</body>
</body>
</html>