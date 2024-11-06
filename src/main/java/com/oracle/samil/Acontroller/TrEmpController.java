package com.oracle.samil.Acontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.StringTokenizer;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Dept;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.LoginInfo;
import com.oracle.samil.TrService.EmpService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;







@Controller
@RequestMapping(value="/tr")
public class TrEmpController {
	
	@Autowired
	private EmpService es;
	
	@Value("${file.path}/tr")
	private String filePath;
	
	@RequestMapping(value = "/findPassword")
	public String findPassword (){
		System.out.println("tr infdPasswordplay~");
		return "tr/findPassword";
	}
	

	@RequestMapping(value = "/findPasswordCheck")
	public String findPasswordCheck (@RequestParam("passQuiz") int passQuiz,@RequestParam("passAnswer")  String passAnswer,@RequestParam("empno")  String empno , Model model){
		System.out.println("tr infdPasswordCheckplay~");
		LoginInfo loginInfo =es.findPassword(passQuiz, passAnswer, empno);
		model.addAttribute("LoginInfo",loginInfo);
		return "tr/showPassword";
	}
	
	@RequestMapping(value = "/addEmp")
	public String addEmp (HttpServletRequest request,  @RequestParam("image") MultipartFile image){
		System.out.println("addEmp");
		
		Emp emp= new Emp();
		
		if (!image.isEmpty()) {
            try {
                // Define your target directory using the injected path
                File directory = new File(filePath);
                if (!directory.exists()) {
                    directory.mkdirs(); // Create the directory if it does not exist
                }

                // Define the file path
                String originalFilename = image.getOriginalFilename();
                String fileSavePath = directory.getAbsolutePath() + File.separator + originalFilename;
                File fileToSave = new File(fileSavePath);
                image.transferTo(fileToSave); // Save the file

                // Store the file name in the Utility object
                emp.setImage(originalFilename); // 경로 대신 파일 이름을 저장
            } catch (IOException e) {
                e.printStackTrace(); 
            }
        }	
		
		System.out.println(request.getParameter("emailID"));
		System.out.println(request.getParameter("emailDomain"));
		emp.setName(request.getParameter("name"));	
		String email=request.getParameter("emailId")+"@"+request.getParameter("emailDomain");
		emp.setEmail(email);
		System.out.println("tr addEmp play~"+3);
		emp.setPhone(request.getParameter("phone"));
		emp.setGrade(Integer.parseInt(request.getParameter("grade")));
		System.out.println("tr addEmp play~"+4);
		emp.setJob(Integer.parseInt(request.getParameter("job")));
		System.out.println("tr addEmp play~"+5);
		emp.setBank(request.getParameter("bank"));
		System.out.println("tr addEmp play~"+6);
		emp.setAccount(request.getParameter("account"));
		System.out.println("tr addEmp play~"+7);
		emp.setAddress(request.getParameter("address"));
		System.out.println("tr addEmp play~"+8);
		emp.setHiredate(request.getParameter("hiredate"));
		System.out.println("tr addEmp play~"+request.getParameter("deptno"));
		emp.setDeptno(Integer.parseInt(request.getParameter("deptno")));
		System.out.println("tr addEmp play~"+10);
		emp.setAdmin(0);
		System.out.println("tr addEmp play~");
		emp.setRecentEditor(1001);
		System.out.println("tr addEmp play~"+12);
		LocalDateTime now = LocalDateTime.now();
		String nowString= now.toString();
		System.out.println(nowString);
		emp.setRecentEditDate(nowString);
		System.out.println("tr addEmp play~"+13);
		System.out.println("tr addEmp play~"+emp.getEmpno());
		int insertResult = es.insertEmp(emp);
		return "redirect:adminEmpList";
	}
	
	@RequestMapping(value = "/empSearch")
	public String per_search (Model model){
		System.out.println("tr per_search play~");
		List<EmpDept> empdeptlist=es.empdeptSelect();
		model.addAttribute("empDeptList",empdeptlist);
		return "tr/empSearch";
	}
	
	@RequestMapping(value = "/searchEmpByKeyword")
	public String searchEmpByKeyword (Model model, @RequestParam("keyword") String keyword, @RequestParam("option") String option){
		System.out.println("tr serchByKeyword~");
		List<EmpDept> empdeptlist=es.searchByKeyword(keyword,option);
		model.addAttribute("empDeptList",empdeptlist);
		return "tr/empSearch";
	}
	@RequestMapping(value = "/deleteDept")
	public String deleteDept (Model model, @RequestParam("deptno") int deptno){
		System.out.println("tr deleteDept~");
		int result=es.deleteDept(deptno);		
		return "redirect:adminGroupChart";
	}
	@RequestMapping(value = "/searchEmpByKeyword_admin")
	public String searchEmpByKeyword_admin (Model model, @RequestParam("keyword") String keyword,@RequestParam("option") String option){
		System.out.println("tr serchByKeyword~");
		List<EmpDept> empdeptlist=es.searchByKeyword(keyword,option);
		model.addAttribute("empDeptList",empdeptlist);
		return "tr/adminEmpList";
	}
	
	@RequestMapping(value = "/updateEmp")
	public String updateEmp (HttpServletRequest request, Model model,  @RequestParam("image") MultipartFile image){
		Emp emp= new Emp();
		
		if (!image.isEmpty()) {
            try {
                // Define your target directory using the injected path
                File directory = new File(filePath);
                if (!directory.exists()) {
                    directory.mkdirs(); // Create the directory if it does not exist
                }

                // Define the file path
                String originalFilename = image.getOriginalFilename();
                String fileSavePath = directory.getAbsolutePath() + File.separator + originalFilename;
                File fileToSave = new File(fileSavePath);
                image.transferTo(fileToSave); // Save the file

                // Store the file name in the Utility object
                emp.setImage(originalFilename); // 경로 대신 파일 이름을 저장
            } catch (IOException e) {
                e.printStackTrace(); 
            }
        }else {
        	emp.setImage(request.getParameter("image1"));
 
        }
		System.out.println("이미지 +"+emp.getImage());
		emp.setEmpno(Integer.parseInt(request.getParameter("empno")));
		emp.setName(request.getParameter("name"));
		System.out.println("tr addEmp play~"+1);
		System.out.println("tr addEmp play~"+2);
		String email=request.getParameter("emailId")+"@"+request.getParameter("emailDomain");
		emp.setEmail(email);
		System.out.println("tr addEmp play~"+3);
		emp.setPhone(request.getParameter("phone"));
		emp.setGrade(Integer.parseInt(request.getParameter("grade")));
		System.out.println("tr addEmp play~"+4);
		emp.setJob(Integer.parseInt(request.getParameter("job")));
		System.out.println("tr addEmp play~"+5);
		emp.setBank(request.getParameter("bank"));
		System.out.println("tr addEmp play~"+6);
		emp.setAccount(request.getParameter("account"));
		System.out.println("tr addEmp play~"+7);
		emp.setAddress(request.getParameter("address"));
		System.out.println("tr addEmp play~"+request.getParameter("deptno"));
		emp.setDeptno(Integer.parseInt(request.getParameter("deptno")));
		System.out.println("tr addEmp play~"+10);
		emp.setAdmin(0);
		System.out.println("tr addEmp play~");	
		emp.setRecentEditor(Integer.parseInt(request.getParameter("recentEditor")));
		System.out.println("tr addEmp play~"+12);
		LocalDateTime now = LocalDateTime.now();
		String nowString= now.toString();
		System.out.println(nowString);
		emp.setRecentEditDate(nowString);
		System.out.println("tr addEmp play~"+emp.getEmpno());
		emp.setAdmin(Integer.parseInt(request.getParameter("admin")));
		System.out.println("tr set Admin"+request.getParameter("admin"));
		int insertResult = es.updateEmp(emp);
		List<EmpDept> empdeptlist=es.empdeptSelect();
		model.addAttribute("empDeptList",empdeptlist);
		return "tr/adminEmpList";
	}
	
	@RequestMapping(value = "/updateOwnEmp")
    public String updateOwnEmp (HttpServletRequest request, Model model,HttpSession session){
        Emp emp= new Emp();
        String email=request.getParameter("emailId")+"@"+request.getParameter("emailDomain");
        System.out.println(email);
        emp.setEmpno(Integer.parseInt(request.getParameter("empno")));
        emp.setEmail(email);
        emp.setPhone(request.getParameter("phone"));
        emp.setBank(request.getParameter("bank"));
        emp.setAccount(request.getParameter("account"));
        emp.setAddress(request.getParameter("address"));
        emp.setRecentEditor(Integer.parseInt(request.getParameter("recentEditor")));
        LocalDateTime now = LocalDateTime.now();
        String nowString= now.toString();
        System.out.println(nowString);
        emp.setRecentEditDate(nowString);
        int insertResult = es.updateOwnEmp(emp);
        Emp emp1 = es.findEmpbyEmpno(emp.getEmpno()+"");
        StringTokenizer emailTokenizer = new StringTokenizer(emp1.getEmail(), "@");
        emp1.setEmail1(emailTokenizer.nextToken());
        emp1.setEmail2(emailTokenizer.nextToken());
        session.setAttribute("emp", emp1);
        return "redirect:../userMain?empno="+emp.getEmpno();
    }
		
	@RequestMapping(value = "/userGroupChart")
	public String per_check (Model model){
		System.out.println("tr per_check play~");
		List<Dept> deptlist= es.deptSelect();
		model.addAttribute("deptList",deptlist);
		return "tr/userGroupChart";
	}
	@RequestMapping(value = "/editDept")
	public String editDept (Model model, @RequestParam("deptno") int deptno){
		System.out.println("tr editDept play~");
		Dept dept=new Dept();
		dept=es.findDeptByDeptno(deptno);
		List<Emp> emplist=es.empCaptainSelect();
		model.addAttribute("empList",emplist);
		model.addAttribute("dept",dept);		
		return "tr/editDept";
	}
	@RequestMapping(value = "/addDept")
	public String addDept (Model model){
		System.out.println("tr editDept play~");
		List<Emp> emplist=es.empCaptainSelect();
		List<Dept> deptlist= es.deptSelect();
		model.addAttribute("empList",emplist);
		model.addAttribute("deptList",deptlist);
		return "tr/addDept";
	}
	@RequestMapping(value = "/updateDept")
	public String updateDept (Model model, HttpServletRequest request){
		Dept dept=new Dept();
		dept.setDeptno(Integer.parseInt(request.getParameter("deptno")));
		dept.setDepttel(request.getParameter("deptTel"));
		dept.setDeptName(request.getParameter("deptName"));
		dept.setManager(Integer.parseInt(request.getParameter("manager")));
		int result = es.updateDept(dept);
		System.out.println("updateDept  redirect:adminGroupChart before...");
		return "redirect:adminGroupChart";
	}
	
	@RequestMapping(value = "/adminEmpInsert")
	public String admin_per_inform (Model model){
		System.out.println("tr admin_per_inform play~");
		List<Dept> deptlist= es.deptSelect();
		model.addAttribute("deptList",deptlist);
		return "tr/adminEmpInsert";
	}
	
	@RequestMapping(value = "/adminEmpList")
	public String admin_per_manage (Model model){
		System.out.println("tr admin_per_manage play~");
		List<EmpDept> empdeptlist=es.empdeptSelect();
		model.addAttribute("empDeptList",empdeptlist);
		return "tr/adminEmpList";
	}
	@RequestMapping(value = "/changeOwnEmp")
	public String changeOwnEmp (Model model){
		System.out.println("tr admin_per_manage play~");
		List<EmpDept> empdeptlist=es.empdeptSelect();
		model.addAttribute("empDeptList",empdeptlist);
		return "tr/changeOwnEmp";
	}
	
	@RequestMapping(value = "editEmpData")
	public String adminEditData (@RequestParam("empno") String  empno,Model model){

		System.out.println(" editEmpData empno->"+empno);
		EmpDept empdept= es.findEmpDeptbyEmpno(empno);
		List<Dept> deptlist= es.deptSelect();
		StringTokenizer emailTokenizer = new  StringTokenizer(empdept.getEmail(), "@") ;
		empdept.setEmail1(emailTokenizer.nextToken());
		empdept.setEmail2(emailTokenizer.nextToken());
		model.addAttribute("deptList",deptlist);
		model.addAttribute("emp1",empdept);
		System.out.println(" editEmpData redirect:adminGroupChart Before");

		return "tr/editEmpData";
	}
	
	@RequestMapping(value = "showDeptMember")
	public String showDeptMember (@RequestParam("deptno") int  deptno,Model model){
		System.out.println(" showDeptMember->"+deptno);
		List<EmpDept> empDeptlist= es.showDeptMember(deptno);
		model.addAttribute("empDeptList",empDeptlist);
		return "tr/adminEmpList";
	}
	@RequestMapping(value = "showDeptMemberUser")
	public String showDeptMemberUser (@RequestParam("deptno") int  deptno,Model model){
		System.out.println(" showDeptMember->"+deptno);
		List<EmpDept> empDeptlist= es.showDeptMember(deptno);
		model.addAttribute("empDeptList",empDeptlist);
		return "tr/empSearch";
	}
	@RequestMapping(value = "deleteEmp")
	public String deleteEmp (@RequestParam("empno") int  empno,Model model){
		System.out.println(" deleteMember->"+empno);
		es.deleteEmp(empno);
		return "redirect:adminEmpList";
	}
	
	@RequestMapping(value = "/adminGroupChart")
	public String admin_group_check (Model model){
		System.out.println("tr admin_group_check play  kkkk     ...~");
		List<Dept> deptlist= es.deptSelect();
		model.addAttribute("deptList",deptlist);
		return "tr/adminGroupChart";
	}
	@RequestMapping(value = "/insertDept")
	public String insertDept (Model model, HttpServletRequest request){
		System.out.println("tr insertDept~");
		Dept dept = new Dept();
		dept.setDeptName(request.getParameter("deptName"));
		dept.setDepttel(request.getParameter("tel"));
		dept.setHigherdeptno(Integer.parseInt(request.getParameter("upperDept")));
		dept.setManager(Integer.parseInt(request.getParameter("upperDept")));
		es.insertDept(dept);		
		
		return "redirect:adminGroupChart";
	}
}
