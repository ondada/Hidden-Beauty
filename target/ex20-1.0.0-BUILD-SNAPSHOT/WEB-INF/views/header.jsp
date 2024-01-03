<%@page import="users.model.UsersBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html> 
<html>
<head> 
<meta charset="UTF-8">
<title>FIND YOUR Hidden Beauty</title>
<link rel="icon" href="resources/image/fyhbLogo_mini.png"/>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<style>
	#center{
		left: 355px;  
		position: relative;
		width: 1200px;
		padding: 10px 0px 100px 0px;
	}
	@font-face {
	    font-family: 'MaruBuri-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.0/MaruBuri-Regular.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	} 
	@font-face {
	    font-family: 'RIDIBatang'; 
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'TheJamsil5Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Somi';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/naverfont_10@1.0/Somi.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
</style>

</head>
  
<body>
	<header class="p-3 mb-3 border-bottom" style="font-family: 'RIDIBatang'; position: fixed; z-index: 99; background: white; left: 0px; right: 0px; top: 0px;">
		<div class="container">
			<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">

				<!-- 메뉴 선택하기 -->
				<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
					<li>
						<a href=".main" class="nav-link px-2 link-secondary">
						<img src="resources/image/fyhbLogo.png" width="170"></a>
					</li>
					<li style="margin-top: 10px; margin-left: 30px">
						<a href="colorAi.ai" class="nav-link px-2 link-body-emphasis">AI 컬러 진단</a>
					</li>
					<li style="margin-top: 10px; margin-left: 10px">
						<a href="colMain.col" class="nav-link px-2 link-body-emphasis">퍼스널 컬러란?</a>
					</li>
					<li style="margin-top: 10px; margin-left: 10px">
						<a href="cBoardList.cb" class="nav-link px-2 link-body-emphasis">후기 게시판</a>
					</li>
					<li style="margin-top: 10px; margin-left: 10px; font-family: 'Somi'; font-size: 13pt;">
						<a href="productMain.p" class="nav-link px-2 link-body-emphasis">The Shop HB</a>
					</li>
				</ul>

				<!-- 로그인아이콘 & 드롭다운 메뉴 -->
				<div class="dropdown text-end" style="margin-right: 50px">
					<c:if test="${loginInfo == null}">
						<a href="#" class="d-block link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"> 
							<img src="resources/image/person.svg" width="32" height="32" class="rounded-circle" style="object-fit: cover;">
						</a>
						<ul class="dropdown-menu text-small">
							<li><a class="dropdown-item" href="login.u">로그인</a></li>
							<li><a class="dropdown-item" href="register.u">회원가입</a></li>
						</ul>
					</c:if>
					<c:if test="${loginInfo != null}">
						<a href="#" class="d-block link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
							<c:if test="${loginInfo.u_profileimg == null }">
								<img src="resources/image/person.svg" width="32" height="32" class="rounded-circle">
							</c:if> 
							<c:if test="${loginInfo.u_profileimg != null }">
								<img src="resources/uploadFolder/users/${loginInfo.u_profileimg}" width="32" height="32" class="rounded-circle">
							</c:if> 
						</a>
						<ul class="dropdown-menu text-small">
							<li style="text-align: center;"><small>안녕하세요, <b>${loginInfo.u_name }</b>님</small></li>
							<li><hr class="dropdown-divider"></li>
							<c:if test="${loginInfo.u_id == 'admin'}">
								<li><a class="dropdown-item" href=".admin">관리자페이지</a></li>
								<li><a class="dropdown-item" href="logout.u">로그아웃</a></li>
							</c:if>
							<c:if test="${loginInfo.u_id != 'admin'}">
								<li><a class="dropdown-item" href="mypage.u">마이페이지</a></li>
								<li><a class="dropdown-item" href="logout.u">로그아웃</a></li>
							</c:if>
						</ul>
					</c:if>
				</div>
			</div>
		</div>
	</header>
