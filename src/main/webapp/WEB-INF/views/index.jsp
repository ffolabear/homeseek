<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>homeseek : 공인중개사 없는 깔끔한 거래</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- socket.js -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<!-- <script src="${pageContext.request.contextPath}/resources/js/alert.js" type="text/javascript"></script> -->
<script src="${pageContext.request.contextPath}/resources/js/index.js" type="text/javascript"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
</head>
<body>
	<!-- header.jsp include -->
	<%@ include file="/WEB-INF/views/form/header.jsp" %>
	<%
//로그인 성공후 가는 페이지에서 위 코드를 넣어준다면 된다고 합니당 <-로그인후 뒤로가기 막는 방법
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
//response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.
%>

	
	
	<section>
		<div class="test">
			<!-- 메인페이지에서 작성할 부분 여기에 작성 -->
			<div class="mainText">
				H O M E <span>S E E</span> K
			</div>
			
			<div class="mainSearch">
			<form action="search.do" class="searchform"> <!-- 엘라스틱서치로 변경시 search.do 로 변경 -->
				<input type="text" class="searchtxt" name="word" placeholder="지역명, 대학교명, 지하철 명을 입력해주세요">
			</form>
			</div> 
			
		</div>
		
    	<img id="backgroundimg" alt="메인사진" src="${pageContext.request.contextPath}/resources/img/backgroundimg.jpg">
	</section>
</body>
</html>