package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.common.EncryptUtils;
import com.memo.user.bo.UserBO;

@RequestMapping("/user")
@RestController
public class UserRestController {
	
	@Autowired
	private UserBO userBO;

	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("id") String id) {
		Map<String, Object> result = new HashMap<>();
		boolean existLoginId = userBO.existLoginId(id);
		result.put("result", existLoginId); // id가 이미 존재하면 true
		
		return result;
	}
	
	@PostMapping("/sign_up")
	public Map<String, Object> signUpForSubmit(
			@RequestParam("id") String id,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email) {
		
		// 비밀번호 암호화 
		String encryptPassword = EncryptUtils.md5(password);
		
		// TODO: DB insert
		int row = userBO.insertUser(id, encryptPassword, name, email);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		if (row < 1) {
			result.put("result", "error");
		}
		
		return result;
	}
}
