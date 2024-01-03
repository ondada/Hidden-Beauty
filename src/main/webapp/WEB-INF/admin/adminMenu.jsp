<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminMenu.css?ver=22023432">
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

  <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- CSS -->
   
    <!-- <link rel="stylesheet" href="assets/css/styles.css">-->

    <title>FIND YOUR Hidden Beauty</title>
</head>
<body id="body-pd">
    <div class="l-navbar" id="navbar">
        <nav class="nav">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                    <a href=".main" class="nav__logo">Hidden Beauty</a>
                </div>
                <div class="nav__list">
                    <a href="selectFeedback.admin" class="nav__link collapse" title="메인">
                        <ion-icon name="home" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;메인</span>
                    </a>
                    
                    <a href="usersList.admin" class="nav__link collapse" title="회원">
                        <ion-icon name="people-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;회원</span>
                    </a>
                    
                    <a href="productList.admin" class="nav__link" title="화장품">
                    	<ion-icon name="cart-outline" class="nav__icon"></ion-icon>
						<span class="nav_name">&nbsp;화장품</span>
                    </a>
                    
                     <a href="orderList.admin" class="nav__link" title="주문 내역">
                    	<ion-icon name="receipt-outline" class="nav__icon"></ion-icon>
						<span class="nav_name">&nbsp;주문 내역</span>
                    </a>
                    
                    <a href="companyList.admin" class="nav__link" title="진단 회사">
                    	<ion-icon name="location-outline" class="nav__icon"></ion-icon>
						<span class="nav_name">&nbsp;진단 회사</span>
                    </a>
                    
                    <a href="celebList.admin" class="nav__link" title="연예인">
                    	<ion-icon name="camera-outline" class="nav__icon"></ion-icon>
						<span class="nav_name">&nbsp;연예인</span>
                    </a>
                    
					<a href="cBoardList.admin" class="nav__link" title="후기 게시판">
                        <ion-icon name="chatbubbles-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;후기 게시판</span>
                    </a>
                    
                    <a href="qBoardList.admin" class="nav__link" title="문의 게시판">
                        <ion-icon name="help-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;문의 게시판</span>
                    </a>
                    
                </div>
                <a href="logout.u" class="nav__link" title="로그아웃">
                    <ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
                    <span class="nav_name">&nbsp;로그아웃</span>
                </a>
            </div>
        </nav>
    </div>
    <!-- IONICONS -->
    <script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
    <!-- JS -->
    <script src="<%= request.getContextPath() %>/resources/js/adminMenu.js"></script>
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
</body>
</html>