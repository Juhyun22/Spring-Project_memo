<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<article class="d-flex">
	<div class="col-2">
		<div class="display-4 mt-4 ml-4">글쓰기</div>
	</div>
	<div class="post-create-part col-8 d-flex align-items-center my-5">
		<div class="w-100">
			<div class="subject-part">
				<input type="text" class="form-control" id="subjcet" name="subjcet" placeholder="제목을 입력해주세요.">
			</div>
			<div class="content-part mt-1">
				<textarea class="form-control" id="content" name="content" rows="15" placeholder="내용을 입력해주세요."></textarea>
			</div>
			<div class="file-part d-flex justify-content-end my-2">
				<input id="file" type="file" accept=".jpg,.png,.gif,.jpeg">
			</div>
			<div class="d-flex justify-content-between">
				<button type="button" id="postListBtn" class="btn btnCss">목록</button>
				<div class="d-flex">
					<button type="button" id="clearBtn" class="btn btnCss mr-2">모두 지우기</button>
					<button type="button" id="saveBtn" class="btn btnCss">저장</button>
				</div>
			</div>
		</div>	
	</div>
	<div class="col-2"></div>
</article>

<script>
	$(document).ready(function() {
		// 목록 버튼 클릭 => 글 목록으로 이동 
		$('#postListBtn').on('click', function(e) {
			// 바로 주소로 이동 
			location.href="/post/post_list_view";
		});
		
		// 모두 지우기 
		$('#clearBtn').on('click', function(e) {
			// 제목과 내용을 빈칸으로 만든다. 
			$('#subjcet').val('');
			$('#content').val('');
		});
		
		// 글 내용 저장 
		$('#saveBtn').on('click', function(e) {
			// validation - 제목만 필수 
			let subject = $('#subjcet').val();
			if (subject.length < 1) {
				alert("제목을 입력해주세요.");
				return;
			}
			
			let content = $('#content').val();
			console.log(content);
			
			// 파일이 업로드 된 경우 확장자 체크  
			let file = $('#file').val(); // 파일 경로만 가져온다. 
			console.log(file); // 파일의 경로!
			if (file != '') {  // 값이 있으면, 
				let ext = file.split('.').pop().toLowerCase();  // 파일 경로를 .으로 나누고 확장자가 있는 마지막 문자열을 가져온 후 모두 소문자로 변경 
				if ($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {  // 파일이 파일 형태에 맞지 않으면 
					alert("gif, png, jpg, jpeg 파일만 업로드 할 수 있습니다.");
					$('#file').val(''); // 파일을 비운다 
					return;
				}
			}
			
			// 폼태그를 자바스크립트에서 만든다. 
			let formData = new FormData();
			formData.append("subject", subject);
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]); // $('#file')[0]은 첫번쨰 input file 태그를 의미, files[0]은 업로드 된 첫번째 파일을 의미 
			
			// AJAX form 데이터 전송 
			$.ajax({
				type: "post"
				, url: "/post/create"
				, data: formData
				, enctype: "multipart/form-data"  // 파일 업로드를 위한 필수 설정 
				, processData: false  // 파일 업로드를 위한 필수 설정 
				, contentType: false  // 파일 업로드를 위한 필수 설정 
				, success: function(data) {
					if (data.result == 'success') {
						alert("메모가 저장되었습니다.");
						location.href = "/post/post_list_view";
					} else {
						alert(data.errorMessage);
						location.href = "/user/sign_in_view";
					}
				}
				, error: function(e) {
					alert("메모 저장에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
	});
</script>



