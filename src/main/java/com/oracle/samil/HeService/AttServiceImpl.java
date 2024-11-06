package com.oracle.samil.HeService;

import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.samil.Adto.LeaveDto;
import com.oracle.samil.Amodel.Attendance;
import com.oracle.samil.HeDao.AttDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttServiceImpl implements AttService {

	@Autowired
	private final AttDao ad;

	// 현재 로그인한 사원의 출퇴근 기록 조회
	@Override
	public List<Attendance> getMyAttRecords(Attendance attendance, String month, String startDateStr, String endDateStr, int page, int size) {
		int start = (page - 1) * size + 1;	// 현재페이지의 시작 번호 계산
		int end = start + size - 1;			// 현재페이지의 종료 번호 계산

		// 출석 객체에 페이징 및 검색 매개변수 설정
		attendance.setStart(start);
		attendance.setEnd(end);
		attendance.setMonth(month);
		attendance.setStartDate(startDateStr);
		attendance.setEndDate(endDateStr);
		List<Attendance> attRecords = ad.getMyAttRecords(attendance);
		return attRecords;
	}

	// 현재 로그인한 사원의 출퇴근 기록 총 개수 조회
	@Override
	public int getTotMyAttRecords(Attendance attendance, String month, String startDateStr, String endDateStr) {
		// 출석 객체에 검색 매개변수 설정
		attendance.setMonth(month);
		attendance.setStartDate(startDateStr);
		attendance.setEndDate(endDateStr);
		return ad.getTotMyAttRecords(attendance);
	}

	// 현재 로그인한 사원의 연차 상세 정보 조회
	@Override
	public List<LeaveDto> myLeaveList(int empno) {
		return ad.myLeaveList(empno);
	}

	// 부서별 출퇴근 기록 조회
	@Override
	public List<Attendance> getDeptAttRecords(Attendance attendance, String month, String startDateStr, String endDateStr) {
		// 출석 객체에 검색 매개변수 설정
		attendance.setMonth(month);
		attendance.setStartDate(startDateStr);
		attendance.setEndDate(endDateStr);
		List<Attendance> deptAttRecords = ad.getDeptAttRecords(attendance);
		return deptAttRecords;
	}

	// 부서별 연차 기록 조회
	@Override
	public List<LeaveDto> deptLeaveList(LeaveDto leaveDto) {
		return ad.deptLeaveList(leaveDto);
	}

	// 현재 날짜를 "yyyy/MM/dd" 형식 조회
	private String getCurrentWorkDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); // 원하는 형식으로 조정
		return sdf.format(new Date());
	}

	// 출근 시간 기록
	@Override
	public void insertClockIn(int empno, String workDate, String clockInTime, String clockOutTime) {
		Map<String, Object> params = new HashMap<>();
		params.put("empno", empno);
		params.put("workDate", workDate);
		params.put("clockIn", clockInTime);
		params.put("clockOut", clockOutTime); // 퇴근 시간 '00:00'
		ad.insertClockIn(params); // 출근 기록을 수행하는 메서드
	}

	// 퇴근 시간 기록
	@Override
	public void updateClockOut(int empno, String workDate) {
		Map<String, Object> params = new HashMap<>();
		params.put("empno", empno);
		params.put("workDate", getCurrentWorkDate()); // 현재 날짜 가져오기
		params.put("clockOut", workDate);
		ad.updateClockOut("updateClockOut", params);
	}

	// 초과근무 시간 조회
	@Override
	public void getOvertime() {
		ad.getOvertime();
	}

	// 출퇴근 시간을 기반으로 총 근무시간 계산
	@Override
	public Integer getTotWorkTime(String clockIn, String clockOut) {
		// clockIn과 clockOut을 시간으로 변환
		LocalTime inTime = LocalTime.parse(clockIn);
		LocalTime outTime = LocalTime.parse(clockOut);

		// 근무한 총 분 수 계산
		long totalMinutes = Duration.between(inTime, outTime).toMinutes();

		// 총 시간이 1시간이 안되면 0으로, 1시간 이상이면 시간 계산
		if (totalMinutes < 60) {
			return 0;
		}

		int hours = (int) (totalMinutes / 60);
		int minutes = (int) (totalMinutes % 60);

		// 30분 이상이면 시간 올림
		if (minutes >= 30) {
			hours += 1;
		}
		return hours - 1; // 하루 총 근로시간에서 1시간(휴게시간) 차감하여 반환
	}

	// 출근상태 기록
	@Override
	public void updateAttStatus() {
		ad.updateAttStatus();
	}

	// 출퇴근 기록 수정할 사원 정보 조회
	@Override
	public Attendance findById(Attendance attendance) {
		System.out.println("attService findById");
		System.out.println("attService findById empno: " + attendance.getEmpno());
		return ad.findById(attendance);
	}

	// 출퇴근 기록 수정
	@Override
	public int updateAtt(Attendance attendance) {
		System.out.println("attService updateAtt");
		int upAttResult = ad.updateAtt(attendance);
		return upAttResult;
	}
}
