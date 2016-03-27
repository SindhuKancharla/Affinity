package com.affine.affinity.handler;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.affine.affinity.dao.UserDao;
import com.affine.affinity.to.User;

public class ValidateCredentials {

	public boolean validate(String username,String password){
		
		boolean check = false;
		
		if(username.equalsIgnoreCase("admin") && password.equalsIgnoreCase("admin123"))
			check = true;
		
		/*ApplicationContext context = new ClassPathXmlApplicationContext(
				"resources/applicationContext.xml");
		try {

			User user = new User();

			user.setUsername(username);
			user.setPassword(password);

	

			UserDao userDAO = (UserDao) context.getBean("userDao");

			check = userDAO.validateUser(user);

		}

		catch (Throwable theException) {
			theException.printStackTrace();
		}
		finally{
			
		}*/
		return check;
		
	}
}
