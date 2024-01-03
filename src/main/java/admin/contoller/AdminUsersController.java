package admin.contoller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import admin.model.AdminDao;
import users.model.UsersBean;


@Controller
public class AdminUsersController {
	private final String command = "usersList.admin";
	private final String delCommand = "usersDelete.admin";
	private final String upCommand = "usersUpdate.admin";
	
	private final String viewPage = "adminUsers";
	private final String viewPage2 = "adminUsersUpdateForm";
	private final String redirect = "redirect";
	
	@Autowired
	private AdminDao ad;
	
	@RequestMapping(value = command)
	public String adUsers(@RequestParam(required = false) String filter,
						@RequestParam(required = false) String whatColumn,
						@RequestParam(required = false) String keyword,
						@RequestParam(required = false) String pageNumber,
						Model model,
						HttpServletRequest request) {
		
		System.out.println("\n=======usersList.admin 요청=======");
		
		if(filter == null) {
			filter = "";
		}
		System.out.println("필터:"+filter);
		System.out.println("페이지넘버:"+pageNumber);
		System.out.println("왓칼럼:"+whatColumn);
		System.out.println("키워드:"+keyword);
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("filter", filter);
		map.put("whatColumn", whatColumn);
		if(keyword == null || keyword.equals("")) {
			keyword = "";
			map.put("keyword", keyword);
		} else{
			map.put("keyword", "%"+keyword+"%");
		}
		List<UsersBean> usersLists = ad.getUsers(map);
		model.addAttribute("usersLists", usersLists);
		
		return viewPage;
	}
	
	@RequestMapping(value = delCommand)
	public String delete(@RequestParam String u_id,
						@RequestParam String u_jointype,
						Model model) {
		ad.deleteUsers(u_id);
		if(u_jointype.equals("N")) {
			// 네이버 연동 해제
			model.addAttribute("msg", u_id.substring(0, 11)+"...(네이버)님이 탈퇴되었습니다.");
			model.addAttribute("url", "disnaver.u?admin=yes");
		} else if(u_jointype.equals("K")) {
			// 카카오 연동 해제
			model.addAttribute("msg", u_id+"(카카오)님이 탈퇴되었습니다.");
			model.addAttribute("url", "diskakao.u?admin=yes");
		} else {
			model.addAttribute("msg", u_id+"님이 탈퇴되었습니다.");
			model.addAttribute("url", ".admin");
		}
		return redirect;
	}
	@RequestMapping(value = upCommand, method = RequestMethod.GET)
	public String update(@RequestParam String u_id, Model model) {
		UsersBean ub = ad.getUserById(u_id);
		model.addAttribute("ub", ub);
		return viewPage2;
	}
	@RequestMapping(value = upCommand, method = RequestMethod.POST)
	public String update(@ModelAttribute("ub") UsersBean ub, Model model) {
		String[] emailParts = ub.getU_email().split(",");
		String u_email = emailParts[0] + "@" + emailParts[1];
		ub.setU_email(u_email);
		
		String[] phoneParts = ub.getU_phone().split(",");
		String u_phone = phoneParts[0] + "-" + phoneParts[1] + "-" + phoneParts[2];
		ub.setU_phone(u_phone);
		String u_address = ub.getU_address().replace(","," ");
		ub.setU_address(u_address);
		int res = ad.updateUsersById(ub);
		if(res == 1) {
			model.addAttribute("msg", "회원정보가 성공적으로 수정되었습니다.");
			model.addAttribute("url", command);
		} else {
			model.addAttribute("msg", "회원 수정 실패. DB 확인 요망.");
			model.addAttribute("url", upCommand+"?u_id="+ub.getU_id());
		}
		return redirect;
	}
}
