package com.spring.resume.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.resume.dao.ResumeDAO;
import com.spring.resume.dto.ResumeDTO;
import com.spring.resume.vo.PeriodVo;
import com.spring.resume.vo.RecruitVo;
import com.spring.resume.vo.SeqVo;

@Service
public class ResumeServiceImpl implements ResumeService{
	
	@Autowired
	ResumeDAO resumeDAO;

	public int insertResume(ResumeDTO resume) {
		return resumeDAO.insertResume(resume);
	}

	public RecruitVo checkInfo(Map<String, String> requestData) {
		return resumeDAO.checkInfo(requestData);
	}

	public ResumeDTO selectSaveResume(Map<String, String> requestData) {
		return resumeDAO.selectSaveResume(requestData);
	}

	public SeqVo selectSeq() {
		return resumeDAO.selectSeq();
	}

	public PeriodVo selectPeriod(Map<String, String> requestData) {
		return resumeDAO.selectPeriod(requestData);
	}

	public int saveFormUpdate(ResumeDTO resume) {
		return resumeDAO.saveFormUpdate(resume);
	}

	public void delete(ResumeDTO resumeDTO) {
		resumeDAO.delete(resumeDTO);
		
	}
	
	

}
