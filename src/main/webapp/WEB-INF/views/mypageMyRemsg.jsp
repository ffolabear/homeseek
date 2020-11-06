<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>homeseek : 받은 쪽지함</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageMyremsg.css" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/mypageMyremsg.js" type="text/javascript"></script>
</head>
<body>

	<%@ include file="./form/header.jsp" %>
	
	<section>
	
		<div class="maincontainer">
			<div class="myremsg-menu">
				<div class="myremsg-menu-title"><a class="goremsglist" href="#">받은 쪽지함</a></div>
				<div class="myremsg-menu-title"><a class="gosenmsglist" href="javascript:goSenMsgList();">보낸 쪽지함</a></div>
			</div>
			<hr/>
			<div class="myremsg-list">
				<form action = "" method = "post" class="checkremsglist">
					<table>
						<!-- 쪽지번호, 보낸사람, 제목, 날짜 -->
						<col width="80px">
						<col width="100px"> <!-- 쪽지 번호 -->
						<col width="80px">
						<col width="300px"> <!-- 쪽지 보낸 사람 -->
						<col width="80px">
						<col width="250px"> <!-- 제목 -->
						<col width="80px">
						<col width="100px"> <!-- 날짜 -->
						<col width="80px">
						<tr>
							<th colspan="9">&nbsp;</th>
						</tr>
						<c:choose>
							<c:when test="${empty remsglist }">
								<tr>
									<th colspan="9">현재 회원님께서 받은 쪽지가 없습니다.</th>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<th><input type="checkbox" class="all_check" name="all_check" onclick="allChk(this.checked)"/></th>
									<th>쪽지번호</th>
									<td></td>
									<th>쪽지제목</th>
									<td></td>
									<th>쪽지보낸아이디</th>
									<td></td>
									<th>쪽지작성날짜</th>
									<td></td>
								</tr>
								<tr>
									<td class="a" colspan="9">&nbsp;</td>
								</tr>
								<c:forEach items="${remsglist }" var="remsglist">
									<tr>
										<th><input type="checkbox" name="chkbox" class="chkbox" value="${remsglist.message_no }"/></th>
										<th>${remsglist.message_no }</th>
										<td></td>
										<th><a class="senmsgtitle" href="#">${remsglist.message_title }</a></th>
										<td></td>
										<th>${remsglist.message_senid }</th>
										<td></td>
										<th><fmt:formatDate value="${remsglist.message_date }" pattern="yyyy-MM-dd"/></th>
										<td></td>
									</tr>
									<tr>
										<td class="a" colspan="9"></td>
									</tr>
								</c:forEach>
							</c:otherwise>							
						</c:choose>
						<c:choose>
							<c:when test="${empty remsglist }">
							
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="9" align="right">
										<input type="button" class="muldelebtn" value="삭제하기"/>
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</form>
			</div>
		</div>
	
	</section>
	
	<%@ include file="./form/footer.jsp" %>

</body>
</html>