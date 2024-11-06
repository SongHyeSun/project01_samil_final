package com.oracle.samil.HbService;

import java.util.List;

import com.oracle.samil.Amodel.Card;
import com.oracle.samil.Amodel.CardUse;


public interface CardService {
	
	// 카드 리스트 출력 
	//유저
	List<Card> 	  getCardList();  			   // 카드 리스트 불러오기
	List<Card>    getCardList(Card card); 	   // 카드에 저장된 정보 불러오기
	//관리자
	List<Card>    getAdminCardList(Card card); // 관리자 카드 목록 보기
	int  	   	  addCard(Card card);		   // 관리자 새로운 카드 추가
	// 카드 분실 처리
	Card          getCardDetails(String cardNum); // 유저 분실 신고 전 리스트 가져오기
	Card 		  updateCardPermit(Card card);	// 유저 분실 신고
	Card 		  updateCardDelGubun(Card card);// 관리자 분실 처리
	
	List<Card>	  cardNumList(Card card);
	
	//검색 구현 
	List<CardUse> getCardUseList(CardUse cardUse); // 사용 목록 
	List<CardUse> SearchcardUse(CardUse cardUse); // 유저 검색
	int           addCardUse(CardUse cardUse); 	// 관리자 카드 사용 목록 신청
	
	// main 페이지 구현
	int           getCardUseNum();

}
