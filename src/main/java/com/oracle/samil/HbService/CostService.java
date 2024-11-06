package com.oracle.samil.HbService;

import java.util.List;

import com.oracle.samil.Adto.CostCodeCost;
import com.oracle.samil.Amodel.Cost;
import com.oracle.samil.Amodel.CostCode;

public interface CostService {

	// 유저 cost 확인 관련
	List<CostCodeCost> 			getCostList(CostCodeCost codeCost); 	//정산 항목 불러오기
	CostCodeCost                addNewCost(CostCodeCost costCodeCost);  // 정산 신청
	List<CostCodeCost> 			searchCost(CostCodeCost codeCost);  	// 유저 정산 검색 
	
	
	// 정산 코드 관련
	List<CostCode> 			   getCodeList(); 							// 유저 정산 항목 
	List<CostCode> 			   getAdminCodeList(); 						// 관리자 정산 항목
	int 					   costCodeUnactivate(int codeNum); 		// 정산 항목 비활성화
	int 					   costCodeActivate(int codeNum); 			// 정산 항목 활성화
	CostCode             	   costCodePlus(CostCode costCode); 		// 정산 항목 추가
	
	// admin cost 확인 관련
	List<CostCodeCost>         getAdminCost(CostCodeCost codeCost);		//	관리자 정산 항목
	CostCodeCost               detailCost(String costTitle);			//	관리자 정산 상세
	void 				 	   updateCostStatus(String costTitle, int newStatus, int costYear); // 관리자 정산 처리
	List<CostCodeCost> 		   adminSearchCost(CostCodeCost codeCost);  // 	관리자 정산 검색
	
	// main 페이지 구현 메소드
	int 					   getAllCost();							//  유저 메인 페이지 총액 


	

}
