package com.oracle.samil.SeDao;

import java.util.List;
import java.util.Map;

import com.oracle.samil.Adto.ApprovalDto;
import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.ApprovalLine;
import com.oracle.samil.Amodel.CostDetails;

public interface ApprovalDao {

	// 유저 전체
	int 					allApp(int empno);
	List<ApprovalDto> 		allAppList(ApprovalDto approvalDto);
	int 					condAllApp(int empno);
	List<ApprovalDto> 		allAppListSearch(ApprovalDto approvalDto);
	
	// 결재 완료
	int 					finApp(int empno);
	List<ApprovalDto> 		finAppList(ApprovalDto approvalDto);
	int 					condFinApp(int empno);
	List<ApprovalDto> 		finAppListSearch(ApprovalDto approvalDto);
	
	// 결재 대기
	int 					stnApp(int empno);
	List<ApprovalDto> 		stnAppList(ApprovalDto approvalDto);
	int 					condStnApp(int empno);
	List<ApprovalDto> 		stnAppListSearch(ApprovalDto approvalDto);
	
	// 어드민 (모든유저)전체
	int 					adminApp();
	List<ApprovalDto> 		adminAppList(ApprovalDto approvalDto);
	int 					condAdminApp(ApprovalDto approvalDto);
	List<ApprovalDto> 		adminAppListSearch(ApprovalDto approvalDto);
	
	// 조회
	ApprovalDto 			appDetail(int approvalNum, int documentFormId);
	// 결재라인
	List<ApprovalLine> 		approvalLineList(ApprovalLine approvalLine);
	// 비용리스트
	List<CostDetails> 		approvalCostList(CostDetails costDetails);
	// 결재 수정
	int						updateApp(ApprovalDto approvalDto);
	// 휴무 수정
	int 					appUpdateFur(ApprovalDto approvalDto);
	// 비용 수정
	int 					appUpdateCost(ApprovalDto approvalDto);
	// 조직도
	List<EmpDept>           empDeptApp();
	// 작성
	int                     insertApp(ApprovalDto approvalDto);
	// 결재라인 작성
	int 					approvalLineInsert(ApprovalDto approvalDto);
	// 휴무상세 작성
	int 					appInsertFur(ApprovalDto approvalDto);
	// 비용상세 작성
	int 					appInsertCost(ApprovalDto approvalDto);
	
	// 결재요청함
	int reqApp(int empno);
	int reqAppFin(int empno);
	List<ApprovalDto>		requestApp(ApprovalDto approvalDto);
	List<ApprovalDto>  requestAppFin(ApprovalDto approvalDto);
	// 문서 삭제
	void					deleteApproval(Map<String, Object> params);
	// 결재 라인 버튼
	int                     appLineUpdate(ApprovalDto approvalDto);
	int                     appClick(ApprovalDto approvalDto);
	
	
	

	

	

	
	
	
	







	
}
