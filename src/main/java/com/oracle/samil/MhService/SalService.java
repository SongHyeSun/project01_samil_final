package com.oracle.samil.MhService;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Attendance;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.Sal;

import jakarta.transaction.Transactional;
@Transactional
public interface SalService {

	int totalSal();

	List<Sal> totalEmp(Sal Sal);

	List<Sal> salDList(Sal sal);

	Sal shemp(Sal Sal);

	List<Sal> setTotalEmp(Sal Sal);

	List<Sal> listSearchEmp(Sal Sal);

	String getSalDate();

	int updateSal(Sal Sal);

	List<Sal> mSalList(Sal Sal);

	String getSalNum();

	int submitDate(int day);

	int insertSal(int empno);

	Map<String, Object> joinList(int empno, String salNum);

	List<Sal> salNumList(String empno);

	int updateBank(String selectedBank, int empno, String account);

	List<Sal> listSearchEmpSet(Sal sal);

	Optional<Integer> empSalempno(int empno);

	int newInsert(Sal sal);

	List<Sal> overtimeSalList(String salnum);

	int updateOvertimeSal(Sal sal);

	Sal getSalModel(Sal sal);
}
