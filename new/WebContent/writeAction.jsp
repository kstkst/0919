<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> <!-- userdao의 클래스 가져옴 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<jsp:setProperty name="bbs" property="category" /> 
<jsp:setProperty name="bbs" property="groupId" />  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SNOW WHITE</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert(' 로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력이 되지 않은 사항이 있습니다.')");
						script.println("history.back()");
						script.println("</script>");
					} else{
						BbsDAO bbsDAO = new BbsDAO(); //인스턴스생성
						
						String category = request.getParameter("category");
						
						if(category.equals("notice")) {

					      	int newGroupId = bbsDAO.getNewGroupId();
					      	bbs.setGroupId(newGroupId);
					      }
					      
					      // 댓글 입력인 경우 게시글 그룹ID Setting
					      if(category.equals("reply")) {

					    	int noticeGroupId = Integer.parseInt(request.getParameter("noticeGroupId"));
					    	bbs.setGroupId(noticeGroupId);
					      }
					      
						int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent(), bbs.getCategory(), bbs.getGroupId());
						//회원가입실패
						if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert(' 글쓰기에 실패했습니다.')");
							script.println("history.back()");
							script.println("</script>");	
						}
						//회원가입 성공
						else{
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'bbs.jsp'");
							script.println("</script>");
						}
					}		
		}
	%>
</body>
</body>
</html>