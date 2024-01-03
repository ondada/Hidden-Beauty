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
                    <a href=".admin" class="nav__link collapse" title="메인">
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
</body>
</html>