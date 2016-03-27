package com.affine.affinity.handler;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.affine.affinity.persistent.HiveConnectivity;
import com.google.gson.Gson;

public class GenerateDeptCatMap {
	private final String TABLE_FOR_CAT="final_cat_occ_results";
	private final String TABLE_FOR_DEPT="final_dept_occ_results";
	private final String TABLE_FOR_ITEM="final_item_occ_results";
	
	public static Map<String,String> dept_id_desc = new HashMap<String, String>();
	public static Map<String,String> cat_id_desc = new HashMap<String, String>();
	
	static Map<String,List<String>> dept_cat_map = new HashMap<String, List<String>>();
	static Map<Integer,String> all_depts = new HashMap<Integer, String>();		

	public List<String> generateDepartmentsFromRundate(String rundate,String level) throws IOException{
		
		String table = null;
   	 	String query = null;

		HiveConnectivity hiveConnectivity = new HiveConnectivity();
   	 	Connection con = null;
   	 	try {
			 con = hiveConnectivity.getHiveConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	   	 
   	 	
	   	if(level.equalsIgnoreCase("Category")){
	 		table=TABLE_FOR_CAT;
	 	}
	 	else if(level.equalsIgnoreCase("dept")){
	 		table=TABLE_FOR_DEPT;
	 	}
	 	else{
	 		table=TABLE_FOR_ITEM;
	 	}

	   	if(level.equalsIgnoreCase("item")){
   	    	
	   		System.out.println(" rundate in method -- "+rundate);
		   	query = "select short_desc_a,short_desc_b,cat_desc_a,cat_desc_b,cat_a,cat_b,dept_a,dept_b from "+table+" where rundate=\""+rundate+"\"";
		
	   	
		   	System.out.println(query);
		   	Statement stmt = null;
			try {
				stmt = con.createStatement();
			} catch (SQLException e) {
				e.printStackTrace();
			}
				
			ResultSet res = null;
			try {
				res = stmt.executeQuery(query);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		   	 
			int num_depts = 0;
			try{
				
				String all_cats = "ALL CATEGORIES";
						
				List<String> depts = new ArrayList<String>();

				List<String> tmp = new ArrayList<String>();
				tmp.add(all_cats);
				
				List<String> tmp1 = new ArrayList<String>();
				tmp1.add("Select Category");
				//depts.add("ALL DEPARTMENTS");
				dept_cat_map.put("Select Department", tmp1);

				dept_cat_map.put("ALL DEPARTMENTS", tmp);
				
				while(res.next()){
					
					String da = res.getString(1);
					String db = res.getString(2);
					String ca = res.getString(3);
					String cb = res.getString(4);
					String caid = res.getString(5);
					String cbid = res.getString(6);
					String depaid = res.getString(7);
					String depbid = res.getString(8);
					
					dept_id_desc.put(da	,depaid);
					dept_id_desc.put(db, depbid);
					
					cat_id_desc.put(ca,caid);
					cat_id_desc.put(cb,cbid);
					
					if(da==null || db == null || ca==null || cb ==null)
						continue;
					
					
					if(dept_cat_map.keySet().contains(da)){
						
						List<String> tempList = dept_cat_map.get(da);
						if(!tempList.contains(ca)){
							tempList.add(ca);
						}
						
						Collections.sort(tempList);
						if(!tempList.contains(all_cats)){
							tempList.add(0,all_cats);
						}
						dept_cat_map.put(da, tempList);
						
					}
					else{
						
						List<String> tempList = new ArrayList<String>();
						tempList.add(ca);
						
						Collections.sort(tempList);
						if(!tempList.contains(all_cats)){
							tempList.add(0,all_cats);
						}
						dept_cat_map.put(da, tempList);
					}
					if(dept_cat_map.keySet().contains(db)){
						
						List<String> tempList = dept_cat_map.get(db);
						
						if(!tempList.contains(cb)){
							tempList.add(cb);
						}
						
						Collections.sort(tempList);
						if(!tempList.contains(all_cats)){
							tempList.add(0,all_cats);
						}
						dept_cat_map.put(db, tempList);
						
					}
					else{
						
						List<String> tempList = new ArrayList<String>();
						tempList.add(cb);
						
						Collections.sort(tempList);
						if(!tempList.contains(all_cats)){
							tempList.add(0,all_cats);
						}
						dept_cat_map.put(db, tempList);
					}
					
					
					if(!depts.contains(da))
						depts.add(da);
					if(!depts.contains(db))
						depts.add(db);
					
				}
				
				
				Collections.sort(depts);
				all_depts.clear();
				all_depts.put(num_depts++, "Select Department");
				all_depts.put(num_depts++, "ALL DEPARTMENTS");

				for(String dep : depts){
					all_depts.put(num_depts++, dep);
				}
				
			}
			catch(SQLException e){
				e.printStackTrace();
			}
   	    }
		else if(level.equalsIgnoreCase("Category")){
			
			query = "select short_dept_desc_a,short_dept_desc_b,dept_1,dept_2 from "+table+" where rundate=\""+rundate+"\"";
			
		   	
		   	System.out.println(query);
		   	Statement stmt = null;
			try {
				stmt = con.createStatement();
			} catch (SQLException e) {
				e.printStackTrace();
			}
				
			ResultSet res = null;
			try {
				res = stmt.executeQuery(query);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		   	 
			int num_depts = 0;
			try{
				List<String> depts = new ArrayList<String>();
				
									
				while(res.next()){
					
					String da = res.getString(1);
					String db = res.getString(2);
					
					
					String depaid = res.getString(3);
					String depbid = res.getString(4);
					
					dept_id_desc.put(da	,depaid);
					dept_id_desc.put(db, depbid);
					
					
					if(da==null || db == null)
						continue;
					
					if(!depts.contains(da))
						depts.add(da);
					if(!depts.contains(db))
						depts.add(db);
					
				}
				
				Collections.sort(depts);
				//depts.add(0,"ALL DEPARTMENTS");

				System.out.println(depts);
				all_depts.clear();
				all_depts.put(num_depts++, "ALL DEPARTMENTS");
				for(String dep : depts){
					all_depts.put(num_depts++, dep);
				}
			}
			catch(SQLException e){
				e.printStackTrace();
			}
		}
		
		String json = null;
	    json= new Gson().toJson(all_depts);  
	    String json_dept_cat_map = new Gson().toJson(dept_cat_map);
	    
	    List<String> jsonsList = new ArrayList<String>();
	    
	    jsonsList.add(json);
	    jsonsList.add(json_dept_cat_map);
	    
	    System.out.println(json);
	    return jsonsList;
	}
}

