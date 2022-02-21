<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<article class="d-flex h-100">
	<div class="col-2"></div>
	<div class="memo-part col-8 d-flex align-items-center">
		<div class="w-100">
		<div>
			<div class="display-4 mb-3">회원가입</div>
		</div>
		<form id="signUpForm" method="POST" action="/user/sign_up">
			<table class="table table-sm table-bordered text-center">
				<tbody>
					<tr>
						<th scope="row" class="table-secondary">* 아이디</th>
						<td>
							<div class="d-flex">
								<input type="text" class="form-control col-8" id="id" name="id" placeholder="아이디를 입력해주세요.">
								<button type="button" class="btn btn-warning btnCss loginCheckBtn">중복확인</button>
							</div>
							<div class="d-flex justify-content-start ml-2">
								<small class="idCheckLength text-primary d-none">id를 4자 이상 입력해주세요.</small>
								<small class="idCheckDuplicated text-primary d-none">중복된 아이디 입니다.</small>
								<small class="idCheckOk text-primary d-none">사용 가능한 아이디 입니다.</small>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="table-secondary">* 비밀번호</th>
						<td>
							<input type="password" class="form-control col-8" id="password" name="password" placeholder="비밀번호를 입력해주세요.">
						</td>
					</tr>
					<tr>
						<th scope="row" class="table-secondary">* 비밀번호 확인</th>
						<td>
							<input type="password" class="form-control col-8" id="checkPwd" name="checkPwd" 
							placeholder="비밀번호를 다시 입력해주세요.">
						</td>
					</tr>
					<tr>
						<th scope="row" class="table-secondary">* 이름</th>
						<td>
							<input type="text" class="form-control col-8" id="name" name="name" placeholder="이름을 입력하세요.">
						</td>
					</tr>
					<tr>
						<th scope="row" class="table-secondary">* 이메일 주소</th>
						<td>
							<input type="text" class="form-control col-8" id="email" name="email" placeholder="이메일 주소를 입력하세요.">
						</td>
					</tr>
				</tbody>
			</table>
			<div class="d-flex justify-content-end">
				<button type="submit" id="signUpBtn" class="btn btnCss">회원가입</button>
			</div>
		</form>		
		</div>
	</div>
	<div class="col-2"></div>
</article>

<script>
	$(document).ready(function() {
		// 아이디 중복 확인 
		$('.loginCheckBtn').on('click', function(e) {
			let id = $('#id').val().trim();
			
			// 상황 문구 안보이게 모두 초기화 
			$('.idCheckLength').addClass('d-none');
			$('.idCheckDuplicated').addClass('d-none');
			$('.idCheckOk').addClass('d-none');
			
			if (id.length < 4) {
				// id가 4자 미만일 때 경고 문구 노출하고 끝낸다.
				$('.idCheckLength').removeClass('d-none');
				return;
			}
			
			// AJAX - 중복확인 
			$.ajax({
				// Get, Post 상관 없으면 비워둬도 됨 type: ""
				url: "/user/is_duplicated_id"
				, data: {"id":id}
				, success: function(data) {
					if (data.result == true) {
						// 중복인 경우
						$('.idCheckDuplicated').removeClass('d-none');
					} else if (data.result == false) {
						// 아닌 경우 => 사용 가능한 id
						$('.idCheckOk').removeClass('d-none');
					} else {
						// 에러 
					}	
				}
				, error: function(e) {
					alert("아이디 중복 확인에 실패하였습니다. 관리자에게 문의하여 주세요.");
				}

			});
		});
		
		// 회원가입 
		$('#signUpForm').on('submit', function(e) {
			e.preventDefault(); // 서브밋 기능 중단 
			
			// validation
			let id = $('#id').val().trim();
			if (id == '') {
				alert("id를 입력해주세요.");
				return false;
			}
			
			let password = $('#password').val();
			let checkPwd = $('#checkPwd').val();
			if (password == '' || checkPwd == '') {
				alert("비밀번호를 입력하세요.");
				return false;
			}
			
			if (password != checkPwd) {
				alert("비밀번호가 일치하지 않습니다.");
				// 텍스트의 값을 초기화한다.
				$('#password').val(''); 
				$('#checkPwd').val('');
				return false;
			}
			
			let name = $('#name').val().trim();
			if (name.length < 1) {
				alert("이름을 입력해주세요.");
				return false;
			}
			
			let email = $('#email').val().trim();
			if (email.length < 1) {
				alert("이메일을 입력해주세요.");
				return false;
			}
			
			// 아이디 중복확인이 되었는지 확인
			// idCheckOk <div>에 클래스 중 d-none이 있는 경우 => 성공이 아님 => return 시킴(회원가입 X)
			if ($('.idCheckOk').hasClass('d-none')) {
				alert("아이디 중복확인을 다시 해주세요.");
				return;
			}
			
			// submit
			// 1. form 서브밋 => 응답이 화면이 됨
			// 2. ajax 서브밋 => 응답은 데이터가 됨
			
			// 1. form 서브밋 
			// $(this)[0].submit();
			
			// 2. ajax 서브밋 
			let url = $(this).attr('action'); // form에 있는 action 주소를 가져오는 법
			let params = $(this).serialize(); // 폼태그에 들어있는 값을 한번에 보낼수 있게 구성한다. (name 속성)
			// console.log(params);
			
			$.post(url, params)
			.done(function(data){
				if (data.result == 'success') {
					alert("회원 가입 완료! 로그인을 해주세요!");
					location.href = "/user/sign_in_view";
				} else {
					alert("회원 가입에 실패했습니다. 다시 시도해 주세요.");
					
				}
			});
		});
	});
</script>



