package users.controller;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import users.model.UsersBean;
import users.model.UsersDao;


@Controller
public class UsersUpdateController {
	
	private final String command = "/update.u";
	private final String command_color = "/updateColor.u";
	private final String viewPage = "usersUpdateForm";
	private final String viewPage2 = "redirect";
	
	@Autowired
	private UsersDao ud;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam String u_id, Model model) {
		UsersBean ub = ud.getUserById(u_id);
		model.addAttribute("ub", ub);
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction2(@ModelAttribute(value = "ub") UsersBean ub,
							HttpServletResponse response, 
							HttpSession session, 
							Model model,
							@RequestParam("img_before") String img_before) throws IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		System.out.println("수정하려는 u_phone : " + ub.getU_phone());
		String u_phone = ub.getU_phone().replace(",","-"); // 010-1234-5678
		String u_email = ub.getU_email().replace(",","@");
		ub.setU_phone(u_phone);
		ub.setU_email(u_email);
		
		System.out.println("기존 프로필이미지:"+img_before);
		System.out.println("받아온 프로필 이미지:"+ub.getU_profileimg());
		String uploadPath = servletContext.getRealPath("/resources/uploadFolder/users/");
		System.out.println("uploadPath : " + uploadPath);
		File destBefore = new File(uploadPath+File.separator+img_before);
		if(ub.getU_profileimg() == null) {
			ub.setU_profileimg(img_before);
		} else {
			destBefore.delete();
		}
		
		int res = ud.updateUsers(ub);
		if(res > 0) {
			System.out.println("res:"+res);
			System.out.println("uploadPath:"+uploadPath);
			File destProfile= new File(uploadPath+File.separator+ub.getU_profileimg());
			if(ub.getUpload_img() != null) {
				MultipartFile u_profileImg = ub.getUpload_img();
				u_profileImg.transferTo(destProfile); // destTitle 업로드하기.
			}
			
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("url", "mypage.u?u_id="+ub.getU_id());
			return viewPage2;
		} else {
			out.print("<script>alert('수정 실패. 관리자에게 문의하세요.');</script>");
			out.flush();
			return viewPage;
		}
	} 
	
	@RequestMapping(value=command_color, method=RequestMethod.GET)
	public String updateColor(HttpServletResponse response, HttpSession session,
							@RequestParam("personalColor") String personalColor, Model model) throws IOException {
		
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		if(ud.updateColor(personalColor, ub.getU_id()) > 0) {
			//out.print("<script>alert('수정되었습니다.');</script>");
			//out.flush();
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("url", "mypage.u?u_id="+ub.getU_id());
			return viewPage2;
		} else {
			out.print("<script>alert('수정 실패. 관리자에게 문의하세요.');</script>");
			out.flush();
		}
		
		return viewPage2;
	}
}