package com.affine.affinity.to;

public class ResultBean {

	private String rule;
	private double support;
	private double lift;
	private double confidence;
	
	public String getRule() {
		return rule;
	}
	public void setRule(String rule) {
		this.rule = rule;
	}
	public double getSupport() {
		return support;
	}
	public void setSupport(double support) {
		this.support = support;
	}
	public double getLift() {
		return lift;
	}
	public void setLift(double lift) {
		this.lift = lift;
	}
	public double getConfidence() {
		return confidence;
	}
	public void setConfidence(double confidence) {
		this.confidence = confidence;
	}
	
	
}
