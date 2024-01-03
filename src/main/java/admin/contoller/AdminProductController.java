package admin.contoller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

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
import product.model.ProductBean;
import utility.Paging;

@Controller
public class AdminProductController {
	private final String command = "/productList.admin";
	private final String inCommand = "/productInsert.admin";
	private final String delCommand = "/productDelete.admin";
	private final String upCommand = "/productUpdate.admin";
	 
	private final String viewPage = "adminProduct";
	private final String inPage = "adminProductInsertForm";
	private final String upPage = "adminProductUpdateForm";
	
	private final String redirect = "redirect";
	@Autowired
	private AdminDao ad;
	@Autowired
	ServletContext servletContext;
	@RequestMapping(value = command)
	public String adminProduct(@RequestParam(required = false) String filter,
						@RequestParam(required = false) String whatColumn,
						@RequestParam(required = false) String keyword,
						@RequestParam(required = false) String pageNumber,
						Model model,
						HttpServletRequest request) {
		System.out.println("=======productList.admin 요청=======");
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
		
		int totalCount = ad.getTotalPrdCount(map);
		System.out.println("토탈카운트:"+totalCount);
		String url = request.getContextPath()+command;
		Paging pageInfo = new Paging(pageNumber, "30", totalCount, url, whatColumn, keyword);
		
		// --------------- pagingHtml에 filter 쿼리스트링 추가하기 ---------------
		String pagingHtml = pageInfo.getPagingHtml();
		System.out.println("\n원래 pagingHtml:"+pagingHtml);
		ArrayList<Integer> indexes = new ArrayList<Integer>(); // 찾은 인덱스들을 저장할 ArrayList
		StringBuffer pagingSB = new StringBuffer(pagingHtml); // pagingHtml 중간에 문자열을 삽입하기 위한 StringBuffer
		
		Matcher matcher = Pattern.compile("' style").matcher(pagingHtml);
		while (matcher.find()) {
			System.out.println("원래 인덱스:"+matcher.start());
			indexes.add(matcher.start());
		}
		
		String queryParam = "&filter="+filter;
		System.out.println("\nfilter쿼리스트링의 길이:"+queryParam.length());
		for(int i=0; i<indexes.size(); ++i) {//Integer idx:indexes
			int idx = indexes.get(i);
			idx += queryParam.length()*i;
			System.out.println("쿼리스트링의 길이가 반영된 인덱스:"+idx);
			indexes.set(i, idx);
			pagingSB.insert(idx, queryParam);
		}
		System.out.println("filter파라미터가 추가된 pagingHtml:"+pagingSB.toString());
		pageInfo.setPagingHtml(pagingSB.toString());
		// -----------------------------------------------------------------
		
		List<ProductBean> prodLists = ad.getProducts(map, pageInfo);
		model.addAttribute("prodLists", prodLists);
		model.addAttribute("pageInfo", pageInfo);
		
		return viewPage;
	}
	
	@RequestMapping(value = inCommand, method = RequestMethod.GET)
	public String adminProdIn() throws IOException {
		return inPage;
	}
	
	@RequestMapping(value = inCommand, method = RequestMethod.POST)
	public String adminProdIn2(@ModelAttribute(value = "pb") ProductBean pb,
							Model model,
							HttpServletRequest request) throws UnsupportedEncodingException {
		System.out.println("insert하려는 상품의 타이틀이미지:"+pb.getP_ttlimg());
		System.out.println("insert하려는 상품의 디테일이미지:"+pb.getP_dtlimg());
		
		int res = ad.insertProduct(pb);
		if(res == 1) {
			model.addAttribute("msg", "상품이 성공적으로 추가되었습니다.");
			model.addAttribute("url", "productList.admin");
			String uploadPath = servletContext.getRealPath("/resources/uploadFolder/product/");
			System.out.println("uploadPath:"+uploadPath);
			File destTitle = new File(uploadPath+File.separator+pb.getP_ttlimg());
			File destDetail = new File(uploadPath+File.separator+pb.getP_dtlimg());
			
			MultipartFile ttl_img = pb.getUpload_ttl();
			MultipartFile dtl_img = pb.getUpload_dtl();
			
			try {
				ttl_img.transferTo(destTitle); //destTitle에 ttl_img 올려라.
				dtl_img.transferTo(destDetail); //destDetail에 dtl_img 올려라.
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			model.addAttribute("msg", "상품 추가 실패. DB 확인 요망.");
			model.addAttribute("url", "productInsert.admin");
		}
		return redirect;
	}
	 
	@RequestMapping(value = delCommand)
	public String adminProdDel(@RequestParam String p_num,
							Model model) throws IOException {
		// 삭제한 타이틀이미지, 디테일이미지를 업로드 폴더에서 내리는 작업
		ProductBean pb = ad.getProductByNum(p_num);
		String uploadPath = servletContext.getRealPath("/resources/uploadFolder/product/");
		System.out.println("uploadPath:"+uploadPath);
		File destTitle = new File(uploadPath+File.separator+pb.getP_ttlimg());
		File destDetail = new File(uploadPath+File.separator+pb.getP_dtlimg());
		
		try {
			destTitle.delete();
			destDetail.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int res = ad.deleteProduct(p_num);
		if(res == 1) {
			model.addAttribute("msg", "상품이 성공적으로 삭제되었습니다.");
		} else {
			model.addAttribute("msg", "상품 삭제 실패. DB 확인 요망.");
		}
		model.addAttribute("url", "productList.admin");
		return redirect;
	}
	
	@RequestMapping(value = upCommand, method = RequestMethod.GET)
	public String adminProdUp(@RequestParam String p_num, Model model) throws IOException {
		ProductBean pb = ad.getProductByNum(p_num);
		model.addAttribute("pb", pb);
		return upPage;
	}
	
	@RequestMapping(value = upCommand, method = RequestMethod.POST)
	public String adminProdUp2(@ModelAttribute(value = "pb") ProductBean pb, 
							@RequestParam String exist_ttl,
							@RequestParam String exist_dtl,
							Model model) throws IOException {
		
		System.out.println("타이틀 기존/수정:"+exist_ttl+"/"+pb.getP_ttlimg());
		System.out.println("디테일 기존/수정:"+exist_dtl+"/"+pb.getP_dtlimg());
		
		// 기존 타이틀이미지, 디테일이미지를 업로드 폴더에서 내리는 작업
		String uploadPath = servletContext.getRealPath("/resources/uploadFolder/product/");
		File destTitle = new File(uploadPath+File.separator+exist_ttl);
		File destDetail = new File(uploadPath+File.separator+exist_dtl);
		
		// 이미지 수정 작업이 이루어졌는지 체크.
		// 이미지 수정이 있었으면 기존이미지를 지우고,
		// 없었으면 기존 이미지로 다시 set한다.
		if(pb.getP_ttlimg() == null) {
			pb.setP_ttlimg(exist_ttl);
		} else {
			destTitle.delete();
		}
		if(pb.getP_dtlimg() == null) {
			pb.setP_dtlimg(exist_dtl);
		} else {
			destDetail.delete();
		}
		// 새로운 타이틀이미지, 디테일이미지 포함 나머지들을 업데이트하는 작업
		int res = ad.updateProduct(pb);
		if(res == 1) {
			model.addAttribute("msg", "상품이 성공적으로 수정되었습니다.");
			model.addAttribute("url", "productList.admin");
			destTitle = new File(uploadPath+File.separator+pb.getP_ttlimg());
			destDetail = new File(uploadPath+File.separator+pb.getP_dtlimg());
			
			if(pb.getUpload_ttl() != null) {
				MultipartFile ttl_img = pb.getUpload_ttl();
				ttl_img.transferTo(destTitle); // destTitle 업로드하기.
			}
			if(pb.getUpload_dtl() != null) {
				MultipartFile dtl_img = pb.getUpload_dtl();
				dtl_img.transferTo(destDetail); // destDetail 업로드하기.
			}
			

		} else {
			System.out.println("update res:"+res);
			model.addAttribute("msg", "상품 수정 실패. DB 확인 요망.");
			model.addAttribute("url", "productUpdate.admin?p_num="+pb.getP_num());
		}
		return redirect;
	}
}