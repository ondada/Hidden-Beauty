<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	session.setAttribute("destination", "redirect:/productNewList.p");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css"> 
	#s {
		margin: 0 auto;
		width: 500px;
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

</head>


<%@ include file="productHeader.jsp" %>

<body>

	<div style="font-family: 'RIDIBatang'; font-size: 13pt; margin: 70px 0px 70px 305px;"> 
		<div style="font-size: 30pt; font-family: 'MaruBuri-Regular'; font-weight: bold; margin-bottom: 10px;">NEW</div>
		&nbsp;&nbsp;Hidden Beauty에 새롭게 입점된 상품 20가지를 소개해드릴게요.<br>
		&nbsp;&nbsp;<span style="font-size: 11pt; color: #BDBDBD;">실시간으로 업데이트 되며, 최근에 판매를 시작한 순서로 정렬되어 있습니다. :)</span>
	</div>

	<div id="wrap">
		<main> 
			<div>
			    <div class="container" style="margin-bottom: 150px;"> 
					<c:if test="${fn:length(product_NLists) == 0}">
						<div class="col">
						    <div class="card shadow-sm">
						        <br><br>
								<b>등록된 상품이 없습니다.</b><br><br>
							</div>
						   </div>
					</c:if>
						
					<c:if test="${fn:length(product_NLists) != 0}">
						<div class="row">
							<c:forEach var="pb" items="${product_NLists}">
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
		</main>
	</div>

</body>

<%@ include file="../views/footer.jsp" %>
</html>