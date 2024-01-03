<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	alert('${msg}');
	if('${msg}' === '탈퇴한 회원입니다.'){
		window.close();
	}
	if('${url}' === 'close'){
		window.close();
	}
	location.href = '${url}';
</script>