package com.spring.resume.vo;

public class PeriodVo {
	
	private String eduPeriod;
	private String carPeriod;
	private String division;
	private String schoolName;
	
	
	public String getEduPeriod() {
		return eduPeriod;
	}
	public void setEduPeriod(String eduPeriod) {
		this.eduPeriod = eduPeriod;
	}
	public String getCarPeriod() {
		return carPeriod;
	}
	public void setCarPeriod(String carPeriod) {
		this.carPeriod = carPeriod;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	
	@Override
	public String toString() {
		return "PeriodVo [eduPeriod=" + eduPeriod + ", carPeriod=" + carPeriod + ", division=" + division
				+ ", schoolName=" + schoolName + "]";
	}
	
	
	
	
	
	
	
	

}
