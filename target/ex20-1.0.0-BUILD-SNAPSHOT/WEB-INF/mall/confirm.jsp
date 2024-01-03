<%@page import="com.ctc.wstx.io.SystemId"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String destination = String.valueOf(session.getAttribute("destination"));
	String[] destinations;
	if(destination.contains("/")){ // redirect:/ 붙어서 들어오면 작동안해서 이렇게 설정해두었음
		destinations = destination.split("/");
		destination = destinations[1];
	}
%>

<script>
	if(confirm("장바구니에 추가되었습니다. 이동하시겠습니까?")){
		location.href = 'cartList.mall';
	} else {
		window.location.href = "<%=destination%>";
	}
</script>