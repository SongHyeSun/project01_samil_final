package com.oracle.samil.Acontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.oracle.samil.Adto.CostCodeCost;
import com.oracle.samil.Amodel.Cost;
import com.oracle.samil.Amodel.CostCode;
import com.oracle.samil.HbService.CostService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping(value="/hb")
public class HbCostController {
		
		
		private final CostService hbCostService;
		
		//페이지에 들어갈 때 리스트를 보여주는 메소드
		@GetMapping(value = "/costCost")
		public String cost_cost(Model model, CostCodeCost codeCost) {
			System.out.println("costCost start...");
		    List<CostCodeCost> costList = hbCostService.getCostList(codeCost);
		    model.addAttribute("costList", costList);
		    
		    // 기타 데이터 추가
		    Map<Integer, String> costMap = new HashMap<>();
		    costMap.put(100, "대기");
		    costMap.put(110, "승인");
		    costMap.put(120, "거부");
		    model.addAttribute("costMap", costMap);
		    
		    return "/hb/costCost";
		}
		
		// 정산 신청 메소드 : 정산 코드 불러오기
		@RequestMapping(value = "costPlus")
		public String cost_plus(Model model) {
			System.out.println("HbcostController submitCost start.. ");
			List<CostCode> costCode = hbCostService.getCodeList();
			model.addAttribute("costCode",costCode);
			
			System.out.println("HbCostController SubmitCost start.. ");

			return "hb/costPlus"; // 신청 완료 후 목록 페이지로 돌아가기
		}
		
		// 정산 신청 메소드 : 신청 내용을 데이터에 넣는 메소드
		@RequestMapping(value ="submitCost", method = RequestMethod.POST)
		public String cost_submit(Model model, CostCodeCost codeCost){
			System.out.println("HBcontroller submitCost start ... ");
			codeCost = hbCostService.addNewCost(codeCost);
			model.addAttribute("codeCost" , codeCost);
			return "redirect:/hb/costCost";
		}
		
		// 정산 목록 찾기 메소드
		@GetMapping(value = "/costSearch")
		public String costSearch(Model model, 
		                          @RequestParam("keyword") String keyword, 
		                          @RequestParam("search") String search,
		                          @RequestParam(value = "costStatus", required = false) int costStatus,
		                          HttpSession session) {
		    System.out.println("Hbcontroller cost_search Start...");

		    // costStatus가 int로 되어있기 때문에 string으로 변환
		    if ("대기".equals(costStatus)) {
		        keyword = "100";
		    } else if ("승인".equals(costStatus)) {
		        keyword = "110";
		    } else if ("거부".equals(costStatus)) {
		        keyword = "120";
		    }

		    CostCodeCost costCodeCost = new CostCodeCost();
		    // 검색어와 키워드 설정 
		    costCodeCost.setSearch(search);
		    costCodeCost.setKeyword(keyword);
		    // costStatus는 따로 빼서 combobox로 두기
		    costCodeCost.setCostStatus(costStatus);
		    List<CostCodeCost> searchCost = hbCostService.searchCost(costCodeCost);
		    
		    
		    Map<Integer, String> costMap = new HashMap<>();
		    costMap.put(100, "대기");
		    costMap.put(110, "승인");
		    costMap.put(120, "거부");

		    model.addAttribute("costList", searchCost);
		    model.addAttribute("costMap", costMap);
		    model.addAttribute("keyword", keyword);
		    model.addAttribute("selectedSearch", search);
		    model.addAttribute("selectedStatus", costStatus); // Add selected status to model

		    if (keyword != null) {
		        session.setAttribute("searchKeyword", keyword);
		    }

		    return "hb/costCost";
		}
		
		//어드민 페이지 메소드
		// 어드민 페이지 들어가면 나오는 코드 목록
		@RequestMapping(value = "adminCostCost")
		public String admin_cost_cost (Model model, CostCode costCode){
			List<CostCode> getAdminCodeList = hbCostService.getAdminCodeList();
			model.addAttribute("getAdminCodeList", getAdminCodeList);
			System.out.println("HbCostController Admin_cost_cost....");
			return "hb/adminCostCost";
		}
		
		//코드 추가 
		@GetMapping(value = "/adminCostPlus")
		public String admin_cost_plus(Model model) {
		    model.addAttribute("costCode", new CostCode()); // 빈 CostCode 객체를 추가
		    return "hb/adminCostPlus";
		}
		@PostMapping(value = "/adminCostPlusEnd")
		public String admin_cost_plus_end(Model model,  CostCode costCode) {
			System.out.println("HbCostController costCodePlus start.. ");
			hbCostService.costCodePlus(costCode);
			return "redirect:/hb/adminCostCost";
		}

		// 코드 비활성화
		@RequestMapping(value = "adminCostUnactivate")
		public String admincostdelete(@RequestParam("code") int costNum) {
			int costUnactivate =  hbCostService.costCodeUnactivate(costNum);
			System.out.println("HbCostController costDel start.. ");
			return "redirect:/hb/adminCostCost";
		}
		
		//코드 활성화
		@RequestMapping(value = "adminCostActivate")
		public String adminCostActivate(@RequestParam("code") int costNum) {
		    int costActivate = hbCostService.costCodeActivate(costNum);
		    System.out.println("HbCostController costActivate start.. ");
		    return "redirect:/hb/adminCostCost";
		}
		
		//관리자 페이지에서 정산 중 대기만 불러오기 체크
		@GetMapping(value ="adminCostCheck")
		public String admin_cost_check(Model model, CostCodeCost costCodeCost) {
			System.out.println("HBCostController  admin_cost_check start ... ");
			List<CostCodeCost> adminCostList = hbCostService.getAdminCost(costCodeCost);
			model.addAttribute("adminCostList",adminCostList);
			System.out.println("HbCostController admin_cost_check adminCostList size = >" + adminCostList.size());
			
			Map<Integer, String> adminCostMap = new HashMap<>();
			adminCostMap.put(100, "대기");
			adminCostMap.put(110, "거절");			
			adminCostMap.put(120, "수락");			
			model.addAttribute("costMap", adminCostMap);

			return "hb/adminCostCheck";
		}
		
		//관리자 정산 내 검색 
		@GetMapping(value = "admincostSearch")
		public String admincostSearch(Model model, 
									@RequestParam("keyword") String keyword, 
									@RequestParam("search") String search,
									HttpSession session) {
			System.out.println("hbController adminCostSearch start .. ");
			CostCodeCost costCodeCost = new CostCodeCost();
			costCodeCost.setSearch(search);
			costCodeCost.setKeyword(keyword);
			List<CostCodeCost> adminSearchCostList = hbCostService.adminSearchCost(costCodeCost);
			model.addAttribute("adminCostList",adminSearchCostList);
		    model.addAttribute("keyword", keyword); 
		    model.addAttribute("selectedSearch", search); 
			
			if(keyword != null ) {
				session.setAttribute("searchKeyword", keyword);
			}
			return "hb/adminCostCheck";
		}
		
		//세부사항
		@GetMapping(value = "adminCostDetail")
		public String adminCostDetail(Model model, CostCodeCost costCodeCost) {
			System.out.println("HBCostController admin_cost_detail start ... ");
			CostCodeCost costDetail = hbCostService.detailCost(costCodeCost.getCostTitle());
			
			 Map<Integer, String> costMap = new HashMap<>();
			 costMap.put(100, "대기");
		     costMap.put(110, "승인");
		     costMap.put(120, "거부");
		     model.addAttribute("costDetail", costDetail);
		     model.addAttribute("statusList",costMap.entrySet());
			 System.out.println("costDetail  ==> " + costDetail);
			 return "hb/adminCostDetail";
		}
		
		// 세부사항 내 정산 상태 변경
		@GetMapping(value = "adminStatusSelect")
		public ResponseEntity<String> updateStatus(@RequestParam("costTitle") String costTitle,
		                                           @RequestParam("costYear") int costYear,
		                                           @RequestParam("costStatus") int costStatus) {
		    System.out.println("상태 변경 요청: costTitle = " + costTitle + ", costStatus = " + costStatus);

		    // 상태 변경 로직
		    try {
		        hbCostService.updateCostStatus(costTitle, costStatus, costYear); // 서비스 메소드 호출
		        return ResponseEntity.ok("상태가 성공적으로 변경되었습니다.");
		    } catch (Exception e) {
		        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("상태 변경 중 오류가 발생했습니다: " + e.getMessage());
		    }
		}

		}
