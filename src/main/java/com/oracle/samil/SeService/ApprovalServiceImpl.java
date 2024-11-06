package com.oracle.samil.SeService;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.oracle.samil.Adto.ApprovalDto;
import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.ApprovalLine;
import com.oracle.samil.Amodel.CostDetails;
import com.oracle.samil.SeDao.ApprovalDao;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalServiceImpl implements ApprovalService {
	
	private final ApprovalDao ad;
	
	// 전체 게시글
	@Override
	public int allApp(int empno) {
		System.out.println("ApprovalServiceImpl allApp start");
		int allApp = ad.allApp(empno);
		return allApp;
	}
	
	// 전체 게시글 리스트
	@Override
	public List<ApprovalDto> allAppList(ApprovalDto approvalDto) {
		List<ApprovalDto> allList = null;
		System.out.println("ApprovalServiceImpl allList Start");
		allList = ad.allAppList(approvalDto);
		System.out.println("ApprovalServiceImpl allList" + allList);
		return allList;
	}
	
	// 전체 검색
	@Override
	public int condAllApp(int empno) {
		System.err.println("ApprovalServiceImpl Start condAllApp...");
		int allAppCnt = ad.condAllApp(empno);
		System.out.println("ApprovalServiceImpl condAllApp "+allAppCnt);
		return allAppCnt;
	}
	
	// 전체 검색 리스트
	@Override
	public List<ApprovalDto> allAppListSearch(ApprovalDto approvalDto) {
		List<ApprovalDto> allAppListSearch = null;
		System.out.println("ApprovalServiceImpl allAppListSearch start");
		allAppListSearch = ad.allAppListSearch(approvalDto);
		System.out.println("ApprovalServiceImpl allAppListSearch "+allAppListSearch);
		return allAppListSearch;
	}
	
	// 결재완료 게시글
	@Override
	public int finApp(int empno) {
		System.out.println("ApprovalServiceImpl finishApp start");
		int finApp = ad.finApp(empno);
		return finApp;
	}
	
	// 결재완료 리스트
	@Override
	public List<ApprovalDto> finAppList(ApprovalDto approvalDto) {
		List<ApprovalDto> finList = null;
		System.out.println("ApprovalServiceImpl finList Start");
		finList = ad.finAppList(approvalDto);
		System.out.println("ApprovalServiceImpl finList" + finList);
		return finList;
	}
	
	// 결재완료 검색
	@Override
	public int condFinApp(int empno) {
		System.err.println("ApprovalServiceImpl Start condFinApp...");
		int finAppCnt = ad.condFinApp(empno);
		System.out.println("ApprovalServiceImpl condFinApp "+finAppCnt);
		return finAppCnt;
	}
	
	// 결재완료 검색 리스트
	@Override
	public List<ApprovalDto> finAppListSearch(ApprovalDto approvalDto) {
		List<ApprovalDto> finAppListSearch = null;
		System.out.println("ApprovalServiceImpl finAppListSearch start");
		finAppListSearch = ad.finAppListSearch(approvalDto);
		System.out.println("ApprovalServiceImpl finAppListSearch "+finAppListSearch);
		return finAppListSearch;
	}
	
	// 결재대기 게시글
	@Override
	public int stnApp(int empno) {
		System.out.println("ApprovalServiceImpl stnApp start");
		int stnApp = ad.stnApp(empno);
		return stnApp;
	}

	// 결제대기 리스트
	@Override
	public List<ApprovalDto> stnAppList(ApprovalDto approvalDto) {
		List<ApprovalDto> stnList = null;
		System.out.println("ApprovalServiceImpl stnList Start");
		stnList = ad.stnAppList(approvalDto);
		System.out.println("ApprovalServiceImpl stnList" + stnList);
		return stnList;
	}

	// 결재대기 검색
	@Override
	public int condStnApp(int empno) {
		System.err.println("ApprovalServiceImpl Start condStnApp...");
		int stnAppCnt = ad.condStnApp(empno);
		System.out.println("ApprovalServiceImpl condStnApp "+stnAppCnt);
		return stnAppCnt;
	}
	
	// 결재대기 검색 리스트
	@Override
	public List<ApprovalDto> stnAppListSearch(ApprovalDto approvalDto) {
		List<ApprovalDto> stnAppListSearch = null;
		System.out.println("ApprovalServiceImpl stnAppListSearch start");
		stnAppListSearch = ad.stnAppListSearch(approvalDto);
		System.out.println("ApprovalServiceImpl stnAppListSearch "+stnAppListSearch);
		return stnAppListSearch;
	}
	
	// 결재대기 게시글
	@Override
	public int reqApp(int empno) {
		System.out.println("ApprovalServiceImpl reqApp start");
		int reqApp = ad.reqApp(empno);
		return reqApp;
	}
	// 결재완료
	public int reqAppFin(int empno) {
		System.out.println("ApprovalServiceImpl stnApp start");
		int reqAppFin = ad.reqAppFin(empno);
		return reqAppFin;
	}

	// 결재요청 대기함
	@Override
	public List<ApprovalDto> requestApp(ApprovalDto approvalDto) {
		List<ApprovalDto> requestList = null;
		requestList = ad.requestApp(approvalDto);
		System.out.println("ApprovalServiceImpl requestApp 진행");
		return requestList;
	}
	
	// 결재요청 완료함
	@Override
	public List<ApprovalDto> requestAppFin(ApprovalDto approvalDto) {
		List<ApprovalDto> requestFinList = null;
		requestFinList = ad.requestAppFin(approvalDto);
		System.out.println("ApprovalServiceImpl requestAppFin 진행");
		return requestFinList;
	}
	
	// 어드민 모든유저 게시글
	@Override
	public int adminApp() {
		System.out.println("ApprovalServiceImpl adminallApp start");
		int adminApp = ad.adminApp();
		return adminApp;
	}

	// 어드민 모든유저 리스트
	@Override
	public List<ApprovalDto> adminAppList(ApprovalDto approvalDto) {
		List<ApprovalDto> adminList = null;
		System.out.println("ApprovalServiceImpl adminAppList Start");
		adminList = ad.adminAppList(approvalDto);
		System.out.println("ApprovalServiceImpl adminAppList" + adminList);
		return adminList;
	}
	
	// 어드민 전체 검색
	@Override
	public int condAdminApp(ApprovalDto approvalDto) {
		System.err.println("ApprovalServiceImpl Start condAdminApp...");
		int adminAppCnt = ad.condAdminApp(approvalDto);
		System.out.println("ApprovalServiceImpl condAdminApp "+adminAppCnt);
		return adminAppCnt;
	}
	
	// 어드민 전체 검색
	@Override
	public List<ApprovalDto> adminAppListSearch(ApprovalDto approvalDto) {
		List<ApprovalDto> adminAppListSearch = null;
		System.out.println("ApprovalServiceImpl adminAppListSearch start");
		adminAppListSearch = ad.adminAppListSearch(approvalDto);
		System.out.println("ApprovalServiceImpl adminAppListSearch "+adminAppListSearch);
		return adminAppListSearch;
	}
	
	// 조회
	@Override
	public ApprovalDto appDetail(int approvalNum, int documentFormId) {
	    System.out.println("ApprovalServiceImpl getApprovalDetails ...");
	    
	    ApprovalDto approvalDto = null;
	    approvalDto = ad.appDetail(approvalNum, documentFormId);
	    
	    return approvalDto;
	}
	
	// 결재라인 불러오기
	@Override
	public List<ApprovalLine> appLineList(ApprovalLine approvalLine) {
		System.out.println("ApprovalServiceImpl appLineList ...");
		List<ApprovalLine> approvalLineList = null;
		approvalLineList = ad.approvalLineList(approvalLine);
		System.out.println("ApprovalServiceImpl appLineList "+approvalLineList);
		return approvalLineList;
	}
	
	// 비용상세 불러오기
	@Override
	public List<CostDetails> appCostList(CostDetails costDetails) {
		System.out.println("ApprovalServiceImpl appCostList ...");
		List<CostDetails> approvalCostList = null;
		approvalCostList = ad.approvalCostList(costDetails);
		System.out.println("ApprovalServiceImpl appLineListSearch "+approvalCostList);
		return approvalCostList;
	}
	
	// 문서 수정 
	@Override
	public void updateApp(ApprovalDto approvalDto) {
	    System.out.println("ApprovalServiceImpl updateApp 시작");
	    ad.updateApp(approvalDto);
	    System.out.println("ApprovalServiceImpl updateApp 진행");
	    return; 
	}
	
	// 휴무 수정
	@Override
	public void appUpdateFur(ApprovalDto approvalDto) {
		ad.appUpdateFur(approvalDto);
		System.out.println("ApprovalServiceImpl appUpdateFur 진행");
		return;
	}
	
	// 비용 수정
	@Override
	public void appUpdateCost(ApprovalDto approvalDto) {
		ad.appUpdateCost(approvalDto);
		System.out.println("ApprovalServiceImpl appUpdateCost 진행");
		return;
	}

	@Override
	public List<EmpDept> empDeptApp() {
		List<EmpDept> empDeptApp = null;
		empDeptApp = ad.empDeptApp();
		System.out.println("ApprovalServiceImpl empDeptApp "+empDeptApp);
		return empDeptApp;
	}
	
	@Override
	public int approvalLineInsert(ApprovalDto approvalDto) {
		System.out.println("ApprovalService approvalLineInsert Start");
		return ad.approvalLineInsert(approvalDto);
	}
	
	// 결재테이블 인설트
	@Override
	public void insertApp(ApprovalDto approvalDto) {
	    System.out.println("ApprovalService insertApp Start");
	    ad.insertApp(approvalDto);
	    return;
	}

	// 휴무 인설트
	@Override
	public void appInsertFur(ApprovalDto approvalDto) {
		ad.appInsertFur(approvalDto);
		System.out.println("ApprovalServiceImpl appInsertFur 진행");
		return;
	}
	
	// 비용 인설트
	@Override
	public void appInsertCost(ApprovalDto approvalDto) {
		System.out.println("ApprovalServiceImpl appInsertCost 진행");
		ad.appInsertCost(approvalDto);
		return;
	}

	// 문서 삭제
	@Override
	@Transactional // 트랜잭션 관리
	public void deleteApproval(Integer approvalNum, Integer documentFormId) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("approvalNum", approvalNum);
	    params.put("documentFormId", documentFormId);

		ad.deleteApproval(params);
		System.out.println("ApprovalServiceImpl deleteApproval 진행");
	}

	@Override
	public void appLineUpdate(ApprovalDto approvalDto) {
		ad.appLineUpdate(approvalDto);
		System.out.println("ApprovalServiceImpl appLineUpdate 진행");
		return;
	}

	@Override
	public void appClick(ApprovalDto approvalDto) {
		ad.appClick(approvalDto);
		System.out.println("ApprovalServiceImpl appClick 진행");
		return;
	}

}
