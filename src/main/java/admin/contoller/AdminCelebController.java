
package admin.contoller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import admin.model.AdminDao;
import celeb.model.CelebBean;
import company.model.CompanyBean;
import product.model.ProductBean;
import q_board.model.QBoardBean;
import utility.Paging;

@Controller
public class AdminCelebController { 
	private final String command = "/celebList.admin";
	private final String viewPage = "adminCeleb";
	private final String deleteCommand = "/celebDelete.admin";
	private final String gotoPage = "redirect:/celebList.admin";
	private final String insertCommand = "/celebInsert.admin";
	private String insertFormPage = "adminCelebInsertForm";
	private final String updateCommand = "/celebUpdate.admin";
	private String updateformPage = "adminCelebUpdateForm";
	private final String redirect = "redirect";
	
	@Autowired
	private AdminDao adminDao;
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value=command)
	public String list(Model model,
					HttpServletRequest request,
					@RequestParam(required = false) String whatColumn,
					@RequestParam(required = false) String keyword,
					@RequestParam(required = false) String filter,
					@RequestParam(required = false) String pageNumber) throws UnsupportedEncodingException {

		 request.setCharacterEncoding("UTF-8");
		if(keyword == null) keyword = "";
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");
		map.put("filter", filter); 
		System.out.println(whatColumn+","+keyword+","+filter);
		String ps="1000";
		 
		int totalCount = adminDao.getCeleb(map);
		String url = request.getContextPath()+command;
		Paging pageInfo = new Paging(pageNumber, ps, totalCount, url, whatColumn, keyword);
		
		List<CelebBean> celebLists = adminDao.getAllCelebList(map, pageInfo);
		model.addAttribute("celebLists",celebLists);
		model.addAttribute("pageInfo", pageInfo); 
		return viewPage;
	}
	
	@RequestMapping(value = insertCommand, method = RequestMethod.GET)
	public String insertForm() {
		return insertFormPage;
	}
	
	@RequestMapping(value = insertCommand, method = RequestMethod.POST)
	public String in(@ModelAttribute("bb") CelebBean bb,
							Model model,
							HttpServletRequest request) throws UnsupportedEncodingException {
		System.out.println("추가하려는 연예인 이미지:"+bb.getCl_image());
		
		int res = adminDao.insertCeleb(bb);
		if(res == 1) {
			model.addAttribute("msg", "연예인이 성공적으로 추가되었습니다.");
			model.addAttribute("url", "celebList.admin");
			String uploadPath = servletContext.getRealPath("/resources/uploadFolder/celeb/");
			System.out.println("uploadPath:"+uploadPath);
			File destTitle = new File(uploadPath+File.separator+bb.getCl_image());
			
			MultipartFile cl_img = bb.getUpload_cl();
			
			try {
				cl_img.transferTo(destTitle); //destTitle에 ttl_img 올려라.
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			model.addAttribute("msg", "연예인 추가 실패. DB 확인 요망.");
			model.addAttribute("url", "celebInsert.admin");
		}
		
		return redirect;
	}
	
	
	
	@RequestMapping(value=updateCommand)
	public String updateForm(@RequestParam("cl_num") int cl_num, Model model) {
		CelebBean bb = adminDao.getSelectOneCeleb(cl_num);
		model.addAttribute("bb", bb);
		return updateformPage;
	}
	
	@RequestMapping(value = updateCommand, method = RequestMethod.POST)
	public String update(@ModelAttribute(value = "bb") CelebBean bb,
							@RequestParam String exist_climg,
							Model model) throws IOException {
		System.out.println("기존 타이틀이미지:"+exist_climg);
		System.out.println("새로운 디테일이미지:"+bb.getCl_image());
		// 기존 타이틀이미지, 디테일이미지를 업로드 폴더에서 내리는 작업
		String uploadPath = servletContext.getRealPath("/resources/uploadFolder/celeb/");
		File destTitle = new File(uploadPath+File.separator+exist_climg);
		try {
			destTitle.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 새로운 타이틀이미지, 디테일이미지 포함 나머지들을 업데이트하는 작업
		int res = adminDao.updateCeleb(bb);
		if(res == 1) {
			model.addAttribute("msg", "성공적으로 수정되었습니다.");
			model.addAttribute("url", "celebList.admin");
			destTitle = new File(uploadPath+File.separator+bb.getCl_image());
			
			MultipartFile cl_image = bb.getUpload_cl();
			
			try {
				cl_image.transferTo(destTitle); //destTitle에 ttl_img 올려라.
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			System.out.println("update res:"+res);
			model.addAttribute("msg", "수정 실패. DB 확인 요망.");
			model.addAttribute("url", "celebUpdate.admin");
		}
		return redirect;
	}
	
	@RequestMapping(value=deleteCommand,method=RequestMethod.GET)
	public String delete(
				Model model,
				@RequestParam("cl_num") int cl_num
			) {
		
		CelebBean bb = adminDao.getSelectOneCeleb(cl_num);
		
		model.addAttribute("bb",bb);
		
		adminDao.deleteCeleb(cl_num);
		
		return gotoPage;
	}
}