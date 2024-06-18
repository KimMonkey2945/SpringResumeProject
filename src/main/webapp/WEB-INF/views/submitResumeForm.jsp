<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUTF-8">
<title>Insert title here</title>
</head>

<script>
	
	$(function(){
			
		$('input').prop('readonly', true);
		$('option').attr('disabled', true);
		
	});

</script>

<body>
	
	<h1>입사지원서</h1>
	<a href="/login.do" style="float: right; text-align: right;">HOME</a>
	<form id="resumeForm">
		<table border="1">

			<tr data-section="recruit">
				<input type="hidden" id="seq" value="${recruit.seq }">
				<input type="hidden" id="submit" value="1">	
				<td>이름</td>
				<td><input id="name" value="${recruit.name}"/></td>
				<td>생년월일</td>
				<td><input id="birth" value="${recruit.birth}"/></td>
			
			</tr>
			<tr data-section="recruit">
			
				<td>성별</td>
				<td>
					<select id="gender" name="gender">
						<option value="male" ${recruit.gender == 'male' ? 'selected' : ''}>남</option>
						<option value="female" ${recruit.gender == 'female' ? 'selected' : ''}>여</option>
					</select>
				</td>
				<td>연락처</td>
				<td><input id="phone" value="${recruit.phone}"/></td>
			
			</tr>
			<tr data-section="recruit">
			
				<td>email</td>
				<td><input id="email" value="${recruit.email}"/></td>
				<td>주소</td>
				<td><input id="addr" value="${recruit.addr}"/></td>
			
			</tr>
			<tr data-section="recruit">
			
				<td>희망근무지</td>
				<td>
					<select id="location" name="location">
						<option value="서울" ${recruit.location == '서울' ? 'selected' : ''}>서울</option>
						<option value="부산" ${recruit.location == '부산' ? 'selected' : ''}>부산</option>
						<option value="울산" ${recruit.location == '울산' ? 'selected' : ''}>울산</option>
						<option value="대구" ${recruit.location == '대구' ? 'selected' : ''}>대구</option>
						<option value="대전" ${recruit.location == '대전' ? 'selected' : ''}>대전</option>
						<option value="광주" ${recruit.location == '광주' ? 'selected' : ''}>광주</option>
						<option value="인천" ${recruit.location == '인천' ? 'selected' : ''}>인천</option>
					</select>
				</td>
				<td>근무형태</td>
				<td>
					<select id="workType" name="workType">
						<option value="정규직" ${recruit.workType == '정규직' ? 'selected' : ''}>정규직</option>
						<option value="계약직" ${recruit.workType == '계약직' ? 'selected' : ''}>계약직</option>
					</select>
				</td>
			
			</tr>
		
		
		</table>
		<table border="1" style="margin-top:10px">
			<tr>
				<td>학력사항</td>
				<td>경력사항</td>
				<td>희망연봉</td>
				<td>희망근무지/근무형태</td>
			</tr>
			<tr>
				<td>${eduPeriod}</td>
				<td>${carPeriod}</td>
				<c:forEach var="car" items="${career}" begin="0" end="0">
					<td>${car.salary}</td>
				</c:forEach>	
				<td>${recruit.location} <br> ${recruit.workType} </td>
			</tr>
		</table>
		
		<h2>학력</h2>
		
		<table id="eduTable" border="1" style="margin-top:10px">
		
			<tr>
				<td>재학기간</td>
				<td>구분</td>
				<td>학교명(소재지)</td>
				<td>전공</td>
				<td>학점</td>
			</tr>
			<c:forEach var="edu" items="${education}">
				<tr data-section="education">
					<input type="hidden" id="eduSeq" name="eduSeq" value="${edu.eduSeq}" />
					<input type="hidden" id="recruitEdSeq" name="recruitEdSeq" value="${recruit.seq}" />
					<td>
						<input type="date" id="edStartPeriod" name="edStartPeriod" value="${edu.edStartPeriod}"/>
						~
						<input type="date" id="edEndPeriod" name="edEndPeriod" value="${edu.edEndPeriod}"/>
					</td>
					<td>
						<select id="division" name="division">
							<option value="graduation" ${edu.division == 'graduation' ? 'selected' : ''}>졸업</option>
							<option value="enrolled" ${edu.division == 'enrolled' ? 'selected' : ''}>재학</option>
							<option value="dropout" ${edu.division == 'dropout' ? 'selected' : ''}>중퇴</option>
						</select>
					</td>
					<td>
						<input id="schoolName" value="${edu.schoolName}"/>
						<select id="edLocation" name="edLocation">
							<option value="서울" ${edu.edLocation == '서울' ? 'selected' : ''}>서울</option>
							<option value="인천" ${edu.edLocation == '인천' ? '인천' : ''}>인천</option>
							<option value="부산" ${edu.edLocation == '부산' ? '부산' : ''}>부산</option>
							<option value="울산" ${edu.edLocation == '울산' ? '울산' : ''}>울산</option>
							<option value="광주" ${edu.edLocation == '광주' ? '광주' : ''}>광주</option>
							<option value="대구" ${edu.edLocation == '대구' ? '대구' : ''}>대구</option>
							<option value="대전" ${edu.edLocation == '대전' ? '대전' : ''}>대전</option>
						</select>
					</td>
					<td><input id="major" name="major" value="${edu.major}"/></td>
					<td><input id="grade" name="grade" value="${edu.grade}"/></td>
				</tr>
			</c:forEach>
		
		</table>
		
		<h2>경력</h2>
		
		<table id="carTable" border="1" style="margin-top:10px">
		
			<tr >
				<td>근무기간</td>
				<td>회사명</td>
				<td>부서/직급/직책</td>
				<td>지역</td>
			</tr>
			<c:forEach var="car" items="${career}">
				<tr data-section="career">
						<input type="hidden" id="carSeq" name="carSeq" value="${car.carSeq}">
						<input type="hidden" id="recruitCaSeq" name="recruitCaSeq" value="${car.recruitCaSeq}">
						<input type="hidden" id="salary" name="salary" value="${car.salary}">		
						<td>
							<input type="month" id="caStartPeriod" name="caStartPeriod" value="${car.caStartPeriod}" />
							~
							<input type="month" id="caEndPeriod" name="caEndPeriod" value="${car.caEndPeriod}"/>
						</td>
						<td>
							<input id="compName" name="compName" value="${car.compName}"/>
						</td>
						<td><input id="task" name="task" value="${car.task}"/></td>
						<td><input id="caLocation" name="caLocation" value="${car.caLocation}"/></td>
				</tr>
			</c:forEach>
		
		</table>
		
		<h2>자격증</h2>
		
		<table id="cerTable" border="1" style="margin-top:10px; margin-bottom:30px">
		
			<tr>
				<td>자격증명</td>
				<td>취득일</td>
				<td>발행처</td>
			</tr>
			<c:forEach var="cer" items="${certification}">
				<tr data-section="certification">
						<input type="hidden" id="certSeq" name="certSeq" value="${cer.certSeq}">
						<input type="hidden" id="recruitCeSeq" name="recruitCeSeq" value="${cer.recruitCeSeq}">	
						<td>
							<input id="qualifiName" name="qualifiName" value="${cer.qualifiName}"/>
						</td>
						<td>
							<input type="date" id="acquDate" name="acquDate" value="${cer.acquDate}"/>
						</td>
						<td><input id="organizeName" name="organizeName" value="${cer.organizeName}"/></td>
				</tr>
			</c:forEach>
		
		</table>
		
	</form>	



</body>
</html>