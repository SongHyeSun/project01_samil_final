package com.oracle.samil.HbDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Amodel.Card;
import com.oracle.samil.Amodel.CardUse;
import com.oracle.samil.Amodel.Cost;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Repository
public class CardDaoImpl implements CardDao {
	@Autowired
	private final SqlSession session;
	
	@Override
	public List<Card> cardList(Card card) {
		List<Card> cardList = null;
		try {
			cardList = session.selectList("hbgetCardList",card);
			System.out.println("CardDaoImpl cardList start..." + cardList.size());
		} catch (Exception e) {
			System.out.println("CardDaoImpl cardList e.getMessage => " + e.getMessage());
		}
		return cardList;
	}

	@Override
	public List<CardUse> cardUseList(CardUse cardUse) {
		List<CardUse> cardUseList = null;
		try {
			cardUseList = session.selectList("hbgetCardUseList",cardUse);
			System.out.println("CardDaoImpl CardUseList start..." + cardUseList.size());
		} catch (Exception e) {
			System.out.println("CardDaoImpl cardUseList e.getMessage => " + e.getMessage());
		}
		return cardUseList;
	}

	@Override
	public int addCard(Card newCard) {
	    int cardResult = 0;
	    try {
	    	cardResult = session.insert("hbcardAdd", newCard); // 새로운 카드 객체를 쿼리에 전달
	        System.out.println("Card added successfully.");
	    } catch (Exception e) {
	        System.out.println("Error adding card: " + e.getMessage());
	    }
	    return cardResult; // 성공적으로 추가된 행의 수를 반환
	}

	@Override
	public List<Card> cardNumList (Card card) {
		List<Card> cardList = null;
		try {
			cardList = session.selectList("hbcardList", card); // 새로운 카드 객체를 쿼리에 전달
		        System.out.println("Card added successfully.");
		    } catch (Exception e) {
		        System.out.println("Error adding card: " + e.getMessage());
		    }
		    return cardList; // 성공적으로 추가된 행의 수를 반환
		}


	@Override
	public Card getCardDetails(String cardNum) {
	    Card cardDetails = session.selectOne("hbgetCardDetails", cardNum); // MyBatis 쿼리 호출
	    if (cardDetails == null) {
	        System.out.println("카드 세부정보가 없습니다: " + cardNum);
	    }
	    return cardDetails;
	}


	@Override
	public List<Card> getCardList() {
		List<Card> cardList = null;
		try {
			cardList = session.selectList("hbgetCardList");
		} catch (Exception e) {
			System.out.println("CardDaoImpl setLostCard e.getMessage => " + e.getMessage());
		}
		
		return cardList;
	}
	
	@Override
	public int getMaxUseNum() {
		int getMaxUseNum;
		try {
			getMaxUseNum = session.selectOne("hbgetMaxUseNum");
			System.out.println("CardDaoImpl maxusenum " + getMaxUseNum);
			return getMaxUseNum;
		} catch (Exception e) {
			System.out.println("CostDaoImpl insertCost error " +e.getMessage());
			return 0;
		}
	}

	@Override
	public int cardUseAdd(CardUse cardUse) {
		try {
			return session.insert("hbcardUseAdd",cardUse);
		} catch (Exception e) {
			System.out.println("CardDao CardUseAdd e.getMessage => " + e.getMessage());
			return 0;
		} 
	}

	@Override
	public List<CardUse> searchCardUse(CardUse cardUse) {
		List <CardUse> searchCardUse = null;
		try {
			searchCardUse = session.selectList("hbsearchCard", cardUse);
			System.out.println("searchCost ==> " + (searchCardUse != null ? searchCardUse.size() : 0));
		} catch (Exception e) {
			System.out.println("CostDaoImpl searchCost error : " +e.getMessage());
		}
		return searchCardUse;
	}

	@Override
	public Card updateCardPermit(Card card) {
		int updateCardPermit;
		try {
			updateCardPermit = session.update("hbupdateCardPermit",card);
			System.out.println("CARD" + card);
		} catch (Exception e) {
			System.out.println("CostDaoImpl updateCardPermit error : " +e.getMessage());
		}
		return card;
	}

	@Override
	public Card updateCardDelGubun(Card card) {
	    int updateCardDelGubun;
	    try {
	        updateCardDelGubun = session.update("hbupdateCardDelGubun", card);
	        System.out.println("done");
	        if (updateCardDelGubun == 0) {
	            System.out.println("No rows updated");
	        }
	    } catch (Exception e) {
	        System.out.println("CostDaoImpl updateCardDelGubun error : " + e.getMessage());
	    }
	    return card;
	}

	@Override
	public List<Card> getAdminCardList(Card card) {
		List<Card> getAdminCardList = null;
		try {
			getAdminCardList = session.selectList("hbgetCardListAll");
		} catch (Exception e) {
			System.out.println("CostDaoImpl getAdminCardList error : " + e.getMessage());
		}
		return getAdminCardList;
	}

	@Override
	public int getCardUseNum() {
		return session.selectOne("hbgetAllCardUse");
	}



	
	}

