<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>와인</title>
<link rel="stylesheet" href="css/st.css">
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav>

	<div class="container nav-container">

	   	<ul class="navbar">

		    <li><a href="index.html">메인으로 이동</a></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>
		    <li></li>

			<li align="right"><a href="sub1.html">회원 가입</a></li>
			
			<li align="right"><a href="sub2.html">로그인</a></li>


	    </ul>

	</div>

</nav>


<!-- ========== 소개화면 ========== -->

<div class="home-keyvisual">	

	<img src="img/mainc.jpg" class="img-responsive">  

</div>


<!-- ========== 메인 ========== --> 

<section class="main">

	<div class="container">

		<main>

			<p class="home-mainc">와인, 어떻게 즐길까<br>

				<span class="home-color1">와인에 대한 모든것</span><strong> 와인21</strong>.
				
			</p>


			<ul class="home-course"> 

				<li>

					<a href="https://www.wine21.com/13_search/wine_view.html?Idx=137504"><figure><img src="img/발비 소프라니.jpg">

					<figcaption>발비 소프라니</figcaption>

					</figure></a>

				</li>

				<li>

					<a href="https://www.wine21.com/13_search/wine_view.html?Idx=143350"><figure><img src="img/일렉트라.jpg">

					<figcaption>일렉트라</figcaption>

					</figure></a>

				</li>

				<li>

					<a href="https://www.wine21.com/13_search/wine_view.html?Idx=149603"><figure><img src="img/솔라티오 모스카토 다스티.jpg"> 

					<figcaption>솔라티오 모스카토 다스티</figcaption>

					</figure></a>

				</li>

				<li>

					<a href="https://www.wine21.com/13_search/wine_view.html?Idx=154703"><figure><img src="img/니볼레 모스카토 다스티.jpg">

					<figcaption>니볼레 모스카토 다스티</figcaption>

					</figure></a>

				</li>

			</ul>
		<!-- 공지사항  -->
			
			
            <h2 class="home-h2">공지 사항</h2>

			<div class="gongjee">

			<ul>

			<li>7월부터 와인 게시판을 개설합니다.</li>

			<li>최신 와인 포럼. 참가자 접수 시작</li>

			<li>프로모션 등록 50% 할인</li>

			</ul>
				</div>
				
				<h2 class="home-h2">게시판</h2>

			<div class="gongjee">

			<ul>

			<li><a href="boardA/board_list.jsp"> 게시판으로 이동 </a></li>

			</ul>
				</div>
				</main>

			


		

	</div>
	
</section>

<!-- ========== 푸터 ========== -->

<footer>


  <div class="container footer-container">

	<p class="footer-copyright">

		copyright jei@jeineungmail.com

		</p>

	</div>


</footer>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>