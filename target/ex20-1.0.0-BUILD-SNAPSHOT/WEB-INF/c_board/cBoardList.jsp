<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="./../views/header.jsp" %>
<%
	session.setAttribute("destination", "redirect:/cBoardList.cb");
%>

<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/qBoardList.css">

<style type="text/css">
	#noneHigtLight{
		text-decoration: none;
	}
	#noneHigtLight:hover{
		color: #7C81BB;
	}
	body{
		padding-top: 90px;
	}
</style>

<script type="text/javascript">
	function selectReset(){
		var keyword = document.getElementById("search");
		keyword.value = "";
	}
	function popup(c_writer, loginInfo, pageNumber){
		if(loginInfo == ''){
			alert('로그인 후 이용 가능합니다.');
			location.href="login.u";
		} else {
			window.open('profile.u?c_writer='+c_writer, '프로필', 'menubar=no, toolbar=no, scrollbars=auto, resizable=no, width=500, height=650');
		}
	}
</script>

<article id="center" style="font-family: 'RIDIBatang';" >

	<div class="page-title">
        <div class="container" style="font-family: 'MaruBuri-Regular';">
            <br><br><br>
            <h3>퍼스널 컬러 진단 후기 게시판</h3>
        </div>
    </div>
	
	 <div id="board-search">
		<div class="container">
            <div class="search-window" style="padding: 20px 15px 10px 15px; background-color: #F7F3ED;">
				<div class="search-wrap">
					<form action="cBoardList.cb" method="get">
					<select name="whatColumn" id="whatColumn" onChange="selectReset()">
						<option value="all" <c:if test="${whatColumn == 'all'}">selected</c:if>>전체</option>
						<option value="c_subject" <c:if test="${whatColumn == 'c_subject'}">selected</c:if>>제목</option>
						<option value="c_writer" <c:if test="${whatColumn == 'c_writer'}">selected</c:if>>작성자</option>
						<option value="c_content" <c:if test="${whatColumn == 'c_content'}">selected</c:if>>내용</option>
					</select>
				 	<input id="search" type="text" name="keyword" value="<c:if test="${keyword != 'null'}">${keyword}</c:if>" placeholder="검색어를 입력해주세요.">
					<button type="submit" class="btn btn-dark">검색</button>
				</form>
            	</div>
        	</div>
    	</div>
    </div>

<div id="board-list">
<div class="container">
        
<input type=button value="글쓰기" onClick="location.href='write.cb?pageNumber=${pageInfo.pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}'" class="btn btn-white">
<table class="board-table" style="font-size: 13pt; text-align: center;">

	
	<tr style="background: #EDE5D8;">
		<th scope="col" class="th-num" width="10%">번호</th>
		<th scope="col" class="th-title" width="30%">제목</th>
		<th width="15%" class="th-writer">작성자</th>
		<th scope="col" class="th-date" width="17%">작성일</th>
		<th width="13%" class="th-readcount">조회수</th>
	</tr>
	<c:if test="${ !empty list }">
	<c:set var="num" value="${pageInfo.totalCount-pageInfo.beginRow+1}" />
		<c:forEach var="bb" items="${ list }">
			<tr>
				<td>${num }
     			<c:set var="num" value="${num -1}" /></td>
				<td align="left" >
					<c:set var="wid" value="0"/>
					<c:if test="${ bb.c_re_level > 0 }">
						<c:set var="wid" value="${bb.c_re_level * 20}"/>
						<img src="<%= request.getContextPath() %>/resources/image/level.gif" width="${wid}" height="20">
						<img src="<%= request.getContextPath() %>/resources/image/re.png" width="2%">
					</c:if>
						<a href="detail.cb?c_num=${bb.c_num}&pageNumber=${pageInfo.pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}" id="noneHigtLight">
							${ bb.c_subject }&nbsp;</a>
					<c:if test="${ bb.c_readcount >= 10 }">
						<img src="<%= request.getContextPath() %>/resources/image/hot.png" width="2%">
					</c:if>
				</td>
				<td>
					<a href="javascript:popup('${bb.c_writer }', '${loginInfo }', '${pageInfo.pageNumber}')" style="text-decoration-line: none;">
					<c:if test="${bb.c_profileimg eq null }">
						<img src="resources/image/person.svg" width="20" class="rounded-circle">
						<c:if test="${fn:length(bb.c_writer) < 16}">
							${ bb.c_writer }
						</c:if>
					</c:if>
					<c:if test="${bb.c_profileimg ne null }">
						<img src="${bb.c_profileimg }" width="32" height="32" class="rounded-circle">
						<c:if test="${fn:length(bb.c_writer) > 16}">
							외부 회원
						</c:if>
						<c:if test="${fn:length(bb.c_writer) < 16}">
							${ bb.c_writer }
						</c:if>
					</c:if>
					</a>
				</td>
				<td>
					<%-- <c:set var="now" value="<%= new java.util.Date() %>" />
					<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>
					<c:set var="regdate" value="<fmt:formatDate value='${bb.c_regdate}' pattern='yyyy-MM-dd'/>" />
					
					<c:if test="${regdate eq now}">
						
					</c:if> --%>
					<%-- ${bb.c_regdate } --%>
					<fmt:formatDate value="${bb.c_regdate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>${ bb.c_readcount }</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${ empty list }" > 
		<tr>
			<td colspan="8">작성된 글이 없습니다.</td> 
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