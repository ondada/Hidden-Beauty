package c_board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import c_board.model.CBoardBean;
import c_board.model.CBoardDao;

@Controller
public class CBoardDeleteController {

	@Autowired
	private CBoardDao cdao;
	 
	public final String command="/cDelete.cb";
	public final String viewPage="cBoardDelete";
	public final String viewPage2="alert";
	public final String gotoPage="redirect:/cBoardList.cb";
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String deleteform(
				Model model,
				@RequestParam("c_num") int c_num,
				@RequestParam("pageNumber") int pageNumber,
				@RequestParam(value="whatColumn", required=false) String whatColumn,
				@RequestParam(value="keyword", required=false) String keyword
			) { 
		
		CBoardBean bb = cdao.selectContent(c_num);
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("bb",bb);
		model.addAttribute("whatColumn",whatColumn);
		model.addAttribute("keyword",keyword);
		
		return viewPage;
	}
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public ModelAndView deletelist(
								Model model, HttpServletResponse response,
								@RequestParam("c_num") int c_num,
								@RequestParam("pageNumber") int pageNumber,
								@RequestParam(value="c_password", required=false) String c_password,
								@RequestParam(value="whatColumn", required=false) String whatColumn,
								@RequestParam(value="keyword", required=false) String keyword) throws IOException {
		
		ModelAndView mav = new ModelAndView();
		CBoardBean bb = cdao.selectContent(c_num);
		
		String[] insertedPassword = c_password.split(",");  // 자꾸 ,가 같이 들어와서 이렇게 처리함
		
		if(insertedPassword[1].equals(bb.getC_password())) {
			cdao.deleteBoard(c_num);
			mav.setViewName(gotoPage+"?pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword);
			return mav;
		} else {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "cDelete.cb?c_num="+c_num+"&pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword);
		    mav.setViewName(viewPage2);
			return mav;
		}
		
	}
	
}
