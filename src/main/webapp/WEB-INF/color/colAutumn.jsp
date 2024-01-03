<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	session.setAttribute("destination", "redirect:/autumn.col");
%>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(window).scroll(function() {
			if ($(this).scrollTop() > 200) {
				$('#thisNav').css({"top":"100px"});
			} else {
				$('#thisNav').css({"top":"270px"});
			}
		});
	});
</script>

<style>
	nav {
		z-index: 99;
		color: black;
		position: fixed;
		left: 350px; 
		top: 270px; 
		font-size: 12pt; 
		font-weight: bold;
		font-family: 'RIDIBatang';
	}
	#navBack, #navAM, #navAS, #navAD {
		width: 120px;
		height: 45px;
		border-radius: 50px;
		border: none;
		background-color: beige;
		text-align: center;
		box-shadow: 3px 3px 3px 0px #BDBDBD;
	}
	#navBack:hover ,#navAM:hover, #navAS:hover, #navAD:hover {
		background-color: bisque;
		cursor: pointer;
	}
	#title{
		font-family: 'MaruBuri-Regular';
		font-size: 20pt;
		padding: 50px 0px 20px 0px;
	}
	#am, #as, #ad {
		width: 100%;
		padding-bottom: 50px;
	}
	#recommend{
		text-align: center; 
		font-weight: bold; 
		font-size: 20pt; 
		font-family: 'MaruBuri-Regular';
	}
	body{
		padding-top: 90px;
	}
</style>

<%@ include file="./../views/header.jsp" %> 

<article id="center">
	<div id="title">
		<b>'가을'의 색상들을 소개해드릴게요!</b><br>
		<span style="font-family: 'RIDIBatang'; font-size: 13pt; line-height: 180%;">
			아래 버튼을 클릭하여 해당 퍼스널 컬러로 이동해주세요.
		</span><br>
	</div>
	<nav id="thisNav">
		<button id="navBack" style="width: 60px;">&lt;&lt;</button>&nbsp;
    	<button id="navAM">${cbam.col_name}</button>&nbsp;
    	<button id="navAS">${cbas.col_name}</button>&nbsp;
    	<button id="navAD">${cbad.col_name}</button>
    </nav>
    
    <div id="am">
    	<br><br><br>
    	<br><br>
    	<img src="resources/image/${cbam.col_ttlImg}" width="100%"><br><br><br>
    	<img src="resources/image/${cbam.col_stlImg}" width="100%"><br><br><br><br>
    	<div id="recommend">▶ ${cbam.col_name} 추천 색상 ◀</div>
    	<br><br>
    	<img src="resources/image/${cbam.col_colImg}" width="100%" style="margin: auto;"><br><br><br><br>
    	<div id="recommend">▶ ${cbam.col_name} 추천 코디 ◀</div> 
    	<img src="resources/image/${cbam.col_codiImg}" width="100%" style="margin: auto;"><br><br><br>
    </div>
    <div id="as">
    	<br><br><br>
    	<br><br>
    	<img src="resources/image/${cbas.col_ttlImg}" width="100%"><br><br><br>
    	<img src="resources/image/${cbas.col_stlImg}" width="100%"><br><br><br><br>
    	<div id="recommend">▶ ${cbas.col_name} 추천 색상 ◀</div>
    	<br><br>
    	<img src="resources/image/${cbas.col_colImg}" width="100%" style="margin: auto;"><br><br><br><br>
    	<div id="recommend">▶ ${cbas.col_name} 추천 코디 ◀</div>
    	<br><br>
    	<img src="resources/image/${cbas.col_codiImg}" width="100%" style="margin: auto;"><br><br><br>
    </div>
    <div id="ad">
    	<br><br><br>
    	<br><br>
    	<img src="resources/image/${cbad.col_ttlImg}" width="100%"><br><br><br>
    	<img src="resources/image/${cbad.col_stlImg}" width="100%"><br><br><br><br>
    	<div id="recommend">▶ ${cbad.col_name} 추천 색상 ◀</div>
    	<br><br>
    	<img src="resources/image/${cbad.col_colImg}" width="100%" style="margin: auto;"><br><br><br><br>
    	<div id="recommend">▶ ${cbad.col_name} 추천 코디 ◀</div>
    	<img src="resources/image/${cbad.col_codiImg}" width="100%" style="margin: auto;"><br><br><br>
    </div>
    
    <script type="text/javascript">
    	document.querySelector("#navBack").addEventListener("click", (e) => {
	  	  history.go(-1);
	  	});
    	document.querySelector("#navAM").addEventListener("click", (e) => {
    	  document.querySelector("#am").scrollIntoView({ behavior: "smooth" });
    	});
    	document.querySelector("#navAS").addEventListener("click", (e) => {
    	  document.querySelector("#as").scrollIntoView({ behavior: "smooth" });
    	});
    	document.querySelector("#navAD").addEventListener("click", (e) => {
      	  document.querySelector("#ad").scrollIntoView({ behavior: "smooth" });
      	});
	</script>
	   
</article>

<%@ include file="./../views/footer.jsp" %>