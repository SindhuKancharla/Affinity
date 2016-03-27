package com.affine.affinity.persistent;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;


public class JoinTablesForAlgo {

	public String getQuery(String level){
		
		String query = "";
		if(level.equalsIgnoreCase("item")){
			query="INSERT into table final_item_occ_results select a.item_b,a.item_a,a.Occ_a,a.Occ_b,a.Occ_aub,a.partial_lift,a.confidence,a.rundate,b.description as desc_a,b.cat as cat_a,b.cat_desc as cat_desc_a,b.dept as dept_a,b.short_dept_desc as short_desc_a,c.description as desc_b,c.cat as cat_b,c.cat_desc as cat_desc_b,c.dept as dept_b,c.short_dept_desc as short_desc_b from temp_result as a inner join desc_master as b on a.item_b = b.item_no left outer join desc_master as c on a.item_a = c.item_no";
		}
		else if(level.equalsIgnoreCase("dept"))
		{
			query="INSERT into table final_dept_occ_results select a.dept_1,a.dept_2,a.Occ_a,a.Occ_b,a.Occ_aub,a.partial_lift,a.confidence,a.rundate,c.dept,c.short_dept_desc,b.dept,b.short_dept_desc from dept_temp_results as a inner join dept_desc as b on a.dept_2 = b.dept left outer join dept_desc as c on a.dept_1 = c.dept";			
		}			
		else{
			query = "INSERT into table final_cat_occ_results select a.cat_1,a.cat_2,a.dept_1,a.dept_2,a.Occ_a,a.Occ_b,a.Occ_aub,a.partial_lift,a.confidence,a.rundate,c.cat_desc as cat_desc_a,c.dept_desc as short_desc_a,b.cat_desc as cat_desc_b,b.dept_desc as short_desc_b from cat_temp_results as a inner join cat_dept_desc as b on a.cat_2 = b.cat and a.dept_2 = b.dept left outer join cat_dept_desc as c on a.cat_1 = c.cat and a.dept_1 = c.dept";
		}
		return query;
	}
	
	public void joinTempResultAndMasterTables(String level) throws SQLException {
		
		try{
			HiveConnectivity hiveConnectivity = new HiveConnectivity();
			
			Connection con = hiveConnectivity.getHiveConnection();	
			
			String joinQuery = getQuery(level);
			System.out.println(joinQuery);
			Statement stmt1 = con.createStatement();
			
			stmt1.executeQuery(joinQuery);
		}
		catch(Exception e){
			
		}
		
	}
}
