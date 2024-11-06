package com.oracle.samil.TrDao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Dept;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.LoginInfo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class EmpDaoImpl implements EmpDao {

	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;

	@Override
	public Emp findEmpbyEmpno(String empno) {
		System.out.println("asd" + empno);
		System.out.println("findEmpbyEmpno start..");
		Emp emp = new Emp();
		try {
			System.out.println("findEmpbyEmpno ->" + empno);
			emp = session.selectOne("trEmpSelect", empno);

		} catch (Exception e) {
			System.out.println(" findEmpbyEmpno->" + e.getMessage());
		}
		return emp;
	}

	@Override
	public LoginInfo findPassbyQuiz(int passQuiz, String passAnswer, String empno) {
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.setPassAnswer(passAnswer);
		loginInfo.setPassQuiz(passQuiz);
		loginInfo.setEmpno(Integer.parseInt(empno));
		System.out.println("EmpDao impl findPassbyQuiz->" + passAnswer);
		try {
			loginInfo = session.selectOne("trFindPass", loginInfo);
		} catch (Exception e) {
			System.out.println("EmpDao impl findPassbyQuiz->" + e.getMessage());
		}

		return loginInfo;
	}

	@Override
	public List<Dept> selectDeptList() {
		List<Dept> deptList = null;
		System.out.println("DeptDaoImpl deptSelect Start...");
		try {
			deptList = session.selectList("trSelectDept");
		} catch (Exception e) {
			System.out.println("DeptDaoImpl deptSelect Exception->" + e.getMessage());
		}
		return deptList;
	}

	@Override
	public int insertEmp(Emp emp) {
		int result = 0;
		System.out.println("EmpDaoImpl insert Start...wwww");
		try {
			result = session.insert("trInsertEmp", emp);
			result = session.insert("trInsertLoginInfo", emp);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl insert Exception->" + e.getMessage());
		}
		return result;
	}

	@Override
	public List<Emp> selectEmpList() {
		List<Emp> empList = null;
		System.out.println("DeptDaoImpl empSelect Start...");
		try {
			empList = session.selectList("trSelectEmp");
		} catch (Exception e) {
			System.out.println("DeptDaoImpl empSelect Exception->" + e.getMessage());
		}
		return empList;
	}

	@Override
	public List<EmpDept> selectEmpDeptList() {
		List<EmpDept> empDeptList = null;
		System.out.println("DeptDaoImpl empDeptSelect Start...");
		try {
			empDeptList = session.selectList("trSelectEmpDept");
		} catch (Exception e) {
			System.out.println("DeptDaoImpl empDeptSelect Exception->" + e.getMessage());
		}
		return empDeptList;
	}

	@Override
	public EmpDept findEmpDept(String emp1empno) {
		EmpDept empDept = null;
		try {
			empDept=session.selectOne("trFindEmpDept",emp1empno);
		} catch (Exception e) {
			System.out.println("findEmpDept->"+e.getMessage());
		}
		
		return empDept;
	}

	@Override
	public int updateEmp(Emp emp) {
		int result = 0;
		System.out.println("EmpDaoImpl update Start...");
		try {
			result = session.update("trUpdateEmp", emp);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl update Exception->" + e.getMessage());
		}
		return result;
	}

	@Override
	public List<EmpDept> searchByKeyword(String keyword,String option) {
		List<EmpDept> empDeptList = null;
		System.out.println("searchByKeywort Start..."+keyword);
		try {
			empDeptList = session.selectList("trSearchEmpByKeyword",Map.of("keyword", keyword, "option", option) );
		} catch (Exception e) {
			System.out.println("EmpDaoImpl searchByKeywor Exception->" + e.getMessage());
		}
		return empDeptList;
	}

	@Override
	public List<EmpDept> showDeptMember(int deptno) {
		List<EmpDept> empDeptList = null;
		System.out.println("showDeptMember Start..."+deptno);
		try {
			empDeptList = session.selectList("trShowDeptMember", deptno);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl searchByKeywor Exception->" + e.getMessage());
		}
		return empDeptList;
	}


	@Override
	public List<Emp> listdeptEmp(int deptno) {
		List<Emp> empDeptlist = null;
		System.out.println("EmpDaoImpl listdeptEmp Start...");

		try {
			empDeptlist = session.selectList("hsEmpDeptListAll",deptno);
			System.out.println("EmpDaoImpl listdeptEmp empDeptlist.size()-> "+empDeptlist.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("EmpDaoImpl listdeptEmp e.getMessage()-> "+e.getMessage());
		}
		return empDeptlist;
	}

	@Override
	public int updateOwnEmp(Emp emp) {
		int result = 0;
		System.out.println("EmpDaoImpl UpdateOwnEmp Start...");
		System.out.println(emp.getEmail());
		try {
			result = session.update("trUpdateOwnEmp", emp);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl Ownupdate Exception->" + e.getMessage());
		}
		return result;
	}

	@Override
	public List<Emp> selectEmpCaptainList() {
		List<Emp> emplist = null;
		System.out.println("EmpDaoImpl listdeptEmp Start...");

		try {
			emplist = session.selectList("trSelectEmpCaptainList");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("EmpDaoImpl listdeptEmp e.getMessage()-> "+e.getMessage());
		}
		return emplist;
	}

	@Override
	public Dept findDeptByDeptno(int deptno) {
		Dept dept=null;
		try {
			dept=session.selectOne("trfindDeptByDeptno",deptno);
		} catch (Exception e) {
			System.out.println("EmpDaoImpl listdeptEmp e.getMessage()-> "+e.getMessage());
		}
		return dept;
	}

	@Override
	public boolean validateUser(String empno, String password) {
		boolean result = false;
		try {
			String matchedResult=session.selectOne("trPasswordMatch",Map.of("password", password, "empno", empno));
			if(matchedResult != null) {
				System.out.println("안태랑1"+matchedResult);
				result = true;
				System.out.println("안태랑2"+result );
			}
		
		} catch (Exception e) {
			System.out.println(" validateUser "+e.getMessage());
		}
		
		return result;
	}

	@Override
	public int updateDept(Dept dept) {
		try {
			session.update("trDeptUpdate",dept);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return 0;
	}

	@Override
	public int deleteDept(int deptno) {
		int result = 0;
		TransactionStatus txStatus= transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			session.update("trClearDeptFromEmp",deptno);
			session.update("trUpperDeptUpdate",deptno);
			session.delete("trDeleteDept",deptno);
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			transactionManager.rollback(txStatus);
		}
		
		
		return result;
	}

	@Override
	public int insertDept(Dept dept) {
		int result = 0;
		try {
			session.insert("trInsertDept",dept);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	@Override
	public int deleteEmp(int empno) {
		int result = 0;
		try {
			result = session.update("trDeleteEmp",empno);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> autocomplete(Map<String, Object> paramMap) {
		List<Map<String, Object>> emplist = null;
		System.out.println("EmpDaoImpl autocomplete start...");
		
		try {
			emplist = session.selectList("hsSelListAllEmpDept", paramMap);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return emplist;
	}

	@Override
	public Emp searhEmpCal(int empno) {
		System.out.println("EmpDaoImpl searhEmpCal start...");
		Emp empp = null;
		try {
			empp = session.selectOne("hsEmpList", empno);
			System.out.println("EmpDaoImpl searhEmpCal empp-> "+empp);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return empp;
	}
	
	  @Override
	    public String radomMenu(int nextInt) {
	        String menu = "";
	        try {
	            menu=session.selectOne("trRandomMenu", nextInt);
	        } catch (Exception e) {
	            // TODO: handle exception
	        }
	        return menu;
	    }
}
