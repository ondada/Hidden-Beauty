<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	body{
		text-align: center;
	}
	.formInput{
		border: 1px solid #D5D5D5;
		border-radius: 5px;
		padding: 5px;
		font-family: 'RIDIBatang';
		font-size: 10pt;
	}
	#thisTable{
		margin: auto;
		font-family: 'RIDIBatang';
		font-size: 11pt;
	}
	#thisTable th{
		padding-right: 10px;
	}
	#btn{
		padding: 6px 20px 6px 20px;
		border: 1px solid #D5D5D5;
		border-radius: 5px;
		background: white;
		font-family: 'RIDIBatang';
		font-size: 10pt;
	}
	#btn:hover{
		background: #7C81BB;
		color: white;
	}
	@font-face {
	    font-family: 'MaruBuri-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.0/MaruBuri-Regular.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	} 
	@font-face {
	    font-family: 'RIDIBatang'; 
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
</style>

<script>

</script>

<div style="font-family: 'MaruBuri-Regular'; font-size: 22pt; font-weight: bold; margin: 45px 0px 20px 0px;">
로그인이 불가능하신가요?
</div>

<div style="font-family: 'RIDIBatang'; font-size: 11pt; margin-bottom: 40px;">
게시글 신고가 누적될 경우 계정이 정지됩니다.<br>
아래 양식에 맞추어 소명해주시면 관리자 검토 후 정지를 풀어드릴게요.
<br><br>
<div style="font-size: 8pt; color: graytext;">
	네이버, 카카오 연동 계정은 개인정보 정책 상 저희쪽에서 로그인 아이디를 알 수 없습니다.<br>
	외부 사이트 연동 계정의 정지 해제 문의는 ssangyong@fyhd.com 으로 메일 부탁 드립니다.
</div>
</div>

<form action="ask.u" method="post">
	<table id="thisTable">
		<tr>
			<th>아이디</th>
			<td><input type="text" name="u_id" class="formInput" value="${param.u_id}" style="width: 265px;" maxlength="16" placeholder="정지된 아이디를 입력하세요." required></td>
		</tr>
		<tr> 
			<th>E-mail</th>
			<td><input type="email" name="u_email" class="formInput" value="${param.u_email}" style="width: 265px;" maxlength="20" placeholder="회신받을 이메일을 입력하세요." required></td>
		</tr>
		<tr>
			<th valign="top" style="padding-top: 5px;">의견소명</th> 
			<td><textarea class="formInput" name="rs_content" rows="10" cols="34" style="resize: none;" maxlength="100" placeholder="100자 이내로 입력하세요." required>${param.rs_content}</textarea></td>
		</tr>
	</table>
	<br>
	<input type="submit" id="btn" value="전송하기">
</form>

