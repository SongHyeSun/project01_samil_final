 package com.oracle.samil.SeDao;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Adto.ApprovalDto;
import com.oracle.samil.Adto.CalTotal;
import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.ApprovalLine;
import com.oracle.samil.Amodel.Attendee;
import com.oracle.samil.Amodel.CostDetails;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ApprovalDaoImpl implements ApprovalDao {
	
	private final SqlSession session;
	
	// 전체 보관함 -> 게시글 가져오기
	@Override
	public int allApp(int empno) {
		int allApp = 0;
		System.out.println("ApprovalDaoImpl allApp Start");
		
		try {
			allApp = session.selectOne("allApp", empno);
			System.out.println("ApprovalDaoImpl allApp ok "+allApp);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl allApp 에러"+e.getMessage());
		}
		return allApp;
	}
	
	// 전체 보관함 -> 게시글 보여주기
	@Override
	public List<ApprovalDto> allAppList(ApprovalDto approvalDto) {
		List<ApprovalDto> allList = null;
		System.out.println("ApprovalDaoImpl allAppList Start");
		
		try {
			allList = session.selectList("allAppList", approvalDto);
			System.out.println("ApprovalDaoImpl allList " + allList.size());
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl allList e.getMessage() -> " + e.getMessage());
		}
		return allList;
	}
	
	// 보관함 조회
	@Override
	public int condAllApp(int empno) {
		int allAppCount = 0;
		System.out.println("ApprovalDaoImpl condAllApp start");
		
		try {
	        // selectOne의 결과를 Integer로 받아 null 체크
	        Integer result = session.selectOne("condAllApp", empno);
	        
	        // result가 null이 아닐 때 stnAppCount에 값을 할당
	        if (result != null) {
	        	allAppCount = result.intValue();
	        } else {
	            // 결과가 null인 경우 로깅 또는 기본값 처리
	            System.out.println("No data found for empno: " + empno);
	            allAppCount = 0; // 기본값 설정
	        }
	        
	        System.out.println("ApprovalDaoImpl allAppCount " + allAppCount);
	    } catch (Exception e) {
	        e.printStackTrace(); // 로깅 등을 추가할 수 있습니다.
	    }
		return allAppCount;
	}
	
	// 보관함 검색
	@Override
	public List<ApprovalDto> allAppListSearch(ApprovalDto approvalDto) {
		List<ApprovalDto> allAppListSearch = null;
		System.out.println("ApprovalDaoImpl allAppListSearch Start...");
		System.out.println("ApprovalDaoImpl allAppListSearch approvalDto->"+approvalDto);
		try {
			allAppListSearch = session.selectList("allAppListSearch", approvalDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return allAppListSearch;
	}
	
	// 결재 완료함 -> 게시글 가져오기
	@Override
	public int finApp(int empno) {
		int finApp = 0;
		System.out.println("ApprovalDaoImpl finApp Start");
		
		try {
			finApp = session.selectOne("finApp", empno);
			System.out.println("ApprovalDaoImpl finApp ok "+finApp);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl finApp 에러"+e.getMessage());
		}
		return finApp;
	}
	
	// 결재 완료함 -> 게시글 보여주기
	@Override
	public List<ApprovalDto> finAppList(ApprovalDto approvalDto) {
		List<ApprovalDto> finList = null;
		System.out.println("ApprovalDaoImpl finList Start");
		
		try {
			finList = session.selectList("finAppList", approvalDto);
			System.out.println("ApprovalDaoImpl finList" + finList.size());
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl finList e.getMessage() -> " + e.getMessage());
		}
		return finList;
	}
	
	// 결재 완료함 -> 게시글 가져오기
	@Override
	public int condFinApp(int empno) {
		int finAppCount = 0;
		System.out.println("ApprovalDaoImpl condFinApp start");
		
		try {
	        // selectOne의 결과를 Integer로 받아 null 체크
	        Integer result = session.selectOne("condFinApp", empno);
	        
	        // result가 null이 아닐 때 stnAppCount에 값을 할당
	        if (result != null) {
	        	finAppCount = result.intValue();
	        } else {
	            // 결과가 null인 경우 로깅 또는 기본값 처리
	            System.out.println("No data found for empno: " + empno);
	            finAppCount = 0; // 기본값 설정
	        }
	        
	        System.out.println("ApprovalDaoImpl finAppCount " + finAppCount);
	    } catch (Exception e) {
	        e.printStackTrace(); // 로깅 등을 추가할 수 있습니다.
	    }
		return finAppCount;
	}
	
	// 결재 완료함 -> 게시글 보여주기
	@Override
	public List<ApprovalDto> finAppListSearch(ApprovalDto approvalDto) {
		List<ApprovalDto> finAppListSearch = null;
		System.out.println("ApprovalDaoImpl finAppListSearch Start...");
		System.out.println("ApprovalDaoImpl finAppListSearch approvalDto->"+approvalDto);
		try {
			finAppListSearch = session.selectList("finAppListSearch", approvalDto);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl allAppListSearch 에러 "+e.getMessage());
		}
		return finAppListSearch;
	}
	
	// 결재 대기함 -> 게시글 가져오기
	@Override
	public int stnApp(int empno) {
		int stnApp = 0;
		System.out.println("ApprovalDaoImpl stnApp Start");
		
		try {
			stnApp = session.selectOne("stnApp", empno);
			System.out.println("ApprovalDaoImpl stnApp ok "+stnApp);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl stnApp 에러"+e.getMessage());
		}
		return stnApp;
	}
	
	// 결재 대기함 -> 게시글 보여주기
	@Override
	public List<ApprovalDto> stnAppList(ApprovalDto approvalDto) {
		List<ApprovalDto> stnList = null;
		System.out.println("ApprovalDaoImpl stnList Start");
		
		try {
			stnList = session.selectList("stnAppList", approvalDto);
			System.out.println("ApprovalDaoImpl stnList" + stnList.size());
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl stnList e.getMessage() -> " + e.getMessage());
		}
		return stnList;
	}
	
	// 결재 완료함 -> 게시글 가져오기
	@Override
	public int condStnApp(int empno) {
	    int stnAppCount = 0;
	    System.out.println("ApprovalDaoImpl condStnApp start");
	    
	    try {
	        // selectOne의 결과를 Integer로 받아 null 체크
	        Integer result = session.selectOne("condStnApp", empno);
	        
	        // result가 null이 아닐 때 stnAppCount에 값을 할당
	        if (result != null) {
	            stnAppCount = result.intValue();
	        } else {
	            // 결과가 null인 경우 로깅 또는 기본값 처리
	            System.out.println("No data found for empno: " + empno);
	            stnAppCount = 0; // 기본값 설정
	        }
	        
	        System.out.println("ApprovalDaoImpl condStnApp " + stnAppCount);
	    } catch (Exception e) {
	        e.printStackTrace(); // 로깅 등을 추가할 수 있습니다.
	    }
	    
	    return stnAppCount;
	}
	
	// 결재 완료함 -> 게시글 보여주기
	@Override
	public List<ApprovalDto> stnAppListSearch(ApprovalDto approvalDto) {
		List<ApprovalDto> stnAppListSearch = null;
		System.out.println("ApprovalDaoImpl stnAppListSearch Start...");
		System.out.println("ApprovalDaoImpl stnAppListSearch approval->"+approvalDto);
		try {
			stnAppListSearch = session.selectList("stnAppListSearch", approvalDto);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl stnAppListSearch 에러 "+e.getMessage());
		}
		return stnAppListSearch;
	}
	
	@Override
	public int reqApp(int empno) {
		int reqApp = 0;
		System.out.println("ApprovalDaoImpl reqApp Start");
		
		try {
			reqApp = session.selectOne("reqApp", empno);
			System.out.println("ApprovalDaoImpl reqApp ok "+reqApp);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl reqApp 에러"+e.getMessage());
		}
		return reqApp;
	}

	@Override
	public int reqAppFin(int empno) {
		int reqAppFin = 0;
		System.out.println("ApprovalDaoImpl reqAppFin Start");
		
		try {
			reqAppFin = session.selectOne("reqAppFin", empno);
			System.out.println("ApprovalDaoImpl reqAppFin ok "+reqAppFin);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl reqAppFin 에러"+e.getMessage());
		}
		return reqAppFin;
	}
	
	// 결재요청 대기함
	@Override
	public List<ApprovalDto> requestApp(ApprovalDto approvalDto) {
		System.out.println("ApprovalDaoImpl requestApp Start..."+approvalDto);
		List<ApprovalDto> requestList = null;
		try {
			requestList = session.selectList("requestApp", approvalDto);
			System.out.println("ApprovalDaoImpl requestApp requestList ->"+requestList);
		} catch (Exception e) {
			System.out.println("결재요청함 오류" + e.getMessage());
		}
		return requestList;
	}
		
	// 결재요청 완료함
	@Override
	public List<ApprovalDto> requestAppFin(ApprovalDto approvalDto) {
		System.out.println("ApprovalDaoImpl requestAppFin Start..."+approvalDto);
		List<ApprovalDto> requestList = null;
		try {
			requestList = session.selectList("requestAppFin", approvalDto);
			System.out.println("ApprovalDaoImpl requestAppFin requestList ->"+requestList);
		} catch (Exception e) {
			System.out.println("결재요청함 오류" + e.getMessage());
		}
		return requestList;
	}
	
	// 어드민 게시글 가져오기
	@Override
	public int adminApp() {
		int adminApp = 0;
		System.out.println("ApprovalDaoImpl adminApp Start");
		
		try {
			adminApp = session.selectOne("com.oracle.samil.SeDao.ApprovalDao.adminApp");
			System.out.println("ApprovalDaoImpl adminApp ok");
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl adminApp 에러"+e.getMessage());
		}
		return adminApp;
	}
	
	// 어드민 게시글 보여주기
	@Override
	public List<ApprovalDto> adminAppList(ApprovalDto approvalDto) {
		List<ApprovalDto> adminList = null;
		System.out.println("ApprovalDaoImpl adminList Start");
		
		try {
			adminList = session.selectList("adminAppList", approvalDto);
			System.out.println("ApprovalDaoImpl adminList" + adminList.size());
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl adminList e.getMessage() -> " + e.getMessage());
		}
		return adminList;
	}
	
	// 어드민 전체보관함 -> 게시글 가져오기
	@Override
	public int condAdminApp(ApprovalDto approvalDto) {
		int adminAppCount = 0;
		System.out.println("ApprovalDaoImpl condAdminApp start");
		
		try {
			adminAppCount = session.selectOne("condAdminApp", approvalDto);
			System.out.println("ApprovalDaoImpl condAdminApp "+adminAppCount);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl condAdminApp 에러 "+e.getMessage());
		}
		return adminAppCount;
	}
	
	// 어드민 전체보관함 -> 게시글 보여주기
	@Override
	public List<ApprovalDto> adminAppListSearch(ApprovalDto approvalDto) {
		List<ApprovalDto> adminAppListSearch = null;
		System.out.println("ApprovalDaoImpl adminAppListSearch Start...");
		System.out.println("ApprovalDaoImpl adminAppListSearch ApprovalDto->"+approvalDto);
		try {
			adminAppListSearch = session.selectList("adminAppListSearch", approvalDto);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl adminAppListSearch 에러 "+e.getMessage());
		}
		return adminAppListSearch;
	}
	
	// 조회
	@Override
	public ApprovalDto appDetail(int approvalNum, int documentFormId) {
	    System.out.println("ApprovalDaoImpl detailApp Start");
	    ApprovalDto approvalDto = new ApprovalDto(); // Approval 객체로 변경

	    try {
	        Map<String, Object> params = new HashMap<>();
	        params.put("approvalNum", approvalNum);
	        params.put("documentFormId", documentFormId);
	        
	        approvalDto = session.selectOne("detailApp", params);
	        System.out.println("ApprovalDaoImpl appDetail " + approvalDto);
	    } catch (Exception e) {
	        e.printStackTrace(); // 로깅 등을 추가할 수 있습니다.
	    }

	    return approvalDto; // Approval 객체에서 필요한 값 반환
	}

	// 결재라인 리스트 불러오기 
	@Override
	public List<ApprovalLine> approvalLineList(ApprovalLine approvalLine) {
		List<ApprovalLine> approvalLineList = null;
		System.out.println("ApprovalDaoImpl approvalLineList Start...");
		System.out.println("ApprovalDaoImpl approvalLineList approval->"+approvalLine);
		try {
			approvalLineList = session.selectList("appLineList", approvalLine);
			System.out.println("ApprovalDaoImpl approvalLineList approvalLineList.size()->"+approvalLineList.size());
			System.out.println("approvalLine->"+approvalLine);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl approvalLineList 에러->"+e.getMessage());
		}
		return approvalLineList;
	}
	
	// 상세비용 리스트 불러오기
	@Override
	public List<CostDetails> approvalCostList(CostDetails costDetails) {
		List<CostDetails> approvalCostList = null;
		System.out.println("ApprovalDaoImpl approvalCostList Start...");
		System.out.println("ApprovalDaoImpl approvalCostList approval->"+costDetails);
		try {
			approvalCostList = session.selectList("appCostList", costDetails);
			System.out.println("ApprovalDaoImpl approvalCostList approvalCostList.size()->"+approvalCostList.size());
			System.out.println("approvalLine->"+costDetails);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl approvalCostList 에러->"+e.getMessage());
		}
		return approvalCostList;
	}
	
	// 결재내용 변경
	@Override
	public int updateApp(ApprovalDto approvalDto) {
		int result = 0;
		System.out.println("ApprovalDaoImpl updateApp Start...");
		try {
			result = session.update("appUpdate", approvalDto);
			System.out.println("ApprovalDaoImpl updateApp result ->"+result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 휴무상세 변경
	@Override
	public int appUpdateFur(ApprovalDto approvalDto) {
		int result = 0;
		System.out.println("ApprovalDaoImpl appUpdateFur Start...");
		try {
			result = session.update("appUpdateFur", approvalDto);
			System.out.println("ApprovalDaoImpl appUpdateFur result ->"+result);
		} catch (Exception e) {
			System.out.println("휴무상세 오류" + e.getMessage());
		}
		return result;
	}
	
	// 비용상세 변경
	@Override
	public int appUpdateCost(ApprovalDto approvalDto) {
		int result = 0;
		System.out.println("ApprovalDaoImpl appUpdateCost Start...");
		try {
			result = session.update("appUpdateCost", approvalDto);
			System.out.println("ApprovalDaoImpl appUpdateCost result ->"+result);
		} catch (Exception e) {
			System.out.println("비용상세 오류" + e.getMessage());
		}
		return result;
	}

	@Override
	public List<EmpDept> empDeptApp() {
		List<EmpDept> empDeptApp = null;
		System.out.println("ApprovalDaoImpl allApp Start");
		
		try {
			empDeptApp = session.selectList("empDeptApp");
			System.out.println("ApprovalDaoImpl empDeptApp ok");
			System.out.println("ApprovalDaoImpl empDeptApp-->"+empDeptApp);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl empDeptApp 에러"+e.getMessage());
		}
		return empDeptApp;
	}

	@Override
	public int insertApp(ApprovalDto approvalDto) {
		int result = 0;
		System.out.println("ApprovalDaoImpl insertApp Start...");
		
		System.out.println("ApprovalDto: " + approvalDto);
		try {
			result = session.insert("appInsert", approvalDto);
			int appNum = session.selectOne("appMaxnum", approvalDto.getDocumentFormId());
			approvalDto.setApprovalNum(appNum);
			System.out.println("ApprovalDaoImpl insertApp result ->"+result);
		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println("ApprovalDaoImpl 결재 에러->"+e);
		}
		return result;
	}
	// 결재라인 작성
	@Override
	public int approvalLineInsert(ApprovalDto approvalDto) {
		int approvalLineInsert = 0;
		System.out.println("ApprovalDaoImpl allApp Start");
		System.out.println("ApprovalDaoImpl approvalLineInsert 값 확인 -->"+approvalDto);
		try {
			approvalLineInsert = session.insert("approvalLineInsert", approvalDto);
			System.out.println("ApprovalDaoImpl approvalLineInsert ok");
			System.out.println("ApprovalDaoImpl approvalLineInsert-->"+approvalDto);
		} catch (Exception e) {
			System.out.println("ApprovalDaoImpl 결재라인 에러"+e.getMessage());
		}
		return approvalLineInsert;
	}

	@Override
	public int appInsertFur(ApprovalDto approvalDto) {
		int result = 0;
		System.out.println("ApprovalDaoImpl appInsertFur Start...");
		System.out.println("ApprovalDaoImpl appInsertFur approvalDto..."+approvalDto);
		try {
			result = session.insert("appInsertFur", approvalDto);
			System.out.println("ApprovalDaoImpl appInsertFur result ->"+result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int appInsertCost(ApprovalDto approvalDto) {
		int result = 0;
		System.out.println("ApprovalDaoImpl appInsertCost Start...");
		try {
			result = session.insert("appInsertCost", approvalDto);
			System.out.println("ApprovalDaoImpl appInsertCost result ->"+result);
		} catch (Exception e) {
			System.out.println("비용테이블 오류" + e.getMessage());
		}
		return result;
	}
	
	
	// 문서 삭제
	@Override
	public void deleteApproval(Map<String, Object> params) {
		System.out.println("ApprovalDaoImpl deleteApproval Start...");
		session.delete("deleteFurloughDetails", params);
		session.delete("deleteCostDetails", params);
		session.delete("deleteApprovalLine", params);
		session.delete("deleteApproval", params);
	}

	@Override
	public int appLineUpdate(ApprovalDto approvalDto) {
		int result = 0;
		System.out.println("ApprovalDaoImpl appLineUpdate Start...");
		try {
			result = session.update("appLineUpdate", approvalDto);
			System.out.println("ApprovalDaoImpl appUpdateCost result ->"+result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int appClick(ApprovalDto approvalDto) {
	    int result = 0;
	    System.out.println("ApprovalDaoImpl appClick Start...");
	    
	    try {
	        // Update approval information
	        result = session.update("appClick", approvalDto);
	        System.out.println("ApprovalDaoImpl appClick approvalDto -> " + approvalDto);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return result;
	}

	


}
