package com.affine.affinity.dao;

import com.affine.affinity.to.User;

//import javax.sql.DataSource;

//import org.springframework.jdbc.core.JdbcTemplate;

public interface UserDao {
	
	public boolean validateUser(User user);
	/*
	private JdbcTemplate jdbcTemplate;  
	  
	
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {  
	    this.jdbcTemplate = jdbcTemplate;  
	}  
	  
	public void validateUser(User user){  
	    
		String username = user.getUsername();
		String password = user.getPassword();
		
		String query="Select Password from Users where Username=\"" + username+"\"";
		
		User user_from_db = (User)jdbcTemplate.queryForObject(query, new UserRowMapper());
	 
	     
		System.out.println(user_from_db);
	}  
	*/
}
