package com.memo.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.memo.user.dao.UserDAO;

@Service
public class UserBO {
	
	@Autowired
	private UserDAO userDAO;
	
	public boolean existLoginId(String id) {
		return userDAO.existLoginId(id);
	}
	
	public int insertUser(String loginId, String password, String name, String email) {
		return userDAO.insertUser(loginId, password, name, email);
	}
}
