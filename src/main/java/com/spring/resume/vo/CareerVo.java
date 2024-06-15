package com.spring.resume.vo;

public class CareerVo {
	
	private String carSeq;
	private String recruitCaSeq;
	private String caStartPeriod;
	private String caEndPeriod;
	private String compName;
	private String task;
	private String caLocation;
	private String salary;
	
	public String getCarSeq() {
		return carSeq;
	}
	public void setCarSeq(String carSeq) {
		this.carSeq = carSeq;
	}
	public String getRecruitCaSeq() {
		return recruitCaSeq;
	}
	public void setRecruitCaSeq(String recruitCaSeq) {
		this.recruitCaSeq = recruitCaSeq;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getCaLocation() {
		return caLocation;
	}
	public void setCaLocation(String caLocation) {
		this.caLocation = caLocation;
	}
	public String getCaStartPeriod() {
		return caStartPeriod;
	}
	public void setCaStartPeriod(String caStartPeriod) {
		this.caStartPeriod = caStartPeriod;
	}
	public String getCaEndPeriod() {
		return caEndPeriod;
	}
	public void setCaEndPeriod(String caEndPeriod) {
		this.caEndPeriod = caEndPeriod;
	}
	public String getTask() {
		return task;
	}
	public void setTask(String task) {
		this.task = task;
	}
	public String getSalary() {
		return salary;
	}
	public void setSalary(String salary) {
		this.salary = salary;
	}
	
	@Override
	public String toString() {
		return "CareerVo [carSeq=" + carSeq + ", recruitCaSeq=" + recruitCaSeq + ", caStartPeriod=" + caStartPeriod
				+ ", caEndPeriod=" + caEndPeriod + ", compName=" + compName + ", task=" + task + ", caLocation="
				+ caLocation + ", salary=" + salary + "]";
	}
	
	
	
	
	
	

}
