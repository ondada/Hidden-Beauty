<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminMenu.jsp"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminCompany.css">

<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
<div class="section">
	<div class="tag">
		<h4>주문 내역</h4>
	</div>
	<div id="board-search">
		<div class="container">
			<div class="search-window">
				<div class="search-wrap">
					<form action="orderList.admin">
						<select name="whatColumn" id="whatColumn">
							<option value="all">전체검색</option>
							<option value="u_id" >아이디</option>
							<option value="o_date">주문일자</option>						 
						</select>
						<input type="text" name="keyword" placeholder="검색어를 입력해주세요.">
						<button type="submit" class="btn btn-dark">검색</button>
					</form>
				</div>  
				 
			</div>
		</div>
	</div>
	<div id="board-list" >
		<div class="container" >
			<div class="row">
				<div class="whole1">
					<div class="topbox1">
						<table class="board-table" style="font-size: 13pt; text-align: center; table-layout:fixed;">
							<tr style="background: #f4f4f4;">
								<th scope="col" class="th-num" width="10%" >번호</th>
								<th scope="col" class="th-brand"width="10%" >주문 번호</th>
								<th scope="col" class="th-name" width="20%">아이디</th>
								<th scope="col" class="th-price"  width="20%">주문일자</th>
								<th scope="col" colspan="2" class="th-stock" width="40%">배송상태</th>
								
							</tr>
							
						</table>
						<div class="middlebox">
							<div class="box2 scrollnone">
								<table class="colr_table2" style="font-size: 13pt; text-align: center;">
									<c:if test="${empty ordLists }">
										<tr>
											<td colspan="12">주문 내역 결과가 없습니다.</td>
										</tr>
									</c:if>
									  
									<c:forEach var="ob" items="${ordLists }" varStatus="loop">
										<tr >
											<td width="10%" style="padding-left: 5px;">${loop.index + 1}</td>
											<td width="10%" style="padding-left: 5px;"><a href="orderDetail.admin?o_num=${ob.o_num}&pageNumber=${pageInfo.pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}">${ob.o_num}</a></td>
											<td width="20%" style="padding-left: 20px;">${ob.u_id}</td>
											<td width="20%" style="padding-left: 30px;">${ob.o_date}</td>
											<td width="20%" style="padding-left: 100px;">${ob.o_status}</td>
											<td width="20%" >
											<form action="orderStatus.admin">
												<input type="hidden" name="o_num" value="${ob.o_num}">
												<input type="hidden" name="u_id" value="${ob.u_id}">
												<input type="hidden" name="whatColumn" value="${whatColumn}">
												<input type="hidden" name="keyword" value="${keyword}">
												<input type="hidden" name="pageNumber" value="${pageInfo.pageNumber}">
												<input type="submit" class="btn btn-white"  value="배송 완료"> 
												 
											</form> 
											</td>
											   
										</tr>
									</c:forEach>
								</table>
								${pageInfo.pagingHtml }
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</article>


