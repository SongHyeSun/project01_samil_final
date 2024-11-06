package com.oracle.samil.MhDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Amodel.Attendance;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.Sal;
import com.oracle.samil.MhService.Paging;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SalDoaI implements SalDao {

	@Autowired
	private final SqlSession session;

	@Override
	public int totalSal() {
		int totSalCount = 0;
		
		try {
			totSalCount = session.selectOne("mhsalTotal");
			
		} catch (Exception e) {
			System.out.println("EmpDaoImpl totalSal e.getMessage()->"+e.getMessage());
		}
		
		return totSalCount;
	
	}

	@Override
	public List<Sal> totalEmp(Sal Sal) {
		List<Sal> totEmpCount  = null;
		
		try {
			totEmpCount = session.selectList("mhempTotal", Sal);
		} catch (Exception e) {
		}
		
		return totEmpCount;
	}

	@Override
	public List<Sal> salDList(Sal sal) {
		List<Sal> salDList = null;
		
		try {
			salDList = session.selectList("mhsalDList", sal);
			
		} catch (Exception e) {
			
		}
		return salDList;
	}

	@Override
	public Sal shemp(Sal Sal) {
		Sal shemp = null;
		
		try {
			shemp = session.selectOne("mhshemp", Sal);
			
		} catch (Exception e) {
			System.out.println("error"+e.getMessage());
			
		}
		
		return shemp;
	}

	@Override
	public List<Sal> setTotalEmp(Sal Sal) {
		List<Sal> setTotalEmp = null;
		
		try {
			setTotalEmp = session.selectList("mhsetTotalEmp", Sal);
			
		} catch (Exception e) {
			
		}
		return setTotalEmp;
	}

	@Override
	public List<Sal> empSearchList(Sal Sal) {
		List<Sal> empSearchList = null;
		try {
			empSearchList = session.selectList("mhEmpSearchList",Sal);
			System.out.println("Dao listSearch3 listSearchEmp.size()=>" + empSearchList.size());
			System.out.println("Dao listSearch3 empSearchList=>" + empSearchList);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return empSearchList;
	}

	@Override
	public String findSalDate() {
		String findSalDate = null;
		try {
			findSalDate = session.selectOne("mhfindSalDate");
			System.out.println("dao salDate->" +findSalDate);
			
		}catch (Exception e) {
			System.out.println("EmpDaoImpl findSalDate e.getMessage()->"+e.getMessage());
		}
		
		return findSalDate;
	}

	@Override
	public int updateSal(Sal Sal) {
	    System.out.println("dao start");
	    int updateSal = 0;  

	    try {
	        System.out.println("dao updateSal empSalDept -> " + Sal);
	        updateSal = session.update("mhupdateSal", Sal);
	      

	        if (updateSal > 0) {
	            System.out.println("업데이트 성공");
	        } else {
	            System.out.println("업데이트 실패 또는 대상 없음");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    System.out.println("updateSal" + updateSal); 

	    return updateSal; 
	}

	@Override
	public List<Sal> mSalList(Sal Sal) {
		List<Sal> mSalList = null;
		try {
			mSalList = session.selectList("mhmSalList", Sal);
	        System.out.println("dao mSalList mSalList-> " + mSalList);
			
		} catch (Exception e) {
	        System.out.println("dao mSalList 오류-> " + e);
		}
		return mSalList;
	}

	@Override
	public String getSalNum() {
		String getSalNum = null;
		try {
			getSalNum = session.selectOne("mhgetSalNum");
			System.out.println("dao salDate->" +getSalNum);
			
		}catch (Exception e) {
			System.out.println("EmpDaoImpl findSalDate e.getMessage()->"+e.getMessage());
		}
		
		return getSalNum;
	}

	@Override
	public int submitDate(int day) {
		System.out.println("dao day->"+ day);
		int submitDate = 0;
		try {
			submitDate = session.update("mhsubmitDate", day);
			System.out.println("dao submitDate->"+ submitDate);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return submitDate;
	}

	@Override
	public int insertSal(int empno) {
		int insertSal = 0;
		try {
			insertSal = session.insert("mhinsertSal", empno);
		}catch (Exception e) {
			System.out.println(e);
		}
		return insertSal;
	}
	@Override
	public Map<String, Object> joinList(int empno, String salnum) {
	    Map<String, Object> joinList = null;

	    try {
	        // MyBatis에 전달할 파라미터를 담을 Map 객체 생성
	        Map<String, Object> params = new HashMap<>();
	        params.put("empno", empno);
	        params.put("salnum", salnum);
	        
	        // MyBatis 쿼리 실행 후 결과를 joinList에 저장
	        joinList = session.selectOne("mhjoinList", params);
	        
	        System.out.println("joinList dao: " + joinList);

	    } catch (Exception e) {
	        System.out.println("Error: " + e.getMessage());
	    }
	  
	    return joinList;
	}

	@Override
	public List<Sal> salNumList(String empno) {
		List<Sal> salNumList = null;
		try {
			
			salNumList = session.selectList("mhsalNumList", empno);
			System.out.println("dao salNumList->" +salNumList);

		} catch (Exception e) {
			// TODO: handle exception
		}
		return salNumList;
	}

	@Override
	public int updateBank(String selectedBank, int empno, String account) {
		int updateBank = 0;
		try {
			  Map<String, Object> params = new HashMap<>();
		        params.put("selectedBank", selectedBank);
		        params.put("empno", empno);
		        params.put("account", account);

		        // MyBatis 업데이트 실행
		        updateBank = session.update("mhupdateBank", params);
		} catch (Exception e) {
		}
		return updateBank;
	}

	@Override
	public List<Sal> empSearchListSet(Sal sal) {
		List<Sal>empSearchListSet = null;
		try {
			empSearchListSet = session.selectList("mhempSearchListSet",sal);
			System.out.println("Dao listSearch3 listSearchEmp.size()=>" + empSearchListSet.size());
			System.out.println("Dao listSearch3 empSearchList=>" + empSearchListSet);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return empSearchListSet;
	}

	@Override
	public Optional<Integer> empSalempno(int empno) {
		 Integer empSalempno = null;
		 try {
			 System.out.println("Dao empSalempno empno=>" + empno);
			 empSalempno = session.selectOne("mhempSalempno", empno);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return Optional.ofNullable(empSalempno);
	}

	@Override
	public int newInsert(Sal sal) {
		int newInsert = 0;
		try {
			 //  saltotal = #{salBase}+#{salFood}+#{salBonus}+#{salNight}
			 int salTotal = sal.getSalBase()+sal.getSalFood()+sal.getSalNight()+sal.getSalBonus();
			 int taxSum = (int) (( sal.getSalBase()+sal.getSalBonus()+sal.getSalFood()+sal.getSalNight())*0.1);
			 int salFinal = salTotal - taxSum;
			 int tax = taxSum;
			 sal.setSalTotal(salTotal);
			 sal.setTaxSum(taxSum);
			 sal.setSalFinal(salFinal);
			 sal.setTax(tax);
			 System.out.println("Dao newInsert sal=>" + sal);
			 
			newInsert = session.insert("mhnewInsert", sal);
		} catch (Exception e) {
			 System.out.println("Dao newInsert Exception=>" + e);
		}
		return newInsert;
	}

	@Override
	public List<Sal> overtimeSalList(String salnum) {
		List<Sal> overtimeSalList = null;
		try {
		        
			overtimeSalList = session.selectList("mhovertimeSalList", salnum);
			System.out.println("overtimeSalList " + overtimeSalList);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return overtimeSalList;
	}

	
	@Override
	public int updateOvertimeSal(Sal sal) {
	//	public int updateOvertimeSal(Sal sal) {
		int updateOvertimeSal = 0;
		try {
			System.out.println("sal -> " + sal);
			session.selectOne("mhupdateProcOtSal",sal);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return updateOvertimeSal;
	}

	
//	@Override
//	public int updateOvertimeSal(Sal sal) {
//	//	public int updateOvertimeSal(Sal sal) {
//		int updateOvertimeSal = 0;
//		try {
//			 // saltotal = #{salBase}+#{salFood}+#{salBonus}+#{salNight}
//			 int salTotal = sal.getSalBase()+sal.getSalFood()+sal.getSalNight();
//			 int taxSum = (int) (( sal.getSalBase()+sal.getSalFood()+sal.getSalNight())*0.1);
//			 int salFinal = salTotal - taxSum;
//			 int tax = taxSum;
//			 sal.setSalTotal(salTotal);
//			 sal.setTaxSum(taxSum);
//			 sal.setSalFinal(salFinal);
//			 sal.setTax(tax);
//
//			 
//			updateOvertimeSal = session.update("mhupdateOvertimeSal",sal);
//			System.out.println("sal -> " + sal);
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
//		return updateOvertimeSal;
//	}

	
	@Override
	public Sal getSalModel(Sal sal) {
		 Sal sal2 = null;
		 try {
			 System.out.println("Dao getSalModel sal=>" + sal);
			 sal2 = session.selectOne("mhEmpSal", sal);
		} catch (Exception e) {
			System.out.println("Exception->"+e);
		}
		return sal2;
	}


}
