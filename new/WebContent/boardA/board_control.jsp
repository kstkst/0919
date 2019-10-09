<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page errorPage="board_error.jsp" %>


<%@ page import= "boardA.*" %>
<%@ page import = "java.util.ArrayList" %>

 
<% request.setCharacterEncoding("UTF-8"); %>


<jsp:useBean id="boardDTO" class="boardA.BoardDTO" scope="request" ></jsp:useBean>


<jsp:setProperty property="*" name="boardDTO"/>

 
<jsp:useBean id="boardDAO" class="boardA.BoardDAO" scope="request" ></jsp:useBean>

	
 
<%

	/**
	*
	* @fn 		action.equals()
	* 
	* @brief 	control
	*
	* @author 	김성택
	* @date 	2019-10-09
	*
	* @param 	action
	*
	* @remark	값에따라 메소드를 다르게작용 [2019-10-09; 김성택] \n
	*
	*/


	String action = request.getParameter("action");

	
	if(action.equals("add")) {
	

		pageContext.forward("board_view.jsp?action=add");
	
	} else if(action.equals("insert")) {
		

		if(boardDAO.insertDB(boardDTO)) {


			pageContext.forward("board_control.jsp?action=list");
		} else {
			throw new Exception("DB 입력오류");
		}
		
	} else if(action.equals("list")) {
		

		ArrayList<BoardDTO> boardList = boardDAO.getDBList();
		

		request.setAttribute("boardList", boardList);
		pageContext.forward("board_list.jsp");
	} else if(action.equals("edit")) {
		

		boardDTO = boardDAO.getDB(Integer.parseInt((String)request.getParameter("id")));
		

		request.setAttribute("boardDTO", boardDTO);
		pageContext.forward("board_view.jsp?action=edit");
		
		
	}else if(action.equals("read")) {
		

		boardDTO = boardDAO.getDB(Integer.parseInt((String)request.getParameter("id")));
		

		request.setAttribute("boardDTO", boardDTO);
		pageContext.forward("board_read.jsp?action=read");
		
		
	} else if(action.equals("update")) {


		if(boardDAO.updateDB(boardDTO)) {


			pageContext.forward("board_control.jsp?action=list");
		} else {
			throw new Exception("DB 수정오류");
		}
		
	} else if(action.equals("delete")) {


		if(boardDAO.deleteDB(Integer.parseInt((String)request.getParameter("id")))) {


			pageContext.forward("board_control.jsp?action=list");
		} else {
			throw new Exception("DB 삭제오류");
		}
		
	} else {
		
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
		
	}
	
	
%> 
 
