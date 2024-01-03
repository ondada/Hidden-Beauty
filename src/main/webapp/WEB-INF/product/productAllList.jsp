<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	session.setAttribute("destination", "redirect:/productAllList.p");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/album/">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">
	#search{
		width: 500px;
		left: -30px;
		position: relative;
	}
	.bd-placeholder-img {
		font-size: 1.125rem;
		text-anchor: middle;
		-webkit-user-select: none;
		-moz-user-select: none;
		user-select: none;
	}
	.b-example-divider {
		width: 100%;
		height: 3rem;
		background-color: rgba(0, 0, 0, .1);
		border: solid rgba(0, 0, 0, .15);
		border-width: 1px 0;
		box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
			rgba(0, 0, 0, .15);
	}
	.b-example-vr {
		flex-shrink: 0;
		width: 1.5rem;
		height: 100vh;
	}
	.bi {
		vertical-align: -.125em;
		fill: currentColor;
	}
	.nav-scroller {
		position: relative;
		z-index: 2;
		height: 2.75rem;
		overflow-y: hidden;
	}
	.nav-scroller .nav {
		display: flex;
		flex-wrap: nowrap;
		padding-bottom: 1rem;
		margin-top: -1px;
		overflow-x: auto;
		text-align: center;
		white-space: nowrap;
		-webkit-overflow-scrolling: touch;
	}
	.btn-bd-primary { -
		-bd-violet-bg: #712cf9; -
		-bd-violet-rgb: 112.520718, 44.062154, 249.437846; -
		-bs-btn-font-weight: 600; -
		-bs-btn-color: var(- -bs-white); -
		-bs-btn-bg: var(- -bd-violet-bg); -
		-bs-btn-border-color: var(- -bd-violet-bg); -
		-bs-btn-hover-color: var(- -bs-white); -
		-bs-btn-hover-bg: #6528e0; -
		-bs-btn-hover-border-color: #6528e0; -
		-bs-btn-focus-shadow-rgb: var(- -bd-violet-rgb); -
		-bs-btn-active-color: var(- -bs-btn-hover-color); -
		-bs-btn-active-bg: #5a23c8; -
		-bs-btn-active-border-color: #5a23c8;
	}
	.bd-mode-toggle {
		z-index: 1500;
	}
	body{
		padding-top: 140px;
	}
</style>

<script>
	function filter(whatColumn, keyword){ // 가격 순 조회
		var filterArea = document.getElementById('filterArea');
		location.href='productAllList.p?filter='+filterArea.value+'&whatColumn='+whatColumn+'&keyword='+keyword;
	}
</script>

</head>


<%@ include file="productHeader.jsp" %>

<body>
	<div id="wrap">
	
		<div class="row" style="width: 30%; margin: auto; font-family: 'RIDIBatang'; left: 0px; padding-top: 70px;">
			
			<div class="col-lg-12" style="margin-bottom: 10px;">
				<section id="drop">
					<ul class="nav nav-underline justify-content-center">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="productAllList.p?whatColumn=p_color&keyword=봄" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: #2457BD;">
						    	봄
						    </a>
						    <ul class="dropdown-menu">
						    	<li><a class="dropdown-item" href="productAllList.p?whatColumn=p_color&keyword=봄+라이트">봄 라이트</a></li>
						        <li><a class="dropdown-item" href="productAllList.p?whatColumn=p_color&keyword=봄+브라이트">봄 브라이트</a></li>
							</ul>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="productAllList.p?whatColumn=p_color&keyword=여름" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: #2457BD;">
						    	여름
						    </a>
						    <ul class="dropdown-menu">
						    	<li><a class="dropdown-item" href="productAllList.p?whatColumn=p_color&keyword=여름+라이트">여름 라이트</a></li>
						        <li><a class="dropdown-item" href="productAllList.p?whatColumn=p_color&keyword=여름+브라이트">여름 브라이트</a></li>
						        <li><a class="dropdown-item" href="productAllList.p?whatColumn=p_color&keyword=여름+뮤트">여름 뮤트</a></li>
						   	</ul>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="productAllList.p?whatColumn=p_color&keyword=가을" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: #2457BD;">
						        가을
						    </a>
						    <ul class="dropdown-menu">
						    	<li><a class="dropdown-item" href="productAllList.p?whatColumn=p_color&keyword=가을+뮤트">가을 뮤트</a></li>
						        <li><a class="dropdown-item" href="productAllList.p?whatColumn=p_color&keyword=가을+스트롱">가을 스트롱</a></li>
						        <li><a class="dropdown-item" href="productAllList.p?whatColumn=p_color&keyword=가을+딥">가을 딥</a></li>
						    </ul>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="productAllList.p?whatColumn=p_color&keyword=겨울" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: #2457BD;">
						        겨울
						   	</a>
						    <ul class="dropdown-menu">
						    	<li><a class="dropdown-item" href="productAllList.p?whatColumn=p_color&keyword=겨울+브라이트">겨울 브라이트</a></li>
						        <li><a class="dropdown-item" href="productAllList.p?whatColumn=p_color&keyword=겨울+딥">겨울 딥</a></li>
							</ul>
						</li>
					</ul>
				</section>
			</div>
			
			<div class="col-lg-6">
				<form action="productAllList.p" method="get">
					<div class="input-group mb-3" id="search">
						<select name ="whatColumn" id="whatColumn" class="btn btn-outline-secondary dropdown-toggle" style="text-align: left;">
							<option value="all">전체
							<option value="p_brand">브랜드
							<option value="p_name">제품명
						</select>
						<input type="text" name="keyword" id="keyword" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
						<input class="btn btn-outline-secondary" type="submit" id="button-addon2"  value="검색"> 
					</div>
				</form>
			</div>
			
			<div style="left: 480px; top: -51px; position: relative;">
				<form action="productAllList.p" method="get">
						<select id="filterArea" class="form-select" style="text-align: left; font-size: 11pt; width: 130px;" onChange="filter('${whatColumn}', '${keyword}')">
							<option value="">기본
							<option value="priceH" <c:if test="${filter == 'priceH'}">selected</c:if> >가격 높은순
							<option value="priceL" <c:if test="${filter == 'priceL'}">selected</c:if> >가격 낮은순
						</select>
				</form>
			</div>
			
		</div>
		<br><br>
		
		<main> 
			<div>
			    <div class="container">
			    	<div style="padding-bottom: 100px; font-size: 20pt; font-family: 'MaruBuri-Regular'; font-weight: bold; text-align: center;">
						<hr style="width: 30%; display: inline-block; top: 8px; position: relative; border: 1px dotted #BDBDBD;">
						&nbsp;&nbsp;&nbsp;&nbsp; 
						${keyword}
						<c:if test="${keyword==''}"> 
							전체 조회
						</c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<hr style="width: 30%; display: inline-block; top: 8px; position: relative; border: 1px dotted #BDBDBD;">
					</div>
						
					<div class="container" style="margin-bottom: 150px;">
					
					<c:if test="${fn:length(productLists) == 0}">
						<div class="col">
						    <div class="card shadow-sm" style="text-align: center; font-family: 'MaruBuri-Regular';">
						        <br><br>
								<b>등록된 상품이 없습니다.</b><br><br>
							</div>
						   </div>
					</c:if>
						
					<c:if test="${fn:length(productLists) != 0}">
						<div class="row">
							<c:forEach var="pb" items="${productLists}">
								<div class="col-lg-3">
									<div class="card shadow-sm" style="border: 1px solid #F6F6F6; margin-bottom: 23px;">
										<a href="prodView.p?p_num=${pb.p_num}&pageNumber=${pageInfo.pageNumber}">
											<div style="height: 300px; width: 100%; overflow: hidden; text-align: center;">
												<img src="<%=request.getContextPath() %>/resources/uploadFolder/product/${pb.p_ttlimg}" style="height: 300px; margin: auto;">
											</div>
										</a>
										<div class="card-body">
											<p style="font-family: 'RIDIBatang'; font-size: 10pt; color: #A6A6A6; width: 100%; text-align: left; top: 15px; position: relative;">${pb.p_brand}</p> 
											<p style="width: 100%; font-family: 'RIDIBatang'; font-size: 12pt; text-align: left; overflow: hidden; white-space: nowrap;">${pb.p_name}</p>
											<p style="width: 100%; font-family: 'TheJamsil5Bold'; font-size: 12pt; text-align: left; padding: 0px;">
												<fmt:formatNumber value="${pb.p_price}" pattern="#,###" />원 
											</p>
											<p style="position: absolute; left: 255px; top: 405px;">
												<a href="cart.mall?p_num=${pb.p_num}&cart_num=<%=session.getId()%>&oqty=1">
													<img src="resources/image/cartAdd.svg" width="25">
												</a>
											</p>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:if>
						
		    	</div>
		    	</div>
			</div>
			<div style="width: 100%; text-align: center; font-family: 'RIDIBatang'; top: -100px; position: relative;">
				${pageInfo.pagingHtml}
			</div>
		</main>
	</div>

</body>

<%@ include file="../views/footer.jsp" %>
</html>