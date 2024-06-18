package com.spring.resume.dao;

import java.util.List;
import java.util.Map;

import com.spring.resume.dto.ResumeDTO;
import com.spring.resume.vo.PeriodVo;
import com.spring.resume.vo.RecruitVo;
import com.spring.resume.vo.SeqVo;

public interface ResumeDAO {
	
	public int insertResume(ResumeDTO resume);

	public RecruitVo dupliCheck(Map<String,String> requestDate);
	
	public RecruitVo checkInfo(Map<String, String> requestData);

	public ResumeDTO selectSaveResume(Map<String, String> requestData);

	public SeqVo selectSeq();

	public PeriodVo selectPeriod(Map<String, String> requestData);

	public int saveFormUpdate(ResumeDTO resumeDTO);

	public void delete(ResumeDTO resumeDTO);
		

}
