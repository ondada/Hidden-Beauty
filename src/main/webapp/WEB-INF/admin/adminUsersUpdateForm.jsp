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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다. 
    function sample4_execDaumPostcode() {
        new daum.Postcode({
        	
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				
                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
        
    }
	function zipClick(){
		document.getElementById("searchBtn").click();
	}
	function inputDomain(){
		var select = document.getElementById("selectDomain");
		var domainArea = document.getElementById("domainArea");
		
		domainArea.value = "";
		if(select.value != "직접 입력"){
			domainArea.value = select.value;
		}
	}
</script>


<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
	<div class="section">
		<div id="tag" style="margin-right:83%; font-size: 2em;">
			<h4>회원 정보 수정</h4>
		</div>
		
		<div id="center" style="text-align: center;">
			<form action="usersUpdate.admin" method="post">
			<table class="board-table">
				<tr style="border-top: 2px solid graytext; padding:10px;">
					<th width="20%">이름</th>
					<td width="80%">
						<input type="text" class="form-control" name="u_name" value="${ub.u_name }">
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th>아이디</th>
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
					<th>전화번호</th>
					<td>
						<c:set var="firstList">010, 011, 016, 017, 018, 019</c:set>
						<select name="u_phone" class="form-select" style="width: 20%; display: inline;">
							<c:forEach var="first" items="${firstList }">
								<option value="${first }" <c:if test="${fn:split(ub.u_phone, '-')[0] eq first }">selected</c:if>>${first }</option>
							</c:forEach>
						</select>
						-
						<input type="text" class="form-control" style="width: 20%; display: inline;" name="u_phone" value="${fn:split(ub.u_phone, '-')[1]}" maxlength="4"> - 
						<input type="text" class="form-control" style="width: 20%; display: inline;" name="u_phone" value="${fn:split(ub.u_phone, '-')[2]}" maxlength="4">
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD;">
					<th>이메일</th>
					<td>
						<input type="text" class="form-control" name="u_email" style="width: 33%; display: inline-block;" value="${fn:split(ub.u_email, '@')[0]}" maxlength="20" required>
						@
						<input type="text" class="form-control" id="domainArea" name="u_email" style="width: 33%; display: inline-block;" value="${fn:split(ub.u_email, '@')[1]}" maxlength="15" required>
						<c:set var="domains">직접 입력,naver.com,daum.net,google.com,hanmail.net</c:set>
						<select class="form-select" id="selectDomain" style="width: 25%; display: inline-block;" onchange="inputDomain()">
							<c:forEach var="domain" items="${domains}">
								<option value="${domain}">${domain}
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th>주소</th>
					<td>
						<input type="hidden" id="sample4_jibunAddress">
						<input type="hidden" id="sample4_extraAddress">
						<input type="text" class="form-control" style="width: 70%; display: inline; margin-bottom: 10px;" name="u_address" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[0]}" id="sample4_postcode" placeholder="먼저 우편번호 찾기 버튼을 눌러주세요." onClick="zipClick()">
						<input type="button" class="btn btn-white" onclick="sample4_execDaumPostcode()" style="margin-bottom:11px; height: 39px; width:140px;" value="우편번호 찾기" id="searchBtn"><br>
						<input type="text" class="form-control" name="u_address" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[1]}" id="sample4_roadAddress" placeholder="도로명주소" style="margin-bottom: 10px;" onClick="zipClick()">
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" class="form-control" name="u_address" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[2]}" id="sample4_detailAddress" placeholder="상세주소">
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th>퍼스널 컬러</th>
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