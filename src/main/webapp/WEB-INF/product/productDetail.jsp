<%@page import="utility.Paging"%>
<%@page import="product.model.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>

<%
	application.setAttribute("flag", false);
%> 

<!doctype html>
<html>

<head>
<meta charset="UTF-8">

<style type="text/css">
	body {
		padding-top: 140px; 
	}
	.container {
		width: 900px;
	} 
	/*폭을 일정하게 담기 위한 css*/
	.menu {
		display: flex;
		justify-content: space-between;
		align-items: center;
		height: 50px;
		background-color: #D0D6CE;
	} /* 상단 메뉴를 디자인하는 CSS */
	.logo {
		margin: 0px 0px 0px 315px;
		font-size: 18pt;
		font-weight: bold;
		font-family: 'MaruBuri-Regular';
		text-decoration: none;
		color: white;
	} /* Webucks font를 위한 CSS*/
	li .menu-list {
		margin-right: 10px;
		padding: 10px;
		color: black;
		text-decoration: none;
		color: gray;
	} /* 상단 배너 내의 버튼들을 디자인해주는 CSS */
	.first {
		width: 50%;
		padding: 80px 0px 0px 10px;
		text-align: center;
		left: -10px;
		position: relative;
	} /* 화면을 이분할하기 위해 width에 50% 적용 */
	.second {
		width: 43%;
		padding: 80px 0px 0px 10px;
		font-family: 'RIDIBatang'; 
	} /* 화면을 이분할하기 위해 width에 50% 적용 */
	.left {
		font-size: 20px;
		font-weight: bold;
	}
	.coldbrew {
		font-size: 23px;
		font-weight: bold;
	}
	#one {
		display: flex;
	} 
	/* container div중 하나를 선택하기 위한 id태그*/
	#one img {
		width: 95%;
	}
	.gray {
		text-align: right;
		color: gray;
		font-size: 12px;
		font-style: bold;
	}
	.coffeename {
		font-size: 25px;
		font-weight: bold;
	}
	.coffeename2 {
		font-size: 15px;
		top: 10px;
		position: relative;
	}
	.seconddetail {
		padding-top: 17px;
		border-top: 3px solid black;
		font-size: 15px;
		padding-bottom: 30px;
		border-bottom: 1px solid lightgray;
		margin: 0;
	}
	.productdetail {
		display: flex;
		justify-content: space-between;
		border-bottom: 1px solid lightgray;
		padding-top: 20px;
		padding-bottom: 20px;
		margin: 0;
	}
	.productdetail span {
		margin-left: 12px;
		margin-right: 12px;
		font-size: 12pt;
	}
	.productdetail2 {
		display: flex;
		justify-content: space-between;
		padding-bottom: 20px; 
		margin: 0;
	}
	.boxone {
		width: 100%;
	}
	.boxtwo {
		width: 50%;
	}
	.productdetail2 ul {
		display: flex;
		flex-direction: column;
		padding: 10px 0px 10px 0px;
		margin: 0 11px 0 11px;
		font-size: 12pt;
		line-height: 200%;
	}
	.productdetail2 li {
		display: flex;
		justify-content: space-between;
		margin-bottom: 5px;
	} 
	/* productdetail2 의 ul과 ㅣi 모두 화면과 같은 레이아웃을 적용해주기 위해 
	위와 같이 Flex가 주된 css 적용*/
	.allegy {
		display: flex;
		background-color: #F9F9F9;
		height: 45px;
		align-items: center;
		text-align: right;
		padding-left: 10px;
		margin-bottom: 40px;
		border-radius: 5px;
		font-weight: bold;
	}
	.reviewnav {
		font-size: 20px;
		font-weight: bold;
		border-bottom: 1px solid lightgray;
		padding-top: 10px;
		padding-bottom: 15px;
	}
	.id {
		font-weight: bold;
		font-size: 13px;
	}
	.ment {
		font-size: 13px;
		margin-left: 5px;
	}
	.reviewcomment {
		font-size: 13px;
		font-weight: bold;
		color: rgb(151, 143, 143);
		background-color: rgb(243, 240, 240);
		margin-top: 20px;
		padding: 7px;
		width: 100%;
		border: 1px solid rgb(243, 240, 240);
	} /* 리뷰 입력창을 위한 CSS*/
	.bottomzone {
		display: flex;
		background-color: rgb(44, 40, 40);
		padding: 30px;
		justify-content: space-around;
		color: white;
		font-size: 13px;
		padding-top: 40px;
	} /* 최하단부의 배너를 포괄하는 div의 CSS*/
	.bottomzone ul {
		display: flex;
		flex-direction: column;
		margin-top: 0;
		padding: 0;
	}
	.bottomzone li {
		padding-bottom: 8px;
	}
	#btn{
		width: 49%;
		height: 50px;
		margin-left: 2px;
		border: 1px solid #D5D5D5;
		border-radius: 5px;
		background: white;
		font-size: 13pt; 
	}
	#btn:hover {
		background: #F6F6F6;
	}
</style>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
   function updateOrderAmount() {
       var quantity = document.getElementById('num').value;
       var unitPrice = ${pb.p_price}; // 서버 측 데이터에서 단가 가져오기
       var unitPoint = ${pb.p_point};

       // 주문 금액 계산
       var orderAmount = quantity * unitPrice;

       // 배송비 계산
       var deliveryFee = orderAmount >= 30000 ? 0 : 3000;

       // 총액 계산
       var totalAmount = orderAmount + deliveryFee;
       var totalPoint = quantity * unitPoint;

       // 표시된 배송비 및 총액 업데이트
       document.getElementById('deliveryFee').innerText =  new Intl.NumberFormat().format(deliveryFee) + '원';
       document.getElementById('totalAmount').innerText = '총 상품 금액 : ' + new Intl.NumberFormat().format(totalAmount) + '원';
       document.getElementById('totalPoint').innerText = '(적립 예정 포인트 : ' + new Intl.NumberFormat().format(totalPoint) + '원)';
   }
</script>
</head>

<%@ include file="productHeader.jsp" %>

<body>

<%
	String cart_num = session.getId();
	UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
	String p_num = request.getParameter("p_num");
	String pageNumber = request.getParameter("pb");
	session.setAttribute("destination", "redirect:/prodView.p?p_num="+p_num+"&pageNumber="+pageNumber);
			
	if(ub==null){
	%>
		<script type="text/javascript">
			alert("로그인 후 이용 가능합니다.")
			window.location.href = "login.u";
		</script>
	<%
	};
%>
	       
<c:set var="ub" value="<%=ub%>" />

<form id="f">
	<input type="hidden" name="p_num" value="${pb.p_num}">
	<input type="hidden" name="id" value="${ub.u_id}">
	<input type="hidden" name="cart_num" value="<%=cart_num%>">
	
	<section>
	<!--중반부의 레이아웃-->
	 
		<div class="container" id="one">
		<!-- 중반부 전체를 감싸는 div 태그-->
		
			<div class="first"> 
			<!--중반부를 두개의 div태그로 나누어 왼쪽 절반의 구역으로 나눠줌 -->
				<div style="width: 480px; height: 720px; overflow: hidden; margin: auto;">
					<img src="<%=request.getContextPath() %>/resources/uploadFolder/product/${pb.p_ttlimg}" alt="타이틀 이미지" style="width: 100%; ">
				</div>
			</div>

			<div class="second">
			<!--중반부 를 두개의 div태그로 나누어 오른쪾 절반의 구역으로 나눠줌-->
				<div id="fifth">
					<div class="emojiright">
						<p class="coffeename2">${pb.p_brand}</p>
						<p class="coffeename">${pb.p_name}</p>
					</div>
				</div>
				<p class="seconddetail">${pb.p_contents}</p>
				<div class="productdetail" style="border: none;">
					<span>판매가</span>
					<span><fmt:formatNumber value="${pb.p_price}" pattern="#,###" />원</span>
				</div>
				<div class="productdetail" style="top: -10px; padding-top: 0px; position: relative;">
					<span>적립 포인트</span>
					<span><fmt:formatNumber value="${pb.p_point}" pattern="#,###" />원</span>
				</div>

				<div class="productdetail2">
					<!--영양정보를 담아주는 div 태그-->
					<div class="boxone">
					<!--영양 정보를 좌우로 반반 나눠주었으며, 왼쪽에 해당하는 div 태그-->
						<ul>
							<li>
								<span class="l">배송비(30,000원 이상 무료배송)</span> 
								<span id="deliveryFee" class="r">
									<c:if test="${pb.p_price > 30000}">0원</c:if>
									<c:if test="${pb.p_price < 30000}">3,000원</c:if>
								</span>
							</li>
							<li>
								<span class="l">수량</span> 
								<span class="r">
									<input type="number" class="form-control" value="1" name="oqty" id="num" min="1" style="width: 60px;" placeholder="단위(개)" oninput="updateOrderAmount()">
								</span>
							</li>
						</ul>
					</div>
				</div>

				<div class="allegy">
					<span id="totalAmount">총 상품 금액 : 
						<fmt:formatNumber value="${pb.p_price+3000}" pattern="#,###" />원
					</span>
					&nbsp;
					<span id="totalPoint" style="font-size: 10pt; padding-top: 3px;">
						<small>(적립 예정 포인트 : <fmt:formatNumber value="${pb.p_point}" pattern="#,###" />원)</small>
					</span>
				</div>
				<button id="btn" onClick="javascript: form.action='cart.mall'; form.submit();"><img src="resources/image/cartAdd.svg" style="width: 20px;">&nbsp;장바구니</button>
				<button id="btn" onClick="javascript: form.action='order.mall'; form.submit();"><img src="resources/image/goOrder.svg" style="width: 20px;">&nbsp;주문하기</button>
			</div>
		</div>
	</section>
</form>

<div style="width: 60%; margin: auto; border-bottom: 1px solid #D5D5D5;"> 
	<div style="width: 250px; height: 45px; background: #C7C7DB; color: white; text-align: center; display: table-cell; vertical-align: middle; font-family: 'RIDIBatang'; font-size: 15pt;">
		상세정보
	</div> 
	<div style="width: 680px; height: 45px; text-align: center; display: table-cell; vertical-align: middle;"></div> 
	<div style="width: 200px; height: 45px; text-align: center; display: table-cell; vertical-align: middle; font-family: 'RIDIBatang'; font-size: 12pt;">
		퍼스널 컬러 - ${pb.p_color} 
	</div>
</div>
<div style="height: 150px;"></div> 

<div style="width: 100%; text-align: center; padding-bottom: 150px;">
	<img alt="상세 이미지" src="<%=request.getContextPath() %>/resources/uploadFolder/product/${pb.p_dtlimg}">
</div>
 
	 
 
 

  
</body>

<%@ include file="../views/footer.jsp" %>

</html>