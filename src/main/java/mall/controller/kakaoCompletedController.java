package mall.controller;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
 
 

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import mall.model.KakaoApproveResponse;
import mall.model.KakaoReadyResponse;

@Controller
public class kakaoCompletedController {
	private final String success = "pay/success.mall";

	  private String viewPage = "redirect:/success.mall"; 
	  private String viewPage2 = "redirect:/fail.mall"; 
	private KakaoReadyResponse kakaoReady;
	  private String cid = "TC0ONETIME";  
	  
	  
	@RequestMapping(value = success)
	public String afterPayRequest(@RequestParam("pg_token") String pg_token,
			@CookieValue(value ="tid", required = false) String tid,
			  HttpSession session,
			  Model model) throws IOException {
		KakaoApproveResponse kar = (KakaoApproveResponse)session.getAttribute("kao");
		
		System.out.println(pg_token+"pg_token");
		System.out.println(tid+"kakaoReady.getTid()");
		 try {
		        String approveResponse = kakaopaySuccess(pg_token, tid,kar);
		        
		        ObjectMapper objectMapper = new ObjectMapper();
		        KakaoApproveResponse approveResponseObject = objectMapper.readValue(approveResponse, KakaoApproveResponse.class);

		        // KakaoApproveResponse 객체에서 approved_at 값을 가져오기
		        String approvedAt = approveResponseObject.getApproved_at();
		        model.addAttribute("approvedAt",approvedAt);
		        
		        return viewPage;
		    } catch (HttpClientErrorException e) {
		        System.err.println("Kakao API 호출 오류: " + e.getMessage());
		        return viewPage2;
		    }
    }
	
	public String kakaopaySuccess(
	        @RequestParam(value ="pg_token", required = false) String pg_token,
	        @RequestParam(value ="tid", required = false) String tid, 
	        KakaoApproveResponse kar
	      
	) {
		
	    // 카카오페이 요청 양식
	    MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
	    parameters.add("cid", cid);
	    parameters.add("tid", tid);
	    parameters.add("partner_order_id", kar.getPartner_order_id());
	    parameters.add("partner_user_id",  kar.getPartner_user_id());
	    parameters.add("pg_token", pg_token);

	    HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(parameters, this.getHeaders());

	    // 외부에 보낼 url
	    RestTemplate restTemplate = new RestTemplate();

	 
	    	  String approveResponse = restTemplate.postForObject(
	                "https://kapi.kakao.com/v1/payment/approve",
	                requestEntity,
	                String.class);

	       
	            
	            return approveResponse;
	           
	}
	
    
    /**
     * 카카오 요구 헤더값
     */
    private HttpHeaders getHeaders() {
        HttpHeaders httpHeaders = new HttpHeaders();

        String auth = "KakaoAK " + "c7071b092e71bb5252ca96cf0e27bd41";

        httpHeaders.set("Authorization", auth);
        httpHeaders.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        return httpHeaders;
    }
}