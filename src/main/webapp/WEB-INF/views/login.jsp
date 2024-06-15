<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script>

	$(function(){
		$('#name').on('keyup', function(){
			this.value = this.value.replace(/[^ㄱ-ㅎ가-힣]/g, '').substring(0,84);
		});
		$('#phoneNum').on('keyup', function(){
			var value = this.value.replace(/[^0-9]/g, '').substring(0,11);
			if (value.substring(0, 3) !== "010") {
		            value = "010" + value.substring(3);
		    }
		    if (value.length > 7) {
		        value = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7);
		    }
			this.value = value;
		});
			
		
		$('#submit').on('click', function(){
			
			var name = $('#name').val();
			var phoneNum = $('#phoneNum').val();
			var key = name + phoneNum;
			
			var storageItem = localStorage.getItem(key);
			
			if(name == ""){
				alert('이름을 입력해주세요.');
				$('#name').focus();
				return false;
			}
			if( phoneNum == "" && name != ""){
				alert('전화번호를 입력해주세요.');
				$('#phoneNum').focus();
				return false;
			} else if(phoneNum.length < 13){
				alert('전화번호를 확인해주세요.');
				$('#phoneNum').focus();
				return false;
			}
			var data = {};
			data['rName'] = name;
			data['rPhoneNum'] = phoneNum
			
// 			console.log("미리찍어보는 콘솔 : ", JSON.stringify(data));
			 $.ajax({
					url : "/checkInfo.do",
				    type: "POST",
	 			    contentType: "application/json",
				    data : JSON.stringify(data),
//	 			    data : data,
				    success: function(response, textStatus, jqXHR)
				    {
	 	 			    console.log(response.success);
						window.location.href=response.success +'?name=' + name + '&phoneNum=' + phoneNum;
						
				    },
				    error: function (xhr, textStatus, error)
				    {
				    	alert("실패");
//	 			    	console.log("xhr : ", xhr.responseText);
				    	console.log("textStatus : ", textStatus);
				    	console.log("error : ", error);
				    }	
				
				});	

		});
		
		
		
		
	});

	

</script>
<body>

		
	<table align="center" border="1">
	
		<tr>
			<td>이름</td>
			<td><input id="name"/></td>
		</tr>
		<tr>
			<td>휴대폰번호</td>
			<td><input id="phoneNum" value="010"/></td>
		</tr>
		<tr>
			<td align="center" colspan="2"><input id="submit" type="button" value="입사지원" /></td>
		</tr>
	
	</table>


</body>
</html>