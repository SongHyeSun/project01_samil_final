package com.oracle.samil.Acontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.samil.Adto.ResTotal;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.Facility;
import com.oracle.samil.Amodel.Reservation;
import com.oracle.samil.HsService.HsResService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value="/hs")
public class HsReservationController extends BaseController {
	@Autowired
	private HsResService hrs;
	
	// 사용자 시설예약 main page
	@GetMapping(value = "/res")
	public String res (ResTotal res, ResTotal faAp , Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("HsReservationController res start...");
		
		//예약대기 조회
		res.setResWriter(empno);
		List<ResTotal> listload = hrs.listload(res);
		model.addAttribute("facilLoad", listload);
		
		
		faAp.setResWriter(empno);
		//예약완료 조회
		List<ResTotal> listFacilAcc = hrs.listFacilAcc(faAp);
		model.addAttribute("facilAcc", listFacilAcc);
		
		//예약반려 조회
		List<ResTotal> listFacilRej = hrs.listFacilRej(faAp);
		model.addAttribute("facilRej", listFacilRej);
		
		System.out.println("HsReservationController res End...");
		return "hs/res";
	}
	
	
	// 사용자 시설예약 작성폼으로 넘어가는 logic
	@GetMapping(value = "/resWriteForm")
	public String res_resWriteForm (Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("HsReservationController res_resWriteForm start...");
		List<ResTotal> facilSort = hrs.facilSortlist();
		model.addAttribute("facilSort", facilSort);
		System.out.println("HsReservationController res_resWriteForm facilSort.size()-> "+facilSort.size());
		
		System.out.println("HsReservationController res_resWriteForm End...");
		return "hs/resWriteForm";
	}
	
	// 사용자 시설 예약 작성 완료된 폼 넘어가는 logic
	@PostMapping(value = "writeReserv")
	public String res_writeReserv (ResTotal res, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		// 작성자 설정
		res.setResWriter(empno);
		
		System.out.println("HsReservationController res_writeReserv start...");
		 int insertResult = hrs.insertReserv(res);
		System.out.println("HsReservationController res_writeReserv End...");
		if (insertResult > 0) {
			return "redirect:/hs/res";
		} else {
			model.addAttribute("msg", "입력 실패! 확인해보세요");
			return "forward:hs/resWriteForm";
		}
	}
	
	// 사용자 시설예약 수정화면 넘어가는 logic
	@RequestMapping("/resUpdate")
	public String res_resUpdateForm (ResTotal resT1, Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("HsReservationController res_resUpdateForm start...");
		
		//시설종류 combobox 불러오기
		List<ResTotal> facilSort = hrs.facilSortlist();
		model.addAttribute("facilSort", facilSort);
		System.out.println("HsReservationController res_resUpdateForm facilSort.size()-> "+facilSort.size());
		
		
		Reservation resT = hrs.detailRes(resT1.getResCode());
		System.out.println("HsReservationController res_resUpdateForm resT->"+resT);
		
		model.addAttribute("reservation", resT);
		return "hs/resUpdate";
	}
	
	// 사용자 시설예약 수정완료된 폼 넘어가는 logic
	@PostMapping(value = "resRealUpdate")
	public String res_resUpdate (ResTotal res, Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("HsReservationController res_resUpdate start...");
		System.out.println("HsReservationController res_resUpdate res-> "+res);
		
		int updateCount = hrs.updateReserv(res);
		System.out.println("HsReservationController res_resUpdate updateCount-> "+updateCount);
		model.addAttribute("uptCnt", updateCount);
		
		System.out.println("HsReservationController res_resUpdate End...");
		return "redirect:/hs/res";
	}
	
	
	// 사용자 시설예약 삭제 logic
	@PostMapping("/deleteRes")
	public String res_resDelete (Reservation res, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("HsReservationController res_resDelete Start...");
		int result = hrs.deleteRes(res.getResCode());
		System.out.println("HsReservationController res_resDelete End...");
		return "redirect:/hs/res";
	}
	
	// 관리자 시설예약 메인 page
	@GetMapping(value = "/adminRes")
	public String res_admin (ResTotal facil, ResTotal resT, Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("HsReservationController res_admin start...");
		
		
		//시설종류 조회
		List<ResTotal> facilSort = hrs.facilSortlist();
		model.addAttribute("facilSort", facilSort);
		
		//승인 신청 조회
		resT.setResAdId(empno);
		List<ResTotal> reserList = hrs.listappr(resT);
		model.addAttribute("reserList", reserList);
		
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
		
		System.out.println("HsReservationController res_admin End...");
		return "hs/adminRes";
	}
	
	// 관리자 시설예약 시설종류 수정화면으로 넘어가는 form logic (팝업창)
	@GetMapping(value = "/adminResUpdate")
	public String res_admin_resUpdateForm (Facility faci1, Model model){
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("HsReservationController res_admin_resUpdateForm start...");
		
		Facility facil = hrs.detailfacil(faci1.getFacilId());
		model.addAttribute("facility", facil);
		System.out.println("HsReservationController res_resUpdateForm facil->"+facil);
		return "hs/adminResUpdate";
	}
	
	// 관리자 시설예약 시설종류 수정완료된 폼 logic (모달창)
	@PostMapping("updateFac")
	public String res_admin_resUpdate (Facility facil, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("HsReservationController res_admin_resUpdate start...");
		System.out.println("HsReservationController res_admin_resUpdate facil-> "+facil);
		
		int updateCount = hrs.updateFac(facil);
		System.out.println("HsReservationController res_admin_resUpdate updateCount-> "+updateCount);
		model.addAttribute("uptCnt", updateCount);
		
		System.out.println("HsReservationController res_admin_resUpdate End...");
		return "redirect:/hs/adminRes";
	}
	
	// 관리자 시설예약 추가 작성 완료된 폼 logic (모달창에서)
	@PostMapping("writeFacil")
	public String res_admin_facilWrite(Facility facil, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("HsReservationController res_admin_facilWrite start...");
		 int insertResult = hrs.insertFacil(facil);
		System.out.println("HsReservationController res_admin_facilWrite End...");
		if (insertResult > 0) {
			return "redirect:/hs/adminRes";
		} else {
			model.addAttribute("msg", "입력 실패! 확인해보세요");
			return "forward:hs/adminRes";
		}
	}
	
	//관리자 시설예약 시설종류 삭제 logic
	@PostMapping("deleteAdFacil")
	public String res_admin_facDelete(Facility facil, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		System.out.println("HsReservationController res_admin_facDelete start...");
		int result = hrs.deleteFacil(facil.getFacilId());
		System.out.println("HsReservationController res_admin_facDelete End...");
		return "redirect:/hs/adminRes";
	}
	
	//관리자 시설예약 승인하는 로직
	@PostMapping("reserApproAd")
	public String res_admin_facilAppr(ResTotal facAp, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		// 작성자 설정
		facAp.setResAdId(empno);
		System.out.println("HsReservationController res_admin_facilAppr start...");
		
		//승인사유 insert (facilApprove TBL)
		hrs.insertResRea(facAp);
		
		//승인여부 update (reservation TBL)
		hrs.updateResState(facAp);
		System.out.println("HsReservationController res_admin_facilAppr facAp-> "+facAp);
		
		System.out.println("HsReservationController res_admin_facilAppr End...");
		return "redirect:/hs/adminRes";
	}
	
	//관리자 시설예약 반려하는 로직
	@PostMapping("reserRejecAd")
	public String res_admin_facilRejec(ResTotal facAp, Model model) {
		
		//로그인 후 empno
		Emp emp = getUser();	//BaseController에서 가져옴
		int empno = emp.getEmpno();	//empno 가져오기
		
		// 작성자 설정
		facAp.setResAdId(empno);
		
		System.out.println("HsReservationController res_admin_facilRejec start...");
		
		//승인사유 insert (facilApprove TBL)
		hrs.insertResRea(facAp);
		
		//승인여부 update (reservation TBL)
		hrs.updateResState(facAp);
		System.out.println("HsReservationController res_admin_facilRejec facAp-> "+facAp);
		
		System.out.println("HsReservationController res_admin_facilRejec End...");
		return "redirect:/hs/adminRes";
	}
	
}
