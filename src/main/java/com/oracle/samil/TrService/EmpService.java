package com.oracle.samil.TrService;

import java.util.List;
import java.util.Map;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Dept;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.LoginInfo;

public interface EmpService {

	boolean validateUser(String empno, String password);

	Emp findEmpbyEmpno(String empno);

	LoginInfo findPassword(int passQuiz, String passAnswer, String empno);

	List<Dept> deptSelect();

	int insertEmp(Emp emp);

	List<Emp> empSelect();

	List<EmpDept> empdeptSelect();

	EmpDept findEmpDeptbyEmpno(String emp1empno);

	int updateEmp(Emp emp);

	List<EmpDept> searchByKeyword(String keyword, String option);

	List<EmpDept> showDeptMember(int deptno);

	List<Emp> listdeptEmp(int deptno);

	int updateOwnEmp(Emp emp);

	List<Emp> empCaptainSelect();

	Dept findDeptByDeptno(int deptno);

	int updateDept(Dept dept);

	int deleteDept(int deptno);

	void insertDept(Dept dept);

	void deleteEmp(int empno);

	// 캘린더 직원검색
	List<Map<String, Object>> autocomplete(Map<String, Object> paramMap);

	Emp searchEmpCal(int empno);

	String radomMenu(int nextInt);
}
