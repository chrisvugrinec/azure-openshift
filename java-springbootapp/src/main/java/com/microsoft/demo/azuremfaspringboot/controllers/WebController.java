package com.microsoft.demo.azuremfaspringboot.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@ComponentScan(basePackages = "com.microsoft.demo.azuremfaspringboot.controllers")
@Controller
public class WebController {

//	@PreAuthorize("hasAuthority('ROLE_USER') or hasAuthority('ROLE_ADMIN')")
	@RequestMapping(value = "/hello", method = { RequestMethod.GET, RequestMethod.POST })
	public String defaultPage(ModelMap model, HttpServletRequest httpRequest) {
		return "hello";
	}

}
