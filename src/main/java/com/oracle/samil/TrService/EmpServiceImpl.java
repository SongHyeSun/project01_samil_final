package com.oracle.samil.TrService;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Dept;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.LoginInfo;
import com.oracle.samil.TrDao.EmpDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmpServiceImpl implements EmpService {

	private final EmpDao ed;

	@Override
	public boolean validateUser(String empno, String password) {
		boolean result = ed.validateUser(empno,password);
		return result;
	}

	@Override
	public Emp findEmpbyEmpno(String empno) {
		System.out.println("findEmpbyEmpno->" + empno);
		Emp emp = ed.findEmpbyEmpno(empno);
		return emp;
	}

	@Override
	public LoginInfo findPassword(int passQuiz, String passAnswer, String empno) {
		System.out.println("findPassword->" + passAnswer);
		LoginInfo loginInfo = ed.findPassbyQuiz(passQuiz, passAnswer, empno);
		return loginInfo;
	}

	@Override
	public List<Dept> deptSelect() {
		System.out.println("EmpServiceImpl");
		List<Dept> deptList = ed.selectDeptList();
		return deptList;
	}

	@Override
	public int insertEmp(Emp emp) {
		int result = ed.insertEmp(emp);
		return result;
	}

	@Override
	public List<Emp> empSelect() {
		System.out.println("EmpServiceImpl");
		List<Emp> empList = ed.selectEmpList();
		return empList;
	}

	@Override
	public List<EmpDept> empdeptSelect() {
		System.out.println("EmpServiceImpl");
		List<EmpDept> empDeptList = ed.selectEmpDeptList();
		return empDeptList;
	}

	@Override
	public EmpDept findEmpDeptbyEmpno(String emp1empno) {
		System.out.println("EmpServiceimpl");
		EmpDept empDept = ed.findEmpDept(emp1empno);
		return empDept;
	}

	@Override
	public int updateEmp(Emp emp) {
		System.out.println("tr EmpServiceImpl updateEmp");
		int result = ed.updateEmp(emp);
		return 0;
	}

	@Override
	public List<EmpDept> searchByKeyword(String keyword,String option) {
		List<EmpDept> empDeptList = ed.searchByKeyword(keyword,option);
		return empDeptList;
	}

	@Override
	public List<EmpDept> showDeptMember(int deptno) {
		List<EmpDept> empdeptlist = ed.showDeptMember(deptno);
		return empdeptlist;
	}

	@Override
	public List<Emp> listdeptEmp(int deptno) {
		List<Emp> empDeptList = null;
		System.out.println("EmpServiceImpl listdeptEmp Start...");
		empDeptList = ed.listdeptEmp(deptno);

		System.out.println("EmpServiceImpl listdeptEmp After...");
		return empDeptList;
	}

	@Override
	public int updateOwnEmp(Emp emp) {
		System.out.println("tr EmpServiceImpl updateOwnEmp");
		int result = ed.updateOwnEmp(emp);
		return result;
	}

	@Override
	public List<Emp> empCaptainSelect() {
		System.out.println("EmpServiceImpl");
		List<Emp> empList = ed.selectEmpCaptainList();
		return empList;
	}

	@Override
	public Dept findDeptByDeptno(int deptno) {
		Dept dept = ed.findDeptByDeptno(deptno);
		return dept;
	}

	@Override
	public int updateDept(Dept dept) {
		int result= ed.updateDept(dept);
		return result;
	}

	@Override
	public int deleteDept(int deptno) {
		int result= ed.deleteDept(deptno);
		return result;
	}

	@Override
	public void insertDept(Dept dept) {
		int result= ed.insertDept(dept);
	}

	@Override
	public void deleteEmp(int empno) {
		int result= ed.deleteEmp(empno);
		
	}

	@Override
	public List<Map<String, Object>> autocomplete(Map<String, Object> paramMap) {
		System.out.println("EmpServiceImpl searchList start...");
		return ed.autocomplete(paramMap);
	}

	@Override
	public Emp searchEmpCal(int empno) {
		System.out.println("EmpServiceImpl searchEmpCal Start...");
		Emp empp = ed.searhEmpCal(empno);
		System.out.println("EmpServiceImpl searchEmpCal After...");
		return empp;
	}
	
	@Override
    public String radomMenu(int nextInt) {
        String menu= ed.radomMenu(nextInt);
        return menu;


    }
}
