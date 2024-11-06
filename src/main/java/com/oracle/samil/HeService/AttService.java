package com.oracle.samil.HeService;

import java.util.List;

import com.oracle.samil.Adto.LeaveDto;
import com.oracle.samil.Amodel.Attendance;

public interface AttService {
	// 현재 로그인한 사원의 출퇴근 기록 조회
	List<Attendance>	getMyAttRecords(Attendance attendance, String month, String startDateStr, String endDateStr, int page, int size);

	// 현재 로그인한 사원의 출퇴근 기록 총 개수 조회
	int					getTotMyAttRecords(Attendance attendance, String month, String startDateStr, String endDateStr);

	// 현재 로그인한 사원의 연차 상세 정보 조회
	List<LeaveDto>		myLeaveList(int empno);

	// 부서별 출퇴근 기록 조회
	List<Attendance>	getDeptAttRecords(Attendance attendance, String period, String startDateStr, String endDateStr);

	// 부서별 연차 기록 조회
	List<LeaveDto>		deptLeaveList(LeaveDto leaveDto);

	// 출근 시간 기록
	void				insertClockIn(int empno, String workDate, String clockInTime, String clockOutTime);

	// 퇴근 시간 기록
	void				updateClockOut(int empno, String workDate);

	// 초과근무 시간 조회
	void				getOvertime();

	// 출퇴근 시간을 기반으로 총 근무시간 계산
	Integer				getTotWorkTime(String clockIn, String clockOut);

	// 출근상태 기록
	void				updateAttStatus();

	// 출퇴근 기록 수정할 사원 정보 조회
	Attendance			findById(Attendance attendance);

	// 출퇴근 기록 수정
	int					updateAtt(Attendance attendance);
}
