package admin.contoller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import admin.model.AdminDao;
import c_board.model.CBoardBean;
import company.model.CompanyBean;
import company.model.CompanyDao;
import users.model.UsersBean;
import utility.Paging;

@Controller
public class AdminCompanyController {

	private final String command = "/companyList.admin";
	private String viewPage = "adminCompany";

	private final String insertCommand = "/companyInsert.admin";
	private String insertFormPage = "adminCompanyInsertForm";
	
	private final String deleteCommand = "/companyDelete.admin";
	private final String updateCommand = "/companyUpdate.admin";
	private String updateformPage = "adminCompanyUpdateForm";
	
	private String gotoPage = "redirect:/companyList.admin";
	
	@Autowired
	private AdminDao admindao;
	
	@RequestMapping(value = command)
	public String list(
						@RequestParam(required = false) String filter,
						@RequestParam(value = "oneName", required = false) String oneName,
						@RequestParam(value = "oneX", required = false) String oneX,
						@RequestParam(value = "oneY", required = false) String oneY,
						@RequestParam(value = "whatColumn", required = false) String whatColumn,
						@RequestParam(value = "keyword", required = false) String keyword,
						@RequestParam(value ="pageNumber", required = false) String pageNumber,
						HttpServletRequest request,
						Model model) {
		
		System.out.println("필터:"+filter);
		System.out.println("페이지넘버:"+pageNumber);
		System.out.println("왓칼럼:"+whatColumn);
		if(keyword == null) keyword = "";
		System.out.println("키워드:"+keyword);
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("filter", filter);
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");
		
		
		int totalCount = admindao.getTotalCountCompany(map);
		String url = request.getContextPath()+command;
		String ps="1000";
		 
		Paging pageInfo = new Paging(pageNumber, ps, totalCount, url, whatColumn, keyword);
		
		List<CompanyBean> list = admindao.getAllCompany(pageInfo,map);
			
		model.addAttribute("list", list);
		model.addAttribute("pageInfo", pageInfo);
		return viewPage;	
	}
	
	@RequestMapping(value = insertCommand, method = RequestMethod.GET)
	public String insertForm() {
		return insertFormPage;
	}
	
	@RequestMapping(value = insertCommand, method = RequestMethod.POST)
	public String in(@ModelAttribute("bb") CompanyBean bb,
						HttpServletResponse response) throws IOException {
		String cmp_addr = bb.getCmp_addr().replace(","," ");
		bb.setCmp_addr(cmp_addr);
		admindao.insertCompany(bb);
		return gotoPage;
		
	}
	
	
	
	@RequestMapping(value=updateCommand)
	public String updateForm(@RequestParam("cmp_num") int cmp_num, Model model) {
		CompanyBean bb = admindao.getSelectOneCompany(cmp_num);
		model.addAttribute("bb", bb);
		return updateformPage;
	}
	
	@RequestMapping(value = updateCommand, method = RequestMethod.POST)
	public String update(@RequestParam("cmp_num") int cmp_num,
							@ModelAttribute(value = "bb") CompanyBean bb, 
							HttpServletResponse response, 
							HttpSession session, 
							Model model) throws IOException {
		
		String cmp_addr = bb.getCmp_addr().replace(","," ");
		bb.setCmp_addr(cmp_addr);
		admindao.updateCompany(bb);
	
		model.addAttribute("bb", bb);
		return gotoPage;
	} 
	
	
	@RequestMapping(value=deleteCommand,method=RequestMethod.GET)
	public String delete(
				Model model,
				@RequestParam("cmp_num") int cmp_num,
				@RequestParam("pageNumber") int pageNumber
			) {
		
		CompanyBean bb = admindao.getSelectOneCompany(cmp_num);
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("bb",bb);
		
		admindao.deleteCompany(cmp_num);
		
		return gotoPage;
	}
	
}