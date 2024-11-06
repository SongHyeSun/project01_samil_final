package com.oracle.samil.MhService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.samil.Amodel.Attendance;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.Sal;
import com.oracle.samil.MhDao.SalDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SalServiceI implements SalService {

	@Autowired
	private final SalDao sd;
	

	@Override
	public int totalSal() {
		int totSalCnt = sd.totalSal();
		return totSalCnt;
	}


	@Override
	public List<Sal> totalEmp(Sal Sal) {
		List<Sal> totSalCnt = null;
		totSalCnt = sd.totalEmp(Sal);
		return totSalCnt;
	}


	@Override
	public List<Sal> salDList(Sal sal) {
		List<Sal> salDList = null;
		salDList = sd.salDList(sal);
		return salDList;
	}

	@Override
	public Sal shemp(Sal Sal) {
		Sal shemp = null;
		shemp = sd.shemp(Sal);

		return shemp;
	}


	@Override
	public List<Sal> setTotalEmp(Sal Sal) {
		List<Sal>setTotalEmp =null;
		setTotalEmp = sd.setTotalEmp(Sal);
		return setTotalEmp;
	}


	@Override
	public List<Sal> listSearchEmp(Sal Sal) {
			List<Sal> listSearchEmp = null;
			listSearchEmp = sd.empSearchList(Sal);
			System.out.println("Service listSearch3 listSearchEmp.size()=>" + listSearchEmp.size());
			
			return listSearchEmp;
		}


	@Override
	public String getSalDate() {
		String getSalDate =  sd.findSalDate();
		System.out.println("service salDate->" +getSalDate);
		return getSalDate;
	}


	@Override
	public int updateSal(Sal Sal) {
		int salupdate = sd.updateSal(Sal);
		
		System.out.println("salupdate service->" +salupdate);
		
		return salupdate;
		
	}


	@Override
	public List<Sal> mSalList(Sal Sal) {
		List<Sal> mSalList = null;
		mSalList = sd.mSalList(Sal);
		return mSalList;
	}


	@Override
	public String getSalNum() {
		String getSalNum = sd.getSalNum();
		return getSalNum;
	}


	@Override
	public int submitDate(int day) {
		int submitDate = sd.submitDate(day);
		System.out.println("service day->"+ day);
		return submitDate;
	}


	@Override
	public int insertSal(int empno) {
		int insertSal = sd.insertSal(empno);
		return insertSal;
	}


	@Override
	public Map<String, Object> joinList(int empno, String salnum) {
        Map<String, Object> joinList = sd.joinList(empno, salnum);
		return joinList;
	}


	@Override
	public List<Sal> salNumList(String empno) {
		List<Sal> salNumList = sd.salNumList(empno);
		System.out.println("service salNumList->" +salNumList +empno);

		return salNumList;
	}


	@Override
	public int updateBank(String selectedBank, int empno, String account) {
		int updateBank = sd.updateBank(selectedBank, empno, account);
		return updateBank;
	}


	@Override
	public List<Sal> listSearchEmpSet(Sal sal) {
		List<Sal> listSearchEmpSet = null;
		listSearchEmpSet = sd.empSearchListSet(sal);
		
		return listSearchEmpSet;
	}


	@Override
	public Optional<Integer> empSalempno(int empno) {
		Optional<Integer> empSalempno = null;
		empSalempno = sd.empSalempno(empno);
		
		return empSalempno;
	}


	@Override
	public int newInsert(Sal sal) {
		int newInsert = 0;
		newInsert = sd.newInsert(sal);
		return newInsert;
		
		
	}


	@Override
	public List<Sal> overtimeSalList(String salnum) {
		List<Sal>overtimeSalList = null;
		overtimeSalList = sd.overtimeSalList(salnum);
		System.out.println("overtimeSalList"+overtimeSalList);
		return overtimeSalList;
	}


	@Override
	public int updateOvertimeSal(Sal sal) {
		int updateOvertimeSal = 0;
		updateOvertimeSal = sd.updateOvertimeSal(sal);
		
		return updateOvertimeSal;
	}


	@Override
	public Sal getSalModel(Sal sal) {
		System.out.println("service getSalModel sal->"+ sal);
		Sal sal2 = sd.getSalModel(sal);
		
		return sal2;
	}


}
