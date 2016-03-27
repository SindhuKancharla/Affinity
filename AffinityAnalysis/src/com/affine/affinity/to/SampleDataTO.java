package com.affine.affinity.to;

import java.io.Serializable;

public class SampleDataTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private String slno;
    private String rule;
    private Double support;
    private Double lift;
    private Double confidence;
    
	public String getSlno() {
		return slno;
	}
	public void setSlno(String slno) {
		this.slno = slno;
	}
	public String getRule() {
		return rule;
	}
	public void setRule(String rule) {
		this.rule = rule;
	}
	public Double getSupport() {
		return support;
	}
	public void setSupport(Double support) {
		this.support = support;
	}
	
	public Double getLift() {
		return lift;
	}
	public void setLift(Double lift) {
		this.lift = lift;
	}
	
	public SampleDataTO(){
		
	}
	public SampleDataTO(String slno, String rule, String support, String lift,String confidence) {
		super();
		this.slno = slno;
		this.rule = rule;
		this.support = Double.valueOf(support);
		this.lift = Double.valueOf(lift);
		this.confidence= Double.valueOf(confidence);
	}
	public Double getConfidence() {
		return confidence;
	}
	public void setConfidence(Double confidence) {
		this.confidence = confidence;
	}
    
}
