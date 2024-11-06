package com.oracle.samil.HeDao;

import java.util.List;
import java.util.Map;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Adto.LeaveDto;
import com.oracle.samil.Amodel.Attendance;

import lombok.RequiredArgsConstructor;


@Repository
@RequiredArgsConstructor
public class AttDaoImpl implements AttDao {

	private final SqlSession session;

	// 현재 로그인한 사원의 출퇴근 기록 조회
	@Override
	public List<Attendance> getMyAttRecords(Attendance attendance) {
		List<Attendance> attRecords = session.selectList("heGetAttRecords", attendance);
		return attRecords;
	}

	// 현재 로그인한 사원의 출퇴근 기록 총 개수 조회
	@Override
	public int getTotMyAttRecords(Attendance attendance) {
		return session.selectOne("heGetTotMyAttRecords", attendance);
	}

	// 현재 로그인한 사원의 연차 상세 정보 조회
	@Override
	public List<LeaveDto> myLeaveList(int empno) {
		return session.selectList("heMyLeaveList", empno);
	}

	// 부서별 출퇴근 기록 조회
	@Override
	public List<Attendance> getDeptAttRecords(Attendance attendance) {
		List<Attendance> deptAttRecords = session.selectList("heGetDeptAttRecords", attendance);
		return deptAttRecords;
	}

	// 부서별 연차 기록 조회
	@Override
	public List<LeaveDto> deptLeaveList(LeaveDto leaveDto) {
		return session.selectList("heAdminDeptLeave", leaveDto);
	}

	// 출근 시간 기록
	@Override
	public void insertClockIn(Map<String, Object> params) {
		session.insert("heInsertClockIn", params);
	}

	// 퇴근 시간 기록
	@Override
	public void updateClockOut(String string, Map<String, Object> params) {
		session.update("heUpdateClockOut", params);
	}

	// 초과근무 시간 조회
	@Override
	public void getOvertime() {
		session.update("heGetOverTime");
	}

	// 출근상태 기록
	@Override
	public void updateAttStatus() {
		session.update("heUpdateAttStatus");
	}

	// 출퇴근 기록 수정할 사원 정보 조회
	@Override
	public Attendance findById(Attendance attendance) {
		Attendance findByAtt = null;
		System.out.println("attDao findById empno: " + attendance.getEmpno());
		try {
			findByAtt = session.selectOne("heFindById", attendance);
		} catch (Exception e) {
			System.out.println("attDao findById error : " + e.getMessage());
		}
		return findByAtt;
	}

	// 출퇴근 기록 수정
	@Override
	public int updateAtt(Attendance attendance) {
		System.out.println("attDaoImpl updateAtt");
		int upAttResult = 0;
		try {
			upAttResult = session.update("heUpdateAttendance", attendance);
			System.out.println("attDao updateAtt attendance: " + attendance);
		} catch (Exception e) {
			System.out.println("attDao updateAtt error : " + e.getMessage());
		}
		return upAttResult;
	}
}
