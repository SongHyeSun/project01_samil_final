package com.oracle.samil.HsService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.samil.Adto.ApprovalDto;
import com.oracle.samil.Adto.CalTotal;
import com.oracle.samil.Amodel.Attendee;
import com.oracle.samil.Amodel.Event;
import com.oracle.samil.Amodel.Reservation;
import com.oracle.samil.HsDao.HsCalDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HsCalServiceImpl implements HsCalService {
	
	@Autowired
	private final HsCalDao hcd;
	
	//회사 일정 불러오기 (사용자)
	@Override
	public List<CalTotal> listComEve(CalTotal event) {
		System.out.println("HsCalServiceImpl listComEve Start...");
		List<CalTotal> listComEvent = hcd.listComEve(event);
		System.out.println("HsCalServiceImpl listComEve After...");
		return listComEvent;
	}
	
	//일정 카테고리 불러오기 (사용자)
	@Override
	public List<CalTotal> listCategory(CalTotal catT) {
		System.out.println("HsCalServiceImpl listCategory Start...");
		List<CalTotal> listCatego = hcd.listCategory(catT);
		System.out.println("HsCalServiceImpl listCategory After...");
		return listCatego;
	}
	
	//일정 카테고리 별 일정 list 공유, 개인, 휴무 (사용자)
	@Override
	public List<CalTotal> listEvent(int eventCategory, int empno) {
		List<CalTotal> eventList = null;
		System.out.println("HsCalServiceImpl listEvent Start...");
		eventList = hcd.listEvent(eventCategory, empno);
		System.out.println("HsCalServiceImpl listEvent End...");
		return eventList;
	}
	
	//fullCalendar List
	//풀캘린더 회사일정
	@Override
	public List<CalTotal> calList() {
		System.out.println("HsCalServiceImpl calList Start...");
		List<CalTotal> calList = hcd.calList();
			
		System.out.println("HsCalServiceImpl calList After...");
			
		return calList;
	}
		
	//풀캘린더 공유일정
	@Override
	public List<CalTotal> calShaList(int empno) {
		System.out.println("HsCalServiceImpl calShaList Start...");
		List<CalTotal> calShaList = hcd.calShaList(empno);
		
		System.out.println("HsCalServiceImpl calShaList After...");
		
		return calShaList;
	}
		
		
	//풀캘린더 개인일정
	@Override
	public List<CalTotal> calPriList(int empno) {
		System.out.println("HsCalServiceImpl calPriList Start...");
		List<CalTotal> calPriList = hcd.calPriList(empno);
		
		System.out.println("HsCalServiceImpl calPriList After...");
		
		return calPriList;
	}
		
	//풀캘린더 휴무
	@Override
	public List<CalTotal> calVacList(int empno) {
		System.out.println("HsCalServiceImpl calVacList Start...");
		List<CalTotal> calVacList = hcd.calVacList(empno);
		
		System.out.println("HsCalServiceImpl calVacList After...");
		
		return calVacList;
	}

	//공유일정 요청 온 것 list (사용자)
	@Override
	public List<CalTotal> listReqAtten(CalTotal attendee, int empno) {
		List<CalTotal> listReqAttendee = null;
		System.out.println("HsCalServiceImpl listReqAtten Start...");
		attendee.setAttendId(empno);
		listReqAttendee = hcd.listReqAtten(attendee);
		System.out.println("HsCalServiceImpl listReqAtten End...");
		return listReqAttendee;
	}
	//내가 보낸 요청상태 list (사용자)
	@Override
	public List<CalTotal> listResAtten(CalTotal attendee) {
		List<CalTotal> listResAttendee = null;
		System.out.println("HsCalServiceImpl listResAtten Start...");
		listResAttendee = hcd.listResAtten(attendee);
		System.out.println("HsCalServiceImpl listResAtten End...");
		return listResAttendee;
	}
	
	// 다른 사원 일정 검색 (사용자)
	@Override
	public List<CalTotal> calSearchEmp(int empno) {
		System.out.println("HsCalServiceImpl calSearchEmp Start...");
		List<CalTotal> calSearchEmp = hcd.calSearchEmp(empno);
		System.out.println("HsCalServiceImpl calSearchEmp empno-> "+empno);
		
		System.out.println("HsCalServiceImpl calSearchEmp After...");
		return calSearchEmp;
	}
	
	
	// 일정 상세정보 -> 권한마다 버튼여부 다른 (사용자)
	@Override
	public CalTotal detailEvent(int eventId, int empno) {
		System.out.println("HsCalServiceImpl detailEvent Start...");
		CalTotal attendee = hcd.detailEvent(eventId, empno);
		System.out.println("service attendee-> "+attendee);
		System.out.println("HsCalServiceImpl detailEvent End...");
		return attendee;
	}
	
	// 사용자 캘린더 일정 수정 폼 수정완료 logic
	@Override
	public int updateEvent(Event event) {
		System.out.println("HsCalServiceImpl updateEvent Start...");
		int updateCount=0;
		updateCount = hcd.updateEvent(event);
		System.out.println("HsCalServiceImpl updateEvent updateCount -> "+updateCount);
		System.out.println("HsCalServiceImpl updateEvent After...");
		return updateCount;
	}
	
	// 사용자 캘린더 작성 완료된 폼 logic
	@Override
	public int insertEvent(CalTotal event) {
		System.out.println("HsCalServiceImpl insertEvent Start...");
		int result = hcd.insertEvent(event);
		
		System.out.println("HsCalServiceImpl insertEvent result-> "+result);
		System.out.println("HsCalServiceImpl insertEvent hcd.insertEvent After...");
		return result;
	}
	
	// 참석자 추가 시 불러올 insert된 eventId
	@Override
	public int curEventId() {
		System.out.println("HsCalServiceImpl curEventId Start...");
		int eventId = hcd.curEventId();
		
		System.out.println("HsCalServiceImpl curEventId After...");
		return eventId;
	}
	
	// 참석자 추가 insert (공유일장에서만)
	@Override
	public void insertAtt(Attendee atten) {
		System.out.println("HsCalServiceImpl insertAtt Start...");
		hcd.insertAtten(atten);
		
		System.out.println("HsCalServiceImpl insertAtt After...");
		
	}
	
	// 휴무 결재정보 불러와 insert (procedure)
	@Override
	public void calVacInsert(ApprovalDto approvalDto) {
		System.out.println("HsCalServiceImpl calVacInsert Start...");
		hcd.calVacInsert(approvalDto);
		
		System.out.println("HsCalServiceImpl calVacInsert After...");
		
	}
	
	
	
	
	// 사용자 캘린더 -> 상세보기 -> 삭제여부로 이동하는 logic (사실은 update logic)
	@Override
	public int deleteEvent(Event event) {
		System.out.println("HsCalServiceImpl deleteEvent Start...");
		int result = hcd.deleteEvent(event);
		
		System.out.println("HsCalServiceImpl deleteEvent result-> "+result);
		System.out.println("HsCalServiceImpl deleteEvent hcd.deleteEvent After...");
		return result;
	}

	// 사용자 캘린더 공유일정 요청 승인 폼 logic
	@Override
	public int updateAttAcc(Attendee attendee) {
		System.out.println("HsCalServiceImpl updateAttAcc Start...");
		int updateCount=0;
		updateCount = hcd.updateAttAcc(attendee);
		System.out.println("HsCalServiceImpl updateAttAcc updateCount -> "+updateCount);
		System.out.println("HsCalServiceImpl updateAttAcc After...");
		return updateCount;
	}
	
	// 사용자 캘린더 공유일정 요청 거절 폼 logic
	@Override
	public int updateAttRej(Attendee attendee) {
		System.out.println("HsCalServiceImpl updateAttRej Start...");
		int updateCount=0;
		updateCount = hcd.updateAttRej(attendee);
		System.out.println("HsCalServiceImpl updateAttRej updateCount -> "+updateCount);
		System.out.println("HsCalServiceImpl updateAttRej After...");
		return updateCount;
	}

	// 사용자 캘린더 휴지통 이동 logic
	@Override
	public List<Event> listDelete(Event event) {
		List<Event> listDelete = null;
		System.out.println("HsCalServiceImpl listDelete Start...");
		listDelete = hcd.listDelete(event);
		System.out.println("HsCalServiceImpl listDelete End...");
		return listDelete;
	}
	
	// 사용자 캘린더 휴지통에서 다시 복원하는 logic
	@Override
	public int eventRestore(Event event) {
		System.out.println("HsCalServiceImpl eventRestore Start...");
		int updateCount=0;
		updateCount = hcd.eventRestore(event);
		System.out.println("HsCalServiceImpl eventRestore updateCount -> "+updateCount);
		System.out.println("HsCalServiceImpl eventRestore After...");
		return updateCount;
	}
	
	// 사용자 캘린더 영구삭제하는 폼 logic
	@Override
	public int eventForever(int eventId) {
		System.out.println("HsCalServiceImpl eventForever Start...");
		int result=0;
		result = hcd.eventForever(eventId);
		System.out.println("HsCalServiceImpl eventForever result -> "+result);
		System.out.println("HsCalServiceImpl eventForever After...");
		return result;
	}
	
//--------------------------------------관리자----------------------------------------

	// 관리자 캘린더 -> 상세보기
	@Override
	public CalTotal detailAdEvent(int eventId) {
		System.out.println("HsCalServiceImpl detailAdEvent Start...");
		CalTotal event = hcd.detailAdEvent(eventId);
		
		System.out.println("HsCalServiceImpl detailAdEvent End...");
		return event;
	}

}
