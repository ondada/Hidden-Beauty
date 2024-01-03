package com.spring.ex20;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AiController {
	private final String command = "/colorAi.ai";
	private String viewPage = "colorAi";
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String view() {
		return viewPage;
		
	}
}
