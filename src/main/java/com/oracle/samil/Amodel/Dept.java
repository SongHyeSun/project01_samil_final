package com.oracle.samil.Amodel;

import lombok.Data;

@Data
public class Dept {
	public int 		deptno;			// 부서번호
	public String 	deptName;		// 부서명
	public int		higherdeptno; 	// 상위부서
	public int		manager;		// 부서장사원번호
	public String	depttel;		// 부서대표번호
	public int		deptdepth;		// 부서reflev
}
