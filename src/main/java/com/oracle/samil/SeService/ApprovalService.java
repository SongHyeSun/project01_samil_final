package com.oracle.samil.SeService;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.oracle.samil.Adto.ApprovalDto;
import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Approval;
import com.oracle.samil.Amodel.ApprovalLine;
import com.oracle.samil.Amodel.CostDetails;

public interface ApprovalService {
	
	//전체 보관
	int 		   			allApp(int empno);
	List<ApprovalDto> 		allAppList(ApprovalDto approvalDto);
	int            			condAllApp(int empno);
	List<ApprovalDto> 		allAppListSearch(ApprovalDto approvalDto);
	
	//완료 보관
	int            			finApp(int empno);
	List<ApprovalDto> 		finAppList(ApprovalDto approvalDto);
	int            			condFinApp(int empno);
	List<ApprovalDto> 		finAppListSearch(ApprovalDto approvalDto);
	
	//대기 보관
	int            			stnApp(int empno);
	List<ApprovalDto> 		stnAppList(ApprovalDto approvalDto);
	int            			condStnApp(int empno);
	List<ApprovalDto> 		stnAppListSearch(ApprovalDto approvalDto);
	
	//어드민 보관
	int            			adminApp();
	List<ApprovalDto> 		adminAppList(ApprovalDto approvalDto);
	int            			condAdminApp(ApprovalDto approvalDto);
	List<ApprovalDto> 		adminAppListSearch(ApprovalDto approvalDto);
	
	//결재조회
	ApprovalDto 			appDetail(int approvalNum, int documentFormId);
	//결재라인조회
	List<ApprovalLine> 		appLineList(ApprovalLine approvalLine);
	//비용리스트조회
	List<CostDetails> 		appCostList(CostDetails costDetails);
	
	// 결재수정
	void					updateApp(ApprovalDto approvalDto);
	// 휴무수정
	void    				appUpdateFur(ApprovalDto approvalDto);
	// 비용수정
	void  					appUpdateCost(ApprovalDto approvalDto);
	// 조직도
	List<EmpDept>           empDeptApp();
	// 작성
	void                     insertApp(ApprovalDto approvalDto);
	void appInsertFur(ApprovalDto approvalDto);
	void appInsertCost(ApprovalDto approvalDto);
	int approvalLineInsert(ApprovalDto approvalDto);
	
	// 결재요청함
	int reqApp(int empno);
	// 결재완료함
	int reqAppFin(int empno);
	List<ApprovalDto>		requestApp(ApprovalDto approvalDto);
	List<ApprovalDto>  requestAppFin(ApprovalDto approvalDto);
	
	
	// 문서 삭제
	void					deleteApproval(Integer approvalNum, Integer documentFormId);
	// 결재 라인 버튼
	void 					appLineUpdate(ApprovalDto approvalDto);
	void                    appClick(ApprovalDto approvalDto);
	
	









}
