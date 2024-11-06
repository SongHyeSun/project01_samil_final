package com.oracle.samil.Acontroller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.samil.Amodel.Card;
import com.oracle.samil.Amodel.CardUse;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.HbService.CardService;
import com.oracle.samil.TrService.EmpService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping(value = "/hb")
public class HbCardController {

	private final CardService hbCardService;
	private final EmpService trEmpService; //Emp 연결
	
	
	// 유저
	// 유저 카드 메인 페이지 : 카드 사용 내역 불러오기
	@GetMapping(value = "/costCard")
	public String cost_card(Model model, CardUse cardUse) {
		List<CardUse> cardUseList = hbCardService.getCardUseList(cardUse);
		model.addAttribute("cardUseList", cardUseList);
		Map<Integer, String> cardMap = new HashMap<>();
		cardMap.put(0, "사용중");
		cardMap.put(110, "분실 신청");
		System.out.println("cost_cardStart....");
		return "hb/costCard";
	}
	// 유저 카드 사용 내 검색 	
	@GetMapping(value = "/cardUseSearch")
	public String searchCardUse(Model model,
	                             @RequestParam("keyword") String keyword, 
	                             @RequestParam("search") String search,
	                             HttpSession session) {
	    System.out.println("카드 사용 내역 검색 시작...");
	    CardUse cardUse = new CardUse();
	    cardUse.setSearch(search);
	    cardUse.setKeyword(keyword);
	    
	    List<CardUse> searchResults = hbCardService.SearchcardUse(cardUse);
	    model.addAttribute("cardUseList", searchResults);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("selectedSearch", search);
	    
	    return "hb/costCard"; // 검색 결과를 보여줄 JSP 페이지
	}

	// 유저 카드 분실 신고 신청 전 : 카드 번호와 부서명 불러오기
	@GetMapping(value = "/costCardLost")
	public String costCardLost(Model model) {
	    System.out.println("HbCardController costCardLost get start ... ");
	    List<Card> cardSearchList = hbCardService.getCardList(); // 카드 목록을 가져옴
	    model.addAttribute("cardSearchList", cardSearchList); 

	    // 카드 번호로 소지자와 부서 정보를 가져오기
	    for (Card card : cardSearchList) {
	        Card cardDetails = hbCardService.getCardDetails(card.getCardNum()); // card.getCardNum() 사용
	        if (cardDetails != null) {
	            model.addAttribute("name", cardDetails.getName()); // 모델에 emp 객체 추가
	            model.addAttribute("deptno", cardDetails.getDeptno()); // 모델에 emp 객체 추가
	        } else {
	            System.out.println("카드 세부정보를 찾을 수 없습니다: " + card.getCardNum());
	        }
	    }

	    return "hb/costCardLost";
	}


	// 유저 카드 분실 신고 신청 후 
	@PostMapping(value = "/costCardLost")
	public String costcardprocess(Model model, Card card, @RequestParam("lostDate") String lostDate) {
		try {
			// date로 입력받은 값을 string으로 변환해서 데이터에 저장
			SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy/MM/dd");
			Date date = originalFormat.parse(lostDate);
			String formattedDate = targetFormat.format(date);
			card.setCardLostDate(formattedDate);

			card.setCardPermit(110); // 분실 신고 시 카드의 permit을 110으로 설정
			System.out.println("hbController costCardLost POST start " + lostDate);
			hbCardService.updateCardPermit(card);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/hb/costCard";
		}

	// 관리자 부분
	// 관리자 신청한 카드 목록 보기 
	@GetMapping(value = "/adminCostCard")
	public String list_card(Model model, Card card) {
		List<Card> cardList = hbCardService.getAdminCardList(card);
		Map<Integer, String> cardMap = new HashMap<>();
		model.addAttribute("cardList", cardList);

		cardMap.put(0, "사용");
		cardMap.put(110, "신청 중");
		model.addAttribute("cardMap", cardMap);

		System.out.println("list_card get start....");
		return "hb/adminCostCard";
	}
	// 관리자 카드 신청 : emp에서 사원과 사번 가지고 오기 
	@GetMapping(value = "/adminCostCardAdd")
	public String adminCostCardAdd(Model model) {
		System.out.println("HbCardController adminCostCardAdd start...");
		List<Emp> empList = trEmpService.empSelect();
		 model.addAttribute("empList", empList);
		return "hb/adminCostCardAdd";
	}
	// 카드 신청 후 데이터에 저장
	@PostMapping(value = "/adminCostCardAdd")
	public String admimCostCardAdd(Card card, Model model) {
		System.out.println("HbCardController After costCardAdd");
		card.setEmpno(card.getEmpno());
		System.out.println("card./..... 정보 " + card);
		card.setCardDelGubun(100);
		hbCardService.addCard(card);
		model.addAttribute("card", card);
		return "redirect:/hb/adminCostCard";
	}
	
	// 카드 사용 내역 넣기: 카드 목록 불러오기 메소드
	@GetMapping(value = "/adminCostCardPlus")
	public String admin_cost_card_plus(Model model) {
		 System.out.println("HbCardController adminCardPlus start...");
	        List<Card> cardList = hbCardService.getCardList();
	        model.addAttribute("cardList", cardList);
	        return "hb/adminCostCardPlus";
	}
	// 선택된 카드 목록에 따라서 사원들 정보를 가지고 오기
	@GetMapping(value = "/getCardDetails")
	public @ResponseBody Card getCardDetails(Model model,
											@RequestParam("cardNum") String cardNum) {
		List<Card> cardList = hbCardService.getCardList();
		model.addAttribute("cardList", cardList);
		return hbCardService.getCardDetails(cardNum);
	}
	// 입력한 데이터를 카드 사용 목록에 넣기
	 @PostMapping(value = "/adminCostCardPlus") 
	 public String adminCostCardPlus(@ModelAttribute CardUse cardUse) {
		System.out.println("HbCardController admin_Card_plus start... " + cardUse);
		 int result = hbCardService.addCardUse(cardUse); 
		 if (result>0) {
			 return "redirect:/hb/adminCostCard"; 
		 } else {
			 return "redirect:/errorPage";
		 }
	 }
	 // 관리자 분실 카드 처리 
	 @PostMapping(value = "/updateCardDelGubun")
	 public ResponseEntity<String> updateCardDelGubun(@RequestParam("cardNum") String cardNum, Model model) {
	     Card card = new Card();
	     
	     // 카드 번호와 현재 날짜를 설정
	     card.setCardNum(cardNum);
	     String cardDelDate = new SimpleDateFormat("yyyy/MM/dd").format(new Date());
	     card.setCardDelDate(cardDelDate);
	     
	     Map<Integer, String> cardDelMap = new HashMap<>();
	     cardDelMap.put(110, "분실 처리 완료");
	     hbCardService.updateCardDelGubun(card);
	     
	     return ResponseEntity.ok("분실 신고가 완료되었습니다.");
	 }




	
}
