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
				<button type="button" id="postDeleteBtn" class="btn btn-danger" data-post-id="${post.id}">삭제</button>
				<div class="d-flex">
					<button type="button" id="postListBtn" class="btn btnCss mr-2">목록</button>
					<button type="button" id="saveBtn" class="btn btnCss" data-post-id="${post.id}">저장</button>
				</div>
			</div>
		</div>	
	</div>	
	<div class="col-2"></div>
</article>

<script>
	$(document).ready(function(e) {
		
		// 목록 버튼 클릭 
		$('#postListBtn').on('click', function(e) {
			location.href = "/post/post_list_view";
		});
		
		// 수정
		$('#saveBtn').on('click', function(e) {
			// validation check
			let subject = $('#subjcet').val().trim();
			
			if (subject == '') {
				alert("제목을 입력해주세요.");
				return;
			}
			
			let content = $('#content').val();
			
			// 파일이 업로드 된 경우 확장자 체크  
			let file = $('#file').val(); // 파일 경로만 가져온다. 
			// console.log(file); // 파일의 경로!
			if (file != '') {  // 값이 있으면, 
				let ext = file.split('.').pop().toLowerCase();  // 파일 경로를 .으로 나누고 확장자가 있는 마지막 문자열을 가져온 후 모두 소문자로 변경 
				if ($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {  // 파일이 파일 형태에 맞지 않으면 
					alert("gif, png, jpg, jpeg 파일만 업로드 할 수 있습니다.");
					$('#file').val(''); // 파일을 비운다 
					return;
				}
			}
			
			// 폼태그 객체를 자바스크립트에서 만든다.
			let formData = new FormData();
			let postId = $(this).data('post-id');
			formData.append("postId", postId);
			formData.append("subject", subject);
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			// AJAX 
			$.ajax({
				url: "/post/update"
				, type: "PUT"
				, data: formData
				, enctype: "multipart/form-data"  // 파일 업로드를 위한 필수 설정 
				, processData: false  // 파일 업로드를 위한 필수 설정 
				, contentType: false  // 파일 업로드를 위한 필수 설정 
				, success: function(data) {
					if (data.result == "success") {
						alert("메모가 수정되었습니다.");
						location.reload();  // 새로고침 
					} else {
						alert(data.errorMessage);
					}
				}
				, error: function(e) {
					alert("메모 저장에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		// 삭제 
		$('#postDeleteBtn').on('click', function(e) {
			let postId = $(this).data('post-id');
				
			// ajax
			$.ajax({
				type: "DELETE"
				, url: "/post/delete"
				, data: {"postId" : postId}
				, success: function(data) {
					if (data.result == "success") {
						alert("삭제되었습니다.");
						location.href = "/post/post_list_view";
					} else {
						alert(data.errorMessage);
					}
				}
				, error: function(e) {
					alert("메모를 삭제하는데 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
	});
</script>







