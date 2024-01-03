package company.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import company.model.CompanyBean;
import company.model.CompanyDao;
import utility.Paging;

@Controller
public class CompanyListController {
	private final String command = "/company.cmp";
	private String viewPage = "Company";
	
	@Autowired
	private CompanyDao dao;
	
	@RequestMapping(value = command)
	public String list(
			@RequestParam(value = "oneName", required = false) String oneName,
			@RequestParam(value = "oneX", required = false) String oneX,
			@RequestParam(value = "oneY", required = false) String oneY,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value ="pageNumber", required = false) String pageNumber,
			HttpServletRequest request,
			Model model) {
		
		Map<String,String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");
		
		int totalCount = dao.getTotalCount(map);
		String url = request.getContextPath()+command;
		
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword);
		
		List<CompanyBean> list = dao.getAllCompany(pageInfo,map);
			
		model.addAttribute("list", list);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		model.addAttribute("oneY", oneY);
		model.addAttribute("oneX", oneX);
		model.addAttribute("oneName", oneName);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		
		return viewPage;
		
		
	}
}
