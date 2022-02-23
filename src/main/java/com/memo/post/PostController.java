package com.memo.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.memo.post.bo.PostBO;
import com.memo.post.model.Post;

@RequestMapping("/post")
@Controller
public class PostController {
	
	@Autowired
	private PostBO postBO;

	/**
	 * 글 목록 화면 
	 * @param model
	 * @return
	 */
	@RequestMapping("/post_list_view")
	public String postListView(Model model) {
		// 글목록 DB에서 들고오기 
		List<Post> postList = postBO.getPostList();
		
		// model.add
		model.addAttribute("postList", postList);
		model.addAttribute("viewName", "post/post_list");
		return "template/layout";
	}
	
	/**
	 * 글 쓰기 화면 
	 * @param model
	 * @return
	 */
	@RequestMapping("/post_create_view")
	public String postCreateView(Model model) {
		model.addAttribute("viewName", "post/post_create");
		return "template/layout";
	}
}



