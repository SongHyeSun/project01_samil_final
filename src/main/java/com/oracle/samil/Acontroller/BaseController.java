package com.oracle.samil.Acontroller;

import org.springframework.beans.factory.annotation.Autowired;

import com.oracle.samil.Amodel.Emp;

import jakarta.servlet.http.HttpSession;

public class BaseController {
	@Autowired
	protected HttpSession session;
	
	protected Emp getUser() {
		return (Emp) session.getAttribute("emp");
	}
}
