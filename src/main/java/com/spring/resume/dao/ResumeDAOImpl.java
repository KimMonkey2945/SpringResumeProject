package com.spring.resume.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.resume.controller.ResumeController;
import com.spring.resume.dto.ResumeDTO;
import com.spring.resume.vo.CareerVo;
import com.spring.resume.vo.CertificationVo;
import com.spring.resume.vo.EducationVo;
import com.spring.resume.vo.PeriodVo;
import com.spring.resume.vo.RecruitVo;
import com.spring.resume.vo.SeqVo;

@Repository
public class ResumeDAOImpl implements ResumeDAO {
	
	 private static final Logger logger = Logger.getLogger(ResumeDAOImpl.class);

	@Autowired
	private SqlSession sqlSession;

	public int insertResume(ResumeDTO resume) {
		int result = 1; // 임시
		if (resume.getRecruit() != null) {
			sqlSession.insert("resume.saveRecruit", resume);
	    }
	    if (resume.getEducation() != null && !resume.getEducation().isEmpty()) {
	    	sqlSession.insert("resume.saveEd", resume);
	    }
	    if (resume.getCareer() != null && !resume.getCareer().isEmpty()) {
	    	sqlSession.insert("resume.saveCa", resume);
	    }
	    if (resume.getCertification() != null && !resume.getCertification().isEmpty()) {
	        sqlSession.insert("resume.saveCe", resume);
	    }
		return result;
	}
	
	public RecruitVo dupliCheck(Map<String, String> requestData) {
		return sqlSession.selectOne("resume.dupliCheck", requestData);
	}

	public RecruitVo checkInfo(Map<String, String> requestData) {
		return sqlSession.selectOne("resume.checkInfo", requestData);
	}

	public ResumeDTO selectSaveResume(Map<String, String> requestData) {
		ResumeDTO resumeDTO = new ResumeDTO();
		resumeDTO.setRecruit((RecruitVo) sqlSession.selectOne("resume.selectRecruit", requestData));
		List<EducationVo> education = sqlSession.selectList("resume.selectEducation", requestData);
		List<CareerVo> career = sqlSession.selectList("resume.selectCareer", requestData);
		List<CertificationVo> certification = sqlSession.selectList("resume.selectCertification", requestData);

		resumeDTO.setEducation(education);
		resumeDTO.setCareer(career);
		resumeDTO.setCertification(certification);

		return resumeDTO;
	}

	public SeqVo selectSeq() {
		return sqlSession.selectOne("resume.selectSeq");
	}

	public PeriodVo selectPeriod(Map<String, String> requestData) {
		return sqlSession.selectOne("resume.selectPeriod", requestData);
	}

	public int saveFormUpdate(ResumeDTO resume) {
		int result = 1; // 임시
		if (resume.getRecruit() != null) {
		    sqlSession.update("resume.updateRecruit", resume);
	    }
	    if (resume.getEducation() != null && !resume.getEducation().isEmpty()) {
	        sqlSession.update("resume.updateEd", resume);
	    }
	    if (resume.getCareer() != null && !resume.getCareer().isEmpty()) {
	        sqlSession.update("resume.updateCa", resume);
	    }
	    if (resume.getCertification() != null && !resume.getCertification().isEmpty()) {
	        sqlSession.update("resume.updateCe", resume);
	    }
		return result;
	}

	public void delete(ResumeDTO resumeDTO) {
		
		 if (resumeDTO.getEducation() != null && !resumeDTO.getEducation().isEmpty()) {
		        sqlSession.delete("resume.deleteEducation", resumeDTO);
	    }
	    if (resumeDTO.getCareer() != null && !resumeDTO.getCareer().isEmpty()) {
	        sqlSession.delete("resume.deleteCareer", resumeDTO);
	    }
	    if (resumeDTO.getCertification() != null && !resumeDTO.getCertification().isEmpty()) {
	        sqlSession.delete("resume.deleteCertification", resumeDTO);
	    }
	}

}
