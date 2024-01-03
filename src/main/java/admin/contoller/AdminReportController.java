package admin.contoller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import admin.model.AdminDao;
import users.model.RestoreBean;
import users.model.UsersBean;
import utility.Paging;


@Controller
public class AdminReportController {
	private final String command = "/report.admin";
	private final String command_see = "/seeReport.admin";
	private final String viewPage = "usersList.admin";
	private final String viewPage_see = "adminSeeRestore";
	private final String redirect = "redirect";
	
	@Autowired
	private AdminDao ad;
	
	@RequestMapping(value = command)
	public String report(Model model,
						@RequestParam(required = false) String u_id,
						@RequestParam(required = false) String filter,
						@RequestParam(required = false) String whatColumn,
						@RequestParam(required = false) String keyword) {
		
		ad.resetReport(u_id);
		ad.restoreDone(u_id);
		
		model.addAttribute("msg", "정지 해제되었습니다.");
		model.addAttribute("url", viewPage+"?filter="+filter+"&whatColumn="+whatColumn+"&keyword="+keyword);
		
		return redirect;
	}
	
	@RequestMapping(value = command_see)
	public String seeRestore(Model model, HttpServletRequest request, @RequestParam(value="pageNumber", required = false) String pageNumber) {
		
		int totalCount = ad.getRestoreCount();
		String url = request.getContextPath()+command_see;
		Paging pageInfo = new Paging(pageNumber, "5", totalCount, url, null, null);
		
		List<RestoreBean> rbList = ad.getAllRestore(pageInfo);
		model.addAttribute("rbList", rbList);
		
		int newRequest = 0;
		for(int i=0; i<rbList.size(); i++) {
			if(rbList.get(i).getRs_done().equals("N")) {
				newRequest++;
			}
		}
		model.addAttribute("newRequest", newRequest);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("pageNumber", pageInfo.getPageNumber());
		
		return viewPage_see;
	}

}
