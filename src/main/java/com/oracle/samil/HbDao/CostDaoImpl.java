package com.oracle.samil.HbDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Adto.CostCodeCost;
import com.oracle.samil.Amodel.Cost;
import com.oracle.samil.Amodel.CostCode;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class CostDaoImpl implements CostDao {
	
	@Autowired
	private final SqlSession session;
	
	// 유저 정산 목록 
	@Override
	public List<CostCodeCost> costList(CostCodeCost codeCost) {
	    List<CostCodeCost> costList = null;
	    try {
	        costList = session.selectList("hbgetCostList",codeCost); 
	        System.out.println("CostDaoImpl costList start...");
	    } catch (Exception e) {
	        System.out.println("CostDaoImpl error .. : " + e.getMessage());
	    }
	    return costList;
	}
	
	// 유저 정산 검색
	@Override
	public List<CostCodeCost> searchCost(CostCodeCost costCodeCost) {
		List <CostCodeCost> searchCost = null;
		try {
			searchCost = session.selectList("hbsearchCost", costCodeCost);
			System.out.println("searchCost ==> " + (searchCost != null ? searchCost.size() : 0));
		} catch (Exception e) {
			System.out.println("CostDaoImpl searchCost error : " +e.getMessage());
		}
		return searchCost;
	}

	// 유저 정산 코드 검색 
	@Override
	public List<CostCode> costCodeList() {
		// CostCode와 Cost 조인 이후에 정보 가지고 오는 것
		List<CostCode> getcostCode = null;
		try {
			getcostCode = session.selectList("hbgetcostCode",getcostCode);
			System.out.println("CostDaoImpl costCodeList start...");
		} catch (Exception e) {
			System.out.println("CostDaoImpl Code error .. : " + e.getMessage());
		}
		return getcostCode;
	}
	
	// 유저 정산 신청 : 코드 번호 가져와서 자동 입력
	@Override
	public String getCodeNameByCodeNum(int codeNum) {
		return session.selectOne("hbgetCodeNameByCodeNum", codeNum);
	}
	// 유저 정산 신청 
	@Override
	public CostCodeCost addNewCost(CostCodeCost costCodeCost) {
		try {
			int costResult = session.insert("hbinsertCost", costCodeCost);
			
			if (costResult > 0) {
				System.out.println("Insertion successful");
			} else {
				System.out.println("Insertion failed");
			}
		} catch (Exception e) {
			System.out.println("CostDaoImpl insertCost error " + e.getMessage());
			e.printStackTrace();
		}
		return costCodeCost; // 수정된 cost 객체 반환
	}
	//관리자
	//관리자 정산 코드 조회
	@Override
	public List<CostCode> adminCostCodeList() {
		// CostCode와 Cost 조인 이후에 정보 가지고 오는 것
		List<CostCode> adminGetcostCode = null;
		try {
			adminGetcostCode = session.selectList("hbadmingetcostCode",adminGetcostCode);
			System.out.println("CostDaoImpl costCodeList start...");
		} catch (Exception e) {
			System.out.println("CostDaoImpl Code error .. : " + e.getMessage());
		}
		return adminGetcostCode;
	}
	
	// 관리자 정산 코드 번호 설정 : 최대 숫자 확인
	@Override
	public int getMaxCodeNum() {
		int maxCodeNum;
		try {
			maxCodeNum = session.selectOne("hbgetMaxCodeNum");
			return maxCodeNum;
		} catch (Exception e) {
			System.out.println("CostDaoImpl insertCost error " +e.getMessage());
			return 0;
		}
	}
	
	// 관리자 코드 추가 및 코드 번호 
	@Override
	public CostCode costCodePlus(CostCode costCode) {
		int costCodePlus = 0;
		try {
			costCodePlus = session.insert("hbcostCodePlus", costCode);
		} catch (Exception e) {
			System.out.println("CostDaoImpl costCodePlus error .. : " + e.getMessage());
		}
		return costCode;
	}
	// 관리자 코드 비활성화
	@Override
	public int costCodeUnactivate(int codeNum) {
	    System.out.println("CostDaoImpl Code delete Start...");
	    int costUnactivateCode = 0;
	    try {
	        // 비활성화 또는 활성화 여부에 따라 적절한 쿼리 호출
	    	costUnactivateCode = session.update("hbcostCodeUnActive", codeNum);
	        System.out.println("CostDaoImpl costCodeDel start ");
	    } catch (Exception e) {
	        System.out.println("CostDaoImpl Code delete error .. : " + e.getMessage());
	    }
	    return costUnactivateCode;
	}
	//관리자 코드 활성화
	@Override
	public int costCodeActivate(int codeNum) {
	    System.out.println("CostDaoImpl Code activate Start...");
	    int costActivateCode = 0;
	    try {
	        costActivateCode = session.update("hbcostCodeActive", codeNum);
	        System.out.println("CostDaoImpl costCodeActivate start ");
	    } catch (Exception e) {
	        System.out.println("CostDaoImpl Code activate error .. : " + e.getMessage());
	    }
	    return costActivateCode;
	}

	// 관리자 정산 신청 리스트
	@Override
	public List<CostCodeCost> adminCostDao(CostCodeCost costCodeCost) {
		List<CostCodeCost> getAdminCost = null;
		try {
			getAdminCost = session.selectList("hbgetAdminCost",costCodeCost);
			System.out.println("CostDaoImpl getAdminCost start...");
		} catch (Exception e) {
			System.out.println("CostDaoImpl getAdminCost error " +e.getMessage());
		}
		return getAdminCost;
	}
	// 관리자 코드 세부사항 확인
	@Override
	public CostCodeCost detailCost(String costTitle) {
		CostCodeCost costCodeCost = new CostCodeCost();
		costCodeCost.setCostTitle(costTitle);
		System.out.println("CostDao detailCost start...");
		try {
			costCodeCost = session.selectOne("hbgetcostDetail",costCodeCost);
			System.out.println("CostDao detailCost costTitle..." + costCodeCost.getCostTitle());
		} catch (Exception e) {
			System.out.println("CostDaoImpl detailCost error " + e.getMessage());
		}
		
		return costCodeCost;
	}
	
	// 관리자 정산 처리
	@Override
	public void updateStatus(String costTitle, int costStatus, int costYear) {
	    Map<String, Object> updateStatus = new HashMap<>();
	    updateStatus.put("costTitle", costTitle);
	    updateStatus.put("costStatus", costStatus);
	    updateStatus.put("costYear", costYear);
	    session.update("hbupdateStatus", updateStatus);
	}
	// 관리자 정산 검색
	@Override
	public List<CostCodeCost> adminsearchCost(CostCodeCost costCodeCost) {
		List <CostCodeCost> adminSearchCostList = null;
		try {
			adminSearchCostList = session.selectList("hbadminSearchCost", costCodeCost);
			System.out.println("searchCost ==> " + (adminSearchCostList != null ? adminSearchCostList.size() : 0));
		} catch (Exception e) {
			System.out.println("CostDaoImpl searchCost error : " +e.getMessage());
		}
			return adminSearchCostList;
		}
	// 메인 페이지 값 
	@Override
	public int getAllCost() {
	return session.selectOne("hbgetAllCost");
		}

	
	
}
	

