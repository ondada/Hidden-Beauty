package utility;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class NaverApi {
	private String client_id = "7e2tSZMcps1aVtINdSJv";
	private String client_secret = "A98jpGEn8v";
	private String redirect_uri = "http%3A%2F%2Flocalhost%3A8080%2Fex20%2Fnaver.u";
	
	// access token 諛쏄린
	public Map<String, String> getAccessToken(String code, String state) {
	    String accessToken = "";
	    String refreshToken = "";
	    String reqUrl = "https://nid.naver.com/oauth2.0/token";
	    Map<String, String> tokens = null;
	    
	    try{
	        URL url = new URL(reqUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setDoOutput(true); //OutputStream�쑝濡� POST �뜲�씠�꽣瑜� �꽆寃⑥＜寃좊떎�뒗 �샃�뀡.
	        
	        // Request Body�뿉 Data瑜� �떞湲곗쐞�빐 OutputStream 媛앹껜瑜� �깮�꽦.
	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        // StringBuilder�뒗 蹂�寃� 媛��뒫�븳 臾몄옄�뿴�쓣 留뚮뱾�뼱以��떎.
	        StringBuilder sb = new StringBuilder();
	        
	        //�븘�닔 荑쇰━ �뙆�씪誘명꽣 �꽭�똿
	        sb.append("grant_type=authorization_code");
	        sb.append("&client_id=").append(client_id);
	        sb.append("&client_secret=").append(client_secret);
	        sb.append("&redirect_uri=").append(redirect_uri);
	        sb.append("&code=").append(code);
	        sb.append("&state=").append(state);

	        bw.write(sb.toString());
	        bw.flush();
	        
	        // �떎�젣 �꽌踰꾨줈 Request �슂泥� �븯�뒗 遺�遺�. (�쓳�떟 肄붾뱶瑜� 諛쏅뒗�떎. 200 �꽦怨�, �굹癒몄� �뿉�윭)
	        int responseCode = conn.getResponseCode();
	        System.out.println("[NaverApi.getAccessToken] responseCode = "+ responseCode);
	        
	        BufferedReader br;
	        if (responseCode == 200) {
	            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }

	        String line = "";
	        StringBuilder responseSb = new StringBuilder();
	        while((line = br.readLine()) != null){
	            responseSb.append(line);
	        }

	        JSONParser parsing = new JSONParser();
	        Object obj = parsing.parse(responseSb.toString());
	        JSONObject jsonObj = (JSONObject)obj;
	        accessToken = String.valueOf(jsonObj.get("access_token"));
	        refreshToken = String.valueOf(jsonObj.get("refresh_token"));
	        tokens = new HashMap<String, String>();
	        tokens.put("accessToken", accessToken);
	        tokens.put("refreshToken", refreshToken);
	        
	        br.close();
	        bw.close();
	    }catch (Exception e){
	        e.printStackTrace();
	    }
	    return tokens;
	}
	
	public Map<String, Object> getUserInfo(String accessToken) {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
	    String reqUrl = "https://openapi.naver.com/v1/nid/me";
	    try{
	        URL url = new URL(reqUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

	        int responseCode = conn.getResponseCode();
	        System.out.println("[NaverApi.getUserInfo] responseCode = "+ responseCode);
	        
	        BufferedReader br;
	        if (responseCode >= 200 && responseCode <= 300) {
	            br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
	        } else {
	            br = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
	        }

	        String line = "";
	        StringBuilder responseSb = new StringBuilder();
	        while((line = br.readLine()) != null){
	            responseSb.append(line);
	        }
	        
	        JSONParser parsing = new JSONParser();
	        Object obj = parsing.parse(responseSb.toString());
	        JSONObject jsonObj = (JSONObject)obj;
	        JSONObject response = (JSONObject)jsonObj.get("response");
	        String id = String.valueOf(response.get("id"));
	        String name = String.valueOf(response.get("name"));
	        String email = String.valueOf(response.get("email"));
	        String profile_image = String.valueOf(response.get("profile_image"));

	        userInfo.put("id", id);
	        userInfo.put("name", name);
	        userInfo.put("email", email);
	        userInfo.put("profile_image", profile_image);

	        br.close();

	    }catch (Exception e){
	        e.printStackTrace();
	    }
	    return userInfo;
	}
	
	public String isTokenValid(String accessToken) {
		String reqValidUrl = "https://openapi.naver.com/v1/nid/me";
		String message = "";
		try {
			URL url = new URL(reqValidUrl);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			int responseCode = conn.getResponseCode();
	        System.out.println("[NaverApi.isTokenValid] responseCode = "+ responseCode);
	        BufferedReader br;
	        if (responseCode == 200) {
	            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }

	        String line = "";
	        StringBuilder responseSb = new StringBuilder();
	        while((line = br.readLine()) != null){
	            responseSb.append(line);
	        }
	        JSONParser parsing = new JSONParser();
	        Object obj = parsing.parse(responseSb.toString());
	        JSONObject jsonObj = (JSONObject)obj;
	        message = String.valueOf(jsonObj.get("message"));
	        System.out.println("유효한 토큰인지 확인: "+message);// �쑀�슚�븯硫� success
		}catch (Exception e){
 	        e.printStackTrace();
 	    }
		return message;
	}
	// �뿰�룞�빐�젣 2�떒怨�. �젒洹� �넗�겙 �옱諛쒓툒
	public String getAccessTokenAgain(String refreshToken) {
		String reqUrl = "https://nid.naver.com/oauth2.0/token";
		String accessToken = "";
		try{
 	        URL url = new URL(reqUrl);
 	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
 	        conn.setDoOutput(true); //OutputStream�쑝濡� POST �뜲�씠�꽣瑜� �꽆寃⑥＜寃좊떎�뒗 �샃�뀡.
 	        
 	        // Request Body�뿉 Data瑜� �떞湲곗쐞�빐 OutputStream 媛앹껜瑜� �깮�꽦.
 	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
 	        // StringBuilder�뒗 蹂�寃� 媛��뒫�븳 臾몄옄�뿴�쓣 留뚮뱾�뼱以��떎.
 	        StringBuilder sb = new StringBuilder();
 	        
 	        //�븘�닔 荑쇰━ �뙆�씪誘명꽣 �꽭�똿
 	        sb.append("grant_type=refresh_token");
 	        sb.append("&client_id=").append(client_id);
 	        sb.append("&client_secret=").append(client_secret);
 	        sb.append("&refresh_token=").append(refreshToken);

 	        bw.write(sb.toString());
 	        bw.flush();
 	        
 	        int responseCode = conn.getResponseCode();
 	        System.out.println("[NaverApi.getAccessTokenAgain] responseCode = "+ responseCode);
 	        
 	        BufferedReader br;
 	        if (responseCode == 200) {
 	            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
 	        } else {
 	            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
 	        }

 	        String line = "";
 	      	StringBuilder responseSb = new StringBuilder();
 	        while((line = br.readLine()) != null){
 	            responseSb.append(line);
 	        }
 	        
 	        JSONParser parsing = new JSONParser();
 	        Object obj = parsing.parse(responseSb.toString());
 	        JSONObject jsonObj = (JSONObject)obj;
 	        accessToken = String.valueOf(jsonObj.get("access_token")); // 媛깆떊�맂 �젒洹� �넗�겙 諛쏄린
 	        br.close();
 	        bw.close();
 	    }catch (Exception e){
 	        e.printStackTrace();
 	    }
		return accessToken;
	}
	public String naverDisconnect(String accessToken) {
		String reqUrl = "https://nid.naver.com/oauth2.0/token";
		String result = "";
		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setDoOutput(true); //OutputStream�쑝濡� POST �뜲�씠�꽣瑜� �꽆寃⑥＜寃좊떎�뒗 �샃�뀡.
	        
	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        StringBuilder sb = new StringBuilder();
	        
	        sb.append("grant_type=delete");
	        sb.append("&client_id=").append(client_id);
	        sb.append("&client_secret=").append(client_secret);
	        sb.append("&access_token=").append(URLEncoder.encode(accessToken, "UTF-8"));
	        sb.append("&service_provider=").append("NAVER");

	        bw.write(sb.toString());
	        bw.flush();
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("[NaverApi.deleteToken] responseCode = "+ responseCode);
	        
	        BufferedReader br;
	        if (responseCode == 200) {
	            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }

	        String line = "";
	        StringBuilder responseSb = new StringBuilder();
	        while((line = br.readLine()) != null){
	            responseSb.append(line);
	        }
	        
	        JSONParser parsing = new JSONParser();
	        Object obj = parsing.parse(responseSb.toString());
	        JSONObject jsonObj = (JSONObject)obj;
	        result = String.valueOf(jsonObj.get("result"));
	        br.close();
	        bw.close();

		}catch (Exception e){
 	        e.printStackTrace();
 	    }
		return result;
	}
}
