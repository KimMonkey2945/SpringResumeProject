package com.spring.resume.vo;

public class CertificationVo {
	
	private String certSeq;
	private String recruitCeSeq;
	private String qualifiName;
	private String acquDate;
	private String organizeName;
	
	
	public String getCertSeq() {
		return certSeq;
	}
	public void setCertSeq(String certSeq) {
		this.certSeq = certSeq;
	}
	public String getRecruitCeSeq() {
		return recruitCeSeq;
	}
	public void setRecruitCeSeq(String recruitCeSeq) {
		this.recruitCeSeq = recruitCeSeq;
	}
	public String getQualifiName() {
		return qualifiName;
	}
	public void setQualifiName(String qualifiName) {
		this.qualifiName = qualifiName;
	}
	public String getAcquDate() {
		return acquDate;
	}
	public void setAcquDate(String acquDate) {
		this.acquDate = acquDate;
	}
	public String getOrganizeName() {
		return organizeName;
	}
	public void setOrganizeName(String organizeName) {
		this.organizeName = organizeName;
	}
	
	
	@Override
	public String toString() {
		return "CertificationVo [certSeq=" + certSeq + ", recruitCeSeq=" + recruitCeSeq + ", qualifiName=" + qualifiName + ", acquDate="
				+ acquDate + ", organizeName=" + organizeName + "]";
	}
	
	
	
	
	

}
