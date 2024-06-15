package com.spring.resume.service;

import java.util.List;
import java.util.Map;

import com.spring.resume.dto.ResumeDTO;
import com.spring.resume.vo.PeriodVo;
import com.spring.resume.vo.RecruitVo;
import com.spring.resume.vo.SeqVo;

public interface ResumeService {

	public int insertResume(ResumeDTO resume);

	public RecruitVo checkInfo(Map<String, String> requestData);

	public ResumeDTO selectSaveResume(Map<String, String> requestData);

	public SeqVo selectSeq();

	public PeriodVo selectPeriod(Map<String, String> requestData);

	public int saveFormUpdate(ResumeDTO resume);

	public void delete(ResumeDTO resumeDTO);
	
	
	
	
	
}
