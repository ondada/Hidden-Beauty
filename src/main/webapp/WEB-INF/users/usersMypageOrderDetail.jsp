<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="usersMypageMenuTop.jsp" %>

<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular'; left: -300px; position: relative;" >
	<div class="section" style="height: 150%">
		<div id="tag" style="font-size: 2em; width: 70%;">
			<h3><b>${num}번 주문 내역</b></h3>
		</div>
		 <br><br>
	<div id="center" style="text-align: center;">
			 
			<table class="board-table" style="width: 70%; height: 600px;">
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
						<!-- <input type="button" value="주문취소" class="btn btn-white" style="margin-bottom:11px; height: 39px; width:150px;" onClick=""> -->
						<input type="button" value="돌아가기" class="btn btn-white" style="margin-bottom:11px; height: 39px; width:150px;" onClick="javascript:history.go(-1);">
					</td>
				</tr>
			</table>
			 
		</div>
	</div>
</article>

<%@ include file="usersMypageMenuBottom.jsp" %>
