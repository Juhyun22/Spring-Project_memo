package com.memo.post.bo;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.common.FileManagerService;
import com.memo.post.dao.PostDAO;
import com.memo.post.model.Post;

@Service
public class PostBO {
	
	// private Logger logger = LoggerFactory.getLogger(PostBO.class);
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManager;
	
	private static final int POST_MAX_SIZE = 3;
	
	public List<Post> getPostListByUserId(int userId, Integer prevId, Integer nextId) {
		// 10 9 8 | 7 6 5 | 4 3 2 | 1
		
		// 예를 들어 7 6 5 페이지에서 
		// 1) 다음을 눌렀을 때: nextId-5 => 5보다 작은 3개 => 4 3 2     DESC
		// 2) 이전을 눌렀을 때: prevId-7 => 7보다 큰 3개 => 8 9 10     ASC  => 코드에서 데이터를 reverse
		// 3) 첫 페이지로 들어왔을 때: 10 9 8 DESC
		
		String direction = null;
		Integer standardId = null;
		if (nextId != null) {  // 1) 다음 클릭 
			direction = "next";
			standardId = nextId;
			
			return postDAO.selectPostListByUserId(userId, direction, standardId, POST_MAX_SIZE);
		} else if (prevId != null) {  // 2) 이전 클릭 
			direction = "prev";
			standardId = prevId;
			
			List<Post> postList = postDAO.selectPostListByUserId(userId, direction, standardId, POST_MAX_SIZE);
			// 7보다 큰 3개 8 9 10이 나오므로 List를 reverse 정렬 시킨다. 
			Collections.reverse(postList);
			return postList;
		}
		
		// 3) 첫 페이지 
		return postDAO.selectPostListByUserId(userId, direction, standardId, POST_MAX_SIZE);
	}
	
	public Post getPostById(int id) {
		return postDAO.selectPostById(id);
	}
	
	public void addPost(int userId, String userLoginId, String subject, String content, MultipartFile file) {
		String imagePath = null;
		if (file != null) { // 파일에 값이 있다면 
			// TODO: 파일 매니저 서비스, input:MultipartFile, output:이미지의 주소 
			imagePath = fileManager.saveFile(userLoginId, file);
		}
		
		// insert DAO
		postDAO.insertPost(userId, subject, content, imagePath);
	}
	
	public int updatePost(int postId, String userLoginId, int userId, String subject,
			String content, MultipartFile file) {
		
		// postId에 해당하는 게시글이 있는지 DB에서 가져와본다. 
		Post post = getPostById(postId);
		if (post == null) {
			logger.error("[update post] 수정할 메모가 존재하지 않습니다." + postId);
			return 0;  // 없음을 리턴 
		}
		
		// 파일이 있는지 본 후 있으면 서버에 업로드하고 image path 받아온다. 
		// 파일이 만약 없으면, 수정하지 않는다. 있으면 수정! 
		String imagePath = null;
		if (file != null) {
			imagePath = fileManager.saveFile(userLoginId, file);  // 컴퓨터 파일 업로드 후 URL PATH를 얻어낸다. 
			
			// 새로 업로드된 이미지가 성공하면 기존 이미지 삭제 (기존 이미지가 있을 때에만)
			if (post.getImagePath() != null && imagePath != null) {
				// 기존 이미지 삭제 
				try {
					fileManager.deleteFile(post.getImagePath());
				} catch (IOException e) {
					logger.error("[update post] 이미지 삭제 실패 {}, {}", post.getId(), post.getImagePath());
				}
			}
		}
		
		// DB에서 update 
		return postDAO.updatePostByUserIdAndPostId(postId, userId, subject, content, imagePath);
	}
	
	public int deletePostByPostIdAndUserId(int postId, int userId) {
		// 삭제 전에 게시글을 먼저 가져와본다. (이미지 path가 있을수 있기 때문에)
		Post post = getPostById(postId);
		if (post == null) {
			logger.warn("[delete post] 삭제할 메모가 존재하지 않습니다." + postId);
			return 0;
		}
		
		// imagePath가 있는 경우 파일 삭제 
		if (post.getImagePath() != null) {
			// 기존 이미지 삭제 
			try {
				fileManager.deleteFile(post.getImagePath());
			} catch (IOException e) {
				logger.error("[delete post] 이미지 삭제 실패 {}, {}", post.getId(), post.getImagePath());
			}
		}
		
		// DB에서 Post 삭제 
		return postDAO.deletePostByUserIdPostId(userId, postId);
	}
}







