<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<article class="d-flex h-100">
	<div class="col-4"></div>
	<div class="login-part col-4 d-flex align-items-center">
		<div class="w-100">
			<div class="display-4">로그인</div>
		
			<%-- 키보드 Enter키로 로그인이 될 수 있도록 form 태그를 만들어준다.(submit 타입의 버튼이 동작됨) --%>
			<form id="loginForm" action="/user/sign_in" method="post">
				<div class="input-group mb-3">
					<%-- input-group-prepend: input box 앞에 ID 부분을 회색으로 붙인다. --%>
					<div class="input-group-prepend">
						<span class="input-group-text">&nbsp;ID&nbsp;</span>
					</div>
					<input type="text" class="form-control" id="loginId" name="loginId">
				</div>
		
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">PW</span>
					</div>
					<input type="password" class="form-control" id="password" name="password">
				</div>
				
				<%-- btn-block: 로그인 박스 영역에 버튼을 가득 채운다. --%>
				<input type="submit" class="btn btn-block btnCss" value="로그인">
				<a class="btn btn-block btnCss" href="/user/sign_up_view">회원가입</a>
			</form>
		</div>	
	</div>
	<div class="col-4"></div>
</article>
<script>
	$(document).ready(function() {
		$('#loginForm').on('submit', function(e) {
			e.preventDefault(); // submit 기능을 중단시킨다. 
			
			// validation check
			let loginId = $('#loginId').val().trim();
			if (loginId.length < 1) {
				alert("아이디를 입력해주세요.");
				return false;
			}
			
			let password = $('#password').val();
			if (password == '') {
				alert("비밀번호 입력해주세요.");
				return false;
			}
			
			// ajax 호출 
			let url = $(this).attr('action'); // form 태그에 있는 action 주소를 가져옴 
			let params = $(this).serialize(); // form 태그에 있는 name 값들을 쿼리스트링으로 구성 
			
			$.post(url, params)
			.done (function(data) { // 성공하면, 
				if (data.result == 'success') {
					location.href = "/post/post_list_view"; // 로그인이 성공하면 글 목록으로 이동 
				} else {
					alert(data.errorMessage);
				}
			});
		});
	});

</script>


