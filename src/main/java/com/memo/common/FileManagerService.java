package com.memo.common;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component  // 스프링 빈  
public class FileManagerService {

	public final static String FILE_UPLOAD_PATH = "/Users/jyhyun/Desktop/6_spring_project/memo/memo_workspace/images";
	
	public String saveFile(String userLoginId, MultipartFile file) {
		// 파일 디렉토리 경로의 예: bora_시간/파일이름.png
		// 파일명이 겹치지 않게 하기 위해 현재시간을 경로에 붙혀준다. 
		String directoryName = userLoginId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		
	}
	
}
