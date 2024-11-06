package com.oracle.samil.Acontroller;


import java.io.File;
import java.io.IOException;
import java.util.List;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;


import java.nio.file.Path;
import java.nio.file.Paths;
import java.net.MalformedURLException;


import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.Posts;
import com.oracle.samil.JhService.Paging;
import com.oracle.samil.JhService.PostsService;


import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpSession;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping(value = "/jh")
@RequiredArgsConstructor
public class JhPostController {

	private final PostsService ps;
	@Value ("${file.path}/jh")
	private String filePath;

	// (공지)토탈로 게시글 수 가져와서 페이징작업
	@GetMapping(value = "/postNotice")
	public String postNotice(Posts posts, Model model) {
		System.out.println("jh postNotice play~");

		int totalPosts = ps.totalPosts();

		if (posts.getCurrentPage() == null)
			posts.setCurrentPage("1");
		// Paging 작업
		Paging page = new Paging(totalPosts, posts.getCurrentPage());

		posts.setStart(page.getStart());
		posts.setEnd(page.getEnd());

		List<Posts> myposts = ps.listPosts(posts);
		List<Posts> mypostss = ps.listPostss(posts);

		model.addAttribute("totalPosts", totalPosts);
		model.addAttribute("listPosts", myposts);
		model.addAttribute("listPostss",mypostss);
		model.addAttribute("page", page);

		return "jh/postNotice";
	}

	// (공지)검색기능 검색된 게시글수 가져와서 페이징작업
	@RequestMapping(value = "listSearch3")
	public String listSearch3(Posts posts, Model model) {

		int totalSearchPosts = ps.totalSearchPosts(posts);
		System.out.println("controller start listSearch3...");
		System.out.println("controller listSearch3 posts->" + posts);
		System.out.println("controller listSearch3 totalSearchPosts->" + totalSearchPosts);
		// Paging 작업
		Paging page = new Paging(totalSearchPosts, posts.getCurrentPage());

		posts.setStart(page.getStart());
		posts.setEnd(page.getEnd());

		List<Posts> listSearchPosts = ps.listSearchPosts(posts);
		model.addAttribute("totalPosts", totalSearchPosts);
		model.addAttribute("listPosts", listSearchPosts);
		model.addAttribute("page", page);
		System.out.println("controller listSearch3 page->" + page);

		return "jh/postNotice";
	}

	// 공지 자유 자주 상세 게시물 조회
	@GetMapping("detailPosts/{postId}")
	public String detailPosts(@PathVariable("postId") int postId, Model model, HttpSession session) {
	    Emp emp = (Emp) session.getAttribute("emp");

	    // 상세 게시물 조회
	    System.out.println("게시물 상세 조회 요청: postId = " + postId);
	    
	    // 조회수 증가
	    ps.increaseViewCount(postId);
	    System.out.println("조회수 증가 완료");

	    // 게시물 상세 정보 가져오기
	    Posts posts = (Posts) ps.detailPosts(postId, emp.getEmpno());
	    
	    // 게시물 정보 출력
	    if (posts != null) {
	        System.out.println("게시물 조회 성공: " + posts.toString()); // toString() 메서드가 오버라이드되어 있어야 유용한 정보가 출력됨
	    } else {
	        System.out.println("게시물 조회 실패: postId = " + postId);
	    }
	    
	    model.addAttribute("posts", posts);
	    return "jh/detailPosts";
	}



    @RequestMapping(value = "writeNotice")
    public String writeNotice(Model model) {
        System.out.println("start...");
        return "jh/writeNotice"; // 게시물 작성 페이지 반환
    }

    @RequestMapping(value = "writePost")
    public String writePost(@RequestParam(value = "fileName", required = false) MultipartFile fileName,
                            @RequestParam(value = "postsTitle") String postsTitle,
                            @RequestParam(value = "postsCnt") String postsCnt,
                            @RequestParam(value = "empno") int empno,
                            Model model) {
        Posts posts = new Posts();
        posts.setPostsTitle(postsTitle);
        posts.setPostsCnt(postsCnt);
        posts.setEmpno(empno);

        System.out.println("게시물 작성 요청: " + posts);
        System.out.println("업로드 파일: " + fileName);

        // 파일이 업로드되었는지 확인
        if (fileName != null && !fileName.isEmpty()) {
            try {
                File directory = new File(filePath);
                if (!directory.exists()) {
                    directory.mkdirs(); // 디렉토리가 없으면 생성
                }
                String originalFilename = fileName.getOriginalFilename();
                String fileSavePath = directory.getAbsolutePath() + File.separator + originalFilename;
                File fileToSave = new File(fileSavePath);
                fileName.transferTo(fileToSave); // 파일 저장

                // 파일 이름을 Posts 객체에 설정
                posts.setFileName(originalFilename);
            } catch (IOException e) {
                e.printStackTrace();
                model.addAttribute("message", "파일 저장에 실패했습니다.");
                return "jh/writePost"; // 에러 메시지를 포함해 작성 페이지로 돌아감
            }
        } else {
            System.out.println("첨부파일이 없습니다."); // 첨부파일이 없음을 로그에 기록
        }

        // 게시물 작성 로직
        try {
            ps.writePost(posts);
        } catch (Exception e) {
            model.addAttribute("message", "게시물 작성에 실패했습니다.");
            return "jh/writePost"; // 게시물 작성 실패 시 작성 페이지로 돌아감
        }

        return "redirect:/jh/postNotice"; // 게시물 목록 페이지로 리다이렉트
    }




	// 삭제
	@RequestMapping(value = "/deletePosts", method = RequestMethod.GET)
	public String deletePosts(@RequestParam("postsId") int postsId, Model model) {
		System.out.println("Controller start delete...");
		int result = ps.deletePosts(postsId);
		if (result > 0) {
			System.out.println("Post deleted successfully");
		}
		return "redirect:/jh/postNotice"; // 삭제 후 목록으로 이동
	}

	@GetMapping("updatePosts")
	public String updatePosts(@RequestParam("postId") int postId, Model model, HttpSession session) {
		Emp emp = (Emp) session.getAttribute("emp");
		System.out.println("Controller updatePosts postId-->" + postId);
		Posts posts = (Posts) ps.detailPosts(postId, emp.getEmpno());
		model.addAttribute("posts", posts);
		return "jh/updatePosts";
	}

	@PostMapping(value = "updatePosts1")
	public String updatePosts1(Posts posts, Model model,
			@RequestParam(value = "isPinned", required = false, defaultValue = "0") int isPinned) {
		posts.setIsPinned(isPinned);
		System.out.println("Controller ps.updatePosts1 posts-->" + posts);
		int updateCount = ps.updatePosts(posts);
		System.out.println("Controller ps.updatePosts updateCount-->" + updateCount);
		model.addAttribute("uptCnt", updateCount);
		model.addAttribute("kk3", "Message Test");

		return "redirect:/jh/postNotice";

	}

	///////////////////// 자주묻는질문게시글////////////////////////
	@GetMapping(value = "/postFaq")
	public String postFaq(Posts posts, Model model) {

		int totalPosts1 = ps.totalPosts1();

		if (posts.getCurrentPage() == null)
			posts.setCurrentPage("1");
		// Paging 작업
		Paging page = new Paging(totalPosts1, posts.getCurrentPage());

		posts.setStart(page.getStart());
		posts.setEnd(page.getEnd());

		System.out.println("jh postFaq play~");
		List<Posts> mypost1 = ps.listPosts1(posts);
		model.addAttribute("totalPosts1", totalPosts1);
		model.addAttribute("listPosts1", mypost1);
		model.addAttribute("page", page);
		return "jh/postFaq";
	}

	// 검색기능 검색된 게시글수 가져와서 페이징작업
	@RequestMapping(value = "listSearch4")
	public String listSearch4(Posts posts, Model model) {

		int totalSearchPosts1 = ps.totalSearchPosts1(posts);
		System.out.println("controller start listSearch3...");
		System.out.println("controller listSearch3 posts->" + posts);
		System.out.println("controller listSearch3 totalSearchPosts->" + totalSearchPosts1);
		// Paging 작업
		Paging page = new Paging(totalSearchPosts1, posts.getCurrentPage());

		posts.setStart(page.getStart());
		posts.setEnd(page.getEnd());

		List<Posts> listSearchPosts1 = ps.listSearchPosts1(posts);

		model.addAttribute("totalPosts1", totalSearchPosts1);
		model.addAttribute("listPosts1", listSearchPosts1);
		model.addAttribute("page", page);
		System.out.println("controller listSearch3 page->" + page);

		return "jh/postFaq";
	}

	 @RequestMapping(value = "writeFaq")
	    public String writeFaq(Model model) {
	        System.out.println("start...");
	        return "jh/writeFaq"; // 게시물 작성 페이지 반환
	    }

	    @RequestMapping(value = "writeFaqq")
	    public String postFaq(@RequestParam(value = "fileName", required = false) MultipartFile fileName,
	                            @RequestParam(value = "postsTitle") String postsTitle,
	                            @RequestParam(value = "postsCnt") String postsCnt,
	                            @RequestParam(value = "empno") int empno,
	                             Model model) {
	        Posts posts = new Posts();
	        posts.setPostsTitle(postsTitle);
	        posts.setPostsCnt(postsCnt);
	        posts.setEmpno(empno);

	        System.out.println("게시물 작성 요청: " + posts);
	        System.out.println("업로드 파일: " + fileName);

	        if (!fileName.isEmpty()) {
	            try {
	                File directory = new File(filePath);
	                if(!directory.exists()) {
	                    directory.mkdirs();
	                }
	                String originalFilename = fileName.getOriginalFilename();
	                String fileSavePath = directory.getAbsolutePath() + File.separator + originalFilename;
	                File fileToSave = new File(fileSavePath);
	                fileName.transferTo(fileToSave); // Save the file

	                // 파일 이름을 Posts 객체에 설정
	                posts.setFileName(originalFilename); // 파일 이름을 설정
	            } catch (IOException e) {
	                e.printStackTrace();
	                return "redirect:/jh/writeFaq";
	            }
	        }

	        // 게시물 작성 로직
	        ps.writeFaq(posts);
	        return "redirect:/jh/postFaq";
	        //} else {
	         //   model.addAttribute("message", "게시물 작성에 실패했습니다.");
	          //  return "jh/writeFaq";
	        //}
	    }
		

	@RequestMapping(value = "/deletePostsFaq", method = RequestMethod.GET)
	public String deletePostsFaq(@RequestParam("postsId") int postsId, Model model) {
		System.out.println("Controller start delete...");
		int result = ps.deletePosts(postsId);
		if (result > 0) {
			System.out.println("Post deleted successfully");
		}
		return "redirect:/jh/postFaq"; // 삭제 후 목록으로 이동
	}

	@GetMapping("detailPostsFaq/{postId}")
	public String detailPostsFaq(@PathVariable("postId") int postId, Model model, HttpSession session) {
		Emp emp = (Emp) session.getAttribute("emp");
		// 상세 게시물 조회
		ps.increaseViewCount(postId);
		Posts posts = (Posts) ps.detailPosts(postId, emp.getEmpno());
		model.addAttribute("posts", posts);
		
		return "jh/detailPostsFaq";
	}

	@GetMapping("updatePostsFaq")
	public String updatePostsFaq(@RequestParam("postId") int postId, Model model, HttpSession session) {
		Emp emp = (Emp) session.getAttribute("emp");
		System.out.println("Controller updatePosts postId-->" + postId);
		Posts posts = (Posts) ps.detailPosts(postId, emp.getEmpno());
		model.addAttribute("posts", posts);
		return "jh/updatePostsFaq";
	}

	@PostMapping(value = "updatePostsFaq")
	public String updatePostsFaq(Posts posts, Model model) {

		System.out.println("Controller ps.updatePosts1 posts-->" + posts);
		int updateCount = ps.updatePosts(posts);
		System.out.println("Controller ps.updatePosts updateCount-->" + updateCount);
		model.addAttribute("uptCnt", updateCount);
		model.addAttribute("kk3", "Message Test");

		return "redirect:/jh/postFaq";

	}

	///////////// 자유게시판//////////////////////////////////////////////
	@GetMapping(value = "/postFree")
	public String postFree(Posts posts, Model model) {

		int totalPosts2 = ps.totalPosts2();

		if (posts.getCurrentPage() == null)
			posts.setCurrentPage("1");
		// Paging 작업
		Paging page = new Paging(totalPosts2, posts.getCurrentPage());

		posts.setStart(page.getStart());
		posts.setEnd(page.getEnd());

		System.out.println("jh postFree play~");
		List<Posts> mypost2 = ps.listPosts2(posts);
		model.addAttribute("totalPosts2", totalPosts2);
		model.addAttribute("listPosts2", mypost2);
		model.addAttribute("page", page);
		return "jh/postFree";
	}

	@RequestMapping(value = "listSearch5")
	public String listSearch5(Posts posts, Model model) {

		int totalSearchPosts2 = ps.totalSearchPosts2(posts);
		System.out.println("controller start listSearch5...");
		System.out.println("controller listSearch5 posts->" + posts);
		System.out.println("controller listSearch5 totalSearchPosts->" + totalSearchPosts2);
		// Paging 작업
		Paging page = new Paging(totalSearchPosts2, posts.getCurrentPage());

		posts.setStart(page.getStart());
		posts.setEnd(page.getEnd());

		List<Posts> listSearchPosts2 = ps.listSearchPosts2(posts);

		model.addAttribute("totalPosts2", totalSearchPosts2);
		model.addAttribute("listPosts2", listSearchPosts2);
		model.addAttribute("page", page);
		System.out.println("controller listSearch3 page->" + page);

		return "jh/postFree";
	}

	@GetMapping("detailPostsfree/{postId}")
	public String detailPosts2(@PathVariable("postId") int postId, Model model, HttpSession session) {
		Emp emp = (Emp) session.getAttribute("emp");
		// 상세 게시물 조회
		ps.increaseViewCount(postId);
		Posts posts = (Posts) ps.detailPosts(postId, emp.getEmpno());
		model.addAttribute("posts", posts);
		model.addAttribute("emp", emp);
		return "jh/detailPostsfree";
	}
	@GetMapping("replydetailPosts/{postId}")
	public String replydetailPosts2(@PathVariable("postId") int postId, Model model, HttpSession session) {
		Emp emp = (Emp) session.getAttribute("emp");
		// 상세 게시물 조회
		ps.increaseViewCount(postId);
		Posts posts = (Posts) ps.detailPosts(postId, emp.getEmpno());
		model.addAttribute("posts", posts);
		model.addAttribute("emp", emp);
		return "jh/replydetailPosts";
	}

	@GetMapping("updatePostsFree")
	public String updatePostsFree(@RequestParam("postId") int postId, Model model, HttpSession session) {
		Emp emp = (Emp) session.getAttribute("emp");
		System.out.println("Controller updatePosts postId-->" + postId);
		Posts posts = (Posts) ps.detailPosts(postId, emp.getEmpno());
		model.addAttribute("posts", posts);
		return "jh/updatePostsFree";
	}

	@PostMapping(value = "updatePostsFree")
	public String updatePostsFree(Posts posts, Model model) {

		System.out.println("Controller ps.updatePosts1 posts-->" + posts);
		int updateCount = ps.updatePosts(posts);
		System.out.println("Controller ps.updatePosts updateCount-->" + updateCount);
		model.addAttribute("uptCnt", updateCount);
		model.addAttribute("kk3", "Message Test");

		return "redirect:/jh/postFree";

	}

	 @RequestMapping(value = "writeFree")
	    public String writeFree(Model model) {
	        System.out.println("start...");
	        return "jh/writeFree"; // 게시물 작성 페이지 반환
	    }

	    @RequestMapping(value = "writeFreee")
	    public String writeFree(@RequestParam(value = "fileName", required = false) MultipartFile fileName,
	                            @RequestParam(value = "postsTitle") String postsTitle,
	                            @RequestParam(value = "postsCnt") String postsCnt,
	                            @RequestParam(value = "empno") int empno,
	                             Model model) {
	        Posts posts = new Posts();
	        posts.setPostsTitle(postsTitle);
	        posts.setPostsCnt(postsCnt);
	        posts.setEmpno(empno);

	        System.out.println("게시물 작성 요청: " + posts);
	        System.out.println("업로드 파일: " + fileName);

	        if (!fileName.isEmpty()) {
	            try {
	                File directory = new File(filePath);
	                if(!directory.exists()) {
	                    directory.mkdirs();
	                }
	                String originalFilename = fileName.getOriginalFilename();
	                String fileSavePath = directory.getAbsolutePath() + File.separator + originalFilename;
	                File fileToSave = new File(fileSavePath);
	                fileName.transferTo(fileToSave); // Save the file

	                // 파일 이름을 Posts 객체에 설정
	                posts.setFileName(originalFilename); // 파일 이름을 설정
	            } catch (IOException e) {
	                e.printStackTrace();
	                return "redirect:/jh/writeFree";
	            }
	        }

	        // 게시물 작성 로직
	        ps.writeFree(posts);
	        return "redirect:/jh/postFree";
	        //} else {
	         //   model.addAttribute("message", "게시물 작성에 실패했습니다.");
	          //  return "jh/writeFree";
	        //}
	    }

	@RequestMapping(value = "/deletePostsFree", method = RequestMethod.GET)
	public String deletePostsFree(@RequestParam("postsId") int postsId, Model model) {
		System.out.println("Controller start delete...");
		int result = ps.deletePosts(postsId);
		if (result > 0) {
			System.out.println("Post deleted successfully");
		}
		return "redirect:/jh/postFree"; // 삭제 후 목록으로 이동
	}

	@GetMapping("replyfree")
	public String replyfree(Model model, @RequestParam("postId") int postId) {

		model.addAttribute("postId", postId);
		return "jh/replyfree"; // 게시물 작성 페이지 반환 }

	}

	@GetMapping("/replyfree1")
	public String replyfree1(HttpServletRequest request, Model model) {
		// 부모 글의 정보를 가져오기
		Posts post = new Posts();
		System.out.println("aaaaaaaaaaa" + request.getParameter("content"));
		Posts parent = ps.parentreply(Integer.parseInt(request.getParameter("postId")));
		System.out.println("안녕");
		System.out.println(post);
		System.out.println(request.getParameter("content"));
		// 부모 글의 group, seq, level 설정
		post.setRef(parent.getRef()); // 부모의 ref 값을 답글의 ref에 저장
		post.setReStep(parent.getReStep() + 1); // 부모의 reStep에 +1을 해서 답글의 reStep에 저장
		post.setReLevel(parent.getReLevel() + 1); // 부모의 reLevel에 +1을 해서 답글의 reLevel에 저장
		post.setPostsCnt(request.getParameter("content"));
		post.setPostsTitle(request.getParameter("title"));
		post.setEmpno(Integer.parseInt(request.getParameter("empno")));
		System.out.println(post);

		// 답글 위치를 위한 seq 업데이트 (기존 답글들의 seq를 1씩 증가)
		ps.replySeqUpdate(parent);

		// 답글 저장
		ps.replyfree1(post);

		// 게시물 리스트 페이지로 리다이렉트
		return "redirect:/jh/postFree";
	}
	//다운로드
    @GetMapping("/uploadFile/jh/{fileName:.+}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {
        String filePath = "C:/spring/springSrc17/samil/src/main/webapp/upload";
        
        Path path = Paths.get(filePath + fileName);
        
        try {
            Resource resource = new UrlResource(path.toUri());
            if (resource.exists() && resource.isReadable()) {
            	MediaType mediaType = MediaType.APPLICATION_OCTET_STREAM; // 기본 MIME 타입
                return ResponseEntity.ok()
                	.contentType(mediaType)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);
            }
        } catch (MalformedURLException e) {
            e.printStackTrace(); // 로그 출력
        }
        
        return ResponseEntity.notFound().build(); // 파일이 없거나 읽을 수 없으면 404 반환
    }
}
	


