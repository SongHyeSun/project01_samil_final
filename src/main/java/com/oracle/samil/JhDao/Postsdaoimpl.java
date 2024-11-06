package com.oracle.samil.JhDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Amodel.Posts;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class Postsdaoimpl implements Postsdao {
	private final SqlSession session;

	@Override
	public int totalPosts() {
		int totPostsCount = 0;
	    try {            
	    	totPostsCount = session.selectOne("totalPosts");
            System.out.println("DaoImpl totalPosts totPostsCount -> " +totPostsCount );
        } catch (Exception e) {
            System.out.println("DaoImpl totalPosts e.getMessage() -> " + e.getMessage());
        }
        return totPostsCount;
    }
	
	@Override
	public List<Posts> listPosts(Posts posts) {
		List<Posts> postsList = null;
		System.out.println("dao");
		try {
			postsList = session.selectList("listPosts", posts);
		} catch (Exception e) {
			
			System.out.println("dao");
		}
		return postsList;
	}

	@Override
	public List<Posts> postsSearchLists3(Posts posts) {
		List<Posts> postsSearchLists3 = null;
		try {
			postsSearchLists3 = session.selectList("searchlist", posts);
		} catch (Exception e) {
			
			System.out.println("postsSearchLists3 daodao");
		}
		return postsSearchLists3;
	}


	@Override
	public int totalSearchPosts(Posts posts) {
		int totSearchPosts = 0;
		try {
			System.out.println("DaoImpl KKK  totalSearchPosts posts->"+posts);

			totSearchPosts = session.selectOne("totalSearchPosts3",posts);

			System.out.println("DaoImpl totalSearchPosts totSearchPosts->"+totSearchPosts);
			
		} catch (Exception e) {
			System.out.println("DaoImpl totSearchPosts kkk e.getMessage() -> " + e.getMessage());
		}
		return totSearchPosts;
	}

	@Override
	public Posts detailPosts(int postId, int empno) {
		Posts detailPosts = null;
		Map<String, Object> params = new HashMap<>();
		params.put("postId", postId);
		params.put("empno", empno);
		detailPosts = session.selectOne("detailPosts",params);
		return detailPosts;
	}
	
	@Override
	public void increaseViewCount(int postId) {
		session.update("increaseViewCount", postId);
		
	}
	
	
	
	
	//자주묻는///////////1111111111111/////////////////////////////////////////////

	@Override
	public int totalPosts1() {
		int totPostsCount1= 0;
	    try {            
	    	totPostsCount1 = session.selectOne("totalPosts1");
            System.out.println("DaoImpl totalPosts1 totPostsCount1 -> " +totPostsCount1 );
        } catch (Exception e) {
            System.out.println("DaoImpl totalPosts1 e.getMessage() -> " + e.getMessage());
        }
        return totPostsCount1;
    }

	@Override
	public List<Posts> listPosts1(Posts posts) {
		List<Posts> postsList1 = null;
		System.out.println("dao");
		try {
			postsList1 = session.selectList("listPosts1", posts);
		} catch (Exception e) {
			
			System.out.println("dao");
		}
		return postsList1;
	}

	@Override
	public int totalSearchPosts1(Posts posts) {
		int totSearchPosts1 = 0;
		try {
			System.out.println("DaoImpl KKK  totalSearchPosts posts->"+posts);

			totSearchPosts1 = session.selectOne("faqsearchtotal",posts);

			System.out.println("DaoImpl totalSearchPosts31 totSearchPosts->"+totSearchPosts1);
			
		} catch (Exception e) {
			System.out.println("DaoImpl totSearchPosts kkk e.getMessage() -> " + e.getMessage());
		}
		return totSearchPosts1;
	}

	@Override
	public List<Posts> postsSearchLists31(Posts posts) {
		List<Posts> postsSearchLists31 = null;
		try {
			postsSearchLists31 = session.selectList("faqsearch",posts);
		} catch (Exception e) {
			System.out.println("postsSearchLists3"+postsSearchLists31.size());
			System.out.println("postsSearchLists3 daodao");
		}
		return postsSearchLists31;
	}
	//////////자유////////

	@Override
	public int totalPosts2() {
		int totPostsCount2 = 0;
	    try {            
	    	totPostsCount2 = session.selectOne("freetotalPosts");
            System.out.println("DaoImpl totalPosts totPostsCount -> " +totPostsCount2 );
        } catch (Exception e) {
            System.out.println("DaoImpl totalPosts e.getMessage() -> " + e.getMessage());
        }
        return totPostsCount2;
    }

	@Override
	public List<Posts> listPosts2(Posts posts) {

		List<Posts> postsList2 = null;
		System.out.println("dao");
		try {
			postsList2 = session.selectList("freelistPosts", posts);
		} catch (Exception e) {
			
			System.out.println("dao");
		}
		return postsList2;
	}

	@Override
	public int totalSearchPosts2(Posts posts) {
		int totalSearchPosts2 = 0;
		try {
			System.out.println("DaoImpl KKK  totalSearchPosts posts->"+posts);

			totalSearchPosts2 = session.selectOne("freesearchtotal",posts);

			System.out.println("DaoImpl totalSearchPosts31 totSearchPosts->"+totalSearchPosts2);
			
		} catch (Exception e) {
			System.out.println("DaoImpl totSearchPosts kkk e.getMessage() -> " + e.getMessage());
		}
		return totalSearchPosts2;
	}

	@Override
	public List<Posts> postsSearchLists32(Posts posts) {
		List<Posts> postsSearchLists32 = null;
		try {
			postsSearchLists32 = session.selectList("freesearch",posts);
		} catch (Exception e) {
			System.out.println("postsSearchLists3"+postsSearchLists32.size());
			System.out.println("postsSearchLists3 daodao");
		}
		return postsSearchLists32;
	}

	@Override
	public int writePost(Posts posts) {
		int insertResult = 0;
		System.out.println("writePost insert start...");
		try {
			insertResult = session.insert("writePost",posts);
		} catch (Exception e) {
			System.out.println("writePost writePost exception->"+e.getMessage());
		}
		return insertResult;
	}

	@Override
	public int deletePosts(int postId) {
		System.out.println("postsDao DELETEstart");
		int result = 0;
		try {
			result = session.delete("iiii",postId);
			System.out.println("postsdao delete result ->"+result);
		} catch (Exception e) {
			System.out.println("postsdao delete exception->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int updatePosts(Posts posts) {
		int updateCount = 0;
		System.out.println("updatePostsupdatePosts"+posts);
		try {
			updateCount = session.update("postsupdate", posts);
		} catch (Exception e) {
			System.out.println("DaoImp updatePosts Exception ->"+e.getMessage());
		}
		return updateCount;
	}

	@Override
	public int writeFree(Posts posts) {
		int insertResult = 0;
		System.out.println("writePost insert start...");
		try {
			insertResult = session.insert("writeFree",posts);
		} catch (Exception e) {
			System.out.println("writePost writePost exception->"+e.getMessage());
		}
		return insertResult;
	}

	@Override
	public int writeFaq(Posts posts) {
		int insertResult = 0;
		System.out.println("writePost insert start...");
		try {
			insertResult = session.insert("writeFaq",posts);
		} catch (Exception e) {
			System.out.println("writePost writePost exception->"+e.getMessage());
		}
		return insertResult;
	}

	@Override
	public void replySeqUpdate(Posts parent) {
		session.update("replySeqUpdate", parent);
		
	}

	@Override
	public void replyfree1(Posts vo) {
		session.insert("replyfree1",vo);
		
	}

	@Override
	public List<Posts> listPosts4(Posts posts) {
		List<Posts> postsList4 = null;
		postsList4 = session.selectList("listPosts4",posts);
		return postsList4;
	}

	@Override
	public Posts parentreply(int postId) {
		Posts parentreply = null;
		parentreply = session.selectOne("parentreply",postId);
		return parentreply;
	}

	@Override
	public List<Posts> listPostss(Posts posts) {
		List<Posts> postssList = null;
		System.out.println("dao");
		try {
			postssList = session.selectList("listPostss", posts);
		} catch (Exception e) {
			
			System.out.println("dao");
		}
		return postssList;
	}









}

