<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#content tr{
		height: 40px;
	}
	#none_under{
		text-decoration: none; 
		color: black;
	}
	#none_under{
		color: graytext;
	}
</style>

<%@ include file="usersMypageMenuTop.jsp" %>

<div style="margin: 0px 0px 28px 5px; font-size: 10pt;">
	<a href="mypage.u" id="none_under">마이페이지</a> > 나의 쇼핑 > <a href="order.u" id="none_under">주문내역 조회</a>
</div>
<hr style="margin-bottom: 50px;">
				
<ul>
	<li><big>주문내역 조회</big></li>
	<br><br>
	<div>
		<table style="width: 90%; text-align: center;" id="content">
			<tr>
				<td style="background: #F7F3ED; font-weight: bold;">번호</td>
				<td style="background: #F7F3ED; font-weight: bold;">주문번호</td>
				<td style="background: #F7F3ED; font-weight: bold;">주문금액</td>
				<td style="background: #F7F3ED; font-weight: bold;">주문일자</td>
				<td style="background: #F7F3ED; font-weight: bold;">주문상태</td>
			</tr>
			
			<c:if test="${fn:length(obList) == 0}">
				<tr>
					<td colspan="5">주문내역이 존재하지 않습니다.</td>
				</tr>
			</c:if>
			
			<c:set var="num" value="${pageInfo.totalCount-pageInfo.beginRow+1}" />
			<c:if test="${fn:length(obList) != 0}">
				<c:forEach var="ob" items="${obList}">
					<tr>
						<td>
							${num}
							<c:set var="num" value="${num-1}" />
						</td>
						<td>
							<a href="orderDetail.u?o_num=${ob.o_num}&pageNumber=${pageNumber}&num=${num}" id="none_under">
								${ob.o_num}
							</a>
						</td>
						<td>
							<fmt:formatNumber value="${ob.o_totalamount}" pattern="#,###" />원
						</td>
						<td>${ob.o_date}</td>
						<td>${ob.o_status}</td>
					</tr>
				</c:forEach>
			</c:if>
			
		</table>
		
		<div style="width: 100%; text-align: center; top: 50px; position: relative;">
			${pageInfo.pagingHtml}
		</div>
	</div>
</ul>
<br>

<%@ include file="usersMypageMenuBottom.jsp" %>
