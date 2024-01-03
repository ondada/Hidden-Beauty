<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	session.setAttribute("destination", "redirect:/winter.col");
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
	#navBack, #navWB, #navWD {
		width: 120px;
		height: 45px;
		border-radius: 50px;
		border: none;
		background-color: beige;
		text-align: center;
		box-shadow: 3px 3px 3px 0px #BDBDBD;
	}
	#navBack:hover, #navWB:hover, #navWD:hover {
		background-color: bisque;
		cursor: pointer;
	}
	#title{
		font-family: 'MaruBuri-Regular';
		font-size: 20pt;
		padding: 50px 0px 20px 0px;
	}
	#wb, #wd {
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
		<b>'겨울'의 색상들을 소개해드릴게요!</b><br>
		<span style="font-family: 'RIDIBatang'; font-size: 13pt; line-height: 180%;">
			아래 버튼을 클릭하여 해당 퍼스널 컬러로 이동해주세요.
		</span><br>
	</div>
	<nav id="thisNav">
      <button id="navBack" style="width: 60px;">&lt;&lt;</button>&nbsp;
      <button id="navWB">${cbwb.col_name}</button>&nbsp;
      <button id="navWD">${cbwd.col_name}</button>
    </nav>
    
    <div id="wb">
    	<br><br><br>
    	<br><br>
    	<img src="resources/image/${cbwb.col_ttlImg}" width="100%"><br><br><br>
    	<img src="resources/image/${cbwb.col_stlImg}" width="100%"><br><br><br><br>
    	<div id="recommend">▶ ${cbwb.col_name} 추천 색상 ◀</div>
    	<br><br>
    	<img src="resources/image/${cbwb.col_colImg}" width="100%" style="margin: auto;"><br><br><br><br>
    	<div id="recommend">▶ ${cbwb.col_name} 추천 코디 ◀</div>
    	<br><br>
    	<img src="resources/image/${cbwb.col_codiImg}" width="100%" style="margin: auto;"><br><br><br>
    </div>
    <div id="wd">
    	<br><br><br>
    	<br><br>
    	<img src="resources/image/${cbwd.col_ttlImg}" width="100%"><br><br><br>
    	<img src="resources/image/${cbwd.col_stlImg}" width="100%"><br><br><br><br>
    	<div id="recommend">▶ ${cbwd.col_name} 추천 색상 ◀</div>
    	<br><br>
    	<img src="resources/image/${cbwd.col_colImg}" width="100%" style="margin: auto;"><br><br><br><br>
    	<div id="recommend">▶ ${cbwd.col_name} 추천 코디 ◀</div>
    	<br><br>
    	<img src="resources/image/${cbwd.col_codiImg}" width="100%" style="margin: auto;"><br><br><br>
    </div>
    
    <script type="text/javascript">
	    document.querySelector("#navBack").addEventListener("click", (e) => {
	  	  history.go(-1);
	  	});
    	document.querySelector("#navWB").addEventListener("click", (e) => {
    	  document.querySelector("#wb").scrollIntoView({ behavior: "smooth" });
    	});
    	document.querySelector("#navWD").addEventListener("click", (e) => {
    	  document.querySelector("#wd").scrollIntoView({ behavior: "smooth" });
    	});
	</script>
	   
</article>

<%@ include file="./../views/footer.jsp" %>