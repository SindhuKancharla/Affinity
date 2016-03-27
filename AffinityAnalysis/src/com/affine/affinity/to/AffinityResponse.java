package com.affine.affinity.to;

import java.io.Serializable;


public class AffinityResponse implements Serializable{

	
	private static final long serialVersionUID = 1L;
	private String msg;
	
	private String updateRundateJSON;

	private String depList;
	
	private String dept_cat_map;
	
	private String catList;
	
	private String filter;
	
	public String getFilter() {
		return filter;
	}
	public void setFilter(String filter) {
		this.filter = filter;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getUpdateRundateJSON() {
		return updateRundateJSON;
	}
	public void setUpdateRundateJSON(String updateRundateJSON) {
		this.updateRundateJSON = updateRundateJSON;
	}
	public String getDepList() {
		return depList;
	}
	public void setDepList(String depList) {
		this.depList = depList;
	}
	public String getCatList() {
		return catList;
	}
	public void setCatList(String catList) {
		this.catList = catList;
	}
	public String getDept_cat_map() {
		return dept_cat_map;
	}
	public void setDept_cat_map(String dept_cat_map) {
		this.dept_cat_map = dept_cat_map;
	}

	
}
