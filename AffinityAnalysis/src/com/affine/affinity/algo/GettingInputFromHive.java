package com.affine.affinity.algo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;






import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.affine.affinity.persistent.HiveConnectivity;

public class GettingInputFromHive {

	private boolean connectionGot = true;
	public String runAlgorithm(String fromDate,String toDate, String dateString) throws IOException{

		String outputMsg = "";
		List<String> levels = new ArrayList<String>();

		//boolean success = false;
		levels.add("Item");
		levels.add("Category");
		levels.add("dept");

	    ExecutorService executor = Executors.newFixedThreadPool(levels.size());

		Map<String, Map<String, List<String>>> mapOfMaps = readFromInputTable(fromDate,toDate);
		
		if(mapOfMaps==null){
			
			if(connectionGot==false){
				outputMsg = "There is a problem while connecting to the server.Please try again after some time. Thanks for your patience :)";
			}
			else{
				outputMsg = "The dates entered are beyond our transactions range. Please enter a valid date range.";
			}
			//success = false;
		}
		else{
			for(String level : levels){
				RunnableLevel runObj = new RunnableLevel(mapOfMaps.get(level),dateString,level);
		  
				executor.execute(runObj);
				
		    }
			
		
		    executor.shutdown();
		    
		    while(!executor.isTerminated()){
		    	
		    }
		    System.out.println(" Finished all threads !!!");
		    //success = true;
		    outputMsg = "The processing is complete and results are saved in our database.";
		}
		return outputMsg;
	}
	
	public Map<String, Map<String, List<String>>> readFromInputTable(String fromDate, String toDate) throws IOException{
		
		Map<String,Map<String, List<String>>> mapOfMaps = new HashMap<String, Map<String, List<String>>>();
		
		Map<String, List<String>> tran_items_map = new HashMap<String, List<String>>();
		
		Map<String, List<String>> tran_cats_map = new HashMap<String, List<String>>();

		Map<String, List<String>> tran_depts_map = new HashMap<String, List<String>>();

		HiveConnectivity hiveConnectivity = new HiveConnectivity();
			
		try {
			Connection con = hiveConnectivity.getHiveConnection();
			
			if(con==null){
				connectionGot = false;
				System.out.println(" conn prob");
				return null;
			}
			String query = "Select mbdate,trnm,item_no,cat,dept from item_trans_new2 where mbdate between \'"+fromDate+"\' AND \'"+toDate+"\'";
			System.out.println(query);
			Statement stmt = con.createStatement();
			
			ResultSet res = stmt.executeQuery(query);
			
			if(res.next()){
			
				do{
					
					String trnm = res.getString(2);
					String item_no = res.getString(3);
					String cat = res.getString(4);
					String dept = res.getString(5);
					
					String catdept = cat+"|"+dept;
					
					if(tran_items_map.keySet().contains(trnm)){
						
						List<String> itemsList = tran_items_map.get(trnm);
						if(!itemsList.contains(item_no)){
							itemsList.add(item_no);
						}
						tran_items_map.put(trnm,itemsList);
	
						List<String> catsList = tran_cats_map.get(trnm);
						if(!catsList.contains(catdept)){
							catsList.add(catdept);
						}
						tran_cats_map.put(trnm,catsList);
	
						List<String> depList = tran_depts_map.get(trnm);
						if(!depList.contains(dept)){
							depList.add(dept);
						}
						tran_depts_map.put(trnm,depList);
	
					}
					else{
						List<String> itemsList = new ArrayList<String>();
						itemsList.add(item_no);
						tran_items_map.put(trnm,itemsList);
						
						List<String> catlist = new ArrayList<String>();
						catlist.add(catdept);
						tran_cats_map.put(trnm, catlist);
						
						List<String> deplist = new ArrayList<String>();
						deplist.add(dept);
						tran_depts_map.put(trnm, deplist);
						
					}
				}while (res.next());
			}
			else
			{
				return null;
			}
		} 
		catch (SQLException e) {
			connectionGot = false;
			return null;
		}
		
		mapOfMaps.put("Item", tran_items_map);
		mapOfMaps.put("Category", tran_cats_map);
		mapOfMaps.put("dept", tran_depts_map);
		
		return mapOfMaps;
	}
}