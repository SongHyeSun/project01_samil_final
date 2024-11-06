package com.oracle.samil.Acontroller;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.oracle.samil.Adto.CalTotal;
import com.oracle.samil.Amodel.Attendee;
import com.oracle.samil.Amodel.Dept;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.Event;
import com.oracle.samil.HsService.HsCalService;
import com.oracle.samil.TrService.EmpService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value="/hs")
public class HsCalController extends BaseController {
	
	@Autowired
	private final HsCalService hcs;
	private final EmpService es;
	
	// 사용자 캘린더 메인 page 로직
	@GetMapping(value = "/cal")
	public String cal (CalTotal event, CalTotal attendee, Model model, 
			@RequestParam(value = "month", required = false) Integer month, 
			@RequestParam(value = "year", required = false) Integer year) throws JsonProcessingException{
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		System.out.println("ename: "+empno);
		
		event.setEventWriter(empno);
		attendee.setAttendId(empno);
		
		System.out.println("hsCalController cal Start");
		
		// 오늘 날짜 불러오기
        Calendar calendar = Calendar.getInstance();
        
        int currentMonth = calendar.get(Calendar.MONTH)+1;
        int currentYear  = calendar.get(Calendar.YEAR);
        int currentDay	 = calendar.get(Calendar.DAY_OF_MONTH);

        Map<String, Object> calendarData = new HashMap<>();
        calendarData.put("month", currentMonth);
        calendarData.put("year", currentYear);
        calendarData.put("day", currentDay);
        model.addAttribute("calendarData", calendarData);
        
        
        //회사일정 list (사용자)
        List<CalTotal> listComEvent = hcs.listComEve(event);
        model.addAttribute("listComEvent", listComEvent);

        //일정 카테고리 불러오기 (사용자)
        List<CalTotal> listCategory = hcs.listCategory(event);
        model.addAttribute("listCategory", listCategory);
        
        //일정 분류
        Map<Integer, String> cateMap = new HashMap<>();
        cateMap.put(100, "회사일정");
        cateMap.put(110, "공유일정");
        cateMap.put(120, "개인일정");
        cateMap.put(130, "직원휴무");
      		
        model.addAttribute("cateMap", cateMap);
        
        
        // eventCategory별로 상세 정보 담기 위한 Map
        Map<Integer, List<CalTotal>> listEventMap = new HashMap<>();
        
        // eventCategory별 일정분류
        for (CalTotal eventC : listCategory) {
        		List<CalTotal> listEventC = hcs.listEvent(eventC.getEventCategory(), empno);	//각 부서의 직원 목록
        		listEventMap.put(eventC.getEventCategory(), listEventC);		//부서번호와 직원 목록 매핑
        }
      		
        model.addAttribute("listEventMap", listEventMap);	//부서와 직원 목록을 모델에 추가

        
        //FullCalendar에 list 넣기
        //풀캘린더 회사일정
        List<CalTotal> calComList = hcs.calList();
        model.addAttribute("calComList", calComList);

        
        //FullCalendar에 list 넣기
        //풀캘린더 공유일정
        List<CalTotal> calShaList = hcs.calShaList(empno);
        model.addAttribute("calShaList", calShaList);
        
        
        //FullCalendar에 list 넣기
        //풀캘린더 개인일정
        List<CalTotal> calPriList = hcs.calPriList(empno);
        model.addAttribute("calPriList", calPriList);
        
        
        //FullCalendar에 list 넣기
        //풀캘린더 휴무
        List<CalTotal> calVacList = hcs.calVacList(empno);
        model.addAttribute("calVacList", calVacList);

        //공유일정 요청 온 것 list (사용자)
        List<CalTotal> listRequestAtten = hcs.listReqAtten(attendee, empno);
        model.addAttribute("listRequestAtten", listRequestAtten);		
        
    	//내가 보낸 요청상태 list (사용자)
        attendee.setEventWriter(empno);
        List<CalTotal> listResponseAtten = hcs.listResAtten(attendee);
        
      	Map<Integer, String> atteReMap = new HashMap<>();
      	atteReMap.put(100, "대기");
      	atteReMap.put(110, "승인");
      	atteReMap.put(120, "거부");
      	
      	model.addAttribute("atteReMap", atteReMap);
      	model.addAttribute("listResponseAtten", listResponseAtten);	
        
        
      	//검색구현 로직
      	//주소록 목록
      	List<Dept> listdept = es.deptSelect();
      	model.addAttribute("deptList", listdept);
        		
        System.out.println("hsCalController cal End....");
		return "hs/cal";
	}
	
	//부서에 따른 직원 자동완성 검색 list
	@RequestMapping(value = "/autocomplete")
    public @ResponseBody Map<String, Object> autoComplete (@RequestParam Map<String, Object> paramMap) throws Exception{
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		System.out.println("ename: "+empno);
		
		paramMap.put("empno", empno);
		
        List<Map<String, Object>> resultList = es.autocomplete(paramMap);
        System.out.println("hsCalController autoComplete start...");
        System.out.println("hsCalController autoComplete resultList => " + resultList);

        Map<String, Object> responeseMap = new HashMap<>();
        responeseMap.put("resultList", resultList);

        return responeseMap;
    }
	
	// 사용자 캘린더 검색 (사원검색) 
	@PostMapping(value = "calSearch")
	public String cal_empSearch (@RequestParam(name = "empno") int empno, Model model) {
		System.out.println("hsCalController cal_empSearch Start");
		
		System.out.println("hsCalController cal_empSearch empno -> "+empno);
		
		//주소록 목록
      	List<Dept> listdept = es.deptSelect();
      	model.addAttribute("deptList", listdept);
		
		//FullCalendar에 list 넣기
        //풀캘린더 공유일정
        List<CalTotal> calShaList = hcs.calShaList(empno);
        model.addAttribute("calShaList", calShaList);
        
        
        //FullCalendar에 list 넣기
        //풀캘린더 개인일정
        List<CalTotal> calPriList = hcs.calPriList(empno);
        model.addAttribute("calPriList", calPriList);
		
        Emp empp = es.searchEmpCal(empno);
        model.addAttribute("empp", empp);
	        
	    //직급명 변환 로직
        Map<Integer, String> empgrade = new HashMap<>();
        empgrade.put(100, "사원");
        empgrade.put(110, "주임");
        empgrade.put(120, "대리");
	    empgrade.put(130, "과장");
	    empgrade.put(140, "차장");
	    empgrade.put(150, "부장");
	    empgrade.put(160, "사장");
	
	    model.addAttribute("empgrade", empgrade);
	        
		System.out.println("hsCalController cal_empSearch End...");
		return "hs/calSearchEmp";
	}

	
	// 사용자 캘린더 상세보기 페이지 이동
	@GetMapping(value = "/calDetail")
	public String cal_calDetail (CalTotal attendee1, Model model){
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_calDetail Start");
		
		//일정 분류
        Map<Integer, String> cateMap = new HashMap<>();
        cateMap.put(100, "회사일정");
        cateMap.put(110, "공유일정");
        cateMap.put(120, "개인일정");
        cateMap.put(130, "직원휴무");
      		
        model.addAttribute("cateMap", cateMap);
		
        // 일정 상세정보 -> 권한마다 버튼여부 다른 (사용자)
        CalTotal attendee = hcs.detailEvent(attendee1.getEventId(), empno);
		System.out.println("attendee -> "+attendee);
		model.addAttribute("calTotal", attendee);
		
		System.out.println("hsCalController cal_calDetail End...");
		
		return "hs/calDetail";
	}
	
	
	// 사용자 캘린더 -> 상세보기 -> 수정 화면 logic
	@GetMapping(value = "/calUpdate")
	public String cal_calUpdateForm (CalTotal attendee1, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_calUpdateForm Start...");
		//일정 분류
        Map<Integer, String> cateMap = new HashMap<>();
        cateMap.put(100, "회사일정");
        cateMap.put(110, "공유일정");
        cateMap.put(120, "개인일정");
        cateMap.put(130, "직원휴무");
      		
        model.addAttribute("cateMap", cateMap);
        CalTotal attendee = hcs.detailEvent(attendee1.getEventId(), empno);
		System.out.println("hsCalController cal_calUpdateForm attendee->"+attendee);
		
		model.addAttribute("calTotal", attendee);
		System.out.println("hsCalController cal_calUpdateForm End...");
		return "hs/calUpdate";
	}
	
	// 사용자 캘린더 일정 수정 폼 수정완료 logic
	@PostMapping(value = "updateEvent")
	public String cal_calUpdate (Event event, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		//int empno = emp.getEmpno();	//empno 가져오기
		event.setEmpno(emp.getEmpno());	//empno 가져오기
		int empno = emp.getEmpno();
		
		System.out.println("hsCalController cal_calUpdate Start...");
		System.out.println("hsCalController cal_calUpdate event->"+event);
		int updateCount = hcs.updateEvent(event);
		System.out.println("hsCalController cal_calUpdate updateCount-> "+updateCount);
		model.addAttribute("uptCnt", updateCount);
		int eventid = event.getEventId();
		System.out.println("hsCalController cal_calUpdate End...");
		return "redirect:/hs/calDetail?eventId="+eventid;
	}
	
	// 사용자 캘리더 eventCategory ajax 처리
	@ResponseBody
	@RequestMapping(value = "getEventCate")
	public String getEventCate(@RequestParam("eventCategory") int eventCategory) {
		System.out.println("hsCalController getEventCate ajax Start...");
		System.out.println("eventCategory-> "+eventCategory);
		//일정 분류
        Map<Integer, String> cateMap = new HashMap<>();
        cateMap.put(110, "공유일정");
        cateMap.put(120, "개인일정");
        
		String eventCat = cateMap.get(eventCategory);
		
		System.out.println("hsCalController getEventCate ajax End...");
		return eventCat;
	}
	
	
	// 사용자 캘린더 작성 폼 페이지로 가는 logic
	@GetMapping(value = "/calWriteForm")
	public String cal_calWriteForm (Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_calWriteForm Start");
		
		//일정 분류
		Map<Integer, String> cateMap = new HashMap<>();
		cateMap.put(100, "회사일정");
		cateMap.put(110, "공유일정");
		cateMap.put(120, "개인일정");
		cateMap.put(130, "직원휴무");
		
		model.addAttribute("cateMap", cateMap);
		
		//직급명 변환 로직
		Map<Integer, String> empgrade = new HashMap<>();
		empgrade.put(100, "사원");
		empgrade.put(110, "주임");
		empgrade.put(120, "대리");
		empgrade.put(130, "과장");
		empgrade.put(140, "차장");
		empgrade.put(150, "부장");
		empgrade.put(160, "사장");

        model.addAttribute("empgrade", empgrade);

		//주소록 목록
		List<Dept> listdept = es.deptSelect();
		model.addAttribute("deptList44", listdept);
		
		// 각 부서별 직원 목록을 담기 위한 Map
		Map<Integer, List<Emp>> deptEmpMap = new HashMap<>();
		
		// 각 부서에 대하 직원 목록 조회
		for (Dept deptL : listdept) {
			List<Emp> listdeptemp = es.listdeptEmp(deptL.getDeptno());	//각 부서의 직원 목록
			deptEmpMap.put(deptL.getDeptno(), listdeptemp);		//부서번호와 직원 목록 매핑
		}
		
		model.addAttribute("deptEmpMap", deptEmpMap);	//부서와 직원 목록을 모델에 추가

		System.out.println("hsCalController cal_calWriteForm End...");
		return "hs/calWriteForm";
	}
	
	// 사용자 캘린더 작성 완료된 폼 logic
	@RequestMapping(value = "writeEvent")
	public String cal_writeEvent (CalTotal event, Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		// 작성자 설정
		event.setEventWriter(empno);
		
		System.out.println("hsCalController cal_writeEvent Start...");
		System.out.println("hsCalController cal_writeEvent event->"+event);
		
		//dto에 담아온 list
		StringTokenizer empnoArr = new StringTokenizer(event.getEmpnoArr(),",");
		
		int insertResult = hcs.insertEvent(event);

		if (insertResult > 0) {
			// 참석자 추가 시 불러올 insert된 eventId
			int curEventId = hcs.curEventId();
			event.setEventId(curEventId);

			while(empnoArr.hasMoreTokens()) {
				Attendee attn = new Attendee();
				attn.setEventId(event.getEventId());
				attn.setAttendId(Integer.parseInt(empnoArr.nextToken()));
				attn.setAttendRes(event.getAttendRes());
				attn.setAttendRsvp(event.getAttendRsvp());
				// System.out.println("event.getEmpnoArr->"+empnoArr.nextToken());
				System.out.println("attn->"+attn);
				
			    hcs.insertAtt(attn);
			}
			 return "redirect:/hs/cal";
		} else {
			model.addAttribute("msg", "입력 실패! 확인해보세요");
			return "forward:hs/calWriteForm";
		}

	}
	
	// 사용자 캘린더 -> 상세보기 -> 삭제여부로 이동하는 logic (사실은 update logic)
	@RequestMapping(value = "deleteEvent")
	public String cal_deleteEvent(Event event, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_deleteEvent Start...");
		
		int result = hcs.deleteEvent(event);
		return "redirect:/hs/cal";
	}
	
	// 사용자 캘린더 공유일정 요청 승인 폼 logic
	@PostMapping("updateAttAcc")
	public String cal_updateAttAccept (Attendee attendee, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_updateAttAccept Start...");
		int updateCount = hcs.updateAttAcc(attendee);
		System.out.println("hsCalController cal_updateAttAccept updateCount-> "+updateCount);
		model.addAttribute("uptCnt", updateCount);
		System.out.println("hsCalController cal_updateAttAccept End...");
		return "redirect:/hs/cal";
	}
	
	// 사용자 캘린더 공유일정 요청 거절 폼 logic
	@PostMapping("updateAttRej")
	public String cal_updateAttReject (Attendee attendee, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_updateAttReject Start...");
		int updateCount = hcs.updateAttRej(attendee);
		System.out.println("hsCalController cal_updateAttReject updateCount-> "+updateCount);
		model.addAttribute("uptCnt", updateCount);
		System.out.println("hsCalController cal_updateAttReject End...");
		return "redirect:/hs/cal";
	}
	
	// 사용자 캘린더 휴지통 이동 logic
	@GetMapping(value = "/calDelete")
	public String cal_calDelete (Event event, Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_calDelete Start");
        //deleteList 삭제된 목록
		event.setEventWriter(empno);
        List<Event> listDelete = hcs.listDelete(event);
        model.addAttribute("listDelete", listDelete);
        
        System.out.println("hsCalController cal_calDelete End");
		return "hs/calDelete";
	}
	
	// 사용자 캘린더 휴지통에서 다시 복원하는 logic
	@PostMapping("eventRestore")
	public String cal_delRestore (Event event, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_delRestore Start...");
		int updateCount = hcs.eventRestore(event);
		System.out.println("hsCalController cal_delRestore updateCount-> "+updateCount);
		model.addAttribute("uptCnt", updateCount);
		System.out.println("hsCalController cal_delRestore End...");
		return "redirect:/hs/cal";
	}
	
	// 사용자 캘린더 영구삭제하는 폼 logic
	@PostMapping("eventForDel")
	public String cal_delForever (Event event, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_delForever Start...");
		
		int result = hcs.eventForever(event.getEventId());
		System.out.println("hsCalController cal_delForever result-> "+result);
		return "redirect:/hs/calDelete";
	}

	// 관리자 캘린더 메인 페이지
	@GetMapping(value = "/adminCal")
	public String cal_admin (CalTotal event, CalTotal attendee, Model model,
							@RequestParam(value = "month", required = false) Integer month, 
							@RequestParam(value = "year", required = false) Integer year) throws JsonProcessingException {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_admin Start");
		
		//현재 날짜 가져오는 로직
		Calendar calendar = Calendar.getInstance();
        
        if (month !=null && year != null) {
        	calendar.set(year, month, 1);
        } else {
        	//현재 날짜로 설정
        	calendar.setTime(new Date());
        }
        
        int currentMonth = calendar.get(Calendar.MONTH)+1;
        int currentYear  = calendar.get(Calendar.YEAR);
        int currentDay	 = calendar.get(Calendar.DAY_OF_MONTH);

        Map<String, Object> calendarData = new HashMap<>();
        calendarData.put("month", currentMonth);
        calendarData.put("year", currentYear);
        calendarData.put("day", currentDay);
        model.addAttribute("calendarData", calendarData);
		
		
		//회사일정 list (사용자)
        List<CalTotal> listComEvent = hcs.listComEve(event);
        model.addAttribute("listComEvent", listComEvent);
		
        //FullCalendar에 list 넣기
        //풀캘린더 회사일정
        List<CalTotal> calComList = hcs.calList();
        model.addAttribute("calComList", calComList);
        
		List<CalTotal> listAdminEvent = hcs.listComEve(event);
		model.addAttribute("listAdminEvent", listAdminEvent);
		return "hs/adminCal";
	}
	
	// 관리자 캘린더 회사일정 상세보기로 이동하는 logic
	@GetMapping(value = "/adminCalDetail")
	public String cal_admin_calDetail (CalTotal event1, Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_admin_calDetail Start");
		
		CalTotal event = hcs.detailAdEvent(event1.getEventId());
		System.out.println("hsCalController cal_admin_calDetail event -> "+event);
		model.addAttribute("event", event);
		
		// 일정 분류
	    Map<Integer, String> cateMap = new HashMap<>();
	    cateMap.put(100, "회사일정");
	    
	    model.addAttribute("cateMap", cateMap);
		
		System.out.println("hsCalController cal_admin_calDetail End...");
		return "hs/adminCalDetail";
	}
	
	// 관리자 캘린더 -> 상세보기 -> 회사일정 삭제하는 logic
	@RequestMapping(value = "deleteAdmEvent")
	public String cal_deleteAdEvent(Event event, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_deleteEvent Start...");
		
		int result = hcs.eventForever(event.getEventId());
		System.out.println("hsCalController cal_deleteAdEvent result-> "+result);
		return "redirect:hs/adminCal";
		
	}
	
	// 관리자 캘린더 회사 일정 작성 form으로 이동 logic
	@GetMapping(value = "/adminCalWriteForm")
	public String cal_admin_calWriteForm (){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_admin_calWriteForm Start");
		return "hs/adminCalWriteForm";
	}
	
	// 관리자 캘린더 회사일정 작성 완료된 폼 logic
	@PostMapping(value = "writeAdEvent")
	public String cal_writeAdEvent (CalTotal event, Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		// 작성자 설정
		event.setEventWriter(empno);
		
		System.out.println("hsCalController cal_writeAdEvent Start...");
		
		
		int insertResult = hcs.insertEvent(event);
		System.out.println("hsCalController cal_writeAdEvent End...");
		if (insertResult > 0) return "redirect:/hs/adminCal";
		else {
			model.addAttribute("msg", "입력 실패! 확인해보세요");
			return "forward:/hs/adminCalWriteForm";
		}
	}
	
	// 관리자 캘린더 -> 상세보기 -> 수정페이지로 이동하는 logic
	@GetMapping(value = "/adminCalUpdate")
	public String cal_admin_calUpdateForm (CalTotal event1, Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_admin_calUpdateForm Start");
		CalTotal event = hcs.detailAdEvent(event1.getEventId());
		System.out.println("hsCalController cal_admin_calUpdateForm event->"+event);
		
		model.addAttribute("event", event);
		
		return "hs/adminCalUpdate";
	}
	
	// 관리자 캘린더 수정 완료된 폼 logic
	@PostMapping(value = "updateAdEvent")
	public String cal_admin_calUpdate (Event event, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("hsCalController cal_admin_calUpdate Start...");
		System.out.println("hsCalController cal_admin_calUpdate event->"+event);
		int updateCount = hcs.updateEvent(event);
		System.out.println("hsCalController cal_admin_calUpdate updateCount-> "+updateCount);
		model.addAttribute("uptCnt", updateCount);
		int eventid = event.getEventId();
		System.out.println("hsCalController cal_admin_calUpdate End...");
		return "redirect:/hs/adminCalDetail?eventId="+eventid;
	}

	
}
