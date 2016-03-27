package com.affine.affinity.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.affine.affinity.handler.ValidateCredentials;

@Controller
public class RequestController {

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public ModelAndView login(@RequestParam("user") String username,@RequestParam("pass") String password) {

		String message = "";
	        
	
		boolean valid = false;
		ValidateCredentials validateCredentials = new ValidateCredentials();
		valid = validateCredentials.validate(username, password);
		if (valid) {
			message = "";
			return new ModelAndView("home", "message", message);
		}
		else {
			message = "Username or Password are invalid.Please try again !!";
			return new ModelAndView("index", "message", message);
		}
	}
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public ModelAndView home() 
	{       
		return new ModelAndView("home");
	}
	
	@RequestMapping(value = "viewAffinity", method = RequestMethod.GET)
	public ModelAndView viewAffinity() 
	{       
		return new ModelAndView("viewAffinity");
	}
	
	@RequestMapping(value = "runAffinity", method = RequestMethod.GET)
	public ModelAndView runAffinity() 
	{       
		return new ModelAndView("runAffinity");
	}
	
	@RequestMapping(value = "viewstrategies", method = RequestMethod.GET)
	public ModelAndView viewstrategies() 
	{       
		return new ModelAndView("viewstrategies");
	}
	
	@RequestMapping(value = "scatteraffinity", method = RequestMethod.GET)
	public ModelAndView scatterAffinity() 
	{       
		return new ModelAndView("scatteraffinity");
	}
	
	@RequestMapping(value = "matrixaffinity", method = RequestMethod.GET)
	public ModelAndView matrixaffinity() 
	{       
		return new ModelAndView("matrixaffinity");
	}
}