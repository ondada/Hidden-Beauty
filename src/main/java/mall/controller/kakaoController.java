package mall.controller;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
 
 

import org.springframework.stereotype.Controller;
 
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import mall.model.KakaoApproveResponse;
import mall.model.KakaoReadyResponse;

@Controller
public class kakaoController {
	private final String command = "/kakaopay33.mall";
	  private String cid = "TC0ONETIME";  
	  private KakaoReadyResponse kakaoReady;
 
	@RequestMapping(value = command)
	@ResponseBody
	public String kakaopay(
			HttpSession session
		 ) {
		KakaoApproveResponse kar = (KakaoApproveResponse)session.getAttribute("kao");
		   
		         // 카카오페이 요청 양식
			MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		        parameters.add("cid", cid);
		        parameters.add("partner_order_id", kar.getPartner_order_id());//주문번호
		        parameters.add("partner_user_id", kar.getPartner_user_id());//회원 아이디
		        parameters.add("item_name", "Hidden Beauty 상품");//상품명
		        parameters.add("quantity", "1");//주문 수량
		        parameters.add("total_amount", Integer.toString(kar.getAmount().getTotal()));//총 금액
		        parameters.add("vat_amount", "0");//부가세
		        parameters.add("tax_free_amount", "0");//상품 비과세 금액
		        parameters.add("approval_url", "http://localhost:8080/ex20/pay/success.mall"); // 결제승인시 넘어갈 url
		        parameters.add("cancel_url", "http://localhost:8080/ex20/pay/cancel.mall"); // 결제취소시 넘어갈 url
			    parameters.add("fail_url", "http://localhost:8080/ex20/pay/fail.mall"); // 결제 실패시 넘어갈 url
		        // 파라미터, 헤더
		        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(parameters, this.getHeaders());
 
		        // 외부에 보낼 url
		        RestTemplate restTemplate = new RestTemplate();
		        
		        ResponseEntity<String> responseEntity = restTemplate.postForEntity(
		                "https://kapi.kakao.com/v1/payment/ready",
		                requestEntity,
		                String.class);
     

		        if (responseEntity.getStatusCode().equals(HttpStatus.OK)) {
		            // 성공적인 경우, JSON 문자열을 그대로 반환하거나 필요에 따라 처리
		            return responseEntity.getBody();
		        } else {
		            // 실패한 경우, 오류 처리
		            return "{\"result\":\"NO\"}"; 
		        }
		
		
	
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