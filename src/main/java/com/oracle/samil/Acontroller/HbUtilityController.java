package com.oracle.samil.Acontroller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Utility;
import com.oracle.samil.HbService.UtilityService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping(value="/hb")
public class HbUtilityController {
		
		private final UtilityService hbUtilityService;
		// 파일 저장 메소드
		@Value("${file.path}/hb")
		private String filePath;
		
		// 유저 페이지에 나올 데이터 가져오기
		@GetMapping(value = "/costUtility")
		public String utilityChart(Model model, Utility utility) {
		    List<Utility> utilityList = hbUtilityService.getUtilityData();
		    model.addAttribute("utilityData", utilityList);
		    
		    // UtilityDetail과 Cost가 있는지 확인
		    for (Utility util : utilityList) {
		        System.out.println("Detail: " + util.getUtilityDetail() + ", Cost: " + util.getUtilityCost()+util.getUtilityYyyymm());
		    }

		    Map<Integer, String> utilityMap = new HashMap<>();
		    utilityMap.put(100, "수도세");
		    utilityMap.put(110, "전기세");
		    utilityMap.put(120, "관리비");
		    model.addAttribute("utilityMap", utilityMap);
		    
		    return "hb/costUtility"; // JSP 뷰 이름
		}
		
		// 관리자 페이지에서 데이터를 표가 아닌 테이블로 확인
	  @GetMapping(value = "/adminCostUtility")
	  public String adminCostUtility(Model model) {
	      List<Utility> utilityList = hbUtilityService.getUtilityData();
	      model.addAttribute("utilityData", utilityList);
	      System.out.println("Utility List Size: " + utilityList.size()); 
	      Map<Integer, String> utilityMap = new HashMap<>();
	      utilityMap.put(100, "수도세");
	      utilityMap.put(110, "전기세");
	      utilityMap.put(120, "관리비");
	      model.addAttribute("utilityMap",utilityMap);// 추가된 로그
	      return "hb/adminCostUtility";
	  }
	  	// 관리자 공과금 추가 전 이미 추가된 공과금인지 확인
	  @PostMapping(value = "/checkDuplicate")
	  @ResponseBody
	  public Map<String, Boolean> checkDuplicate(
	          @RequestParam("utilityYyyymm") String utilityYyyymm,
	          @RequestParam("utilityDetail") int utilityDetail) {

	      String[] parts = utilityYyyymm.split("-");
	      int parsedYyyymm = Integer.parseInt(parts[0] + parts[1]);
	      
	      boolean exists = hbUtilityService.existsByYyyymmAndDetail(parsedYyyymm, utilityDetail);
	      Map<String, Boolean> response = new HashMap<>();
	      response.put("exists", exists);
	      return response;
	  }
	    // 공과금 추가
	    @PostMapping(value = "/adminCostUtility")
	    public String adminCostUtilityPlus(
	            @RequestParam("utilityAttach") MultipartFile utilityAttach,
	            @RequestParam("utilityYyyymm") String utilityYyyymm,
	            @RequestParam("utilityDetail") int utilityDetail,
	            @RequestParam("utilityCost") int utilityCost,
	            @RequestParam("empno") int empno,
	            Model model) {

	        // Utility 객체 수동 생성
	        Utility utility = new Utility();
	        EmpDept empDept = new EmpDept();
	        System.out.println("utilityDetail: " + utilityDetail); // 추가된 로그

	        // Yyyymm 변환
	        String[] parts = utilityYyyymm.split("-");
	        utility.setUtilityYyyymm(Integer.parseInt(parts[0] + parts[1]));
	        

	        // 추가된 필드 값 설정
	        utility.setUtilityDetail(utilityDetail); 
	        utility.setUtilityCost(utilityCost);
	        utility.setEmpno(empDept.getEmpno());
	        utility.setName(empDept.getName());

	        // 파일 업로드 처리
	        if (!utilityAttach.isEmpty()) {
	            try {
	                File directory = new File(filePath);
	                if (!directory.exists()) {
	                    directory.mkdirs(); // 디렉토리 존재하지 않으면 하나 생성
	                }

	                // 파일 경로 지정 
	                String originalFilename = utilityAttach.getOriginalFilename();
	                String fileSavePath = directory.getAbsolutePath() + File.separator + originalFilename;
	                File fileToSave = new File(fileSavePath);
	                utilityAttach.transferTo(fileToSave); // 파일 저장

	                // 파일 이름으로 데이터에 넣기
	                utility.setUtilityAttach(originalFilename); // 경로 대신 파일 이름을 저장
	            } catch (IOException e) {
	                e.printStackTrace(); 
	                return "hb/adminCostUtility";
	            }
	        }

	        // 파일이름으로 데이터에 저장
	        hbUtilityService.UilityPlus(utility);
	        return "redirect:/hb/adminCostUtility";
	    }
	    //파일 불러오기 메소드
	    @RequestMapping("/downloadUtilityAttach")
	    public ResponseEntity<Resource> downloadUtilityAttach(@RequestParam("fileName") String fileName) throws UnsupportedEncodingException {
	    	try{ 
	            String decodedFileName = URLDecoder.decode(fileName, StandardCharsets.UTF_8.toString());
	    		System.out.println("Requested file name: " + decodedFileName); // 추가된 로그
	        // 파일 경로 설정
	    		Path fileRoute = Paths.get(filePath, decodedFileName);
	    		Resource resource = new FileSystemResource(fileRoute.toFile());
	    		System.out.println("File path: " + fileRoute.toString());

	    		if (!resource.exists()) {
	    			return ResponseEntity.notFound().build();
	    		}
	    		
	    		return ResponseEntity.ok()
	    				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
	    				.body(resource);
	    		}catch (Exception e) {
	                    // 에러 메시지 로그 출력
	                    System.out.println("Error: " + e.getMessage());
	                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	    		}

	    }       
}
