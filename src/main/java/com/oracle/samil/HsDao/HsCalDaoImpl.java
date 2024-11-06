package com.oracle.samil.HsDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Adto.ApprovalDto;
import com.oracle.samil.Adto.CalTotal;
import com.oracle.samil.Amodel.Attendee;
import com.oracle.samil.Amodel.Event;
import com.oracle.samil.Amodel.Reservation;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class HsCalDaoImpl implements HsCalDao {
	
	@Autowired
	private final SqlSession session;
	
	//회사일정 list (사용자)
	@Override
	public List<CalTotal> listComEve(CalTotal event) {
		List<CalTotal> listComEvent = null;
		System.out.println("HsCalDaoImpl listComEve Start...");
		try {
			listComEvent = session.selectList("hsEventComp", event);
			System.out.println("HsCalDaoImpl listComEve listCatego.size()-> "+listComEvent.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl listComEve e.getMessage()-> "+e.getMessage());
		}
		return listComEvent;
	}
	
	//일정 카테고리 불러오기 (사용자)
	@Override
	public List<CalTotal> listCategory(CalTotal calT) {
		List<CalTotal> listCatego = null;
		System.out.println("HsCalDaoImpl listCategory Start...");
		try {
			listCatego = session.selectList("hsEventCategory", calT);
			System.out.println("HsCalDaoImpl listCategory listCatego.size()-> "+listCatego.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl listCategory e.getMessage()-> "+e.getMessage());
		}
		return listCatego;
	}

	//카테고리 별 list 공유, 개인, 휴무 (사용자)
	@Override
	public List<CalTotal> listEvent(int eventCategory, int empno) {
		List<CalTotal> eventList = null;
		System.out.println("HsCalDaoImpl listEvent Start...");
		
		Map<String, Object> eventm = new HashMap<>();
		eventm.put("eventCategory", eventCategory);
		eventm.put("empno", empno);
		try {
			eventList = session.selectList("hsEventListAll",eventm);
			System.out.println("HsCalDaoImpl listEvent eventList.size()-> "+eventList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl listEvent e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsCalDaoImpl listEvent End...");
		return eventList;
	}
	
	
	//fullCalendar List 불러오기
	//풀캘린더 회사일정
	@Override
	public List<CalTotal> calList() {
		List<CalTotal> calList = null;
		System.out.println("HsCalDaoImpl calList Start...");
		
		try {
			calList = session.selectList("hsCalList");
			System.out.println("HsCalDaoImpl calList calList.size()-> "+calList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl calList e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsCalDaoImpl calList End...");
		return calList;
	}
	
	//풀캘린더 공유일정
	@Override
	public List<CalTotal> calShaList(int empno) {
		List<CalTotal> calShaList = null;
		System.out.println("HsCalDaoImpl calShaList Start...");
		
		try {
			calShaList = session.selectList("hsCalShaList",empno);
			System.out.println("HsCalDaoImpl calShaList calShaList.size()-> "+calShaList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl calShaList e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsCalDaoImpl calShaList End...");
		return calShaList;
	}
	
	//풀캘린더 개인일정
	@Override
	public List<CalTotal> calPriList(int empno) {
		List<CalTotal> calPriList = null;
		System.out.println("HsCalDaoImpl calPriList Start...");

		try {
			calPriList = session.selectList("hsCalPriList",empno);
			System.out.println("HsCalDaoImpl calPriList calPriList.size()-> "+calPriList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl calPriList e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsCalDaoImpl calPriList End...");
		return calPriList;
	}
	
	//풀캘린더 휴무
	@Override
	public List<CalTotal> calVacList(int empno) {
		List<CalTotal> calVacList = null;
		System.out.println("HsCalDaoImpl calVacList Start...");
		
		try {
			calVacList = session.selectList("hsCalVacList",empno);
			System.out.println("HsCalDaoImpl calVacList calVacList.size()-> "+calVacList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl calVacList e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsCalDaoImpl calVacList End...");
		return calVacList;
	}
	
	//공유일정 요청 온 것 list (사용자)
	@Override
	public List<CalTotal> listReqAtten(CalTotal attendee) {
		List<CalTotal> listReqAttendee = null;
		System.out.println("HsCalDaoImpl listReqAtten Start...");
		
		try {
			listReqAttendee = session.selectList("hsReqAttList",attendee);
			System.out.println("HsCalDaoImpl listReqAtten listReqAttendee.size()-> "+listReqAttendee.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl listReqAtten e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsCalDaoImpl listReqAtten End...");
		return listReqAttendee;
	}
	
	//내가 보낸 요청상태 list (사용자)
	@Override
	public List<CalTotal> listResAtten(CalTotal attendee) {
		List<CalTotal> listResAttendee = null;
		System.out.println("HsCalDaoImpl listResAtten Start...");

		try {
			listResAttendee = session.selectList("hsResAttList",attendee);
			System.out.println("HsCalDaoImpl listResAtten listResAttendee.size()-> "+listResAttendee.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl listResAtten e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsCalDaoImpl listResAtten End...");
		return listResAttendee;
	}
	
	
	// 다른 사원 일정 검색 (사용자)
	@Override
	public List<CalTotal> calSearchEmp (int empno) {
		System.out.println("HsCalDaoImpl calSearchEmp Start...");
		List<CalTotal> calSearchEmp = null;
		try {
			calSearchEmp = session.selectList("hsSearchList", empno);
			System.out.println("HsCalDaoImpl calSearchEmp calSearchEmp.size()"+calSearchEmp.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl calSearchEmp e.getMessage()-> "+e.getMessage());
		}
		return calSearchEmp;
	}
	
	
	
	// 일정 상세정보 -> 권한마다 버튼여부 다른 (사용자)
	@Override
	public CalTotal detailEvent(int eventId, int empno) {
		CalTotal attendee = new CalTotal();
		System.out.println("HsCalDaoImpl detailEvent Start...");
		Map<String, Object> eventm = new HashMap<>();
		eventm.put("eventId", eventId);
		eventm.put("empno", empno);
		try {
			attendee = session.selectOne("hsEventSelOne", eventm);
			System.out.println("HsCalDaoImpl detailEvent attendee-> "+attendee);
			
		} catch (Exception e) {
			System.out.println("HsCalDaoImpl detailEvent e.getMessage()-> "+e.getMessage());
		}
		System.out.println("HsCalDaoImpl detailEvent End...");
		return attendee;
	}
	
	// 사용자 캘린더 일정 수정 폼 수정완료 logic
	@Override
	public int updateEvent(Event event) {
		int updateCount = 0;
		System.out.println("HsCalDaoImpl updateEvent Start...");
		
		
		try {
			updateCount = session.update("hsEventUpdate", event);
			System.out.println("HsCalDaoImpl updateEvent updateCount-> "+updateCount);
		} catch (Exception e) {
			System.out.println("HsCalDaoImpl updateEvent e.getMessage()-> "+e.getMessage());
		}
		return updateCount;
	}
	
	// 사용자 캘린더 작성 완료된 폼 logic
	@Override
	public int insertEvent(CalTotal event) {
		int result = 0;
		System.out.println("HsCalDaoImpl insertEvent Start...");
		try {
			result = session.insert("hsEventInsert", event);
			System.out.println("HsCalDaoImpl insertEvent event-> "+event);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl insertEvent e.getMessage()-> "+e.getMessage());
		}
		return result;
	}
	
	// 참석자 추가 시 불러올 insert된 eventId
	@Override
	public int curEventId() {
		int eventId = 0;
		System.out.println("HsCalDaoImpl curEventId Start...");
		try {
			eventId = session.selectOne("hsCurEventId");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl curEventId e.getMessage()-> "+e.getMessage());
		}
		return eventId;
	}
	
	// 참석자 추가 insert (공유일장에서만)
	@Override
	public void insertAtten(Attendee atten) {
		System.out.println("HsCalDaoImpl insertAtten Start...");
		try {
			session.insert("hsAttenInsert", atten);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl insertEvent e.getMessage()-> "+e.getMessage());
		}
		
	}
	
	
	// 휴무 결재정보 불러와 insert (procedure)
	@Override
	public void calVacInsert(ApprovalDto approvalDto) {
		System.out.println("HsCalDaoImpl calVacInsert Start...");
		try {
			session.selectOne("hsCalVacIns", approvalDto);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl calVacInsert e.getMessage()-> "+e.getMessage());
		}
		
	}
	
	
	// 사용자 캘린더 -> 상세보기 -> 삭제여부로 이동하는 logic (사실은 update logic)
	@Override
	public int deleteEvent(Event event) {
		int result = 0;
		System.out.println("HsCalDaoImpl deleteEvent Start...");
		try {
			result = session.update("hsEventDelupt", event);
			System.out.println("HsCalDaoImpl updateEvent updateCount-> "+result);
		} catch (Exception e) {
			System.out.println("HsCalDaoImpl deleteEvent e.getMessage()-> "+e.getMessage());
		}
		return result;
	}

	// 사용자 캘린더 공유일정 요청 승인 폼 logic
	@Override
	public int updateAttAcc(Attendee attendee) {
		int updateCount = 0;
		System.out.println("HsCalDaoImpl updateAttAcc Start...");
		
		try {
			updateCount = session.update("hsAttAccupdate", attendee);
			System.out.println("HsCalDaoImpl updateAttAcc updateCount-> "+updateCount);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl updateAttAcc e.getMessage()-> "+e.getMessage());
		}
		return updateCount;
	}
	
	// 사용자 캘린더 공유일정 요청 거절 폼 logic
	@Override
	public int updateAttRej(Attendee attendee) {
		int updateCount = 0;
		System.out.println("HsCalDaoImpl updateAttRej Start...");

		try {
			updateCount = session.update("hsAttRejupdate", attendee);
			System.out.println("HsCalDaoImpl updateAttRej updateCount-> "+updateCount);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl updateAttRej e.getMessage()-> "+e.getMessage());
		}
		return updateCount;
	}

	
	// 사용자 캘린더 휴지통 이동 logic
	@Override
	public List<Event> listDelete(Event event) {
		List<Event> listDelete = null;
		System.out.println("HsCalDaoImpl listDelete Start...");

		try {
			listDelete = session.selectList("hsEventListDel", event);
			System.out.println("HsCalDaoImpl listDelete listDelete.size()-> "+listDelete.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl listDelete e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsCalDaoImpl listDelete End...");
		return listDelete;
	}

	// 사용자 캘린더 휴지통에서 다시 복원하는 logic
	@Override
	public int eventRestore(Event event) {
		int updateCount = 0;
		System.out.println("HsCalDaoImpl eventRestore Start...");

		try {
			updateCount = session.update("hseventRestore", event);
			System.out.println("HsCalDaoImpl eventRestore updateCount-> "+updateCount);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsCalDaoImpl eventForever e.getMessage()-> "+e.getMessage());
		}
		return updateCount;
	}
	
	// 사용자 캘린더 영구삭제하는 폼 logic
	@Override
	public int eventForever(int eventId) {
		int result = 0;
		System.out.println("HsCalDaoImpl eventForever Start...");
		System.out.println("HsCalDaoImpl eventForever eventId->" +eventId);
		try {
			result = session.delete("hsEventDelete", eventId);
			System.out.println("HsCalDaoImpl deleteEvent result-> "+result);
		} catch (Exception e) {
			System.out.println("HsCalDaoImpl deleteEvent e.getMessage()-> "+e.getMessage());
		}
		return result;
	}

//---------------------------------관리자--------------------------------
	
	// 관리자 캘린더 -> 상세보기
	@Override
	public CalTotal detailAdEvent(int eventId) {
		CalTotal event = new CalTotal();
		System.out.println("HsCalDaoImpl detailAdEvent Start...");
		try {
			event = session.selectOne("hsEventAdSelOne", eventId);
			System.out.println("HsCalDaoImpl detailAdEvent event-> "+event);
			
		} catch (Exception e) {
			System.out.println("HsCalDaoImpl detailAdEvent e.getMessage()-> "+e.getMessage());
		}
		System.out.println("HsCalDaoImpl detailAdEvent End...");
		return event;
	}
	

}
