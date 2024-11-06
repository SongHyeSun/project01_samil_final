package com.oracle.samil.Acontroller;


import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oracle.samil.Adto.ApprovalDto;
import com.oracle.samil.Adto.LeaveDto;
import com.oracle.samil.Amodel.Attendance;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.HeService.AttService;
import com.oracle.samil.SeService.ApprovalService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@Controller
@RequestMapping(value="/he")
@RequiredArgsConstructor
public class HeAttController {

	@Autowired
	private final AttService as;

	@Autowired
	private final ApprovalService apps;

	@GetMapping(value = "/att")
	public String att(Attendance attendance, HttpSession session, Model model,
					  @RequestParam(value = "month", required = false) String month,
					  @RequestParam(value = "startDate", required = false) String startDateStr,
					  @RequestParam(value = "endDate", required = false) String endDateStr,
					  @RequestParam(value = "page", defaultValue = "1") int page,
					  @RequestParam(value = "size", defaultValue = "10") int size) {

		// 세션에서 현재 로그인한 사원 정보를 가져옴
		Emp emp = (Emp) session.getAttribute("emp");

		// 시작일과 종료일을 LocalDate로 변환하는 이유
		 // 형식 안전성: 날짜 관련 오류를 줄여줌
		 // 편리한 계산: 날짜 간의 차이 계산과 더하기/빼기가 쉬움
		 // 유효성 검증: 잘못된 날짜 생성 방지
		 // 가독성 향상: 코드가 더 명확하고 직관적
		 // 시간대 독립성: 시간대에 구애받지 않고 날짜만 필요할 때 적합
		LocalDate startDate = (startDateStr != null && !startDateStr.isEmpty()) ? LocalDate.parse(startDateStr) : null;
		LocalDate endDate = (endDateStr != null && !endDateStr.isEmpty()) ? LocalDate.parse(endDateStr) : null;

		// 날짜 형식 설정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String formattedStartDate = startDate != null ? startDate.format(formatter) : null;
		String formattedEndDate = endDate != null ? endDate.format(formatter) : null;

		// 올해의 첫날
		LocalDate startOfYear = LocalDate.of(LocalDate.now().getYear(), 1, 1);

		// 현재 월
		int currentMonth = LocalDate.now().getMonthValue();

		// 이번달 1일
		LocalDate firstDayOfCurrentMonth = LocalDate.now().withDayOfMonth(1);

		// 현재 날짜
		LocalDate lastDayOfCurrentMonth = LocalDate.now();

		// Attendance 객체에 사원 번호 설정
		attendance.setEmpno(emp.getEmpno());
		as.getOvertime();		// 초과 근무 조회
		as.updateAttStatus();	// 출석 상태 업데이트

		// 기본 날짜 설정: 시작일과 종료일이 비어있는 경우 이번 달의 1일부터 현재 날짜로 설정
		if (month == null || month.isEmpty()) {
			if ((startDateStr == null || startDateStr.isEmpty()) &&
				(attendance.getStartDate() == null || attendance.getStartDate().isEmpty())) {
				 formattedStartDate = firstDayOfCurrentMonth.format(DateTimeFormatter.ofPattern("yyyyMMdd")); // 당월 1일
				 attendance.setStartDate(formattedStartDate);
			}
			if ((endDateStr == null || endDateStr.isEmpty()) &&
				(attendance.getEndDate() == null || attendance.getEndDate().isEmpty())) {
				 formattedEndDate = lastDayOfCurrentMonth.format(DateTimeFormatter.ofPattern("yyyyMMdd")); // 오늘 날짜
				 attendance.setEndDate(formattedEndDate);
			}
		}

		// 출석 기록 조회
		List<Attendance> attRecords = as.getMyAttRecords(attendance, month, formattedStartDate, formattedEndDate, page, size);

		// 총 기록 수 조회
		int totalRecords = as.getTotMyAttRecords(attendance, month, formattedStartDate, formattedEndDate);

		// 총 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalRecords / size);

		// 종료일만 입력된 경우 : 시작일을 올해 1월 1일로 설정
		if (startDate == null && endDate != null) {
			attendance.setStartDate(startOfYear.format(DateTimeFormatter.ofPattern("yyyyMMdd"))); // 올해의 첫 기록
			attendance.setEndDate(formattedEndDate); // 입력된 종료일
		} else if (startDate != null && endDate != null) {
			// startDate와 endDate가 모두 입력된 경우
			attendance.setStartDate(formattedStartDate); // 기존 입력된 시작일 사용
			attendance.setEndDate(formattedEndDate);	 // 기존 입력된 종료일 사용
		}

		// 쿼리 호출 전에 시작일과 종료일 업데이트
		formattedEndDate = attendance.getStartDate();
		formattedEndDate = attendance.getEndDate();

		// 월별 조회
		if (month != null && !month.isEmpty()) {
			int selectedMonth = Integer.parseInt(month.replace("월", ""));

			// 현재 월과 비교하여 작년 12월을 조회
			if (selectedMonth == 12 && currentMonth != 12) {
				// 작년 12월 기록 조회
				attRecords = as.getMyAttRecords(attendance, "12", null, null, page, size);
			} else {
				// 선택된 월의 기록 조회
				attRecords = as.getMyAttRecords(attendance,  String.format("%02d", selectedMonth), formattedStartDate, formattedEndDate, page, size);
			}
		} else {
			// 선택된 날짜 범위에 맞는 기록 조회
			attRecords = as.getMyAttRecords(attendance, null, formattedStartDate, formattedEndDate, page, size);
		}

		// 본인 연차 기록 조회
		List<LeaveDto> myLeave = as.myLeaveList(emp.getEmpno());

		// 각 Attendance 객체에 총 근무 시간 계산
		for (Attendance att : attRecords) {
			Integer totalWorkTime = as.getTotWorkTime(att.getClockIn(), att.getClockOut());
			att.setTotWorkTime(totalWorkTime); // 총 근무 시간 설정
		}

		model.addAttribute("attRecords", attRecords);	// 조회된 출석 기록
		model.addAttribute("totalPages", totalPages);	// 전체 페이지 수
		model.addAttribute("currentPage", page);		// 현재 페이지 번호
		model.addAttribute("pageSize", size);			// 페이지 크기
		model.addAttribute("myLeave", myLeave);			// 조회된 연차 정보
		System.out.println("검색 조건 - 출근 상태: " + attendance.getAttStatus());
		System.out.println("Selected Month: " + month);
		System.out.println("name: " + attendance.getName());
		System.out.println("attStatus: " + attendance.getAttStatus());
		System.out.println("startDate: " + startDateStr);
		System.out.println("endDate: " + endDateStr);
		System.out.println("조회된 근무 기록 수: " + attRecords.size());
		return "he/att";
	}

	@GetMapping(value = "/adminAtt")
	public String adminAtt (Attendance attendance, LeaveDto leaveDto, HttpSession session, Model model,
							@RequestParam(value = "empInfo", required = false) String empInfo,
							@RequestParam(value = "searchContent", required = false) String searchContent,
							@RequestParam(value = "searchEmpDeptInfo", required = false) String searchEmpDeptInfo,
							@RequestParam(value = "LeaveSearchContent", required = false) String LeaveSearchContent,
							@RequestParam(value = "month", required = false) String month,
							@RequestParam(value = "startDate", required = false) String startDateStr,
							@RequestParam(value = "endDate", required = false) String endDateStr,
							@RequestParam(value = "page", defaultValue = "1") int page,
							@RequestParam(value = "size", defaultValue = "10") int size,
							@RequestParam(value = "leavePage", defaultValue = "1") int leavePage,
							@RequestParam(value = "leaveSize", defaultValue = "10") int leaveSize) {

		// 세션에서 현재 로그인한 사원 (관리자) 정보를 가져옴
		Emp emp = (Emp) session.getAttribute("emp");

		// 문자열로 받은 날짜를 LocalDate로 변환
		LocalDate startDate = (startDateStr != null && !startDateStr.isEmpty()) ? LocalDate.parse(startDateStr) : null;
		LocalDate endDate = (endDateStr != null && !endDateStr.isEmpty()) ? LocalDate.parse(endDateStr) : null;

		// 날자 형식 설정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String formattedStartDate = startDate != null ? startDate.format(formatter) : null;
		String formattedEndDate = endDate != null ? endDate.format(formatter) : null;

		// 올해의 첫날
		LocalDate startOfYear = LocalDate.of(LocalDate.now().getYear(), 1, 1);

		// 현재 날짜
		LocalDate currentDate = LocalDate.now();

		// 이번 달의 첫 날과 현재 날짜 설정
		LocalDate firstDayOfCurrentMonth = LocalDate.now().withDayOfMonth(1);
		LocalDate lastDayOfCurrentMonth = LocalDate.now();

		// 출석 정보 객체 초기화
		attendance.setEmpno(emp.getEmpno());
		attendance.setDeptno(emp.getDeptno());
		attendance.setEditWho(emp.getEmpno());
		attendance.setAdmin(emp.getAdmin());

		// 연차 정보 객체 초기화
		leaveDto.setDeptno(emp.getDeptno());
		leaveDto.setAdmin(emp.getAdmin());

		// 초과 근무 및 출석 상태 업데이트
		as.getOvertime();
		as.updateAttStatus();

		// 검색 조건이 비어 있는지 확인
		boolean isSearchContentEmpty = (searchContent == null || searchContent.isEmpty());
		boolean isEmpInfoEmpty = (empInfo == null || empInfo.isEmpty());

		// 기본 날짜 설정 : 이번 달의 1일부터 현재 날짜로 설정
		if (isSearchContentEmpty && isEmpInfoEmpty) {
			if ((startDateStr == null || startDateStr.isEmpty()) &&
				(attendance.getStartDate() == null || attendance.getStartDate().isEmpty())) {
				 formattedStartDate = firstDayOfCurrentMonth.format(DateTimeFormatter.ofPattern("yyyyMMdd")); // 당월 1일
				 attendance.setStartDate(formattedStartDate);
			}
			if ((endDateStr == null || endDateStr.isEmpty()) &&
				(attendance.getEndDate() == null || attendance.getEndDate().isEmpty())) {
				 formattedEndDate = lastDayOfCurrentMonth.format(DateTimeFormatter.ofPattern("yyyyMMdd")); // 오늘 날짜
				 attendance.setEndDate(formattedEndDate);
			}
		}

		// 출석 기록 조회 위한 리스트 초기화
		List<Attendance> deptAttRecords = new ArrayList<>();

		// 종료일만 입력된 경우
		if (startDate == null && endDate != null) {
			attendance.setStartDate(startOfYear.format(DateTimeFormatter.ofPattern("yyyyMMdd"))); // 올해의 첫 기록
			attendance.setEndDate(formattedEndDate);	 // 입력된 종료일
		} else if (startDate != null && endDate != null) {
			// 시작일과 종료일 모두 입력된 경우
			attendance.setStartDate(formattedStartDate); // 기존 입력된 시작일 사용
			attendance.setEndDate(formattedEndDate);	 // 기존 입력된 종료일 사용
		}

		// 쿼리 호출 전에 시작일과 종료일 업데이트
		formattedStartDate = attendance.getStartDate();
		formattedEndDate = attendance.getEndDate();

		// 출석 기록 조회: 관리자 권한이 170일 경우 모든 부서의 기록 조회
		if (attendance.getAdmin() == 170) {
			deptAttRecords = as.getDeptAttRecords(attendance, null, formattedStartDate, formattedEndDate);
		} else {
			// 로그인한 사원의 부서번호와 일치하는 해당 부서의 기록 조회
			attendance.setDeptno(emp.getDeptno());
			deptAttRecords = as.getDeptAttRecords(attendance, month, formattedStartDate, formattedEndDate);
		}

		// 검색 필터링 : 날짜 확인 및 설정
		if (searchContent != null && !searchContent.isEmpty()) {
			// 시작 날짜가 설정되지 않았거나 비어있으면, 올해의 첫 날(1월 1일)로 설정
			if (attendance.getStartDate() == null || attendance.getStartDate().isEmpty()) {
				attendance.setStartDate(LocalDate.of(LocalDate.now().getYear(), 1, 1).format(DateTimeFormatter.ofPattern("yyyyMMdd")));
			}
			// 종료 날짜가 설정되지 않았거나 비어있으면, 오늘 날짜로 설정
			if (attendance.getEndDate() == null || attendance.getEndDate().isEmpty()) {
				attendance.setEndDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd")));
			}

			// 출석 기록 필터링
			deptAttRecords = deptAttRecords.stream()
										   .filter(att -> att.getWorkDate().compareTo(attendance.getStartDate()) >= 0 && 
										   				  att.getWorkDate().compareTo(attendance.getEndDate()) <= 0)
										   					 .collect(Collectors.toList());
		// 사원명 검색
		if ("사원명".equals(empInfo)) {
			attendance.setName(searchContent);
			List<Attendance> filteredDeptAttRecords = deptAttRecords.stream()
																	.filter(att -> att.getName().contains(searchContent))
																	.collect(Collectors.toList());
			if (filteredDeptAttRecords.isEmpty()) {
				model.addAttribute("error", "해당 사원은 없습니다."); // 오류 메시지를 모델에 추가
				deptAttRecords = new ArrayList<>();	// 결과를 비우기
			} else {
					deptAttRecords = filteredDeptAttRecords; // 필터링된 결과로 업데이트
			}
		// 부서명 검색
		} else if ("부서명".equals(empInfo)) {
					attendance.setDeptName(searchContent);
					List<Attendance> filteredDeptAttRecords = deptAttRecords.stream()
																			.filter(att -> att.getDeptName().contains(searchContent))
																			.collect(Collectors.toList());
			if (filteredDeptAttRecords.isEmpty()) {
				model.addAttribute("error", "해당 부서는 없습니다.");
				deptAttRecords = new ArrayList<>();
			} else {
					deptAttRecords = filteredDeptAttRecords;
			}
		// 출근상태 검색
		} else if ("출근상태".equals(empInfo)) {
					List<Attendance> filteredDeptAttRecords = deptAttRecords.stream()
																			.filter(att -> att.getAttStatusString().contains(searchContent))
																			.collect(Collectors.toList());
			if (filteredDeptAttRecords.isEmpty()) {
				model.addAttribute("error", "해당 출근상태의 기록은 없습니다.");
				deptAttRecords = new ArrayList<>(); // 결과를 비우기
			} else {
				deptAttRecords = filteredDeptAttRecords;
			}
		}
	}

		// 월별 조회
		if (month != null && !month.isEmpty()) {
			int selectedMonth = Integer.parseInt(month.replace("월", ""));
			LocalDate firstDayOfSelectedMonth;
			LocalDate lastDayOfSelectedMonth;

			// 이번 달
			int currentMonth = LocalDate.now().getMonthValue();

			// 월별 날짜 설정
			if (selectedMonth == 12 && currentMonth == 12) {
				// 검색하는 시기가 12월이면 당해 12월 기록 조회
				firstDayOfSelectedMonth = LocalDate.of(currentDate.getYear(), selectedMonth, 1);
			} else if (selectedMonth == 12) {
				// 검색하는 시기가 12월이 아닐 경우, 작년 12월 기록 조회
				firstDayOfSelectedMonth = LocalDate.of(currentDate.getYear() - 1, selectedMonth, 1);
			} else {
				// 다른 월은 당해 연도 기록 조회
				firstDayOfSelectedMonth = LocalDate.of(currentDate.getYear(), selectedMonth, 1);
			}

			// 선택한 월의 마지막 날짜 계산
			lastDayOfSelectedMonth = firstDayOfSelectedMonth.withDayOfMonth(firstDayOfSelectedMonth.lengthOfMonth());

			// 해당 월의 출석 기록 조회
			deptAttRecords = as.getDeptAttRecords(attendance, String.format("%02d", selectedMonth),
												  firstDayOfSelectedMonth.format(DateTimeFormatter.ofPattern("yyyyMMdd")),
												  lastDayOfSelectedMonth.format(DateTimeFormatter.ofPattern("yyyyMMdd")));
		}

		// 전체 기록 수 및 페이지 수 계산
		int totDeptAttRecords = deptAttRecords.size();
		int totDeptAttPages = (int) Math.ceil((double) totDeptAttRecords / size);
		
		// 현재 페이지 유효성 검사
		if (page < 1) {
			page = 1;
		} else if (page > totDeptAttPages) {
			page = totDeptAttPages;
		}

		// 페이징 처리
		int start = (page - 1) * size;	// 현재 페이지의 첫번째 인덱스
		int end = Math.min(start + size, totDeptAttRecords); // 현재 페이지의 마지막 인덱스

		List<Attendance> pagedRecords; // 출근 페이지 기록 저장

		// 데이터 범위 검사
		if (totDeptAttRecords == 0) {
			pagedRecords = new ArrayList<>(); // 빈 리스트로 초기화
		} else {
			if (start >= totDeptAttRecords) {
				start = 0; // 첫 페이지로 리셋
				page = 1;
			}
			end = Math.min(start + size, totDeptAttRecords);	// end 계산
			pagedRecords = deptAttRecords.subList(start, end);	// 현재 페이지의 데이터만 슬라이스
		}


		// 부서 연차 기록 조회
		List<LeaveDto> deptLeave = as.deptLeaveList(leaveDto);

		// 부서 연차 검색 필터링
		if ("사원".equals(searchEmpDeptInfo) && LeaveSearchContent != null && !LeaveSearchContent.isEmpty()) {
			List<LeaveDto> filteredDeptLeave = deptLeave.stream()
														.filter(leave -> leave.getName().contains(LeaveSearchContent))
														.collect(Collectors.toList());
			if (filteredDeptLeave.isEmpty()) {
				model.addAttribute("error", "해당 사원은 없습니다."); // 오류 메시지를 모델에 추가
			} else {
				deptLeave = filteredDeptLeave; // 필터링된 결과로 업데이트
			}
		} else if ("부서".equals(searchEmpDeptInfo) && LeaveSearchContent != null && !LeaveSearchContent.isEmpty()) {
			List<LeaveDto> filteredDeptLeave = deptLeave.stream()
														.filter(leave -> leave.getDeptName().contains(LeaveSearchContent))
														.collect(Collectors.toList());
			if (filteredDeptLeave.isEmpty()) {
				model.addAttribute("error", "해당 부서는 없습니다.");
				} else {
					deptLeave = filteredDeptLeave;
				}
		} else if ("결재상태".equals(searchEmpDeptInfo) && LeaveSearchContent != null && !LeaveSearchContent.isEmpty()) {
			List<LeaveDto> filteredDeptLeave = deptLeave.stream()
														.filter(leave -> leave.getApprovalStatus().contains(LeaveSearchContent))
														.collect(Collectors.toList());
			if (filteredDeptLeave.isEmpty()) {
				model.addAttribute("error", "유효하지 않은 결재상태입니다.");
				deptLeave = new ArrayList<>();
				} else {
					deptLeave = filteredDeptLeave;
				}
		}

		// 전체 연차 기록 계산
		int totDeptLeaveRecords = deptLeave.size();


		// 일일 총 근무 시간 계산
		for (Attendance att : deptAttRecords) {
			 Integer totalWorkTime = as.getTotWorkTime(att.getClockIn(), att.getClockOut());
			 att.setTotWorkTime(totalWorkTime);
		}

		model.addAttribute("deptAttRecords", pagedRecords);	// 조회된 부서 출석 정보
		model.addAttribute("totalPages", totDeptAttPages);	// 부서 출석 기록 전체 페이지 수
		model.addAttribute("currentPage", page);			// 부서 출석 현재 페이지 번호
		model.addAttribute("pageSize", size);				// 부서 출석 페이지 크기
		model.addAttribute("deptLeave", deptLeave);						// 조회된 부서 연차 정보
		model.addAttribute("totalLeaveRecords", totDeptLeaveRecords);	// 전체 연차 기록 수
		System.out.println("deptno: " + attendance.getDeptno());
		System.out.println("Admin: " + attendance.getAdmin());
		System.out.println("EditWho: " + attendance.getEditWho());
		System.out.println("EditWhoName: " + attendance.getEditWhoName());
		System.out.println("검색 조건 - 사원명: " + attendance.getName());
		System.out.println("검색 조건 - 출근 상태: " + attendance.getAttStatus());
		System.out.println("Selected Month: " + month);
		System.out.println("name: " + attendance.getName());
		System.out.println("attStatus: " + attendance.getAttStatus());
		System.out.println("startDate: " + startDateStr);
		System.out.println("endDate: " + endDateStr);
		System.out.println("Query - Start Date: " + attendance.getStartDate());
		System.out.println("Query - End Date: " + attendance.getEndDate());
		System.out.println("조회된 근무 기록 수: " + deptAttRecords.size());
		return "he/adminAtt";
	}

	// 출근 시간 기록
	@PostMapping("/att/clockIn")
	@ResponseBody
	public String clockIn(HttpSession session) {
		// 세션에서 로그인된 사원 (출근 시간 기록할 사원) 정보 가져오기
		Emp emp = (Emp) session.getAttribute("emp");

		String currentTime = getCurrentTime();	// 현재 시간 가져오는 메소드
		String workDate = getCurrentDate();		// 오늘 날짜 가져오는 메소드

		// 출근 시간 기록시 퇴근 시간을 00:00으로 설정
		as.insertClockIn(emp.getEmpno(), workDate, currentTime, "00:00");
		return currentTime; // 현재 시간을 반환하여 기록된 출근 시간 확인
	}

	// 퇴근 시간 기록
	@PostMapping("/att/clockOut")
	@ResponseBody
	public String clockOut(HttpSession session) {
		// 세션에서 로그인된 사원 (퇴근 시간 기록할 사원) 정보 가져오기
		Emp emp = (Emp) session.getAttribute("emp");
		String currentTime = getCurrentTime(); // 현재 시간 가져오기

		// 퇴근 기록 업데이트: 현재 시간으로 업데이트
		as.updateClockOut(emp.getEmpno(), currentTime); // 서비스 메소드 호출
		return currentTime; // 현재 시간을 반환하여 기록된 퇴근 시간 확인
	}

	// 현재 날짜를 yyyyMMdd 형식으로 반환 (출근 시간 기록시 사용)
	private String getCurrentDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(new Date()); // 현재 날짜 반환
	}

	// 현재 시간을 HH:mm 형식으로 반환 (출퇴근 시간 기록시 사용)
	private String getCurrentTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		return sdf.format(new Date()); // 현재 시간 반환
	}

	// 출근 시간과 퇴근 시간으로 총 근무 시간을 계산
	@GetMapping(value = "/calculate")
	public Integer calculateWorkTime(@RequestParam String clockIn, @RequestParam String clockOut) {
		Integer totalWorkTime = as.getTotWorkTime(clockIn, clockOut);
		return totalWorkTime;
	}

	// 결재 상세 정보 조회
	@GetMapping(value = "/appDetail")
	public String appDetail(@RequestParam(value = "approvalNum") Integer approvalNum,
							@RequestParam(value = "documentFormId", required = false)
							Integer documentFormId, Model model) {
		ApprovalDto approval = apps.appDetail(approvalNum, documentFormId);

		model.addAttribute("approval", approval);
		return "se/leaveDetail";
	}

	// 출석 정보 수정
	@PostMapping(value = "/updateAdminAtt")
	public String updateAttendance(HttpServletRequest request, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
		Emp emp = (Emp) session.getAttribute("emp"); // 세션에서 로그인된 사원(수정자) 정보 가져오기
		Attendance attendance = new Attendance();
		attendance.setEmpno(Integer.parseInt(request.getParameter("empno"))); // 수정할 사원 번호 설정
		attendance.setWorkDate(request.getParameter("workDate")); // 수정할 날짜 설정
		attendance.setName(request.getParameter("name"));		  // 수정자명 설정
		attendance.setClockIn(request.getParameter("clockIn"));	  // 수정한 출근 시간 설정
		attendance.setClockOut(request.getParameter("clockOut")); // 수정한 퇴근 시간 설정
		attendance.setEditCheck(1); // 수정시 수정 체크 설정
		attendance.setEditWho((emp.getEmpno())); // 수정자 사번 설정

		// 수정 날짜 및 시간 설정
		LocalDateTime updateAttWhen = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String editAttString = updateAttWhen.format(formatter);
		attendance.setEditWhen(editAttString);	// 수정일자 설정


		// 업데이트된 근무시간 호출
		int upAttResult = as.updateAtt(attendance);

		// 출근 시간 형식 확인
		String timePattern = "^([01]\\d|2[0-3]):([0-5]\\d)$";
		if (!attendance.getClockIn().matches(timePattern) || !attendance.getClockOut().matches(timePattern)) {
			return "redirect:/he/updateAdminAtt"; // 오류 메시지 없이 원래 페이지로 리다이렉트
		}

		model.addAttribute("upAttResult", upAttResult);
		return "redirect:/he/adminAtt";
	}

	// 출퇴근 시간 수정 Form
	@GetMapping(value = "updateAdminAtt")
	public String adminAttUpdate (@ModelAttribute Attendance attendance, Model model){
		System.out.println("adminAttUpdate attendance : " + attendance);
		Attendance findByAtt = as.findById(attendance); // 수정할 사원의 출석 정보 조회
		model.addAttribute("updateAtt", findByAtt);
		return "he/updateAdminAtt";
	}
}