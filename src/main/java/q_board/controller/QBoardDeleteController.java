package q_board.controller;

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

import q_board.model.QBoardBean;
import q_board.model.QBoardDao;

@Controller
public class QBoardDeleteController {

	@Autowired
	private QBoardDao qdao;
	 
	public final String command="/qDelete.qb";
	public final String viewPage="qBoardDelete";
	public final String viewPage2="alert";
	public final String gotoPage="redirect:/qBoardList.qb";
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String deleteform(
				Model model,
				@RequestParam("q_num") int q_num,
				@RequestParam("pageNumber") int pageNumber,
				@RequestParam(value="whatColumn", required=false) String whatColumn,
				@RequestParam(value="keyword", required=false) String keyword
			) {
		
		QBoardBean bb = qdao.selectContent(q_num);
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("bb",bb);
		model.addAttribute("whatColumn",whatColumn);
		model.addAttribute("keyword",keyword);
		
		return viewPage;
	}
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public ModelAndView deletelist(
								Model model, HttpServletResponse response,
								@RequestParam("q_num") int q_num,
								@RequestParam("pageNumber") int pageNumber,
								@RequestParam(value="q_password", required=false) String q_password,
								@RequestParam(value="whatColumn", required=false) String whatColumn,
								@RequestParam(value="keyword", required=false) String keyword) throws IOException {
		
		ModelAndView mav = new ModelAndView();
		QBoardBean bb = qdao.selectContent(q_num);
		
		String[] insertedPassword = q_password.split(",");  // 자꾸 ,가 같이 들어와서 이렇게 처리함
		
		if(insertedPassword[1].equals(bb.getQ_password())) {
			qdao.deleteBoard(q_num);
			mav.setViewName(gotoPage+"?pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword);
			return mav;
		} else {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "qDelete.qb?q_num="+q_num+"&pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword);
		    mav.setViewName(viewPage2);
			return mav;
		}
		
	}
	
}
