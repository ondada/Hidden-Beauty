package company.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import company.model.CompanyBean;
import company.model.CompanyDao;


@Controller
public class CompanyMarkerController {
	private final String command = "/marker.cmp";
	private String viewPage = "redirect:/company.cmp";
	
	@Autowired
	private CompanyDao dao;
	
	@RequestMapping(value = command)
	public String marker(
			@RequestParam(value = "cmp_num", required = false) String cmp_num,
			@RequestParam(value ="pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword
			
			/* Model model */
			) throws UnsupportedEncodingException {
 
		CompanyBean cb = dao.getSelectOne(Integer.parseInt(cmp_num));
		String encodedName = URLEncoder.encode(cb.getCmp_name(), "UTF-8");
		String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
		/*
		  model.addAttribute("oneY", cb.getCmp_y()); 
		  model.addAttribute("oneX",cb.getCmp_x()); 
		  model.addAttribute("oneName", cb.getCmp_name());
		  model.addAttribute("pageNumber", pageNumber);
		 */
		return viewPage+"?oneY="+cb.getCmp_y()+"&oneX="+cb.getCmp_x()+"&oneName="+encodedName+"&pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+encodedKeyword;
		
		
	}
}
