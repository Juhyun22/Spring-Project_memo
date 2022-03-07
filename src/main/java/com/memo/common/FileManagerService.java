package com.memo.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component  // 스프링 빈  
public class FileManagerService {

	public final static String FILE_UPLOAD_PATH = "/Users/jyhyun/Desktop/6_spring_project/memo/memo_workspace/images/";
	
	public String saveFile(String userLoginId, MultipartFile file) {
		// 파일 디렉토리 경로의 예: bora_시간/파일이름.png
		// 파일명이 겹치지 않게 하기 위해 현재시간을 경로에 붙혀준다. 
		String directoryName = userLoginId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		// 디렉토리 만들기 
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;  // 디렉토리 생성 시 실패하면 null 리턴 
		}
		
		// upload file : byte단위로 업로드한다. 
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());  // getOriginalFilename()은 input에 올릴 파일 명이다.(한글 X)
			Files.write(path, bytes);
			
			// 이미지 url을 리턴한다.(WebMvcConfig에서 매핑한 이미지 path) 
			// ex) http://localhost/images/image파일 이름/이미지이름
			return "/images/" + directoryName + file.getOriginalFilename();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public void deleteFile(String imagePath) throws IOException {
		// imagePath의  /images/image파일 이름/이미지이름에서     /images/를 제거한 path 실제 저장 경로를 붙힌다. 
		// /Users/jyhyun/Desktop/6_spring_project/memo/memo_workspace/images/ 에서 /images/image파일 이름/이미지이름 두개 겹쳐서 하나 삭제해야함
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
		if (Files.exists(path) == true) {  // 이미지 파일이 있으면 삭제 
				Files.delete(path);
		}
		
		// 디렉토리(폴더) 삭제 
		path = path.getParent();
		if (Files.exists(path)) {
			try {
				Files.delete(path);
			} catch (IOException e) {
				e.printStackTrace();  // 이 부분도 로깅으로 찍는 것이 좋음 
			}
		}
	}
}







