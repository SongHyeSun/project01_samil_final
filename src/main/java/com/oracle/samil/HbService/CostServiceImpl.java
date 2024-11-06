package com.oracle.samil.HbService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.samil.Adto.CostCodeCost;
import com.oracle.samil.Amodel.Cost;
import com.oracle.samil.Amodel.CostCode;
import com.oracle.samil.HbDao.CostDao;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CostServiceImpl implements CostService {
	
	@Autowired
	private final CostDao hbCostDao;
	
	// 유저 정산 항목
	@Override
	public List<CostCodeCost> getCostList(CostCodeCost codeCost) {
		System.out.println("HbcostList getCostList start...");
		List<CostCodeCost> costList = hbCostDao.costList(codeCost);
		if (costList == null) {
			costList = new ArrayList<>(); // null일 경우 빈 리스트로 초기화
		}
		System.out.println("hbCostList getCostList cost size.. = >  " + costList.size());
		return costList;
	}
	
	// 유저 정산 코드
	@Override
	public List<CostCode> getCodeList() {
		System.out.println("Hbcostservice getCodeList start...");
		List<CostCode> getCostCodeList = hbCostDao.costCodeList();
		System.out.println("hbCostService getCostCodeList size = > " + getCostCodeList.size());
		return getCostCodeList;
	}
	
	// 유저 정산 검색
	@Override
	public List<CostCodeCost> searchCost(CostCodeCost costCodeCost) {
		System.out.println("HBcostService searchCost start... ");
		List<CostCodeCost> searchCostList = hbCostDao.searchCost(costCodeCost);
		if (searchCostList != null) {
			System.out.println("HbcostService searchCostList size = > " + searchCostList.size());
		} else {
			System.out.println("No results found.");
		}
		return searchCostList;
	}

	
	// 유저 정산 신청 
	@Override
	public CostCodeCost addNewCost(CostCodeCost costCodeCost) {
		try {
			// codeNum에 따라 codeName 조회
			String codeName = hbCostDao.getCodeNameByCodeNum(costCodeCost.getCodeNum());
			
			costCodeCost.setCodeName(codeName); // Cost 객체에 codeName 설정
			costCodeCost.setCostStatus(100);
			
			// Cost 삽입
			hbCostDao.addNewCost(costCodeCost);
			System.out.println("정보 확인 :   " +  costCodeCost.getAttach()+ " / " + costCodeCost.getCodeName() + " / " + costCodeCost.getCostTitle() + " / " + costCodeCost.getCostMoney() + 
					" / " + costCodeCost.getEmpno() + " / " + costCodeCost.getSigndate()+ " / " + costCodeCost.getCostYear() + " / " + costCodeCost.getStatus());
			
			System.out.println("삽입 성공");
		} catch (Exception e) {
			System.out.println("CostDaoImpl insertCost 오류: " + e.getMessage());
			e.printStackTrace();
		}
		return costCodeCost; // 수정된 Cost 객체 반환
	}
	//관리자 
	
	
	// 관리자 정산 코드
	@Override
	public List<CostCode> getAdminCodeList() {
		System.out.println("Hbcostservice getCodeList start...");
		List<CostCode> getAdminCodeList = hbCostDao.adminCostCodeList();
		System.out.println("hbCostService getCostCodeList size = > " + getAdminCodeList.size());
		return getAdminCodeList;
	}
	
	//관리자 정산 코드 추가
	@Override
	public CostCode costCodePlus(CostCode costCode) {
		    System.out.println("HbcostService CostCodePlus start...");

		    // 최대 codeNum 조회
		    int maxCodeNum = hbCostDao.getMaxCodeNum();
		    if (maxCodeNum == 0) {
		        maxCodeNum = 180; // 초기값 설정
		    } else {
		        maxCodeNum += 10; // 10씩 증가
		    }
		    costCode.setCodeDel(0);
		    costCode.setCodeNum(maxCodeNum); // 새로운 codeNum 설정
		    return hbCostDao.costCodePlus(costCode); // DAO 호출
		}
	// 관리자 정산 코드 비활성화
	@Override
	public int costCodeUnactivate(int codeNum) {
		System.out.println("Hbcostservice costCodeDel start...");
		int costUnactivateCode = hbCostDao.costCodeUnactivate(codeNum);
		System.out.println("Hbcostservice costCodeDel =" + codeNum);
		return costUnactivateCode;
	}
	// 관리자 정산 코드 활성화
	@Override
	public int costCodeActivate(int codeNum) {
	    System.out.println("Hbcostservice costCodeActivate start...");
	    int costActivateCode = hbCostDao.costCodeActivate(codeNum);
	    System.out.println("Hbcostservice costCodeActivate =" + codeNum);
	    return costActivateCode;
	}
	
	// 관리자 정산 목록
	@Override
	public List<CostCodeCost> getAdminCost(CostCodeCost costCodeCost) {
		List<CostCodeCost> adminCostList = hbCostDao.adminCostDao(costCodeCost);
		System.out.println("HbcostService getAdminCost start...");
		System.out.println("HbcostService getAdminCost size = > " +adminCostList.size());
		return adminCostList;
	}
	
	// 관리자 정산 상세 보기
	@Override
	public CostCodeCost detailCost(String costTitle) {
		   System.out.println("HbService detailCost start...");
		   CostCodeCost costDetail = hbCostDao.detailCost(costTitle);
		   return costDetail;
	}
	// 관리자 정산 상태 변경 
	@Override
	public void updateCostStatus(String costTitle, int costStatus, int costYear) { // costStaus에서 오타 수정
	    hbCostDao.updateStatus(costTitle, costStatus, costYear);
	}
	// 관리자 정산 검색 
	@Override
	public List<CostCodeCost> adminSearchCost(CostCodeCost costCodeCost) {
		System.out.println("HBcostService searchCost start... ");
		List<CostCodeCost> adminSearchCostList = hbCostDao.adminsearchCost(costCodeCost);
		if (adminSearchCostList != null) {
			System.out.println("HbcostService searchCostList size = > " + adminSearchCostList.size());
		} else {
			System.out.println("No results found.");
		}
		return adminSearchCostList;	
	}
	
	
	//main 페이지 구현 
	@Override
	public int getAllCost() {
		System.out.println("HbCostService getAllCost Start .. ");
		int totalCost = hbCostDao.getAllCost();
	    System.out.println("Total Cost: " + totalCost); // 추가된 로그
		return totalCost;
	}



		
	}
