package com.oracle.samil.Acontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.hibernate.internal.build.AllowSysOut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequestInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.WebRequestHandlerInterceptorAdapter;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Attendance;
import com.oracle.samil.Amodel.Dept;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.Sal;
import com.oracle.samil.MhService.Paging;
import com.oracle.samil.MhService.SalService;
import com.oracle.samil.TrService.EmpService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


import org.springframework.beans.factory.annotation.Autowired;

import com.oracle.samil.Amodel.Emp;

import jakarta.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@RequestMapping(value="/mh")
public class MhSalController extends BaseController {

	@Autowired
	private final SalService ss;
	@Autowired
	private final EmpService es;
	
	@PostMapping(value = "/salJoin")
	public String sal_join(@RequestParam("empno") int empno,
							@RequestParam("salNum") String salNum,
	
							Model model) {
	    System.out.println("mh sal_join play~");
	    Map<String, Object> joinList = ss.joinList(empno,salNum);
	    model.addAttribute("empno", empno);
	    model.addAttribute("salNum", salNum);
	    model.addAttribute("joinList", joinList);
	    return "mh/salJoin"; 
	}

		@GetMapping(value = "/adminSalSet")
		public String empList (Sal sal, Model model){
			int totalSal =  ss.totalSal();
			String currentPage = "1";
		

			Paging page = new Paging(totalSal, sal.getCurrentPage());
			sal.setStart(page.getStart());
			sal.setEnd(page.getEnd());
			String salDate = ss.getSalDate();
			System.out.println("page.getEnd()1 ->"+ page.getEnd());

			System.out.println("Sal->" + totalSal);
			List<Sal> listEmp = ss.totalEmp(sal);
			model.addAttribute("totalSal", totalSal);
			model.addAttribute("listEmp", listEmp);
			model.addAttribute("page", page);
			model.addAttribute("salDate", salDate);
			
			System.out.println("controller salDate->" +salDate);
			
			return "/mh/adminSalSet";
			
		}
		@ResponseBody
	    @GetMapping("/getDeptName")
		  public ResponseEntity<Map<String, Sal>> getDeptName(@RequestParam("empno") int empno) {
			Sal sal = new Sal();
			sal.setEmpno(empno);
			Sal shemp = ss.shemp(sal);
			Map<String, Sal> response = new HashMap<>();
			response.put("response", shemp);
			
	        return ResponseEntity.ok(response); 
		}
		
		@RequestMapping(value = "listSearch")
		public String listSearch(Sal sal ,  Model model) {
			System.out.println("EmpController Start listEmp..." );
			System.out.println("EmpController listSearch sal->"+sal );
			// Emp 전체 Count   
			int totalEmp =  ss.totalSal();
			// Paging 작업
			Paging   page = new Paging(totalEmp, sal.getCurrentPage());
			// Parameter emp --> Page만 추가 Setting
			sal.setStart(page.getStart());   // 시작시 1
			sal.setEnd(page.getEnd());       // 시작시 10 
			String salDate = ss.getSalDate();
			List<Sal> listSearchEmp = ss.listSearchEmpSet(sal);
			// 1. DAO  ed.empSearchList3(emp);
	        // 2. Mapper selectList("tkEmpSearchList3", emp);

			System.out.println("EmpController listSearch3 listSearchEmp.size()=>" + listSearchEmp.size());
			model.addAttribute("salDate",  salDate);
			model.addAttribute("totalEmp", totalEmp);
			model.addAttribute("listEmp" , listSearchEmp);
			model.addAttribute("page"    , page);
			return "mh/adminSalSet";
		}
		
		@RequestMapping(value = "/listSearchGive")
		public String listSearchGive(Sal sal ,  Model model) {
			System.out.println("EmpController Start listEmp..." );
			System.out.println("EmpController listSearch sal->"+sal );
			// Emp 전체 Count   
			int totalEmp =  ss.totalSal();
			// Paging 작업
			Paging   page = new Paging(totalEmp, sal.getCurrentPage());
			// Parameter emp --> Page만 추가 Setting
			sal.setStart(page.getStart());   // 시작시 1
			sal.setEnd(page.getEnd());       // 시작시 10 

			List<Sal> listSearchEmp = ss.listSearchEmpSet(sal);
			// 1. DAO  ed.empSearchList3(emp);
	        // 2. Mapper selectList("tkEmpSearchList3", emp);
			String salDate = ss.getSalDate();

			System.out.println("EmpController listSearch3 listSearchEmp.size()=>" + listSearchEmp.size());
			model.addAttribute("salDate",  salDate);
			model.addAttribute("totalEmp", totalEmp);
			model.addAttribute("listEmp" , listSearchEmp);
			model.addAttribute("page"    , page);
			return "mh/adminSalGive";
		}
		
		@ResponseBody
		@GetMapping("/loadEmployeeData")
		public ResponseEntity<Map<String, Object>> getEmployeeList(@RequestParam("currentPage") int currentPage) {
			int totalCount = ss.totalSal();
			int pageBlock = 10;
			int totalPage = (int)Math.ceil((double)totalCount/pageBlock);
			Paging page = new Paging(currentPage, totalPage, pageBlock);
			Sal sal = new Sal();
			sal.setStart(page.getStart());
			sal.setEnd(page.getEnd());
			List<Sal> listemp = ss.totalEmp(sal);
			System.out.println("controller listemp->"+listemp);
			Map<String, Object> resultMap = new HashMap<>();
			System.out.println("page.getEnd()2 ->"+ page.getEnd());
			resultMap.put("listEmp", listemp);
			resultMap.put("page", page);
			return new ResponseEntity<>(resultMap, HttpStatus.OK);
		}
		
		
		@RequestMapping(value = "/adminSalGive")
		public String admin_sal_give (Sal sal, Model model){
			int totalSal =  ss.totalSal();
			String currentPage = "1";
			String salDate = ss.getSalDate();
			
			Paging page = new Paging(totalSal, sal.getCurrentPage());
			sal.setStart(page.getStart());
			sal.setEnd(page.getEnd());
			
			System.out.println("page.getEnd()1 ->"+ page.getEnd());
			String salNum = ss.getSalNum();
			model.addAttribute("salNum", salNum);

			System.out.println("Sal->" + totalSal);
			List<Sal> listEmp = ss.totalEmp(sal);
			model.addAttribute("totalSal", totalSal);
			model.addAttribute("listEmp", listEmp);
			model.addAttribute("page", page);
			model.addAttribute("salDate", salDate);
			return "mh/adminSalGive";
		}
		
		
		@GetMapping(value = "/adminSalSetUpdate")
		public String sal_setUpdate (@RequestParam("empno") int empno, Model model){
			System.out.println("mh sal_setUpdate play~");
			System.out.println("empno->" +empno);
			Sal sal = new Sal();
			sal.setEmpno(empno);
			Sal shemp = ss.shemp(sal);
			System.out.println("shemp->"+shemp);
			model.addAttribute("shemp", shemp);
			return "mh/adminSalSetUpdate";
		}
		
		@GetMapping(value = "/adminSalGiveD")
		public String sal_give_D (@RequestParam("empno") int empno, Model model){
			Sal sal = new Sal();
			String salDate = ss.getSalDate();
			sal.setEmpno(empno);
			Sal shemp = ss.shemp(sal);
			System.out.println("shemp->"+shemp);
			model.addAttribute("empno", empno);
			model.addAttribute("shemp", shemp);
			model.addAttribute("salDate", salDate);
			return "mh/adminSalGiveD";
		}
		
		@GetMapping(value = "/adminSalList")
		public String sal_list  (Sal Sal, Model model){
			String salDate = ss.getSalDate();
			String salNum = ss.getSalNum();
			List<Sal> mSalList = ss.mSalList(Sal);
			// Emp 전체 Count   
			int totalEmp =  ss.totalSal();
			// Paging 작업
			Paging   page = new Paging(totalEmp,Sal.getCurrentPage());
			// Parameter emp --> Page만 추가 Setting
			Sal.setStart(page.getStart());   // 시작시 1
			Sal.setEnd(page.getEnd());       // 시작시 10 
			model.addAttribute("SalDate", salDate);
			model.addAttribute("listEmp", mSalList);
			model.addAttribute("totalEmp", totalEmp);
			model.addAttribute("page"    , page);
			model.addAttribute("salNum"    , salNum);
			System.out.println("mSalList->" +mSalList);
			System.out.println("mh admin_sal_list play~");
			return "mh/adminSalList";
		}
			
			@RequestMapping(value = "/listSearchList")
			public String listSearchList(Sal sal ,  Model model, Dept dept,
					@RequestParam(value = "keyword", required = false) String keyword) {
				System.out.println("EmpController Start listEmp..." );
				System.out.println("EmpController listSearch sal->"+sal );
				// Emp 전체 Count   
				int totalEmp =  ss.totalSal();
				// Paging 작업
				Paging   page = new Paging(totalEmp, sal.getCurrentPage());
				// Parameter emp --> Page만 추가 Setting
				sal.setStart(page.getStart());   // 시작시 1
				sal.setEnd(page.getEnd());       // 시작시 10 

				List<Sal> listSearchEmp = ss.listSearchEmp(sal);
				// 1. DAO  ed.empSearchList3(emp);
		        // 2. Mapper selectList("tkEmpSearchList3", emp);


				System.out.println("EmpController listSearch3 listSearchEmp.size()=>" + listSearchEmp.size());
				
				model.addAttribute("totalEmp", totalEmp);
				model.addAttribute("listEmp" , listSearchEmp);
				model.addAttribute("page"    , page);
				model.addAttribute("dept", dept);
				return "mh/adminSalList";
		}
			
		    private String getAttendanceStatus(String keyword) {
				// TODO Auto-generated method stub
				return null;
			}
			
		
		    @ResponseBody
			@PostMapping("/updateSal")
			public ResponseEntity<String> updateSalary(Sal sal, @RequestParam("empno" ) int empno) {
			    System.out.println("updatesal sal: " + sal);
			    System.out.println("updatesal empno: " + empno);
			    // empno로 sal 정보를 조회
			    Optional<Integer> empSalempno = ss.empSalempno(empno);
			    System.out.println("empSalempno: " + ss.empSalempno(empno));
			    try {
			        // empno가 존재하는 경우
			        if (empSalempno.isPresent()) {
			            // 급여 정보 업데이트 로직
			            int updateCount = ss.updateSal(sal);  // updateSal의 반환값 처리
			            System.out.println("ss.updateSal(sal) - 업데이트된 행 수: " + updateCount);

			            if (updateCount > 0) {
			                return ResponseEntity.ok("급여 정보가 성공적으로 업데이트되었습니다.");
			            } else {
			                return ResponseEntity.status(500).body("급여 정보 업데이트에 실패했습니다.");
			            }

			        } else {
			            // empno가 존재하지 않는 경우, 신규 데이터 삽입
			            ss.newInsert(sal);
			            return ResponseEntity.ok("급여 정보를 신규 등록했습니다.");
			        }

			    } catch (Exception e) {
			        // 예외 발생 시 처리
			        e.printStackTrace();  // 로그 출력
			        return ResponseEntity.status(500).body("급여 정보 처리 중 오류가 발생했습니다.");
			    }
			}
			
			@PostMapping("/adminSalSet")
			public String submitDate (@RequestParam("day") int day, Model model) {
				Sal sal = new Sal();
				int submitDate = ss.submitDate(day);
				String salDate = ss.getSalDate();
				System.out.println("controller day->"+ day);
				int totalSal =  ss.totalSal();
				String currentPage = "1";
				
				Paging page = new Paging(totalSal, sal.getCurrentPage());
				sal.setStart(page.getStart());
				sal.setEnd(page.getEnd());


				List<Sal> listEmp = ss.totalEmp(sal);
				
				model.addAttribute("submitDate", submitDate);
				model.addAttribute("salDate",  salDate);
				model.addAttribute("totalSal", totalSal);
				model.addAttribute("listEmp", listEmp);
				model.addAttribute("page", page);
				return "/mh/adminSalSet";
			}
			
			
			
			@GetMapping(value = "/insertSal")
			public String insertSal(Sal sal, Model model, HttpSession session) {
				System.out.println("Congtroller insertSal start...");
				System.out.println("Congtroller insertSal sal->"+sal);
				Emp emp = (Emp) session.getAttribute("emp");
				sal.setEmpno(emp.getEmpno());
				int insertSal = ss.insertSal(sal.getEmpno());
				model.addAttribute("empno", sal.getEmpno());
				model.addAttribute("insertSal", insertSal);
				System.out.println("Congtroller insertSal End empno:" +sal.getEmpno());
				return  "redirect:/mh/adminSalGive";
			}
			
			@PostMapping("/saveBank")
		    public String saveBank(@RequestParam(value = "selectedBank", required = false) String selectedBank,  
		    						@RequestParam(value="iempno", defaultValue = "0") int empno, 
		    						@RequestParam(value="iaccount", required = false) String account,
		    						Model model) {
		        int updateBank = ss.updateBank(selectedBank, empno, account);
		        model.addAttribute("updateBank",updateBank );
		        
		        return "redirect:/mh/adminSalSet";  // 처리 후 성공 페이지 또는 다른 페이지로 리다이렉트
		    }
			
			
			
			
			@GetMapping("/overtimeSal")
		    public List<Sal> overtimeSal(@RequestParam("salNum") String salnum, Sal sal, Model model) {
				List<Sal> overtimeSalList = ss.overtimeSalList(salnum);
				System.out.println("mhovertimeSalList->" + overtimeSalList);
				System.out.println("Controller overtimeSal sal->" + sal);
				String salNum = ss.getSalNum();
				int totalSal =  ss.totalSal();
				String currentPage = "1";
				String salDate = ss.getSalDate();
				
				Paging page = new Paging(totalSal, sal.getCurrentPage());
				sal.setStart(page.getStart());
				sal.setEnd(page.getEnd());
				
				System.out.println("page.getEnd()1 ->"+ page.getEnd());
				model.addAttribute("salNum", salNum);

				List<Sal> listEmp = ss.totalEmp(sal);
				model.addAttribute("totalSal", totalSal);
				model.addAttribute("listEmp", listEmp);
				model.addAttribute("page", page);
				model.addAttribute("salDate", salDate);
				model.addAttribute("salNum", salNum);
				model.addAttribute("overtimeSalList", overtimeSalList);
				
		        return overtimeSalList; 
		    }
			
			@GetMapping("/updateOvertimeSal")
		    public String updateOvertimeSalary(@RequestParam("salNum") String salnum,
		    		                            HttpSession session,
		    									Sal sal,
		    									Model model) {
				Emp emp = (Emp) session.getAttribute("emp");
				sal.setEmpno(emp.getEmpno());
				String salNum = ss.getSalNum();
				// mhEmpSal 조회를 통해 관련정보 Get
				Sal sal2 = ss.getSalModel(sal);
				System.out.println("Controller updateOvertimeSal sal2->>"+sal2);
				int updateOvertimeSal = ss.updateOvertimeSal(sal2);
				List<Sal> overtimeSalList = ss.overtimeSalList(salnum);
				// mh 용도
				Sal shemp = ss.shemp(sal);
				System.out.println("updateOvertimeSal shemp->>"+shemp);
				int totalSal =  ss.totalSal();
				List<Sal> listEmp = ss.totalEmp(sal);
				model.addAttribute("totalSal", totalSal);
				model.addAttribute("listEmp", listEmp);
				model.addAttribute("overtimeSalList", overtimeSalList);
				model.addAttribute("salNum", salNum);
				model.addAttribute("shemp", shemp);
				model.addAttribute("updateOvertimeSal", updateOvertimeSal);
		        return "/mh/overtimeSal";
		    }

			@PostMapping("/processStep1")
			@ResponseBody  // AJAX 응답을 JSON 형태로 반환
			public String processStep1(@RequestParam("empno") String empno,
			                           @RequestParam("salNum") String salNum,
			                           @RequestParam("password") String password,
			                           HttpSession session) {
				System.out.println("processStep1 start");
				boolean isValidUser = es.validateUser(empno, password);
		    	
			    if(isValidUser) {

			        // 비밀번호가 올바른 경우 salNum을 세션에 저장
			        session.setAttribute("salNum", salNum); 
			        System.out.println("비번성공");
			        return "/salJoin";
			    } else {
			        // 비밀번호가 틀린 경우
			    	System.out.println("비번실패");
			        return "비밀번호가 올바르지 않습니다.";
			    }
			}
		    
		    @GetMapping("/check")
		    public String check(@RequestParam("salNum") String salNum, @RequestParam("empno") String empno, Model model) {
		    	
		    	model.addAttribute("salNum", salNum);
		    	model.addAttribute("empno", empno);
		    	
				return "/mh/check";
		    	
		    }
}