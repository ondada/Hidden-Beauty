<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
	String cart_num = session.getId();
			
	if(ub==null){
		session.setAttribute("destination", "redirect:/cartList.mall");
	%>
		<script type="text/javascript">
			alert("로그인 후 이용 가능합니다.")
			window.location.href = "login.u";
		</script>
<%
	};
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	body {
		padding-top: 140px;
	}
	#btn{
		border: 1px solid #D5D5D5;
		border-radius: 5px;
		background: white;
		font-family: 'RIDIBatang';
	}
	#btn:hover{
		background: #B3B3CE;
		color: white;
		border: 1px solid white;
	}
	#btn2{
		border: 1px solid #D5D5D5;
		border-radius: 5px;
		background: white;
		font-family: 'RIDIBatang';
		font-size: 11pt;
		margin: 2px 0px 2px 0px;
	}
	#btn2:hover{
		background: #E7B3CE;
		color: white;
		border: 1px solid white;
	}
</style>

<script>
	var allBtn = document.getElementsByName("all");
	var checkBtns = document.getElementsByName("check");
	
	function allCheck(){
		if(allBtn[0].checked == true){
			for(var i=0; i<checkBtns.length; i++){
				checkBtns[i].checked = true;
			}
		} else {
			for(var i=0; i<checkBtns.length; i++){
				checkBtns[i].checked = false;
			}
		}
	}
	
	function delCheck(){
		var flag = false;
		
		for(var i=0; i<checkBtns.length; i++){
			if(checkBtns[i].checked == true){
				flag = true;
			}
		}
		
		if(flag == false){
			alert("1개 이상 체크 하신 후 요청 바랍니다.");
			return false;
		}
	}
	
	function goUpQty(p_num, p_stock){
		var cart_qty = document.getElementById("cart_qty").value;
		
		if(cart_qty <= 0){
			alert("1 이상의 숫자만 입력 가능합니다.");
			return;
		}
		
		if(cart_qty > p_stock){
			alert(p_stock+" 이하의 숫자만 입력 가능합니다.");
			return;
		}
		
		window.location.href = "qtyUp.mall?p_num="+p_num+"&cart_num=<%=cart_num%>&cart_qty="+cart_qty;
	}
</script>

</head>
<body>

<%@ include file="../product/productHeader.jsp"%>

	<div style="font-family: 'MaruBuri-Regular'; font-size: 25pt; font-weight: bold; margin: 50px 0px 30px 360px;">
		장바구니
	</div>
	
	<div style="width: 1200px; margin: auto; padding: 0px 25px 80px 12px;">
		<form action="cartDelete.mall" method="post" onsubmit="return delCheck()">
		<input type="submit" id="btn2" value="선택 삭제" style="padding: 3px 10px 3px 10px; margin-bottom: 10px;">
		<table style="text-align: center; font-family: 'RIDIBatang'; width: 100%;">
			<thead>
				<tr style="font-size: 13pt; border-top: 1px solid black; background: #F6F6F6; height: 50px;">
					<th scope="col"><input type="checkbox" name="all" onClick="allCheck()"></th>
					<th scope="col">상품명</th>
					<th scope="col">수량</th>
					<th scope="col">가격</th>
					<th scope="col">배송비</th>
					<th scope="col">주문금액</th>
					<th scope="col">선택</th>
				</tr>
			</thead>

			<tbody>
				<c:if test="${fn:length(productList) == 0}">
					<tr style="border-bottom: 1px solid #D5D5D5; height: 80px;">
						<td colspan="7" style="text-align: center;">
							장바구니에 담긴 상품이 없습니다.
						</td>
					</tr>
				</c:if>
				
				<c:if test="${fn:length(productList) != 0}">
					<c:forEach var="pb" items="${productList}" varStatus="loop">
						<tr valign="middle" style="border-bottom: 1px solid #D5D5D5; height: 120px;">
							<td scope="row"><input type="checkbox" name="check" value="${pb.p_num}"></td>
							<td>${pb.p_name}</td>
							<td>
								<input type="number" id="cart_qty" class="form-control" min="1" max="${pb.p_stock}" value="${list[loop.index].cart_qty}" style="width: 70px; height: 31px; display: inline;">
								<input type="button" value="수정" style="width: 40px; font-size: 10pt;" onClick="goUpQty('${pb.p_num}', '${pb.p_stock}')">
							</td> 
							<td><fmt:formatNumber value="${pb.p_price}" pattern="#,###" />원</td>
							<td>
								<c:if test="${totalAmount < 30000}">
									3,000원
								</c:if>
								<c:if test="${totalAmount >= 30000}">
									0원
								</c:if>
							</td>
							<td>
								<c:if test="${pb.p_price*list[loop.index].cart_qty < 30000}">
									<fmt:formatNumber value="${pb.p_price*list[loop.index].cart_qty + 3000}" pattern="#,###" />원
								</c:if>
								<c:if test="${pb.p_price*list[loop.index].cart_qty >= 30000}">
									<fmt:formatNumber value="${pb.p_price*list[loop.index].cart_qty}" pattern="#,###" />원
								</c:if>
							</td>
							<td>
								<input type="button" id="btn2" value="삭제하기" onClick="location.href='cartDelete.mall?p_num=${pb.p_num}'"><br>
								<input type="button" id="btn2" value="바로구매" onClick="location.href='order.mall?p_num=${pb.p_num}&id=${loginInfo.u_id}&cart_num=<%=cart_num%>&oqty=${list[loop.index].cart_qty}'">
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		</form>
		<br><br>
		
		<table style="width: 100%; height: 130px; border: 2px solid #B1B1B1; font-family: 'RIDIBatang'; font-size: 15pt;">
			<tr align="center">
				<td>
					<span style="font-size: 11pt; color: #A6A6A6;">총 주문 금액</span><br>
					<div style="font-size: 18pt; margin-top: 3px;">
						<fmt:formatNumber value="${totalAmount}" pattern="#,###" />원
					</div>
				</td>
				<td>+</td>
				<td>
					<span style="font-size: 11pt; color: #A6A6A6;">배송비</span><br>
					<div style="font-size: 18pt; margin-top: 3px;">
						<c:if test="${totalAmount < 30000}">
							<c:if test="${fn:length(productList) == 0}">
								0원
							</c:if>
							<c:if test="${fn:length(productList) != 0}">
								3,000원
							</c:if>
						</c:if> 
						<c:if test="${totalAmount >= 30000}">
							0원
						</c:if>
					</div>
				</td>
				<td>=</td>
				<td>
					<span style="font-size: 11pt; color: #A6A6A6;">결제 예정 금액</span><br>
					<div style="font-size: 18pt; margin-top: 3px; color: red;">
						<c:if test="${totalAmount < 30000}">
							<c:if test="${totalAmount < 30000}">
								<c:if test="${fn:length(productList) == 0}">
									<fmt:formatNumber value="${totalAmount}" pattern="#,###" />원
								</c:if>
								<c:if test="${fn:length(productList) != 0}">
									<fmt:formatNumber value="${totalAmount+3000}" pattern="#,###" />원
								</c:if>
							</c:if> 
						</c:if> 
						<c:if test="${totalAmount >= 30000}">
							<fmt:formatNumber value="${totalAmount}" pattern="#,###" />원
						</c:if>
					</div>
				</td>
			</tr>
		</table>
		
		<div style="width: 100%; text-align: center; margin-top: 50px;">
			<input type="button" id="btn" style="padding: 10px 50px 10px 50px;" value="전체 상품 주문" onClick="location.href='cartOrder.mall?total=${totalAmount}'"> 
		</div>
		
	</div>
	<%@ include file="../views/footer.jsp"%>
</body>
</html>