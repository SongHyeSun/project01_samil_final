package com.oracle.samil.HeDao;

import java.util.List;
import java.util.Map;

import com.oracle.samil.Adto.LeaveDto;
import com.oracle.samil.Amodel.Attendance;

public interface AttDao {
	// 현재 로그인한 사원의 출퇴근 기록 조회
	List<Attendance>	getMyAttRecords(Attendance attendance);

	// 현재 로그인한 사원의 출퇴근 기록 총 개수 조회
	int					getTotMyAttRecords(Attendance attendance);

	// 현재 로그인한 사원의 연차 상세 정보 조회
	List<LeaveDto>		myLeaveList(int empno);

	// 부서별 출퇴근 기록 조회
	List<Attendance>	getDeptAttRecords(Attendance attendance);

	// 부서별 연차 기록 조회
	List<LeaveDto>		deptLeaveList(LeaveDto leaveDto);

	// 출근 시간 기록
	void				insertClockIn(Map<String, Object> params);

	// 퇴근 시간 기록
	void				updateClockOut(String string, Map<String, Object> params);

	// 초과근무 시간 조회
	void				getOvertime();

	// 출근 상태 기록
	void				updateAttStatus();

	// 출퇴근 기록 수정할 사원 정보 조회
	Attendance			findById(Attendance attendance);

	// 출퇴근 기록 수정
	int					updateAtt(Attendance attendance);
}
