<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="header.jsp" %>

<style>
	#btn{
		width: 500px; 
		height: 100px;
		background: white;
		border-radius: 15px 15px 15px 15px;
		box-shadow: 5px 5px 10px 0px #BDBDBD;  
		text-align: left;
	}
	#btn:hover {
		background: #EAEAEA;
	} 
	table{
		width: 100%; 
	}
	td{
		padding: 15px 0px 0px 10px;
	}
	body{
		padding-top: 90px;
	}
}
</style>

<center>
<img src="resources/image/main.gif" width="100%">
<div style="color: white; top: -560px; position: relative; font-family: 'TheJamsil5Bold'; font-size: 28pt;">
	당신에게 가장 잘 어울리는<br>
	퍼스널 컬러 진단 서비스를 제공합니다.</div>
<div style="color: white; top: -550px; position: relative; font-family: 'MaruBuri-Regular'; font-size: 15pt;">
	Personal Color Consulting Service
</div>
<div style="color: white; top: -480px; position: relative; font-family: 'MaruBuri-Regular'; font-size: 12pt; line-height: 200%;">
	'FIND YOUR Hidden Beauty' 는 고객님께 보다 간편한 퍼스널 컬러 진단 서비스를 제공하며,<br>
	진단 이후에는 퍼스널 컬러 별 화장법과 스타일링을 안내해드리고 있습니다.
</div>
<img src="resources/image/fyhbLogo_white.png" width="200" style="top: -310px; position: relative;">
</center>

<article id="center" style="text-align: center; font-family: 'MaruBuri-Regular'; top: -80px; position: relative;">
	
	<p style="font-size: 35pt; color: #C98BA4; font-family: 'TheJamsil5Bold';">
		퍼스널 컬러 진단
	</p>
	<p style="font-size: 18pt; color: graytext; top: -10px; position: relative;">
		personal color consulting
	</p>
	<br><br>
	<p style="font-size: 13pt; font-weight: bold; line-height: 180%;">
		사람은 각자 고유의 색을 가지고 있습니다.<br>
		'퍼스널 컬러'는 자신이 가진 신체색과 조화를 이루어,<br> 
		자신을 보다 생기있고 활기차게 보이게 해 주는 색상을 뜻합니다.
	</p>
	<br><br>
	<p style="font-size: 11pt; color: #BDBDBD; line-height: 220%; font-family: 'RIDIBatang';">
		퍼스널 컬러를 파악하는 것은 효과적으로 이미지를 관리하는 방법 중 하나입니다.<br>
		어울리는 컬러를 활용하면 긍정적인 이미지를 얻을 수 있는 반면,<br>
		어울리지 않는 컬러를 활용하면 피부가 거칠어보이거나 노안으로 보이는 등 단점이 극대화될 수 있습니다.
	</p>
	<br><br><br><br><br>
	<div style="display: inline-block;">
		<img src="resources/image/personal.svg" width="120"><br><br><br>
		<span style="font-size: 17pt; font-weight: bold; color: #C98BA4; font-family: 'TheJamsil5Bold'">
			Personal
		</span>
		<br>
		<span style="font-size: 14pt; color: graytext; line-height: 200%;">
			각자의
		</span>
	</div>
	<div style="width: 200px; display: inline-block;"></div>
	<div style="display: inline-block;">
		<img src="resources/image/color.png" width="120"><br><br><br>
		<span style="font-size: 17pt; font-weight: bold; color: #C98BA4; font-family: 'TheJamsil5Bold'">
			Color
		</span>
		<br>
		<span style="font-size: 14pt; color: graytext; line-height: 200%;">
			색상
		</span>
	</div>
	<div style="width: 200px; display: inline-block;"></div>
	<div style="display: inline-block;">
		<img src="resources/image/personalColor.svg" width="125"><br><br><br>
		<span style="font-size: 17pt; font-weight: bold; color: #C98BA4; font-family: 'TheJamsil5Bold'">
			Personal Color
		</span>
		<br>
		<span style="font-size: 14pt; color: graytext; line-height: 200%;">
			개인의 고유색
		</span>
	</div>
	
</article>

<center style="font-family: 'MaruBuri-Regular'; padding-bottom: 0px; top: -170px; position: relative;">
	<br><br><br><br><br><br><br><br>
	<div id="btn" onclick="location.href='colorAi.ai'">
		<table>
			<tr>
				<td><img src="resources/image/ai.png" width="70"></td>
				<td>
					<span style="font-size: 18pt; font-weight: bold;">AI 진단받기</span><br>
					<span style="font-size: 13pt; color: graytext;">얼굴이 선명하게 나온 사진을 준비해주세요!</span>
				</td>
			</tr>
		</table>
	</div>
	<br><br>
	<div id="btn" onclick="location.href='colList.col'">
		<table>
			<tr>
				<td>&nbsp;&nbsp;<img src="resources/image/report.png" width="70"></td>
				<td>
					<span style="font-size: 18pt; font-weight: bold;">퍼스널 컬러 별 특징이 궁금하다면?</span><br>
					<span style="font-size: 13pt; color: graytext;">진단받은 컬러의 특징을 알려드릴게요.</span>
				</td>
			</tr>
		</table>
	</div>
</center>

<img src="resources/image/main2.png" width="100%" style="padding: 60px 0px 200px 0px;">

<div style="width: 100%; height: 3000px; overflow: hidden;">
	<div style="background: #F6F6F6; width: 20%; height: 3000px; left: 1520px; top: -300px; position: relative; border-radius: 300px;"></div>
	 
	<div style="width: 100%; height: 1000px; padding: 150px 200px 150px 200px; position: absolute; top: 3200px;" id="ai">
		<div style="left: 1315px; position: absolute; text-align: right; font-family: 'RIDIBatang'; padding-top: 8px;">
			<div style="color: #7C81BB; padding: 0px 0px 15px 0px; cursor : pointer;" onClick="ai()">AI 퍼스널컬러 진단받기</div>
			<div style="color: #D5D5D5; padding: 0px 0px 13px 0px; cursor : pointer;" onClick="allAbout()">퍼스널 컬러의 모든 것</div>
			<div style="color: #D5D5D5; cursor : pointer;" onClick="shop()">맞춤 쇼핑몰 둘러보기</div>
		</div>
		<div style="left: 1495px; position: absolute; width: 50px;"> 
			<div style="border: 1px solid #7C81BB; border-radius: 50%; width: 40px; height: 40px; margin: 0px 5px 15px 5px;">
				<div style="border-radius: 50%; width: 10px; height: 10px; background: #7C81BB; margin: 14px 10px 10px 14px;"></div> 
			</div>
			<div style="border-radius: 50%; width: 10px; height: 10px; background: #D5D5D5; margin: 0px 20px 25px 20px;"></div>
			<div style="border-radius: 50%; width: 10px; height: 10px; background: #D5D5D5; margin: 0px 20px 25px 20px;"></div>
		</div>
		
		<span style="font-family: 'MaruBuri-Regular'; font-size: 10pt; font-weight: bold; color: #7C81BB; line-height: 200%;"> 
			FIND YOUR <big>Hidden Beauty</big> 이용방법 - 1
		</span>
		<br>
		<span style="font-family: 'MaruBuri-Regular'; font-size: 35pt; font-weight: bold; cursor : pointer;" onclick="location.href='colorAi.ai'">
			AI 퍼스널컬러 진단받기
		</span>
		<br><br>
		<span style="font-family: 'RIDIBatang'; font-size: 12pt; line-height: 180%;">
			꾸준히 유행중인 퍼스널컬러. 아직도 자신의 퍼스널 컬러를 모르시나요?<br>
			시간과 공간의 제약 없이 간단하게 AI를 통해 진단 받아보세요!<br>
			<small>(※ 이용료 무료, 로그인 이후 이용가능)</small>
		</span> 
		<br><br><br><br>
		<div style="width: 700px; height: 400px; display: inline-block; border-radius: 30px; background: white; background-image: url('resources/image/ai1.png'); background-repeat: no-repeat; background-size: cover; box-shadow: 5px 5px 10px 0px #BDBDBD;"></div>
		&nbsp;&nbsp;&nbsp;
		<div style="width: 700px; height: 400px; display: inline-block; border-radius: 30px; background: white; background-image: url('resources/image/ai2.png'); background-repeat: no-repeat; background-size: cover; box-shadow: 5px 5px 10px 0px #BDBDBD;"></div>
	</div>
	
	<div style="width: 100%; height: 1000px; padding: 200px; position: absolute; top: 4200px;" id="allAbout">
		<div style="left: 1315px; position: absolute; text-align: right; font-family: 'RIDIBatang'; padding-top: 8px;">
			<div style="color: #D5D5D5; padding: 0px 0px 15px 0px; cursor : pointer;" onClick="ai()">AI 퍼스널컬러 진단받기</div>
			<div style="color: #7C81BB; padding: 0px 0px 13px 0px; cursor : pointer;" onClick="allAbout()">퍼스널 컬러의 모든 것</div> 
			<div style="color: #D5D5D5; cursor : pointer;" onClick="shop()">맞춤 쇼핑몰 둘러보기</div>
		</div>
		<div style="left: 1495px; position: absolute; width: 50px;">
			<div style="border-radius: 50%; width: 10px; height: 10px; background: #D5D5D5; margin: 12px 20px 12px 20px;"></div>
			<div style="border: 1px solid #7C81BB; border-radius: 50%; width: 40px; height: 40px; margin: 15px 5px 14px 5px;">
				<div style="border-radius: 50%; width: 10px; height: 10px; background: #7C81BB; margin: 14px 10px 10px 14px;"></div>
			</div>
			<div style="border-radius: 50%; width: 10px; height: 10px; background: #D5D5D5; margin: 0px 20px 25px 20px;"></div>
		</div>
		<span style="font-family: 'MaruBuri-Regular'; font-size: 10pt; font-weight: bold; color: #7C81BB; line-height: 200%;">
			FIND YOUR <big>Hidden Beauty</big> 이용방법 - 2
		</span>
		<br>
		<span style="font-family: 'MaruBuri-Regular'; font-size: 35pt; font-weight: bold; cursor : pointer;" onclick="location.href='colMain.col'">
			퍼스널 컬러의 모든 것
		</span>
		<br><br>
		<span style="font-family: 'RIDIBatang'; font-size: 12pt; line-height: 180%;">
			퍼스널 컬러만 진단해주면 끝인가요?<br>
			아니요! 저희는 진단받은 컬러의 특징과 스타일링 방법, 어울리는 화장품까지 추천해드린답니다.<br>
			퍼스널 컬러별 연예인을 둘러보시면서 스타일링에 대한 감을 잡을 수 있게 도와드려요.
		</span> 
		<br><br><br><br> 
		<div style="width: 700px; height: 400px; display: inline-block; border-radius: 30px; background: white; background-image: url('resources/image/every.png'); background-repeat: no-repeat; background-size: cover; box-shadow: 5px 5px 10px 0px #BDBDBD;"></div>
		&nbsp;&nbsp;&nbsp;
		<div style="border: 1px solid black; width: 700px; height: 400px; display: inline-block; border: none; border-radius: 30px; background: white; background-image: url('resources/image/celeb_ex.png'); background-repeat: no-repeat; background-size: cover; box-shadow: 5px 5px 10px 0px #BDBDBD;""></div>
	</div>
	
	<div style="width: 100%; height: 1000px; padding: 200px; position: absolute; top: 5200px;" id="shop">  
		<div style="left: 1315px; position: absolute; text-align: right; font-family: 'RIDIBatang'; padding-top: 8px;">
			<div style="color: #D5D5D5; padding: 0px 0px 15px 0px; cursor : pointer;" onClick="ai()">AI 퍼스널컬러 진단받기</div>
			<div style="color: #D5D5D5; padding: 0px 0px 13px 0px; cursor : pointer;" onClick="allAbout()">퍼스널 컬러의 모든 것</div> 
			<div style="color: #7C81BB; cursor : pointer;" onClick="shop()">맞춤 쇼핑몰 둘러보기</div>
		</div>
		<div style="left: 1495px; position: absolute; width: 50px;">
			<div style="border-radius: 50%; width: 10px; height: 10px; background: #D5D5D5; margin: 15px 20px 12px 20px;"></div>
			<div style="border-radius: 50%; width: 10px; height: 10px; background: #D5D5D5; margin: 28px 20px 12px 20px;"></div>
			<div style="border: 1px solid #7C81BB; border-radius: 50%; width: 40px; height: 40px; margin: 13px 5px 14px 5px;">
				<div style="border-radius: 50%; width: 10px; height: 10px; background: #7C81BB; margin: 14px 10px 10px 14px;"></div>
			</div>
		</div>
		<span style="font-family: 'MaruBuri-Regular'; font-size: 10pt; font-weight: bold; color: #7C81BB; line-height: 200%;">
			FIND YOUR <big>Hidden Beauty</big> 이용방법 - 3
		</span>
		<br>
		<span style="font-family: 'MaruBuri-Regular'; font-size: 35pt; font-weight: bold; cursor : pointer;" onclick="location.href='productMain.p'">
			맞춤 쇼핑몰 둘러보기
		</span>
		<br><br>
		<span style="font-family: 'RIDIBatang'; font-size: 12pt; line-height: 180%;">
			퍼스널 컬러 안내페이지를 통해 알게된 내 컬러 맞춤 화장품들.<br>
			바로 구매해보고 싶지 않으신가요? 상단 '쇼핑하기' 메뉴를 통해 바로 구매하실 수 있어요!<br>
			<small>(※ 총 10종류의 퍼스널 컬러 맞품 상품 제공. 로그인 이후 구매가능)</small>
		</span> 
		<br><br><br><br><br><br>
		<div style="width: 150px; display: inline-block;"></div><img src="resources/image/spring-mainImg.png">
		&nbsp;&nbsp;&nbsp;&nbsp;<img src="resources/image/summer-mainImg.png">
		&nbsp;&nbsp;&nbsp;&nbsp;<img src="resources/image/fall-mainImg.png">
		&nbsp;&nbsp;&nbsp;&nbsp;<img src="resources/image/winter-mainImg.png">
	</div>
	
	<script type="text/javascript">
		function ai(){
			document.querySelector("#ai").scrollIntoView({ behavior: "smooth" });
		}
		function allAbout(){
			document.querySelector("#allAbout").scrollIntoView({ behavior: "smooth" });
		}
		function shop(){
			document.querySelector("#shop").scrollIntoView({ behavior: "smooth" });
		}
	</script>
	
	
</div>

<div style="width:100%; height: 200px;"></div>

<%@ include file="footer.jsp" %>