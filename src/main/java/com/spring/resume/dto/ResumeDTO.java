package com.spring.resume.dto;

import java.util.List;

import com.spring.resume.vo.CareerVo;
import com.spring.resume.vo.CertificationVo;
import com.spring.resume.vo.EducationVo;
import com.spring.resume.vo.RecruitVo;

public class ResumeDTO {
	
	private RecruitVo recruit;
	private List<EducationVo> education;
	private List<CareerVo> career;
	private List<CertificationVo> certification;
	
    public ResumeDTO() {
        
    }

	public RecruitVo getRecruit() {
		return recruit;
	}

	public void setRecruit(RecruitVo recruit) {
		this.recruit = recruit;
	}

	public List<EducationVo> getEducation() {
		return education;
	}

	public void setEducation(List<EducationVo> education) {
		this.education = education;
	}

	public List<CareerVo> getCareer() {
		return career;
	}

	public void setCareer(List<CareerVo> career) {
		this.career = career;
	}

	public List<CertificationVo> getCertification() {
		return certification;
	}

	public void setCertification(List<CertificationVo> certification) {
		this.certification = certification;
	}
		
    
	
	
	
}
