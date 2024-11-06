package com.oracle.samil.TrDao;

import java.util.List;
import java.util.Map;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Dept;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.LoginInfo;

public interface EmpDao {

	Emp findEmpbyEmpno(String empno);

	LoginInfo findPassbyQuiz(int passQuiz, String passAnswer, String empno);

	List<Dept> selectDeptList();

	int insertEmp(Emp emp);

	List<Emp> selectEmpList();

	List<EmpDept> selectEmpDeptList();

	EmpDept findEmpDept(String emp1empno);

	int updateEmp(Emp emp);

	List<EmpDept> searchByKeyword(String keyword, String option);

	List<EmpDept> showDeptMember(int deptno);

	List<Emp> listdeptEmp(int deptno);

	int updateOwnEmp(Emp emp);

	List<Emp> selectEmpCaptainList();

	Dept findDeptByDeptno(int deptno);

	boolean validateUser(String empno, String password);

	int updateDept(Dept dept);

	int deleteDept(int deptno);

	int insertDept(Dept dept);

	int deleteEmp(int empno);

	// 캘린더 직원검색
	List<Map<String, Object>> autocomplete(Map<String, Object> paramMap);

	Emp searhEmpCal(int empno);

	String radomMenu(int nextInt);
}
