<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<article id="post-list-part" class="d-flex">
	<div class="col-2">
		<div class="display-4 mt-3 ml-3">글 목록</div>
	</div>
	<div class="post-list-part col-8 d-flex align-items-center">
		<div class="w-100">
			<table class="table table-hover table-bordered text-center">
				<thead>
					<tr>
						<th>No.</th>
						<th>제목</th>
						<th>작성 날짜</th>
						<th>수정 날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${postList}" var="post">
						<tr>
							<td>${post.id}</td>
							<td>${post.subject}</td>
							<td>
								<fmt:formatDate value="${post.createdAt}" pattern="yyyy-M-d HH:mm:ss"/>
							</td>
							<td>
								<fmt:formatDate value="${post.updatedAt}" pattern="yyyy-M-d HH:mm:ss"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="d-flex justify-content-center">
				<a href="#" class="go-front text-dark font-weight-bold">&lt;&lt;이전</a>&emsp;&emsp;&emsp;
				<a href="#" class="go-back text-dark font-weight-bold">다음&gt;&gt;</a>
			</div>
			<div class="d-flex justify-content-end">
				<a href="/post/post_create_view" id="writeBtn" class="btn btnCss">글쓰기</a>
			</div>
		</div>	
	</div>
	<div class="col-2"></div>
</article>