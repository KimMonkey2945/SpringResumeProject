package com.spring.resume.vo;

public class EducationVo {
	
	private String eduSeq;
	private String recruitEdSeq;
	private String edStartPeriod;
	private String edEndPeriod;
	private String division;
	private String schoolName;
	private String edLocation;
	private String major;
	private String grade;

	
	public String getEduSeq() {
		return eduSeq;
	}
	public void setEduSeq(String eduSeq) {
		this.eduSeq = eduSeq;
	}
	public String getRecruitEdSeq() {
		return recruitEdSeq;
	}
	public void setRecruitEdSeq(String recruitEdSeq) {
		this.recruitEdSeq = recruitEdSeq;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getEdStartPeriod() {
		return edStartPeriod;
	}
	public void setEdStartPeriod(String edStartPeriod) {
		this.edStartPeriod = edStartPeriod;
	}
	public String getEdEndPeriod() {
		return edEndPeriod;
	}
	public void setEdEndPeriod(String edEndPeriod) {
		this.edEndPeriod = edEndPeriod;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getEdLocation() {
		return edLocation;
	}
	public void setEdLocation(String edLocation) {
		this.edLocation = edLocation;
	}
	
	
	@Override
	public String toString() {
		return "EducationVo [eduSeq=" + eduSeq + ", recruitEdSeq=" + recruitEdSeq + ", schoolName=" + schoolName + ", division="
				+ division + ", edStartPeriod=" + edStartPeriod + ", edEndPeriod=" + edEndPeriod + ", major=" + major
				+ ", grade=" + grade + ", edLocation=" + edLocation + "]";
	}
	
	
	
	
	
	
	
	

}
