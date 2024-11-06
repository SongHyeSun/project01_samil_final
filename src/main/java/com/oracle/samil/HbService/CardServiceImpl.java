package com.oracle.samil.HbService;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.samil.Amodel.Card;
import com.oracle.samil.Amodel.CardUse;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.HbDao.CardDao;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CardServiceImpl implements CardService {
	
	@Autowired
	private final CardDao hbCardDao;

	@Override
	public List<Card> getCardList(Card card) {
		System.out.println("HbCardService getCardList start...");
		List<Card> cardList = null;
		cardList = hbCardDao.cardList(card);
		System.out.println("HbCardService getCardList card size -> " + cardList.size());
		return cardList;
	}

	@Override
	public List<CardUse> getCardUseList(CardUse cardUse) {
		System.out.println("HbCardService getCardUseList start...");
		List<CardUse> cardUseList = null;
		cardUseList = hbCardDao.cardUseList(cardUse);
		System.out.println("HbCardService getCardUseList size => " + cardUseList.size());
		return cardUseList;
	}

	@Override
	public int addCard(Card card) {
		int cardResult = 0;
		System.out.println("HbCardService addcard start...");
		cardResult = hbCardDao.addCard(card);
		System.out.println("HbCardService .." +card.getCardBank());
		return cardResult;
	}

	@Override
	public List<Card> cardNumList(Card card) {
		System.out.println("HbCardService addCardUse start..");
		List<Card> cardNumList = hbCardDao.cardNumList(card);
		System.out.println("HbCardService addCardUSE .. " +card.getCardNum());
		return cardNumList;
	}
	
	@Override
	public List<Card> getCardList() {
		return hbCardDao.getCardList();
	}
	
	@Override
	public Card getCardDetails(String cardNum) {
	    return hbCardDao.getCardDetails(cardNum); // DAO 호출
	}

	
	
	@Override
	public int addCardUse(CardUse cardUse) {
		    int getMaxUseNum = hbCardDao.getMaxUseNum();
		    
		    if (getMaxUseNum == 0) {
		    	getMaxUseNum = 1; // 초기값 설정
		    } else {
		    	getMaxUseNum += 1; 
		    }
		    cardUse.setUseNum(getMaxUseNum); // 새로운 codeNum 설정
		    System.out.println("getMaxUseNum : "  +getMaxUseNum);
		    String useDateInput = cardUse.getUseDate(); // 여기서 useDate를 가져옵니다.
		    LocalDate useDate = LocalDate.parse(useDateInput); // yyyy-MM-dd 형식으로 파싱
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd"); // 원하는 형식
		    String formattedUseDate = useDate.format(formatter); // 형식 변환
		    cardUse.setUseDate(formattedUseDate); // 변환된 날짜를 설정
		    return hbCardDao.cardUseAdd(cardUse); // DAO 호출
		}
	
	@Override
	public List<CardUse> SearchcardUse(CardUse cardUse) {
	    System.out.println("카드 사용 내역 검색 서비스 시작...");
	    List<CardUse> cardUseSearch = hbCardDao.searchCardUse(cardUse);
	    if (cardUseSearch != null) {
	        System.out.println("검색 결과 수: " + cardUseSearch.size());
	    } else {
	        System.out.println("검색 결과가 없습니다.");
	    }
	    return cardUseSearch;
	}

	@Override
	public Card updateCardPermit(Card card) {
		System.out.println("CardService updateCardPermit Start...");
		System.out.println("Card..." + card);
		return hbCardDao.updateCardPermit(card);
	}

	@Override
	public Card updateCardDelGubun(Card card) {
	    System.out.println("CardService updateCardDelGubun Start...");
	    return hbCardDao.updateCardDelGubun(card);
	}

	@Override
	public List<Card> getAdminCardList(Card card) {
		return hbCardDao.getAdminCardList(card);
	}

	@Override
	public int getCardUseNum() {
		System.out.println("HbCostService getAllCost Start .. ");
		int cardUseNum = hbCardDao.getCardUseNum();
	    System.out.println("Total Cost: " + cardUseNum); // 추가된 로그
		return cardUseNum;// TODO Auto-generated method stub
	}

	
}
