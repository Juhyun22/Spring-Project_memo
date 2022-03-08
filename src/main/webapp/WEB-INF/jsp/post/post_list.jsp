<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<article id="post-list-part" class="d-flex my-4">
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
							<td>
								<a href="/post/post_detail_view?postId=${post.id}" class="text-dark">${post.subject}</a>
							</td>
							<td>
								<fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td>
								<fmt:formatDate value="${post.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<%-- 페이징 --%>
			<div class="d-flex justify-content-center">
			<c:if test="${prevId ne 0}">
				<a href="/post/post_list_view?prevId=${prevId}" class="go-front mr-5 text-dark font-weight-bold">&lt;&lt;이전</a>
			</c:if>
			<c:if test="${nextId ne 0}">
				<a href="/post/post_list_view?nextId=${nextId}" class="go-back text-dark font-weight-bold">다음&gt;&gt;</a>
			</c:if>
			</div>
			
			<%-- 글쓰기 버튼 --%>
			<div class="d-flex justify-content-end">
				<a href="/post/post_create_view" id="writeBtn" class="btn btnCss">글쓰기</a>
			</div>
		</div>	
	</div>
	<div class="col-2"></div>
</article>