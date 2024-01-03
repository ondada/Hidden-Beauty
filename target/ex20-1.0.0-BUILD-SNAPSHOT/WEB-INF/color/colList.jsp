<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	session.setAttribute("destination", "redirect:/colList.col");
%>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		if($("#btnSpring").click(function(){
			$("#decoration").css({"background-image":"url('resources/image/spring_bg.jpg')"});
			$("#spring").show();
			$("#summer").hide();
			$("#autumn").hide();
			$("#winter").hide();
		}));
		
		if($("#btnSummer").click(function(){
			$("#decoration").css({"background-image":"url('resources/image/summer_bg.jpg')"});
			$("#spring").hide();
			$("#summer").show();
			$("#autumn").hide();
			$("#winter").hide();
		}));
		
		if($("#btnAutumn").click(function(){
			$("#decoration").css({"background-image":"url('resources/image/autumn_bg.jpeg')"});
			$("#spring").hide();
			$("#summer").hide();
			$("#autumn").show();
			$("#winter").hide();
		}));
		
		if($("#btnWinter").click(function(){
			$("#decoration").css({"background-image":"url('resources/image/winter_bg.jpg')"});
			$("#spring").hide();
			$("#summer").hide();
			$("#autumn").hide();
			$("#winter").show();
		}));
	});
</script>

<!-- 저장용 -->

<style>
	#mainArea{
		text-align: center;
		margin: 60px 0px 150px 0px;
	}
	#btnSpring, #btnSummer, #btnAutumn, #btnWinter {
		border: 1px solid #EAEAEA;
		background: white;
		font-family: 'RIDIBatang';
		font-size: 13pt;
	}
	#btnSpring:hover {
		background: #EDE5D8;
		color: white;
	}
	#btnSummer:hover {
		background: #B3B3CE;
		color: white;
	}
	#btnAutumn:hover {
		background: #C98BA4;
		color: white;
	}
	#btnWinter:hover {
		background: #7C81BB;
		color: white;
	}
	#decoration{
		width: 50%;
		margin: auto;
		padding-bottom: 150px;
		border-radius: 30px;
		background-repeat: no-repeat;
		background-size: cover;
		background-image: url('resources/image/spring_bg.jpg');
	}
	#seasonArea{
		font-family: 'MaruBuri-Regular';
		font-size: 40pt;
		font-weight: bold;
	}
	#sDetailArea{
		font-family: 'RIDIBatang';
		font-size: 11pt;
		line-height: 180%;
	}
	#seasonImg{
		width: 60%;
		border-radius: 20px;
		box-shadow: 5px 5px 10px 0px #4C4C4C;
	}
	#summer, #autumn, #winter{
		display: none;
	}
	#seasonBtn{
		width: 250px;
		height: 40px;
		background: white; 
		border-radius: 25px;
		border: none;
		font-family: 'MaruBuri-Regular';
		font-size: 14pt;
		font-weight: bold;
	}
	#seasonBtn:hover{
		background: #EAEAEA;
	}
	body{
		padding-top: 90px;
	}
}
</style>

<%@ include file="./../views/header.jsp"%>

<article id="center" style="padding: 80px 0px 0px 0px; ">
	<span style="font-family: 'MaruBuri-Regular'; font-weight: bold; font-size: 25pt;">컬러 별 특징 살펴보기</span><br><br>
	<span style="font-family: 'RIDIBatang'; font-size: 11pt; line-height: 180%; color: graytext;"> 
		&nbsp;&nbsp;저희 Hidden Beauty에서는 톤을 크게 <u>4계절</u>로,<br>
		&nbsp;&nbsp;자세하게는 <u>총 10가지</u>로 분류해서 진단해드리고 있어요.<br>
		&nbsp;&nbsp;아래 버튼을 클릭하시면 계절 별 자세한 설명을 확인할 수 있습니다!<br>
		&nbsp;&nbsp;컬러 별 대표 연예인이 궁금하시다면 <a href="celebList.cel?whatColumn=cl_color&keyword=봄+라이트" style="color: graytext;">여기</a>를 클릭해주세요.
	</span>
</article>

<hr style="width: 61%; margin: auto; top: 80px; position: relative; z-index: 0; border: dashed 1px gray;">

<div id="mainArea">
	<div class="btn-group" role="group" style="width: 300px; margin: auto; z-index: 98">
		<input type="button" class="btn" id="btnSpring" value="&nbsp;봄&nbsp;">
		<input type="button" class="btn" id="btnSummer" value="여름"> 
		<input type="button" class="btn" id="btnAutumn" value="가을"> 
		<input type="button" class="btn" id="btnWinter" value="겨울">
	</div>
	<br><br><br><br>

	<div id="decoration">
	<br><br><br>
		<div id="spring">
			<span id="seasonArea">봄</span><br><br>
			<span id="sDetailArea">
				따듯한 색상으로 선명(vivid) 하고 밝은(bright) 톤과 엷은(pale) 톤으로 이루어져 있어요.<br>
				화사한 느낌을 가진 컬러가 많아서 생동감과 에너지를 느낄 수 있어요.<br>
			</span><br><br>
			<input type="button" value="자세히 알아보기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→" id="seasonBtn" onClick="location.href='spring.col'"><br><br><br>
			<img src="resources/image/pccs_spring.png" id="seasonImg">
		</div>
		<div id="summer">
			<span id="seasonArea">여름</span><br><br>
			<span id="sDetailArea">
				블루 베이스의 파스텔 계열이나 회색이 섞인 톤으로 이루어져 있어요.<br>
				청량감 넘치며 시원하고 차분한 분위기를 지니고 있어요.<br>
			</span><br><br>
			<input type="button" value="자세히 알아보기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→" id="seasonBtn" onClick="location.href='summer.col'"><br><br><br>
			<img src="resources/image/pccs_summer.png" id="seasonImg">
		</div>
		<div id="autumn">
			<span id="seasonArea">가을</span><br><br>
			<span id="sDetailArea"> 
				차분하고 무거운 분위기의 부드러운 톤으로 이루어져 있어요.<br>
				전반적으로 고급스럽고 강하면서도 편안 느낌을 줘요.<br>
			</span><br><br> 
			<input type="button" value="자세히 알아보기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→" id="seasonBtn" onClick="location.href='autumn.col'"><br><br><br>
			<img src="resources/image/pccs_autumn.png" id="seasonImg">
		</div>
		<div id="winter"> 
			<span id="seasonArea">겨울</span><br><br>
			<span id="sDetailArea">
				차갑고 강렬하며 이지적인 느낌의 톤으로 이루어져 있어요.<br>
				깔끔하고 세련된 이미지를 지닌 사람이 많아요!<br>
			</span><br><br>
			<input type="button" value="자세히 알아보기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→" id="seasonBtn" onClick="location.href='winter.col'"><br><br><br>
			<img src="resources/image/pccs_winter.png" id="seasonImg">
		</div>
	</div>
</div>

<%@ include file="./../views/footer.jsp"%>