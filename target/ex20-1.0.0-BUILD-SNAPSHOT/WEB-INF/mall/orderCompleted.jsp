<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	body{
		padding-top: 140px;
	}
	#infoTable{
		margin: auto; 
		border: 1px solid #D5D5D5; 
		width: 580px;
		line-height: 160%;
	}
	#infoTable th{
		padding-left: 30px;
		color: #A6A6A6;
		font-weight: normal;
	}
	#infoTable td{
		font-size: 11pt;
	}
	#btn{
		padding: 5px 15px 5px 15px;
		border: 1px solid #D5D5D5;
		border-radius: 5px;
		color: black; 
		background: white; 
	}
	#btn:hover {
		background: #7C81BB;
		color: white;
	}
</style>

<%@ include file="../product/productHeader.jsp" %>

<article id="center" style="text-align: center; font-family: 'RIDIBatang';">
	<div style="margin: 80px 0px 50px 0px;">
		<div style="margin-bottom: 5px;">
			FIND YOUR Hidden Beauty를 이용해주셔서 감사합니다.
		</div>
		<div style="font-family: 'MaruBuri-Regular'; font-weight: bold; font-size: 20pt;">
			고객님의 주문이 정상적으로 완료되었습니다.
		</div>
		<c:if test="${ob.way == '무통장 입금'}"> 
			<div style="margin-top: 30px; font-size: 11pt;">
				아래 계좌로 입금해주시면 배송이 시작됩니다.
			</div>
		</c:if>
		</div>
	<table id="infoTable">
		<c:if test="${ob.way == '무통장 입금'}">
			<tr style="border-bottom: 1px dotted #EAEAEA; height: 130px;"> 
				<th valign="top" style="padding-top: 15px;">입금계좌 안내</th>
				<td>
					[${ob.pay_bank}]<br>
					1234-5678-7895012<br>
					Hidden Beauty (환감탈태)<br>
					<span style="font-weight: bold; font-size: 12pt; color: #C98BA4;"><fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</span>
				</td>
			</tr>
		</c:if>
		<tr style="border-bottom: 1px dotted #EAEAEA; height: 60px;"> 
			<th>주문번호</th>
			<td>${ob.o_num}</td>
		</tr>
		<tr style="border-bottom: 1px dotted #EAEAEA; height: 80px;"> 
			<th valign="top" style="padding-top: 15px;">배송지</th>
			<td>
				${ob.o_name} (${ob.o_phone})<br>
				${ob.o_addr}<br>
			</td>
		</tr>
		<tr style="border-bottom: 1px dotted #EAEAEA; height: 60px;">
			<th>포인트 혜택</th>
			<td><fmt:formatNumber value="${totalPoint}" pattern="#,###" />원</td>
		</tr>
		<tr style="height: 50px;">
			<th>배송메모</th>
			<td>${ob.o_message}</td>
		</tr>
	</table>
	<br><br>
	<input type="button" id="btn" value="주문내역 확인" onClick="location.href='order.u'">
	<input type="button" id="btn" value="계속 쇼핑하기" onClick="location.href='productMain.p'">
	
</article>

<%@ include file="../views/footer.jsp" %>

