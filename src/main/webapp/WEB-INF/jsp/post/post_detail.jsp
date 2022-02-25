<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<article class="d-flex">
	<div class="col-2">
		<div class="display-4 mt-4 ml-4">글상세</div>
		<div class="display-4 mt-4 ml-4">& 수정</div>
	</div>
	<div class="post-create-part col-8 d-flex align-items-center my-5">
		<div class="w-100">
			<div class="subject-part">
				<input type="text" class="form-control" id="subjcet" name="subjcet" placeholder="제목을 입력해주세요." value="${post.subject}">
			</div>
			<div class="content-part mt-1">
				<textarea class="form-control" id="content" name="content" rows="15" placeholder="내용을 입력해주세요.">${post.content}</textarea>
			</div>
			<%-- 이미지가 있을 때만 이미지 영역 추가 --%>
			<c:if test="${not empty post.imagePath}">
				<div class="image-area mt-2">
					<img src="${post.imagePath}" alt="업로드 이미지" height="60px">
				</div>
			</c:if>
			
			<div class="file-part d-flex justify-content-end my-2">
				<input id="file" type="file" accept=".jpg,.png,.gif,.jpeg">
			</div>
			
			<div class="d-flex justify-content-between">
				<button type="button" id="postDeleteBtn" class="btn btn-danger">삭제</button>
				<div class="d-flex">
					<button type="button" id="postListBtn" class="btn btnCss mr-2">목록</button>
					<button type="button" id="saveBtn" class="btn btnCss">저장</button>
				</div>
			</div>
		</div>	
	</div>	
	<div class="col-2"></div>
</article>
