package com.spring.resume.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.resume.dto.ResumeDTO;
import com.spring.resume.service.ResumeService;
import com.spring.resume.vo.PeriodVo;
import com.spring.resume.vo.RecruitVo;
import com.spring.resume.vo.SeqVo;

import org.apache.log4j.Logger;

@Controller
public class ResumeController {
	
	 private static final Logger logger = Logger.getLogger(ResumeController.class);
	
	@Autowired
	ResumeService resumeService;
	
	//로그인 화면 호출
	@RequestMapping(value = "/login.do" ,method = RequestMethod.GET)
	public String loginForm() {
		return "login";
	}
	
	// 저장된 데이터인지 제출된 데이터인지 확인
	@RequestMapping(value="/checkInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> checkInfo(@RequestBody Map<String, String> data) {
		Map<String, String> response = new HashMap<String, String>();
		
		Map<String, String> requestData = new HashMap<String, String>();
		requestData.put("name", data.get("rName"));
		requestData.put("phoneNum", data.get("rPhoneNum"));
		
		RecruitVo submit = resumeService.checkInfo(requestData);
		RecruitVo dupli = resumeService.dupliCheck(requestData);
		logger.info("dupli" + dupli);
		if(dupli == null) {
			if("0".equals(submit.getSubmit())) {
				response.put("success", "/resumeForm.do");
			}
		}else if(dupli != null && "1".equals(submit.getSubmit())) {
				response.put("success", "/saveResumeForm.do");
		}else if(dupli != null && "2".equals(submit.getSubmit())){
				response.put("success", "/submit.do");
		}else {
			response.put("dupli", "이미 등록된 번호입니다.");
		}
		
		return response;
	}
	
	// 이력서 작성
	@RequestMapping(value = "/resumeForm.do" ,method = RequestMethod.GET)
	public void resumeForm(@RequestParam("name") String name
							,@RequestParam("phoneNum") String phoneNum
							,Model model) {
//		logger.info(name);
		
		model.addAttribute("name", name);
		model.addAttribute("phoneNum", phoneNum);
		SeqVo seq = resumeService.selectSeq();
		model.addAttribute("seq", seq);
		logger.info(seq);
	}
	
	// 이력서 저장
	@RequestMapping(value = "/insertResume.do" ,method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> insertResume(@RequestBody ResumeDTO resumeDTO) {

//		logger.info(resumeDTO.getRecruit());
//		logger.info(resumeDTO.getEducation());
//		logger.info(resumeDTO.getCareer());
//		logger.info(resumeDTO.getCertification());
		
		Map<String, String> response = new HashMap<String, String>();
		int result = resumeService.insertResume(resumeDTO);
//		if(result == 4) {
//			response.put("success", "저장완료");
//		}
				
		return response;
	}
	
	//저장된 폼.
	@RequestMapping(value = "/saveResumeForm.do" ,method = RequestMethod.GET)
	public String saveResumeForm(@RequestParam("name") String name
								 ,@RequestParam("phoneNum") String phoneNum
								,Model model) {
		
		Map<String, String> requestData = new HashMap<String, String>();
		requestData.put("name", name);
		requestData.put("phoneNum", phoneNum);
		
		ResumeDTO saveData = resumeService.selectSaveResume(requestData);
		
		PeriodVo period = resumeService.selectPeriod(requestData);
//		logger.info(period);

		if(period != null && period.getEduPeriod() != null) {
			int eduPeriod =  (int)Math.floor(Double.parseDouble(period.getEduPeriod()));
			eduPeriod = eduPeriod / 12; 
			String schoolName = period.getSchoolName();
			String division = period.getDivision();
			if(schoolName.contains("대학") && division.equals("졸업")) {
				if(eduPeriod >= 4) {
					model.addAttribute("eduPeriod", schoolName + "(4년)" + period.getDivision());
				}else {
					model.addAttribute("eduPeriod", schoolName + "(2-3년)" + period.getDivision());
				}
			}else {
				model.addAttribute("eduPeriod", schoolName + period.getDivision());
			}
		}
		
		if(period != null && period.getCarPeriod() != null) {
			int carPeriod = (int)Math.floor(Double.parseDouble(period.getCarPeriod()));
			if(carPeriod / 12  >= 1) {
				int year = (carPeriod / 12);
				int month = (carPeriod % 12);
				model.addAttribute("carPeriod", year +"년 " + month+"개월");
			}else {
				int month = (carPeriod / 12);
				model.addAttribute("carPeriod", month +"개월");
			}
		}
		
		
		SeqVo seq = resumeService.selectSeq();
		model.addAttribute("seq", seq);
		model.addAttribute("recruit", saveData.getRecruit());
        model.addAttribute("education", saveData.getEducation());
        model.addAttribute("career", saveData.getCareer());
        model.addAttribute("certification", saveData.getCertification());
		
		return "saveResumeForm";
	}
	
	// 저장된 폼 업데이트
	@RequestMapping(value = "/saveFormUpdate.do" ,method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> saveFormUpdate(@RequestBody ResumeDTO resumeDTO) {
		
		Map<String, String> response = new HashMap<String, String>();
//		logger.info(resumeDTO.getRecruit());
		int result = resumeService.saveFormUpdate(resumeDTO);
		
		if(result != 0) {
			response.put("success", "저장완료");
		}
		
		return response;
	}
	
	// 삭제
	@RequestMapping(value = "/delete.do" ,method = RequestMethod.POST)
	@ResponseBody
	public void delete(@RequestBody ResumeDTO resumeDTO) {
//		logger.info(resumeDTO.getEducation());
//		logger.info(resumeDTO.getCareer());
//		logger.info(resumeDTO.getCertification());
		resumeService.delete(resumeDTO);
	}
	
	// 제출
	@RequestMapping(value = "/submit.do" ,method = RequestMethod.GET)
	public String submit(@RequestParam("name") String name
						,@RequestParam("phoneNum") String phoneNum
						,Model model) {
		
		Map<String, String> requestData = new HashMap<String, String>();
		requestData.put("name", name);
		requestData.put("phoneNum", phoneNum);
		
		ResumeDTO submitData = resumeService.selectSaveResume(requestData);
		PeriodVo period = resumeService.selectPeriod(requestData);
		
		if(period != null && period.getCarPeriod() != null) {
			int carPeriod = (int)Math.floor(Double.parseDouble(period.getCarPeriod()));
			if(carPeriod / 12  >= 1) {
				int year = (carPeriod / 12);
				int month = (carPeriod % 12);
				model.addAttribute("carPeriod", year +"년 " + month+"개월");
			}else {
				int month = (carPeriod / 12);
				model.addAttribute("carPeriod", month +"개월");
			}
		}
		
		if(period != null && period.getEduPeriod() != null) {
			int eduPeriod =  (int)Math.floor(Double.parseDouble(period.getEduPeriod()));
			eduPeriod = eduPeriod / 12; 
			String schoolName = period.getSchoolName();
			String division = period.getDivision();
			if(schoolName.contains("대학") && division.equals("졸업")) {
			if(schoolName.contains("대학")){ 
				if(eduPeriod >= 4) {
					model.addAttribute("eduPeriod", schoolName + "(" + eduPeriod  + "년)" + period.getDivision());
				}else {
					model.addAttribute("eduPeriod", schoolName + "(2-3년)" + period.getDivision());
				}
			}
			}else {
				model.addAttribute("eduPeriod", schoolName + period.getDivision());
			}
		}
		
		model.addAttribute("recruit", submitData.getRecruit()); 
        model.addAttribute("education", submitData.getEducation());
        model.addAttribute("career", submitData.getCareer());
        model.addAttribute("certification", submitData.getCertification());
		
        return "submitResumeForm";
	}
	
	

}
