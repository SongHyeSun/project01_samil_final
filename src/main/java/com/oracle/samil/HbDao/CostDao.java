package com.oracle.samil.HbDao;

import java.util.List;

import com.oracle.samil.Adto.CostCodeCost;
import com.oracle.samil.Amodel.Cost;
import com.oracle.samil.Amodel.CostCode;

public interface CostDao {

	
	List<CostCodeCost> 	costList(CostCodeCost codeCost);	//유저 정산 항목
	String              getCodeNameByCodeNum(int codeNum);	//유저 정산 신청에서 코드 확인
	CostCodeCost        addNewCost(CostCodeCost costCodeCost); // 유저 정산 신청
	List<CostCodeCost> 	searchCost(CostCodeCost costCodeCost); // 유저 정산 검색
	
	
	// costCode 추가 삭제 method
	List<CostCode> 		costCodeList();						  // 유저 정산 코드 조회
	List<CostCode> 		adminCostCodeList();				  // 관리자 정산 코드 조회
	int                 getMaxCodeNum();					  // 관리자 코드 번호
	int                 costCodeUnactivate(int codeNum);	  // 관리자 코드 비활성화
	int 				costCodeActivate(int codeNum);		  // 관리자 코드 활성화
	CostCode            costCodePlus(CostCode costCode);	  // 관리자 코드 추가 
	
	//  관리자 cost
	List<CostCodeCost>  adminCostDao(CostCodeCost costCodeCost); // 관리자 정산 확인
	CostCodeCost        detailCost(String costTitle);			 // 관리자 세부사항 확인
	void				updateStatus(String costTitle, int newStatus, int costYear); // 관리자 정산 상태 변경
	List<CostCodeCost> 	adminsearchCost(CostCodeCost CostCodeCost); // 관리자 정산 검색
	
	// 메인 페이지 구현 메소드
	int 				getAllCost(); 							// 메인 페이지 값 


}
