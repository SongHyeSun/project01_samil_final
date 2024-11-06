package com.oracle.samil.JhDao;

import java.util.List;

import com.oracle.samil.Amodel.Posts;

public interface Postsdao {

	List<Posts> listPosts(Posts posts);

	List<Posts> postsSearchLists3(Posts posts);

	List<Posts> listPosts1(Posts posts);

	int totalPosts();

	int totalSearchPosts(Posts posts);

	Posts detailPosts(int postId, int empno);

	int totalPosts1();

	int totalSearchPosts1(Posts posts);

	List<Posts> postsSearchLists31(Posts posts);

	int totalPosts2();

	List<Posts> listPosts2(Posts posts);

	int totalSearchPosts2(Posts posts);

	List<Posts> postsSearchLists32(Posts posts);

	void increaseViewCount(int postId);

	int writePost(Posts posts);

	int deletePosts(int postId);

	int updatePosts(Posts posts);

	int writeFree(Posts posts);

	int writeFaq(Posts posts);

	void replySeqUpdate(Posts parent);

	void replyfree1(Posts vo);

	List<Posts> listPosts4(Posts posts);

	Posts parentreply(int postId);

	List<Posts> listPostss(Posts posts);





	


	



	



}
