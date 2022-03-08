package com.memo.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class PermissionInterceptor implements HandlerInterceptor {

	private Logger logger = LoggerFactory.getLogger(PermissionInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object Handler) throws IOException {
		
		//  /user/sign_in_view => 로그인 페이지, 회원가입        로그인 상태&&/user... => /post/post_list_view로 이동시킨다. 
		// 로그아웃까지 처리하면 /post로 이동되면서 로그아웃 안되는 현상 발생하므로 권한검사 제외 
		
		
		// /post/post_detail, list, ...     로그인이 안된 상태 && /post => /user/sign_in_view로 이동시킨다. 
		
		
		// 세션이 있는지 확인한다. => 있으면 로그인된 상태 
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		
		
		// URI 확인(url path를 가져온다.) 
		String uri = request.getRequestURI();
		
		if (userId != null && uri.startsWith("/user")) {
			// 로그인 상태 && 접근을 시도한 uri path가 /user... 이면 게시판 목록으로 리다이렉트 
			response.sendRedirect("/post/post_list_view");
			return false;
		} else if (userId == null && uri.startsWith("/post")) {  // 비로그인 상태 && 접근을 시도한 uri path가 /post... 이면 로그인 페이지로 리다이렉트 
			response.sendRedirect("/user/sign_in_view");
			return false;
		}
		
		logger.warn("########## preHandle 호출, uri:{}", uri);
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, 
			Object Handler, ModelAndView modelAndView) {
		
		// URI 확인(url path를 가져온다.) 
		String uri = request.getRequestURI();
		
		logger.warn("######### postHandle, uri:{}", uri);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, 
			Object Handler, Exception ex) {

		// URI 확인(url path를 가져온다.) 
		String uri = request.getRequestURI();
		
		logger.warn("######## afterCompletion, uri:{}", uri);
	}
} 
