package com.spring.resume.vo;

public class SeqVo {
	
	private String seq;
	private String eduSeq;
	private String carSeq;
	private String certSeq;
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getEduSeq() {
		return eduSeq;
	}
	public void setEduSeq(String eduSeq) {
		this.eduSeq = eduSeq;
	}
	public String getCarSeq() {
		return carSeq;
	}
	public void setCarSeq(String carSeq) {
		this.carSeq = carSeq;
	}
	public String getCertSeq() {
		return certSeq;
	}
	public void setCertSeq(String certSeq) {
		this.certSeq = certSeq;
	}
	
	@Override
	public String toString() {
		return "SeqVo [seq=" + seq + ", eduSeq=" + eduSeq + ", carSeq=" + carSeq + ", certSeq=" + certSeq + "]";
	}
	
	

}
