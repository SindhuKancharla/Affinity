package com.affine.affinity.handler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class GetDatesFromRundate {

	String from_date = "";
	String to_date = "";
	
	
	public String getDate(String key){
        
        ApplicationContext context = 
                         new ClassPathXmlApplicationContext("resources/applicationContext.xml");
      
         DataSource dataSource = (DataSource) context.getBean("dataSource");
                     
         Connection conn = null;
            try {
                    conn = dataSource.getConnection();
            } catch (SQLException e) {
                    e.printStackTrace();
            }
            
            String sql = "select run_date from run_history order by run_date desc";
            PreparedStatement ps = null;
            try {
                    ps = conn.prepareStatement(sql);
            } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
            }
            
            ResultSet rs = null;

            try {
                    rs = ps.executeQuery();
            } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
            }
                            
            Map<Integer,String> map = new HashMap<Integer, String>();
            
            int num_count=0;
            try {
                    while(rs.next()){
                            
                            String run_date = rs.getString(1);
                            run_date= run_date.substring(0, run_date.length()-2);
                            map.put(num_count++, run_date);
                            
                    }
            } catch (SQLException e) {
                    e.printStackTrace();
            }
            
            String datefull = map.get(Integer.valueOf(key));
            System.out.println("date is "+datefull);
            return datefull;
	}

	protected String getDatesFromRundate(String key){
    	
	
    	ApplicationContext context = 
	     		new ClassPathXmlApplicationContext("resources/applicationContext.xml");
	  
     	DataSource dataSource = (DataSource) context.getBean("dataSource");
		         
     	Connection conn = null;
		try {
			conn = dataSource.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		String sql = "select from_date,to_date from run_history where run_date='"+key+"';";
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ResultSet rs = null;

		try {
			rs = ps.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
						
		try {
			while(rs.next()){
				
				this.from_date = rs.getString(1);
				
				this.to_date = rs.getString(2);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		String dates = this.from_date+","+this.to_date;
		return dates;
    }
}
