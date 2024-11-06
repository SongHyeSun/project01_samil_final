package com.oracle.samil.Amodel;






import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class Posts extends Emp{
	private int 		postId;			//게시글아이디
	private int 		empno;			//사원번호
	private int 		boardId;		//게시판유형
	private String 		postsTitle;		//제목
	private String 		postsCnt;		//내용
	private String 		creationDate;	//작성일
	private int 		isPinned;		//상단고정
	private int 		postsViews;		//조회수
	private String 		fileName;		//파일명
	private int 		ref;			//답변글끼리그룹
	private int 		reStep;			//REF내의순서
	private int 		reLevel;		//들여쓰기
	private String 		name;
	
	private String search;
	private String keyword;
	private String pageNum;
	private int start;
	private int end;
	//page 정보
	private String currentPage;

}
