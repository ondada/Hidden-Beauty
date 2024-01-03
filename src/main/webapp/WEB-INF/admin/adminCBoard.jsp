<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/admin_C_Board.css">
<%@ include file="adminMenu.jsp"%>
<script type="text/javascript">
	
	function delBtn(c_num,pageNumber){
		if(confirm('정말로 삭제하시겠습니까?')){
			location.href="cBoardDelete.admin?c_num="+c_num+"&pageNumber="+pageNumber;
		}
	}
	
</script>

<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
	
 <div id="board-list">
<div class="section">
	<div class="tag">
	<h4>후기 게시판 관리</h4>
	</div>
	  <div id="board-search">
        <div class="container">
            <div class="search-window">
               <div class="search-wrap">
				<form action="cBoardList.admin" method="get">
						<select name="whatColumn" id="whatColumn">
							<option value="all">전체검색</option>
							<option value="c_subject">제목</option>
							<option value="c_writer">작성자</option>
						</select>
					 	<input id="search" type="search" name="keyword" placeholder="검색어를 입력해주세요." value="">
					 	
					<button type="submit" class="btn btn-dark">검색</button>
		            </div>
				   </form>
		        </div>
		    </div>
 
 <div id="board-list" >
        <div class="container" >
        <div class="row">
        <div class="whole1">
            <div class="topbox1">
        
		<table class="board-table" style="font-size: 13pt; text-align: center; table-layout:fixed;">
			<input type="hidden" name="c_num" value="${ bb.c_num }">
			<input type="hidden" name="pageNumber" value="${ pageInfo.pageNumber}">
			
			<tr style="background: #f4f4f4;">
				<th scope="col" class="th-num" width="10%">번호</th>
				<th scope="col" class="th-title" width="24%" align="left">제목</th>
				<th width="10%" class="th-writer">작성자</th>
				<th width="10%" class="th-email">이메일</th>
				<th scope="col" class="th-date" width="10%">작성일</th>
				<th width="10%" class="th-readcount"></th>
			</tr>
			<c:if test="${ !empty list }">
			</table>
<div class="middlebox">
      <div class="box2 scrollnone">
          <table class="colr_table2"  style="font-size: 13pt; text-align: center; ">
			<c:set var="num" value="${pageInfo.totalCount-pageInfo.beginRow+1}" />
				<c:forEach var="bb" items="${ list }">
					<tr style="border-bottom:1px solid #eee;">
					<td width="11%">${num }
		      		<c:set var="num" value="${num -1}" /></td>
						<td align="left" style=" width:48%;  text-align: left;">
							<c:set var="wid" value="0"/>
							<c:if test="${ bb.c_re_level > 0 }">
								<c:set var="wid" value="${bb.c_re_level * 20}"/>
								<img src="<%= request.getContextPath() %>/resources/image/level.gif" width="${wid}" height="20">
								<img src="<%= request.getContextPath() %>/resources/image/re.png" width="2%">
							</c:if>
								<a href="cBoardDetail.admin?c_num=${ bb.c_num }&pageNumber=${ pageInfo.pageNumber }" id="noneHigtLight">
									${ bb.c_subject }&nbsp;</a>
							<c:if test="${ bb.c_readcount >= 10 }">
								<img src="<%= request.getContextPath() %>/resources/image/hot.png" width="2%">
							</c:if>
						</td>
						<td width="11%">${ bb.c_writer }</td>
						<td width="11%">${ bb.c_email }</td>
						<td width="10%">
							<fmt:formatDate value="${bb.c_regdate}" pattern="yyyy-MM-dd"/>
						</td>
						<td>
								<input type="button" class="btn btn-white"  value="삭제하기" onClick="delBtn('${bb.c_num }','${ pageInfo.pageNumber }')">
		 				</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${ empty list }" >
				<tr>
					<td colspan="8">작성된 글이 없습니다.</td>
				</tr>
			</c:if>
		 </table>
		 </div></div></div></div>
        </div>
    </div>
    <br>
<br><br>
</article>


