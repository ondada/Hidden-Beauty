<%@page import="mall.model.KakaoApproveResponse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오페이결제완료</title>
</head>
<body>
카카오페이 결제가 정상적으로 완료되었습니다.<br>
결제일시: ${approvedAt}<br>
<%
KakaoApproveResponse kar = (KakaoApproveResponse)session.getAttribute("kao");
%>
결제내용: Hidden Beauty 상품<br>
결제금액: <%=kar.getAmount().getTotal()%>원<br>

</body>
</html>