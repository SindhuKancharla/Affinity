package com.affine.affinity.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;

import com.affine.affinity.dao.UserDao;
import com.affine.affinity.to.User;

public class UserDaoImpl implements UserDao{

	
	@Autowired
	private DataSource dataSource;
	 
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
 
	
	@Override
	public boolean validateUser(User user) {

		boolean valid_user = false;
		String sql = "SELECT * FROM users WHERE Username = ?";
		 
		
 
		try {
			
			Connection conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			
			ResultSet rs = ps.executeQuery();
			
			///System.out.println(" rs set paswd is "+ rs.getString("Password"));
			User user1 = null;
			if (rs.next()) {
				user1 = new User(
					rs.getString("Username"),
					rs.getString("Password")
					);
			}
			
			System.out.println(user1);
			String actual_pwd = user1.getPassword();
			
			String entered_pwd = user.getPassword();
			
			if(actual_pwd.equals(entered_pwd)){
				valid_user = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			e.printStackTrace();
			valid_user = false;
		}
		
		return valid_user;
	}

	
	
}
