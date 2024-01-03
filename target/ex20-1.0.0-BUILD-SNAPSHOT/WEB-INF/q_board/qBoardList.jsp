<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	session.setAttribute("destination", "redirect:/qBoardList.qb");
%>
    
<%@ include file="./../product/productHeader.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/qBoardList.css">

<style type="text/css">
	#noneHigtLight{
		text-decoration: none;
	}
	#noneHigtLight:hover{
		color: #7C81BB;
	}
	body{ 
		padding-top: 140px;
	}
		.secret{
		background-color:transparent;
		border :none;
	}
	.secret:hover{
	color: #7C81BB;
	}
</style>

<script type="text/javascript">
	function selectReset(){
		var keyword = document.getElementById("search");
		keyword.value = "";
	}
	function popup(u_id, loginInfo){
		if(loginInfo == ''){ 
			alert("로그인 후 이용 가능합니다.");
			location.href="login.u";
		} else {
			alert("작성자:"+u_id);
			window.open("profile.u?u_id="+u_id, '_blank', 'menubars=no, scrollbars=auto');
		}
	}
	function secret(){
		alert("비밀글은 작성자와 관리자만 확인 가능합니다.");
	}
</script>

<%
	application.setAttribute("flag", false);
	UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
	String id = "null";
	
	if(ub != null){
		id = ub.getU_id();
	}
%>
<article id="center" style="font-family: 'RIDIBatang';" >

	<div class="page-title">
        <div class="container" style="font-family: 'MaruBuri-Regular';">
            <br><br><br>
            <h3>상품 문의 게시판</h3>
        </div>
    </div>
	
	 <div id="board-search">
		<div class="container">
            <div class="search-window" style="padding: 20px 15px 10px 15px; background-color: #F7F3ED;">
				<div class="search-wrap">
					<form action="qBoardList.qb" method="get">
					<select name="whatColumn" id="whatColumn" onChange="selectReset()">
						<option value="all" <c:if test="${whatColumn == 'all'}">selected</c:if>>전체</option>
						<option value="q_subject" <c:if test="${whatColumn == 'q_subject'}">selected</c:if>>제목</option>
						<option value="q_writer" <c:if test="${whatColumn == 'q_writer'}">selected</c:if>>작성자</option>
						<option value="q_content" <c:if test="${whatColumn == 'q_content'}">selected</c:if>>내용</option>
					</select>
				 	<input id="search" type="search" name="keyword" value="<c:if test="${keyword != 'null'}">${keyword}</c:if>" placeholder="검색어를 입력해주세요.">
					<button type="submit" class="btn btn-dark">검색</button>
				</form>
            	</div>
        	</div>
    	</div>
    </div>

<div id="board-list">
<div class="container">
        
<input type=button value="글쓰기" onClick="location.href='write.qb?pageNumber=${pageInfo.pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}'" class="btn btn-white">
<table class="board-table" style="font-size: 13pt; text-align: center;">

	<tr style="background: #EDE5D8;">
		<th scope="col" class="th-num" width="10%">번호</th>
		<th scope="col" class="th-num" width="15%">문의유형</th>
		<th scope="col" class="th-title" width="30%">제목</th>
		<th width="15%" class="th-writer">작성자</th>
		<th scope="col" class="th-date" width="17%">작성일</th>
		<th width="8%">조회수</th>
		<th width="8%">비밀글</th>
	</tr>
	<c:if test="${ !empty list }">
	<c:set var="num" value="${pageInfo.totalCount-pageInfo.beginRow+1}" />
		<c:forEach var="bb" items="${ list }">
			<tr>
				<td>${num }
      				<c:set var="num" value="${num -1}" />
      			</td>
      			<td>${bb.q_type}</td>
				<td align="left" >
					<c:set var="wid" value="0"/>
					<c:if test="${ bb.q_re_level > 0 }">
						<c:set var="wid" value="${bb.q_re_level * 20}"/>
						<img src="<%= request.getContextPath() %>/resources/image/level.gif" width="${wid}" height="20">
						<img src="<%= request.getContextPath() %>/resources/image/re.png" width="2%">
					</c:if>
					
				<c:if test="${bb.q_secret == 'N'}">
					<c:set var="userId" value="<%=id%>" />
				    <c:choose>
				        <c:when test="${bb.q_writer != userId && userId != 'admin'}"> <!-- 작성자이거나 관리자일 때 -->
							<input type="button" value="${ bb.q_subject }" onClick="secret()" class="secret" id="noneHigtLight">
				        </c:when>
				         <c:when test="${bb.q_writer == userId || userId=='admin'}"> <!-- 작성자이거나 관리자일 때 -->
							   <a href="detail.qb?q_num=${bb.q_num}&pageNumber=${pageInfo.pageNumber}&userId=${loginInfo.u_id}&whatColumn=${whatColumn}&keyword=${keyword}" id="noneHigtLight">
						${ bb.q_subject }&nbsp;</a>
				        </c:when>
				        <c:otherwise>
				         	 <a href="detail.qb?q_num=${bb.q_num}&pageNumber=${pageInfo.pageNumber}&userId=${loginInfo.u_id}&whatColumn=${whatColumn}&keyword=${keyword}" id="noneHigtLight">
						${ bb.q_subject }&nbsp;</a>
				        </c:otherwise>
				    </c:choose>                                            
				</c:if>
					
					<c:if test="${bb.q_secret == 'Y'}">
					<c:set var="userId" value="<%=id%>" />
					<a href="detail.qb?q_num=${bb.q_num}&pageNumber=${pageInfo.pageNumber}&userId=${loginInfo.u_id}&whatColumn=${whatColumn}&keyword=${keyword}" id="noneHigtLight">
							${ bb.q_subject }&nbsp;</a>
					</c:if>
					<c:if test="${ bb.q_readcount >= 10 }">
						<img src="<%= request.getContextPath() %>/resources/image/hot.png" width="2%">
					</c:if>
				</td>
				<td>
					<a href="javascript:popup('${bb.q_writer }', '${loginInfo }')" style="text-decoration-line: none;">
					<c:if test="${bb.q_profileimg eq null }">
						<img src="resources/image/person.svg" width="20" class="rounded-circle">
						<c:if test="${fn:length(bb.q_writer) < 16}">
							${ bb.q_writer }
						</c:if>
					</c:if>
					<c:if test="${bb.q_profileimg ne null }">
						<img src="${bb.q_profileimg }" width="32" height="32" class="rounded-circle">
						<c:if test="${fn:length(bb.q_writer) > 16}">
							외부 회원
						</c:if>
						<c:if test="${fn:length(bb.q_writer) < 16}">
							${ bb.q_writer }
						</c:if>
					</c:if>
					</a>
				</td>
				<td>
					<fmt:formatDate value="${bb.q_regdate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>${ bb.q_readcount }</td>
				<td>
					<c:if test="${bb.q_secret == 'N'}">
						<img src="resources/image/secret.png" width="20">
					</c:if>
					<c:if test="${bb.q_secret == 'Y'}">
						-
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${ empty list }" >
		<tr>
			<td colspan="10">작성된 글이 없습니다.</td>
		</tr>
	</c:if>
 </table>
        </div>
    </div>
<br><br>
<center>
<div id="pagenation">
	${pageInfo.pagingHtml}
</div>
</center> 

</article>



<%@ include file="./../views/footer.jsp" %>