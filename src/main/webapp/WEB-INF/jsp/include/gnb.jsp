<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="header-part d-flex h-100">
	<div class="logo col-10 d-flex align-items-center">
		<div>
			<a href="#" class="text-dark"><h1>메모 게시판</h1></a>
		</div>
	</div>
	<div class="login-part col-2 d-flex align-items-end justify-content-center flex-column">
		<%-- 세션이 있을 때만(로그인이 되었을 때만) 출력 --%>
		<c:if test="${not empty userName}">
			<div class="hello-userName">
				<div>${userName}님 안녕하세요.</div>
			</div>
			<div class="logout-part">
				<a href="/user/sign_out" class="logout text-dark"><small>로그아웃</small></a>
			</div>
		</c:if>
		<c:if test="${empty userName}">
			<div class="login-part">
				<a href="/user/sign_in_view" class="login text-dark"><small>로그인</small></a>
			</div>
		</c:if>
	</div>
</div>
