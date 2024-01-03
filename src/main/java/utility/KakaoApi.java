package utility;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


public class KakaoApi {
	private String client_id = "a8d5622ce00b9080e03be1948663093a";
	private String redirect_uri = "http%3A%2F%2Flocalhost%3A8080%2Fex20%2Fkakao.u";
	
	// access token 諛쏄린
	public Map<String, String> getAccessToken(String code) {
		String accessToken = "";
	    String refreshToken = "";
	    String reqUrl = "https://kauth.kakao.com/oauth/token";
	    Map<String, String> tokens = null;

	    try{
	        URL url = new URL(reqUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        
	        // Request Header媛� �꽭�똿
	        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	        conn.setDoOutput(true); //OutputStream�쑝濡� POST �뜲�씠�꽣瑜� �꽆寃⑥＜寃좊떎�뒗 �샃�뀡.
	        
	        // Request Body�뿉 Data瑜� �떞湲곗쐞�빐 OutputStream 媛앹껜瑜� �깮�꽦.
	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        // StringBuilder�뒗 蹂�寃� 媛��뒫�븳 臾몄옄�뿴�쓣 留뚮뱾�뼱以��떎.
	        StringBuilder sb = new StringBuilder();
	        
	        //�븘�닔 荑쇰━ �뙆�씪誘명꽣 �꽭�똿
	        sb.append("grant_type=authorization_code");
	        sb.append("&client_id=").append(client_id);
	        sb.append("&redirect_uri=").append(redirect_uri);
	        sb.append("&code=").append(code);

	        bw.write(sb.toString());
	        bw.flush();
	        
	        // �떎�젣 �꽌踰꾨줈 Request �슂泥� �븯�뒗 遺�遺�. (�쓳�떟 肄붾뱶瑜� 諛쏅뒗�떎. 200 �꽦怨�, �굹癒몄� �뿉�윭)
	        int responseCode = conn.getResponseCode();
	        System.out.println("[KakaoApi.getAccessToken] responseCode = "+ responseCode);
	        
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
	
	// �궗�슜�옄 �젙蹂� 諛쏄린
	public HashMap<String, Object> getUserInfo(String accessToken) {
	    HashMap<String, Object> userInfo = new HashMap<String, Object>();
	    String reqUrl = "https://kapi.kakao.com/v2/user/me";
	    try{
	        URL url = new URL(reqUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

	        int responseCode = conn.getResponseCode();
	        System.out.println("[KakaoApi.getUserInfo] responseCode = "+ responseCode);
	        
	        // �쓳�떟 諛쏆븘�삤湲�
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
	        Long id = (Long)jsonObj.get("id");
	        JSONObject kakaoAccount = (JSONObject)jsonObj.get("kakao_account");
	        String email = String.valueOf(kakaoAccount.get("email"));
	        JSONObject profile = (JSONObject)(kakaoAccount.get("profile"));
	        String nickname = String.valueOf(profile.get("nickname"));
	        String profile_image_url = String.valueOf(profile.get("profile_image_url"));
	        
	        userInfo.put("id", id);
	        userInfo.put("nickname", nickname);
	        userInfo.put("email", email);
	        userInfo.put("profile_image_url", profile_image_url);

	        br.close();

	    }catch (Exception e){
	        e.printStackTrace();
	    }
	    return userInfo;
	}

	// �뿰�룞�빐�젣 1�떒怨�. �젒洹� �넗�겙 �쑀�슚�꽦 泥댄겕
	public String isTokenValid(String accessToken) {
		String reqValidUrl = "https://kapi.kakao.com/v1/user/access_token_info";
		String id = "";
		try {
			URL url = new URL(reqValidUrl);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			int responseCode = conn.getResponseCode();
			System.out.println("[KakaoApi.isTokenValid] responseCode = "+ responseCode);
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
	        id = String.valueOf(jsonObj.get("id"));
		}catch (Exception e){
 	        e.printStackTrace();
 	    }
		return id;
	}
	// �뿰�룞�빐�젣 2�떒怨�. �젒洹� �넗�겙 �옱諛쒓툒
	public String getAccessTokenAgain(String refreshToken) {
		String reqUrl = "https://kauth.kakao.com/oauth/token";
	    String accessToken = "";
	    try{
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			
			//�븘�닔 荑쇰━ �뙆�씪誘명꽣 �꽭�똿
			sb.append("grant_type=refresh_token");
			sb.append("&client_id=").append(client_id);
			sb.append("&refresh_token=").append(refreshToken);
			
			bw.write(sb.toString());
			bw.flush();
			
			// �떎�젣 �꽌踰꾨줈 Request �슂泥� �븯�뒗 遺�遺�. (�쓳�떟 肄붾뱶瑜� 諛쏅뒗�떎. 200 �꽦怨�, �굹癒몄� �뿉�윭)
			int responseCode = conn.getResponseCode();
			System.out.println("[KakaoApi.getAccessTokenAgain] responseCode = "+ responseCode);
			
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
			br.close();
			bw.close();
		}catch (Exception e){
		    e.printStackTrace();
		}
		return accessToken;
	}
	// �뿰�룞�빐�젣 3�떒怨�. �뿰�룞�빐�젣(�젒洹� �넗�겙 �궘�젣)
	public String kakaoDisconnect(String accessToken) {
		String reqUrl = "https://kapi.kakao.com/v1/user/unlink";
		String id = "";
		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer "+accessToken);
			int responseCode = conn.getResponseCode();
			
			BufferedReader br;
	        if (responseCode >= 200 && responseCode <= 300) {
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
	        id = String.valueOf(jsonObj.get("id"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}

}
