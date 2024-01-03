<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminMenu.jsp"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminCompanyUpdate.css">

<style>
input[type="text"] {
  font-size: 15px;
  width: 300px;
  height:35px;
  border: none;
  border-bottom: solid #aaaaaa 1px;
  padding-bottom: 3px;
  padding-left: 10px;
  position: relative;
  background: #f8f9f7;
  z-index: 5;
  border-radius:5px;
}

#searchBtn{
margin-top:13px;
}

table th{
	text-align:left;
}
.board-table{
margin-top:20px;
}
</style>

<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
	<div class="section" style="height: 150%">
		<div id="tag" style="margin-right:83%; font-size: 2em;">
			<h6>${ob.o_num}번 주문 내역</h6>
			 
		</div>
		  
	<div id="center" style="text-align: center;">
			 
			<table class="board-table">
				<tr style="border-top: 2px solid graytext; padding:10px;">
					<th width="20%">아이디</th>
					<td width="80%">
						 ${ob.u_id}
					</td>  
				</tr>
			<c:forEach var="pb" items="${ prodList }"  varStatus="loop">
			 <c:set var="totalAmount" value="${totalAmount + (pb.p_price * ordProdlist[loop.index].cart_qty)}" />
   
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%">주문 상품 ${loop.index + 1}</th>
					<td width="80%">
					 
					 ${pb.p_name }&nbsp;&nbsp;&nbsp;${ordProdlist[loop.index].cart_qty }개
					
					</td>
				</tr>
			 </c:forEach>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th>배송비</th>
					<td> 
					<c:if test="${totalAmount<30000}">
								 3,000원
					</c:if>
					<c:if test="${totalAmount>=30000}">
								 0원
					</c:if>
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%">전체 금액</th>
					<td width="80%">
						<c:if test="${totalAmount<30000}">
							<fmt:formatNumber value="${totalAmount+3000}" pattern="#,###" />원
						</c:if>
						<c:if test="${totalAmount>=30000}">
							<fmt:formatNumber value="${totalAmount}" pattern="#,###" />원
						</c:if>
					</td>  
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">  
					<th width="20%">수령인 번호</th>
					<td width="80%">
						${ob.o_phone}
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%">수령인</th>
					<td width="80%">
						${ob.o_name}
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%">배송메모</th>
					<td width="80%">
						${ob.o_message}
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%">수령주소</th>
					<td width="80%">
						${ob.o_addr}
					</td>
				</tr> 
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%">주문일자</th>
					<td width="80%">
						${ob.o_date}
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%">배송상태</th>
					<td width="80%">
						${ob.o_status}
					</td>
				</tr> 
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%">결제방법</th>
					<td width="80%">
						${ob.way}
					</td>
				</tr> 
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%">입금은행</th>
					<td width="80%">
						${ob.pay_bank}
					</td>
				</tr> 
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%">입금자명</th>
					<td width="80%">
						${ob.pay_name}
					</td>
				</tr> 
				<tr>
					<td colspan="2" align="center"> 
						<br>
						<form action="orderList.admin">
						 <input type="hidden" name="pageNumber" value="${pageNumber}">
						 <input type="hidden" name="keyword" value="${keyword}">
						 <input type="hidden" name="whatColumn" value="${whatColumn}">
							<input type="submit" value="돌아가기" class="btn btn-white" style="margin-bottom:11px; height: 39px; width:150px;">
						</form>
					</td>
				</tr>
			</table>
			 
		</div>
	</div>
</article>
