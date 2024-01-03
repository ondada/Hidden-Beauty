<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	html, body {
	  width: 100%;  
	  height: 100%;
	  background: #B3B3CE ;
	  display: flex;
	  -webkit-font-smoothing: antialiased;
	  justify-content: center;
	  align-items: center;
	}
	
	h1 {
	  height: 100px;
	  margin-bottom: 200px;
	  margin-left: -30px;
	}
	
	h1 span {
	  top: 20px;
	  position: relative;
	  animation: bounce .3s ease infinite alternate;
	  font-family: 'YClover-Bold';
	  font-size: 130px;
	  color: #FFF;
	  text-shadow: 0 1px 0 #CCC,
	               0 2px 0 #CCC,
	               0 3px 0 #CCC,
	               0 4px 0 #CCC,
	               0 5px 0 #CCC,
	               0 6px 0 transparent,
	               0 7px 0 transparent,
	               0 8px 0 transparent,
	               0 9px 0 transparent,
	               0 10px 10px rgba(0, 0, 0, .4);
	}
	
	h1 span:nth-child(2) { animation-delay: .1s; }
	h1 span:nth-child(3) { animation-delay: .2s; }
	h1 span:nth-child(4) { animation-delay: .3s; }
	h1 span:nth-child(5) { animation-delay: .4s; }
	h1 span:nth-child(6) { animation-delay: .5s; }
	h1 span:nth-child(7) { animation-delay: .6s; }
	h1 span:nth-child(8) { animation-delay: .7s; }
	
	@keyframes bounce {
	  100% {
	    top: -20px;
	    text-shadow: 0 1px 0 #CCC,
	                 0 2px 0 #CCC,
	                 0 3px 0 #CCC,
	                 0 4px 0 #CCC,
	                 0 5px 0 #CCC,
	                 0 6px 0 #CCC,
	                 0 7px 0 #CCC,
	                 0 8px 0 #CCC,
	                 0 9px 0 #CCC,
	                 0 50px 25px rgba(0, 0, 0, .2);
	  }
	}
	
	@font-face {
	    font-family: 'YClover-Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/YClover-Bold.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'RIDIBatang';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	#textArea{
		margin: 0px 0px 70px 50px; 
		font-family: 'RIDIBatang'; 
		font-size: 13pt;
		line-height: 180%;
	}
	#btn{
		width: 180px;
		height: 40px;
		margin-left: 5px;
		background: #7C81BB;
		color: white;
		border: none;
		border-radius: 3px;
		font-size: 12pt;
		font-family: 'RIDIBatang';
	}
	#btn:hover {
		background: #EDE5D8 ;
		color: black;
	}
</style>

<h1>
  <span>W</span>
  <span>e</span>
  <span>l</span>
  <span>c</span>
  <span>o</span>
  <span>m</span>
  <span>e</span>
  <span>!</span>
</h1>

<div id="textArea">
<span style="font-weight: bold; font-size: 15pt;">회원가입을 진심으로 환영합니다!</span><br>
' ${loginInfo.u_name} ' 님은 지금부터 hidden beauty의 모든 서비스를 이용하실 수 있습니다.<br>
 우선 필수 회원정보를 업데이트 해 주세요!

<br><br>
<input type="file" name="upload_img" value="" accept="image/*" style="display: none">
<a href="update.u?u_id=${loginInfo.u_id }"><input type="button" id="btn" value="업데이트 하러가기"></a>
</div>
