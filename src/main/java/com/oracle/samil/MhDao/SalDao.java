package com.oracle.samil.MhDao;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.oracle.samil.Amodel.Attendance;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.Sal;

public interface SalDao {


	int totalSal();

	List<Sal> totalEmp(Sal Sal);

	List<Sal> salDList(Sal sal);

	Sal shemp(Sal Sal);

	List<Sal> setTotalEmp(Sal Sal);

	List<Sal> empSearchList(Sal Sal);

	String findSalDate();

	int updateSal(Sal Sal);

	List<Sal> mSalList(Sal Sal);

	String getSalNum();

	int submitDate(int day);

	int insertSal(int empno);

	Map<String, Object> joinList(int empno, String salnum);

	List<Sal> salNumList(String empno);

	int updateBank(String selectedBank, int empno, String account);

	List<Sal> empSearchListSet(Sal sal);

	Optional<Integer> empSalempno(int empno);

	int newInsert(Sal sal);

	List<Sal> overtimeSalList(String salnum);
	
	int updateOvertimeSal(Sal sal);

	Sal getSalModel(Sal sal);

}
