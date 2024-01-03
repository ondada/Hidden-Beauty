<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminMenu.jsp"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminCompanyUpdate.css?ver=220610">
<style>
	input[type="text"], select {
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
	<div class="section">
		<div id="tag" style="margin-right:83%; font-size: 2em;">
			<h4>회원 정보 수정</h4>
		</div>
		
		<div id="center" style="text-align: center;">
			<form action="usersUpdate.admin" method="post">
			<table class="board-table">
				<tr style="border-top: 2px solid graytext; padding:10px;">
					<th width="20%"><font color="red">*</font> 이름</th>
					<td width="80%">
						<input type="text" class="form-control" name="u_name" value="${ub.u_name }" readonly>
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th><font color="red">*</font> 아이디</th>
					<td>
						<c:if test="${ub.u_jointype eq 'N' }">
							<input type="text" class="form-control" name="u_id" value="네이버 연동 회원" readonly> 
						</c:if>
						<c:if test="${ub.u_jointype eq 'K' }">
							<input type="text" class="form-control" name="u_id" value="카카오 연동 회원" readonly> 
						</c:if>
						<c:if test="${ub.u_jointype eq 'S' }">
							<input type="text" class="form-control" name="u_id" value="${ub.u_id }" readonly> 
						</c:if>
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th><font color="red">*</font> 전화번호</th>
					<td>
						<c:set var="firstList">010, 011, 016, 017, 018, 019</c:set>
						<select name="u_phone" class="form-select" style="width: 20%; display: inline;">
							<c:forEach var="first" items="${firstList }">
								<option value="${first }" <c:if test="${fn:split(ub.u_phone, '-')[0] eq first }">selected</c:if>>${first }</option>
							</c:forEach>
						</select>
						-
						<input type="text" class="form-control" style="width: 20%; display: inline;" name="u_phone" value="${fn:split(ub.u_phone, '-')[1]}" maxlength="4" readonly> - 
						<input type="text" class="form-control" style="width: 20%; display: inline;" name="u_phone" value="${fn:split(ub.u_phone, '-')[2]}" maxlength="4" readonly>
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th>&nbsp;&nbsp;주소</th>
					<td>
						<input type="text" class="form-control" style="width: 70%; display: inline; margin-bottom: 10px;" name="u_address" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[0]}" id="sample4_postcode" placeholder="먼저 우편번호 찾기 버튼을 눌러주세요." onClick="zipClick()" readonly>
						<input type="button" class="btn btn-white" onclick="sample4_execDaumPostcode()" style="margin-bottom:11px; height: 39px; width:140px;" value="우편번호 찾기" id="searchBtn"><br>
						<input type="text" class="form-control" name="u_address" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[1]}" id="sample4_roadAddress" placeholder="도로명주소" style="margin-bottom: 10px;" onClick="zipClick()" readonly>
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" class="form-control" name="u_address" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[2]}" id="sample4_detailAddress" placeholder="상세주소" readonly>
					</td>
				</tr>
				<!-- <tr>
					<th>* 결제수단</th>
					<td>
						<input type="text" name="u_pay" value="" placeholder="" required>
					</td>
				</tr> -->
				<!-- border-bottom: 2px solid graytext;  -->
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th ><font color="red">*</font> 퍼스널 컬러</th>
					<td>
						<c:set var="pcList">잘 모르겠음,봄 라이트,봄 브라이트,여름 라이트,여름 브라이트,여름 뮤트,가을 뮤트,가을 스트롱,가을 딥,겨울 브라이트,겨울 딥</c:set>
						<select name="u_color" class="form-select">
							<c:forEach var="pc" items="${pcList }">
								<option value="${pc }" <c:if test="${pc eq ub.u_color }">selected</c:if>>${pc }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<br><br>
						<input type="submit" value="수정하기" id="subBtn" class="btn btn-white" style="margin-bottom:11px; height: 39px; width:150px;">
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>
</article>