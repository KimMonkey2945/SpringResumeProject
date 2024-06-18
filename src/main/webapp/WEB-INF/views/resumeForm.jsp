<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script>
	
	$(function(){
		
		// 각각 seq에 recruitSeq를 넣어준다.
		var seqValue = parseInt($('#seq').val());
		if (isNaN(seqValue)) seqValue = 0;
	    var recruitSeq = (parseInt(seqValue) + 1);
// 		console.log(recruitSeq);
		$('#seq').val(recruitSeq);
		$('#recruitEdSeq').val(recruitSeq);
		$('#recruitCaSeq').val(recruitSeq);
		$('#recruitCeSeq').val(recruitSeq);
		
		$('#name').on('keyup', function(){
				this.value = this.value.replace(/[^ㄱ-ㅎ가-힣]/g, '').substring(0,84);
		});
		
		// 현재날짜 구하기
		function getCurrentDateString() {
	       var currentDate = new Date();
	       var currentYear = currentDate.getFullYear();
	       var currentMonth = (currentDate.getMonth() + 1).toString().padStart(2, '0'); // 월을 2자리로 변환
	       var currentDay = currentDate.getDate().toString().padStart(2, '0'); // 일을 2자리로 변환
	       return currentYear + '-' + currentMonth + '-' + currentDay;
	    }
		// 현재날짜 월까지
		function getCurrentDateStringMonth() {
		    var currentDate = new Date();
	        var currentYear = currentDate.getFullYear();
	        var currentMonth = (currentDate.getMonth() + 1).toString().padStart(2, '0'); // 월을 2자리로 변환
	        var currentDay = currentDate.getDate().toString().padStart(2, '0'); // 일을 2자리로 변환
	        return currentYear + '-' + currentMonth;
	    }
		
		$('#birth').on('keyup', function(){
		    var cleaned = this.value.replace(/[^0-9]/g, '');
		    cleaned = cleaned.substring(0, 8);
		    var cleanedMonth = "";
		    if (cleaned.length >= 4) {
		        var year = cleaned.substring(0, 4); // 연도
		        var month = cleaned.substring(4, 6); // 월
		        var day = cleaned.substring(6, 8); // 일

		        // 현재 날짜 구하기
		        var currentDate = new Date();
		        var currentYear = currentDate.getFullYear();
		        var currentMonth = currentDate.getMonth() + 1; // getMonth()는 0부터 시작하므로 +1 해줌

		        // 입력된 생년월일과 현재 날짜 비교
		        if (parseInt(year) > currentYear ||
		            (parseInt(year) == currentYear && parseInt(month) > currentMonth) ||
		            (parseInt(year) == currentYear && parseInt(month) == currentMonth && parseInt(day) > currentDay)) {
		            // 입력된 생년월일이 현재 시간보다 미래인 경우 경고 메시지 표시
		            alert('생년월일은 현재 시간 이전이어야 합니다.');
		            // 값을 초기화하거나 이전 유효한 값으로 복원할 수 있음
		            cleaned = '';
		        } else {
		            // 월이 1 이상 12 이하의 값이어야 함
		            if (parseInt(month) > 12) {
		                month = '12'; // 월이 12보다 크면 최대값인 12로 설정
		            } else if (month === '00'){
		            	month = '01';
		            }

		            // 일이 1 이상 해당 월의 최대 일수 이하의 값이어야 함
		            var maxDays = new Date(year, month, 0).getDate(); // 해당 월의 마지막 날짜
		            if (parseInt(day) > maxDays) {
		                day = maxDays.toString(); // 일이 최대 날짜를 초과하면 최대 날짜로 설정
		            } else if(day === '00'){
		            	day = '01';
		            }

		            cleaned = year + '-' + month + '-' + day;
		            cleanedMonth = year + '-' + month;
		        }
		    }
		    if(cleaned.length == 10){
		    	this.value = cleaned;	
		    }
		    var currentDateString = getCurrentDateString();
		    var CurrentDateStringMonth = getCurrentDateStringMonth();
		    $('#edStartPeriod').attr('min', this.value);
		    $('#edStartPeriod').attr('max', currentDateString);
		    $('#caStartPeriod').attr('min', cleanedMonth);
		    $('#caStartPeriod').attr('max', CurrentDateStringMonth);
		    $('#acquDate').attr('min', this.value);
		    $('#acquDate').attr('max', currentDateString);
		});
		
		function isValidEmail(email) {
		    var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
		    return emailRegex.test(email);
		};
		
		$('#email').on('keyup', function() {
		    var email = this.value;
		    var cleanedEmail = email.replace(/[^a-zA-Z0-9._@-]/g, '').substring(0, 84);
		    // 유효하지 않은 문자를 제거한 이메일로 입력 필드 업데이트
		    if (email !== cleanedEmail) {
		        this.value = cleanedEmail;
		    }
		    
		});
		
		$('#addr').on('keyup', function(){
			this.value = this.value.replace( /[^\w가-힣-]/g, '').substring(0,84);
		});
		
		$('#edStartPeriod').on('change', function() {
	        var startDate = $(this).val();
		    var currentDateString = getCurrentDateString();
	        $('#edEndPeriod').attr('min', startDate);
	        $('#edEndPeriod').attr('max', currentDateString);
	        
	        var endDate = $('#edEndPeriod').val();
	        if (endDate > startDate) {
	            $('#edEndPeriod').val('');
	        }
	 	});
		
		$('#edEndPeriod').on('change', function() {
			var endDate = $(this).val();
			
			var endD = new Date(endDate);
			var edYear = endD.getFullYear();
			var edMonth = (endD.getMonth() + 1).toString().padStart(2,'0');
			var edYearMonth = edYear + '-' + edMonth
	 	    $('#caStartPeriod').attr('min', edYearMonth);
			
		});
			
		$('#caStartPeriod').on('change', function() {  	    
 		    var startDateStr = $(this).val();
 		   	var currentDateStringMonth = getCurrentDateStringMonth();
 		    $('#caEndPeriod').attr('min', startDateStr); 
 		   	$('#caEndPeriod').attr('max', currentDateStringMonth); 
 		    var caEndDateStr = $('#caEndPeriod').val(); 
		    
		    if (caEndDateStr) {
		        var endDate = new Date(startDateStr); 
		        var caEndDate = new Date(caEndDateStr); 
		        
		        if (caEndDate < endDate) { 
 		            $('#caEndPeriod').val('');
		        }
		    }
		    
		});
		
		$('#acquDate').on('change', function() {  
			var currentDateStringMonth = getCurrentDateStringMonth();
			var birth = $('#birth').val()
 		    $('#acquDate').attr('min', birth); 
 		   	$('#acquDate').attr('max', currentDateString);    
		});
		
		$('#grade').on('keyup', function(){
			this.value = this.value.replace(/[^0-9.]/g, '').substring(0,84);
		});
		
		var currentDateString = getCurrentDateString();
		var birth = $('#birth').val()
	    $('#acquDate').attr('min', birth); 
	   	$('#acquDate').attr('max', currentDateString);   
		
		$(document).on('change', '#edStartPeriod', function() {
		    var startDate = $(this).val();
		    
		    var $edEndPeriod = $(this).closest('tr').find('#edEndPeriod');    
		    $edEndPeriod.attr('min', startDate);
		    
		    var endDate = $edEndPeriod.val();
		    if (endDate > startDate) {
		        $edEndPeriod.val('');
		    }
		    
		    var $edStartPeriod = $(this);
		    var $row = $(this).closest('tr');
		    var $edEndPeriod = $row.find('#edEndPeriod');
		    var edStartVal = $edStartPeriod.val();
		
		    // 다른 경력의 시작일과 종료일과 비교하여 겹치지 않도록 검사
		    $('tr').not($row).each(function() {
		        var $existingEdStart = $(this).find('#edStartPeriod');
		        var $existingEdEnd = $(this).find('#edEndPeriod');
		        var existingEdStartVal = $existingEdStart.val();
		        var existingEdEndVal = $existingEdEnd.val();
		
		        if (existingEdEndVal && new Date(edStartVal) < new Date(existingEdEndVal)) {
		            alert('학력기간을 확인해주세요.');
		            $edStartPeriod.val('');
		            return false; // 검사 실패로 중단
		        }
		
		        if (existingEdStartVal && new Date(edStartVal) < new Date(existingEdStartVal)) {
		            alert('학력기간을 확인해주세요.');
		            $edStartPeriod.val('');
		            return false; // 검사 실패로 중단
		        }
		    });
		    
		});
		
		$(document).on('change', '#caStartPeriod', function() {
		    var startDate = $(this).val();
		    
		    var $caEndPeriod = $(this).closest('tr').find('#caEndPeriod');    
		    $caEndPeriod.attr('min', startDate);
		    
		    var endDate = $caEndPeriod.val();
		    if (endDate > startDate) {
		        $caEndPeriod.val('');
		    }
		    
		    var $caStartPeriod = $(this);
		    var $row = $(this).closest('tr');
		    var $caEndPeriod = $row.find('#caEndPeriod');
		    var caStartVal = $caStartPeriod.val();
		
		    // 다른 경력의 시작일과 종료일과 비교하여 겹치지 않도록 검사
		    $('tr').not($row).each(function() {
		        var $existingCaStart = $(this).find('#caStartPeriod');
		        var $existingCaEnd = $(this).find('#caEndPeriod');
		        var existingCaStartVal = $existingCaStart.val();
		        var existingCaEndVal = $existingCaEnd.val();
		
		        if (existingCaEndVal && new Date(caStartVal) < new Date(existingCaEndVal)) {
		            alert('새로 추가된 경력의 시작일은 다른 경력의 종료일 이후여야 합니다.');
		            $caStartPeriod.val('');
		            return false; // 검사 실패로 중단
		        }
		
		        if (existingCaStartVal && new Date(caStartVal) < new Date(existingCaStartVal)) {
		            alert('새로 추가된 경력의 시작일은 다른 경력의 시작일 이후여야 합니다.');
		            $caStartPeriod.val('');
		            return false; // 검사 실패로 중단
		        }
		    });
		    
		});
	
		
		jQuery.fn.serializeAll = function(){
			
			var obj = {
				recruit: {},
				education: [],
				career: [],
				certification: []

			};

			  // 각 섹션별로 요소를 가져와서 배열에 추가
	        this.find('tr[data-section="recruit"]').each(function(){
	            $(this).find('input, select').each(function(){
	                var element = $(this);
	                var id = element.attr('id');
	                var value = element.val();
	                obj.recruit[id] = value;
	            });
	        });

	        var eduSeqCounter = $('#eduSeq').val();
	        this.find('tr[data-section="education"]').each(function(){
	            var eduObj = {};
	            $(this).find('input:not(.educheck_):not(.educheck), select').each(function(){
	                var element = $(this);
	                var id = element.attr('id');
	                var value = element.val();
	                if (id === 'eduSeq') {
	                    value = ++eduSeqCounter;
	                    eduSeqCounter++;  
	                }
	                eduObj[id] = value;
	            });
	            obj.education.push(eduObj);
	        });
			
	        var carSeqCounter = $('#carSeq').val();
	        this.find('tr[data-section="career"]').each(function(){
	            var carObj = {};
	            $(this).find('input:not(.carcheck_):not(.carcheck), select').each(function(){
	                var element = $(this);
	                var id = element.attr('id');
	                var value = element.val();
	                if(id === 'carSeq'){
	                	value = ++carSeqCounter;
	                    carSeqCounter++;  
	                }
	                carObj[id] = value;
	            });
	            obj.career.push(carObj);
	        });
			
	        var cerSeqCounter = $('#certSeq').val();
	        this.find('tr[data-section="certification"]').each(function(){
	            var certObj = {};
	            $(this).find('input:not(.cercheck_):not(.cercheck), select').each(function(){
	                var element = $(this);
	                var id = element.attr('id');
	                var value = element.val();
	                if(id === 'certSeq'){
	                	value = ++cerSeqCounter;
	                    cerSeqCounter++;  
	                }
	                certObj[id] = value;
	            });
	            obj.certification.push(certObj);

	        });

			    return obj;
			
		};
		
		// 동적으로 만들어진 테이블에는 이벤트 리스너 연결
		$(document).on('click', '#eduDel', function(){
		    $('#eduTable .educheck_:checked').each(function(){
		        $(this).closest('tr').remove();
		    });
		});
		
		$(document).on('click', '#carDel', function(){
		    $('#carTable .carcheck_:checked').each(function(){
		        $(this).closest('tr').remove();
		    });
		});
		
		$(document).on('click', '#cerDel', function(){
		    $('#cerTable .cercheck_:checked').each(function(){
		        $(this).closest('tr').remove();
		    });
		});
		
		function validateEduTableInputs() {
		    var isValid = true; // 유효성 검사 결과를 저장할 변수

		    $('#eduTable input[name="edStartPeriod"]').each(function() {
		        var $edStartPeriod = $(this);
		        var $row = $edStartPeriod.closest('tr');
		        var birth = $('#birth').val();

		        if ($edStartPeriod.val() !== '') {
		            if ($row.find('#edEndPeriod').val() === '') {
		                alert('재학기간을 입력해주세요.');
		                isValid = false;
		                $row.find('#edEndPeriod').focus();
		                return false; // each 함수를 종료하기 위해 false 반환
		                if($row.find('#edEndPeriod').val() > birth){
		                	alert('재학기간을 입력해주세요.');
		                }
		            }
		        if($edStartPeriod.val() < birth){
		        	alert('재학기간을 확인해주세요.');
	                isValid = false;
	                $('#edStartPeriod').focus();
		        }
	            if ($row.find('#schoolName').val() === '') {
	                alert('학교이름을 입력해주세요.');
	                isValid = false;
	                $row.find('#schoolName').focus();
	                return false; 
	            }
	            if ($row.find('#major').val() === '') {
	                alert('전공을 입력해주세요.');
	                isValid = false;
	                $row.find('#major').focus();
	                return false; 
	            }
	            if ($row.find('#grade').val() === '') {
	                alert('학점을 입력해주세요.');
	                isValid = false;
	                $row.find('#grade').focus();
	                return false; 
	            }
	        }
		    });

		    return isValid; // 유효성 검사 결과 반환
		}
			    
		function validateCarTableInputs() {
		    var isValid = true; // 유효성 검사 결과를 저장할 변수

		    $('#carTable input[name="caStartPeriod"]').each(function() {
		        var $caStartPeriod = $(this);
		        var $row = $caStartPeriod.closest('tr');
		        var birth = $('#birth').val();

		        if ($caStartPeriod.val() !== '') {
		        	if ($row.find('#caEndPeriod').val() === '') {
		                alert('근무기간을 입력해주세요.');
		                isValid = false;
		                $row.find('#caEndPeriod').focus();
		                return false; // each 함수를 종료하기 위해 false 반환
		            }
		        	if($caStartPeriod.val() < birth){
		        		alert('근무기간을 확인해주세요.');
		                isValid = false;
		        	}
		            if ($row.find('#compName').val() === '') {
		                alert('회사이름을 입력해주세요.');
		                isValid = false;
		                $row.find('#compName').focus();
		                return false; // each 함수를 종료하기 위해 false 반환
		            }
		            if ($row.find('#task').val() === '') {
		                alert('부서/직급/직책을 입력해주세요.');
		                isValid = false;
		                $row.find('#task').focus();
		                return false; 
		            }
		            
		            var inputValue = $row.find('#task').val().trim();
		            var slashCount = (inputValue.match(/\//g) || []).length;
		            if (slashCount !== 2) {
		                alert('부서/직급/직책 형식으로 입력해주세요.');
		                isValid = false;
		                $row.find('#task').focus();
		                return false;
		            }
		            
		            if ($row.find('#caLocation').val() === '') {
		                alert('근무지역을 입력해주세요.');
		                isValid = false;
		                $row.find('#caLocation').focus();
		                return false; 
		            }
		        }
		    });

		    return isValid; // 유효성 검사 결과 반환
		}
		
		function validateCerTableInputs() {
		    var isValid = true; // 유효성 검사 결과를 저장할 변수

		    $('#cerTable input[name="qualifiName"]').each(function() {
		        var $qualifiName = $(this);
		        var $row = $qualifiName.closest('tr');
		        var birth = $('#birth').val();

		        if ($qualifiName.val() !== '') {
		            if ($row.find('#acquDate').val() === '') {
		                alert('취득일을 입력해주세요.');
		                isValid = false;
		                $row.find('#acquDate').focus();
		                return false; // each 함수를 종료하기 위해 false 반환
		            }
		            if($row.find('#acquDate').val() < birth){
		            	alert('취득일을 확인해주세요.');
		                isValid = false;
		            }
		            if ($row.find('#organizeName').val() === '') {
		                alert('발행처를 입력해주세요.');
		                isValid = false;
		                $row.find('#organizeName').focus();
		                return false; 
		            }
		        }
		    });

		    return isValid; // 유효성 검사 결과 반환
		}

		
		$(document).on('click', '#save', function() {
			
			if($('#name').val() == ""){
	 			alert('이름을 입력해주세요.');
	 			$('#name').focus();
	 			return false;
	 		}
	 		if($('#birth').val() == ""){
	 			alert('생년월일을 입력해주세요.');
	 			$('#birth').focus();
	 			return false;
	 		}
	 		if($('#email').val() == ""){
	 			alert('이메일을 입력해주세요.');
	 			$('#email').focus();
	 			return false;
	 		}
	 		if($('#addr').val() == ""){
	 			alert('주소를 입력해주세요.');
	 			$('#addr').focus();
	 			return false;
	 		}
	 		if($('#edStartPeriod').val() == ""){
	 			alert('재학기간을 입력해주세요.');
	 			$('#edStartPeriod').focus();
	 			return false;
	 		}
	 		
	 		if (!validateEduTableInputs()) {
	 	        return false;
	 	    }
			if (!validateCarTableInputs()) {
	 	        return false;
	 	    }
	 		if (!validateCerTableInputs()) {
	 	        return false;
	 	    }
	 		var birth = $('#birth').val();
	 	    if (birth.length !== 10) {
	 	    	alert('생년월일을 다시 입력해주세요 ex) 1999-01-01');
	 	    	$('#birth').focus();
				return;
	 	    }
	 		
	 		if (isValidEmail($('#email').val())) {
	  		}else {
  		       alert('이메일 형식이 틀립니다 : ex)아이디@email.com ');
  		     $('#email').focus()
  		       return; 
	  		}
			
			var name = $('#name').val();
			var phone = $('#phone').val();
			var key = (name + phone);
			
		    var form = $(this).closest('#resumeForm');
		    var data = form.serializeAll();
		    
//  		    console.log(data);		    
		    console.log(JSON.stringify(data));
		    
		    $.ajax({
				url : "/insertResume.do",
			    type: "POST",
 			    contentType: "application/json",
			    data : JSON.stringify(data),
// 			    data : data,
			    success: function(response, textStatus, jqXHR)
			    {
// 			    	alert(response.success);
					alert('저장완료');
					window.location.href="/login.do";
					
			    },
			    error: function (xhr, textStatus, error)
			    {
			    	alert("실패");
// 			    	console.log("xhr : ", xhr.responseText);
			    	console.log("textStatus : ", textStatus);
			    	console.log("error : ", error);
			    }	
			
			});

		});
		
		$(document).on('click', '#submit', function() {
			
	 		if($('#name').val() == ""){
	 			alert('이름을 입력해주세요.');
	 			$('#name').focus();
	 			return false;
	 		}
	 		if($('#birth').val() == ""){
	 			alert('생년월일을 입력해주세요.');
	 			$('#birth').focus();
	 			return false;
	 		}
	 		if($('#email').val() == ""){
	 			alert('이메일을 입력해주세요.');
	 			$('#email').focus();
	 			return false;
	 		}
	 		if($('#addr').val() == ""){
	 			alert('주소를 입력해주세요.');
	 			$('#addr').focus();
	 			return false;
	 		}
	 		if($('#edStartPeriod').val() == ""){
	 			alert('재학기간을 입력해주세요.');
	 			$('#edStartPeriod').focus();
	 			return false;
	 		}
	 	    var birth = $('#birth').val();
	 	    if (birth.length !== 10) {
	 	        alert('생년월일을 다시 입력해주세요 ex) 1999-01-01');
				return;
	 	    }

			if (!validateEduTableInputs()) {
	 	        return false;
	 	    }
			if (!validateCarTableInputs()) {
	 	        return false;
	 	    }
	 		if (!validateCerTableInputs()) {
	 	        return false;
	 	    }	
			
			var name = $('#name').val();
			var phone = $('#phone').val();
			var key = (name + phone);
			
		    var form = $(this).closest('#resumeForm');
		    form.find('tr[data-section="recruit"] input#submit').val(2);
		    var data = form.serializeAll();
		    
//  		    console.log(data);		    
		    console.log(JSON.stringify(data));
		    
		    $.ajax({
				url : "/insertResume.do",
			    type: "POST",
 			    contentType: "application/json",
			    data : JSON.stringify(data),
// 			    data : data,
			    success: function(response, textStatus, jqXHR)
			    {
			    	alert('제출완료');
// 					location.href="/submit.do?name=" + name + "&phone=" + phone;
			    	location.href="/login.do";
					
			    },
			    error: function (xhr, textStatus, error)
			    {
			    	alert("실패");
// 			    	console.log("xhr : ", xhr.responseText);
			    	console.log("textStatus : ", textStatus);
			    	console.log("error : ", error);
			    }	
			
			});

		});
		
		
		$('#eduAdd').on('click', function(){			
			var str = '';
			str +=      "<tr data-section='education'>";
			str += 			"<input type='hidden' id='eduSeq' name='eduSeq' value='${seq.eduSeq}'>"
			str += 			"<input type='hidden' id='recruitEdSeq' name='recruitEdSeq' value='" + recruitSeq + "' />" 
			str += 			"<td><input class='educheck_' type='checkbox'/></td>"
			str += 			"<td>"
			str += 				"<input type='date' class='edStartPeriod' id='edStartPeriod' name='edStartPeriod' />"
			str += 				"~"
			str += 				"<input type='date' class='edEndPeriod' id='edEndPeriod' name='edEndPeriod'/>"
			str += 			"</td>"
			str += 			"<td>"
			str += 				"<select id='division' name='division'>"
			str += 					"<option value='졸업'>졸업</option>"
			str += 					"<option value='재학'>재학</option>"
			str += 					"<option value='중퇴'>중퇴</option>"
			str += 				"</select>"
			str += 			"</td>"
			str += 			"<td>"
			str += 				"<input id='schoolName' name='schoolName' />"
			str += 				"<select id='edLocation' name='edLocation'>"
			str += 					    "<option value='서울'>서울</option>"
			str +=						"<option value='인천'>인천</option>"
			str +=						"<option value='부산'>부산</option>"
			str +=						"<option value='대구'>대구</option>"
			str +=						"<option value='대전'>대전</option>"
			str +=						"<option value='광주'>광주</option>"
			str +=						"<option value='울산'>울산</option>"
			str += 				"</select>"
			str += 			"</td>"
			str += 			"<td><input id='major' name='major'/></td>"
			str += 			"<td><input id='grade' name='grade'/></td>"
			str += 		"</tr>"	
			
			$('#eduTable').append(str);
			
			 var currentDateString = getCurrentDateString();
		     var birth = $('#birth').val();
//	 	        console.log(birth);

	        $('.edStartPeriod:last').attr('min', birth);
	        $('.edStartPeriod:last').attr('max', currentDateString);
	        $('.edEndPeriod:last').attr('max', currentDateString);
		 		
		});
		
		$('#carAdd').on('click', function(){
			var str = '';
			str +=	"<tr data-section='career'>"
			str += "<input type='hidden' id='carSeq' name='carSeq' value='${seq.carSeq}'>"
			str += "<input type='hidden' id='recruitCaSeq' name='recruitCaSeq' value='" + recruitSeq + "' />" 
			str +=		"<td><input class='carcheck_' type='checkbox'/></td>"
			str +=		"<td>"
			str +=			"<input type='month' class='caStartPeriod' id='caStartPeriod' name='caStartPeriod' />"
			str +=			"~"
			str +=			"<input type='month' class='caEndPeriod' id='caEndPeriod' name='caEndPeriod'/>"
			str +=		"</td>"
			str +=		"<td>"
			str +=			"<input id='compName' name='compName'/>"
			str +=		"</td>"
			str +=		"<td><input id='task' name='task' placeholder='부서 / 직급 / 직책'/></td>"
			str +=		"<td><input id='caLocation' name='caLocation'/></td>"
			str +=	"</tr>"
			
			$('#carTable').append(str);
			
			   var currentDateString = getCurrentDateString();
			   var currentDateStringMonth = getCurrentDateStringMonth();
		       var birth = $('#birth').val();
		       var eduEnd = $('#edEndPeriod').val();
//	 	        console.log(birth);

		        $('.caStartPeriod:last').attr('min', eduEnd);
		        $('.caStartPeriod:last').attr('max', currentDateStringMonth);
		        $('.caEndPeriod:last').attr('max', currentDateStringMonth);
			
		});
		
		$('#cerAdd').on('click', function(){
			
			var str = '';
		
			str +=	"<tr data-section='certification'>"
			str +=  "<input type='hidden' id='certSeq' name='certSeq' value='${seq.certSeq}'>"
			str +=  "<input type='hidden' id='recruitCeSeq' name='recruitCeSeq' value='" + recruitSeq + "' />" 
			str +=		"<td><input class='cercheck_' type='checkbox'/></td>"
			str +=		"<td>"
			str +=			"<input id='qualifiName' name='qualifiName' />"
			str +=		"</td>"
			str +=		"<td>"
			str +=			"<input type='date' class='acquDate' id='acquDate' name='acquDate'/>"
			str +=		"</td>"
			str +=		"<td><input id='organizeName' name='organizeName'/></td>"
			str +=	"</tr>"
			
			$('#cerTable').append(str);
			
			var currentDateString = getCurrentDateString();
	        var birth = $('#birth').val();			
	        $('.acquDate:last').attr('min', birth);
	        $('.acquDate:last').attr('max', currentDateString);
			
		});
					
	});
				
		
</script>
<body>
	
	<h1>입사지원서</h1>
	<a href="/login.do" style="float: right; text-align: right;">HOME</a>
	<form id="resumeForm">
		<table border="1">
			
			<tr data-section="recruit">
				<input type="hidden" id="seq" value="${seq.seq}">
				<input type="hidden" id="submit" value="1">		
				<td>이름</td>
				<td><input id="name" value="${name}"/></td>
				<td>생년월일</td>
				<td><input id="birth"/></td>
					
			</tr>
			<tr data-section="recruit">
			
				<td>성별</td>
				<td>
					<select id="gender" name="gender">
						<option value="male">남</option>
						<option value="female">여</option>
					</select>
				</td>
				<td>연락처</td>
				<td><input id="phone" value="${phoneNum}"/></td>
			
			</tr>
			<tr data-section="recruit">
			
				<td>email</td>
				<td><input id="email"/></td>
				<td>주소</td>
				<td><input id="addr"/></td>
			
			</tr>
			<tr data-section="recruit">
			
				<td>희망근무지</td>
				<td>
					<select id="location" name="location">
						<option value="서울">서울</option>
						<option value="인천">인천</option>
						<option value="부산">부산</option>
						<option value="대구">대구</option>
						<option value="대전">대전</option>
						<option value="광주">광주</option>
						<option value="울산">울산</option>
					</select>
				</td>
				<td>근무형태</td>
				<td>
					<select id="workType" name="workType">
						<option value="정규직">정규직</option>
						<option value="계약직">계약직</option>
					</select>
				</td>
			
			</tr>
		
		
		</table>
		
		<h2>학력</h2>
		<input id="eduAdd" type="button" value="추가"/>
		<input id="eduDel" type="button" value="삭제"/>
		
		<table id="eduTable" border="1" style="margin-top:10px">
		
			<tr>
				<td></td>
				<td>재학기간</td>
				<td>구분</td>
				<td>학교명(소재지)</td>
				<td>전공</td>
				<td>학점</td>
			</tr>
			<tr data-section="education">
				<input type="hidden" id="eduSeq" name="eduSeq" value="${seq.eduSeq}">
				<input type="hidden" id="recruitEdSeq" name="recruitEdSeq" value="">
				<td><input class="educheck" type="checkbox"/></td>
				<td>
					<input type="date" id="edStartPeriod" name="edStartPeriod"/>
					~
					<input type="date" id="edEndPeriod" name="edEndPeriod"/>
				</td>
				<td>
					<select id="division" name="division">
						<option value="졸업">졸업</option>
						<option value="재학">재학</option>
						<option value="중퇴" >중퇴</option>
					</select>
				</td>
				<td>
					<input id="schoolName"/>
					<select id="edLocation" name="edLocation">
						<option value="서울">서울</option>
						<option value="인천">인천</option>
						<option value="부산">부산</option>
						<option value="대구">대구</option>
						<option value="대전">대전</option>
						<option value="광주">광주</option>
						<option value="울산">울산</option>
					</select>
				</td>
				<td><input id="major" name="major"/></td>
				<td><input id="grade" name="grade"/></td>
			</tr>
			
		
		</table>
		
		<h2>경력</h2>
		<input id="carAdd" type="button" value="추가"/>
		<input id="carDel" type="button" value="삭제"/>
		
		<table id="carTable" border="1" style="margin-top:10px">
		
			<tr >
				<td></td>
				<td>근무기간</td>
				<td>회사명</td>
				<td>부서/직급/직책</td>
				<td>지역</td>
			</tr>
			<tr data-section="career">
				<input type="hidden" id="carSeq" name="carSeq" value="${seq.carSeq}">
				<input type="hidden" id="recruitCaSeq" name="recruitCaSeq"value="">	
				<input type="hidden" id="salary" name="salary"value="">	
				<td><input class="carcheck" type="checkbox"/></td>
				<td>
					<input type="month" id="caStartPeriod" name="caStartPeriod" />
					~
					<input type="month" id="caEndPeriod" name="caEndPeriod"/>
				</td>
				<td>
					<input id="compName" name="compName"/>
				</td>
				<td><input id="task" name="task" placeholder="부서 / 직급 / 직책"/></td>
				<td><input id="caLocation" name="caLocation"/></td>
			</tr>
		
		</table>
		
		<h2>자격증</h2>
		<input id="cerAdd" type="button" value="추가"/>
		<input id="cerDel" type="button" value="삭제"/>
		
		<table id="cerTable" border="1" style="margin-top:10px; margin-bottom:30px">
		
			<tr>
				<td></td>
				<td>자격증명</td>
				<td>취득일</td>
				<td>발행처</td>
			</tr>
			<tr data-section="certification">
				<input type="hidden" id="certSeq" name="certSeq" value="${seq.certSeq}">
				<input type="hidden" id="recruitCeSeq" name="recruitCeSeq" value="">	
				<td><input class="cercheck" type="checkbox"/></td>
				<td>
					<input id="qualifiName" name="qualifiName"/>
				</td>
				<td>
					<input type="date" id="acquDate" name="acquDate"/>
				</td>
				<td><input id="organizeName" name="organizeName"/></td>
			</tr>
		
		</table>
		
			<input id="save" type="button" value="저장"/>
			<input id="submit" type="button" value="제출"/>
	</form>	


</body>
</html>