<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
	.footer_content{
		font-size: 10pt;
		left: 50px;
		top: -23px;
		position: relative;
		margin-bottom: 100px;
		font-family: 'MaruBuri-Regular';
	}
	#footer_vertical{
		width: 3px; 
		height: 18px;
		background: #7C81BB;
		display: inline-block;
	}
	#footer_title{
		font-size: 15pt; 
		font-weight: bold;
		font-family: 'MaruBuri-Regular';
	}
	#footer_menu{
		font-size: 9pt;
		text-decoration: none;
		color: graytext;
	}
    a.top {
      position: fixed;
      left: 96%;
      bottom: 28px;
      display: none;
    }
</style>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function() {
		$(window).scroll(function() {
			if ($(this).scrollTop() > 300) {
				$('.top').fadeIn();
			} else {
				$('.top').fadeOut();
			}
		});
		$('.top').click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 400);
			return false;
		});
	});
</script>

<a href="#" class="top"><img src="resources/image/arrow1.png" width="50"></a>

<div class="container">
	<footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
		<div class="col-md-4 d-flex align-items-center">
			<svg class="bi" width="30" height="24"><use xlink:href="#bootstrap" /></svg>
			<span class="mb-3 mb-md-0 text-body-secondary">
				&copy; 2023 FIND YOUR Hidden Beauty Inc.
			</span>
		</div>
		<ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
			<li class="ms-2">
				<a href="#" id="footer_menu">개인정보 보호 정책&nbsp;&nbsp;&nbsp;|</a>
			</li>
			<li class="ms-2">
				<a href="#" id="footer_menu">이메일 무단수집 거부&nbsp;&nbsp;&nbsp;|</a>
			</li>
			<li class="ms-2">
				<a href="#" id="footer_menu">제작자 정보</a>
			</li>
			<li class="ms-3">&nbsp;&nbsp;
			</li>
		</ul>
	</footer>
	<div class="footer_content">
		<br>
		<b>당신의 숨겨진 아름다움을 찾아서 -</b><br><br><br>
		&nbsp;&nbsp;&nbsp;
		<div id="footer_vertical"></div>&nbsp;&nbsp;<font id="footer_title">업무시간</font><div style="width: 138px; display:inline-block;"></div>
		<div id="footer_vertical"></div>&nbsp;&nbsp;<font id="footer_title">휴무일</font><div style="width: 244px; display:inline-block;"></div>
		<div id="footer_vertical"></div>&nbsp;&nbsp;<font id="footer_title">주소</font>
		<br>
		<div style="top: 8px; position: relative; color: #8C8C8C; font-family: 'RIDIBatang'">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			평일 AM 09:00 ~ PM 06:00 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			공휴일, 주말, 지정 휴무일(추후 팝업창 안내) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			서울특별시 마포구 월드컵북로 21 풍성빌딩 4층
		</div><br><br>
		&nbsp;&nbsp;&nbsp;<div id="footer_vertical"></div>&nbsp;&nbsp;<font id="footer_title">정보</font>
		<div style="top: 8px; position: relative; color: #8C8C8C; font-family: 'RIDIBatang';">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(주)쌍용교육센터 H반 환감탈태조 FIND YOUR Hidden Beauty | 신고번호 : 제 2023-서울마포-00000호<br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;공동대표 4인 : 김수연, 박혜주, 황다온, 이유진 (TEL : 02-336-8546 / FAX : 02-334-5405)
		</div>
		<img src="resources/image/fyhbLogo.png" width="230" style="left: 975px; top: -30px; position: relative;" onclick="location.href='https://www.sist.co.kr/index.jsp'">
	</div>
</div>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous">
</script>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다. 
    function sample4_execDaumPostcode() {
        new daum.Postcode({
        	
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				
                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
        
    }
</script>
</html>