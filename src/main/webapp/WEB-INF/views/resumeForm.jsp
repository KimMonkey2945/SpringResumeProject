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
		
		var eduSeq = '';
	    var carSeq = '';
	    var certSeq = '';
	    			       
	    
	    if (eduSeq === null || eduSeq === undefined || eduSeq === '' || isNaN(eduSeq)) eduSeq = 1;
	    if (carSeq === null || carSeq === undefined || carSeq === '' || isNaN(carSeq)) carSeq = 1;
	    if (certSeq === null || certSeq === undefined || certSeq === '' || isNaN(certSeq)) certSeq = 1;
	
		$('#name').on('keyup', function(){
				this.value = this.value.replace(/[^ㄱ-ㅎ가-힣]/g, '').substring(0,84);
		});
		
		$('#birth').on('keyup', function(){
			this.value = this.value.replace(/[^0-9]/g, '').substring(0,84);
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
		
		var cleaned = "";
		$('#birth').on('keyup', function(){
		    cleaned = this.value.replace(/[^0-9]/g, '');
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
		            return;
		            // 값을 초기화하거나 이전 유효한 값으로 복원할 수 있음
		            cleaned = '';
		        } else {
		            cleaned = year + '-' + month + '-' + day;
		            cleanedMonth = year + '-' + month;
		        }
		    }
		    
		    var currentDateString = getCurrentDateString();
		    var CurrentDateStringMonth = getCurrentDateStringMonth();
		    $('#edStartPeriod').attr('min', cleaned);
		    $('#edStartPeriod').attr('max', currentDateString);
		    $('#caStartPeriod').attr('min', cleanedMonth);
		    $('#caStartPeriod').attr('max', CurrentDateStringMonth);
		    $('#acquDate').attr('min', cleaned);
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
	    });
		
			
		$('#caStartPeriod').on('change', function() {  	    
 		    var startDateStr = $(this).val();
 		   	var currentDateStringMonth = getCurrentDateStringMonth();
 		    $('#caEndPeriod').attr('min', startDateStr); 
 		   	$('#caEndPeriod').attr('max', currentDateStringMonth); 
 		    var caEndDateStr = $('#caEndPeriod').val(); 	    
		    
		});
		
		$('#acquDate').on('change', function() {  
			var currentDateStringMonth = getCurrentDateStringMonth();
			var birth = $('#birth').val()
 		    $('#acquDate').attr('min', birth); 
 		   	$('#acquDate').attr('max', currentDateString);    
		});
		
		$('#grade').on('focusout', function(){
			this.value = this.value.replace(/[^0-9.]/g, '').substring(0,84);
		});
		
		$(document).on('keyup', '#grade', function() {
			  var $this = $(this);
			  var inputValue = $this.val();
          	  var filteredValue = inputValue.replace(/[^0-9.]/g, '').substring(0, 84);
			  $this.val(filteredValue);
		});
		
		$(document).on('focusout', '#grade', function() {
			this.value = this.value.replace(/[^0-9.]/g, '').substring(0,84);
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
	            var allFieldsValid = true;
	            $(this).find('input:not(.educheck_):not(.educheck), select').each(function(){
	                var element = $(this);
	                var id = element.attr('id');
	                var value = element.val();
	                
	                if (id === 'eduSeq') {
	                    value = ++eduSeqCounter;
	                }
	                if(value == '' || value == null){
	                	allFieldsValid = false;
	                }
	                eduObj[id] = value;
	            });
	            if(allFieldsValid){
	            	obj.education.push(eduObj);	
	            }
	        });
			
	        var carSeqCounter = $('#carSeq').val();
	        this.find('tr[data-section="career"]').each(function(){
	            var carObj = {};
	            var allFieldsValid = true;
	            $(this).find('input:not(.carcheck_):not(.carcheck), select').each(function(){
	                var element = $(this);
	                var id = element.attr('id');
	                var value = element.val();
	                if(id === 'carSeq'){
	                	value = ++carSeqCounter;
	                }
	                if(value == '' || value == null){
	                	allFieldsValid = false;
	                }
	                carObj[id] = value;
	            });
	            if(allFieldsValid){
	            	obj.career.push(carObj);
	            }
	       	});
			
	        var cerSeqCounter = $('#certSeq').val();
	        this.find('tr[data-section="certification"]').each(function(){
	            var certObj = {};
	            var allFieldsValid = true;
	            $(this).find('input:not(.cercheck_):not(.cercheck), select').each(function(){
	                var element = $(this);
	                var id = element.attr('id');
	                var value = element.val();
	                if(id === 'certSeq'){
	                	value = ++cerSeqCounter;
	                }
	                if(value == '' || value == null){
	                	allFieldsValid = false;
	                }
	                certObj[id] = value;
	            });
	            if(allFieldsValid){
	            	obj.certification.push(certObj);
	            }
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

			    
		function validateCarTableInputs() {
		    var isValid = true; // 유효성 검사 결과를 저장할 변수

		    $('#carTable input[name="caStartPeriod"]').each(function() {
		        var $caStartPeriod = $(this);
		        var $row = $caStartPeriod.closest('tr');
		        var birth = $('#birth').val();
		        var birthMonth = '';

		        var year = birth.substring(0, 4);
		        var month = birth.substring(4, 6);

		        birthMonth = year + '-' + month;
		        console.log('저장버튼 후 : ', birthMonth);

		        if ($caStartPeriod.val() !== '' || $row.find('#caEndPeriod').val() !== '' || $row.find('#compName').val() !== ''
		            || $row.find('#task').val() !== '' || $row.find('#caLocation').val() !== '') {

		            var caStartDate = new Date($caStartPeriod.val());
		            var caEndDate = new Date($row.find('#caEndPeriod').val());

		            if ($caStartPeriod.val() === '') {
		                alert('근무기간을 입력해주세요.');
		                isValid = false;
		                $caStartPeriod.focus();
		                return false; // each 함수를 종료하기 위해 false 반환
		            }

		            if ($row.find('#caEndPeriod').val() === '') {
		                alert('근무기간을 입력해주세요.');
		                isValid = false;
		                $row.find('#caEndPeriod').focus();
		                return false; // each 함수를 종료하기 위해 false 반환
		            }

		            if ($caStartPeriod.val() < birthMonth) {
		                alert('생년월보다 근무기간이 빠를 수 없습니다. 근무기간을 확인해주세요.');
		                $row.find('#caStartPeriod').focus();
		                isValid = false;
		                return false; // each 함수를 종료하기 위해 false 반환
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

		            if (caStartDate > caEndDate) {
		                alert('근무기간을 확인해주세요.');
		                isValid = false;
		                $row.find('#caEndPeriod').focus();
		                return false;
		            }

		            // 중복 검사 함수
		            function checkOverlap(selector, section) {
		                var isOverlap = false;
		                $(selector).not($row).each(function() {
		                    var existingStart = new Date($(this).find(section + 'StartPeriod').val());
		                    var existingEnd = new Date($(this).find(section + 'EndPeriod').val());

		                    if (!isNaN(existingStart) && !isNaN(existingEnd)) {
		                        // 시작일과 종료일이 정확히 일치하는 경우는 중복으로 보지 않음
		                        if ((caStartDate <= existingEnd && caEndDate >= existingStart) &&
		                            !(caStartDate.getMonth() === existingEnd.getMonth() && caStartDate.getFullYear() === existingEnd.getFullYear()) &&
		                            !(caEndDate.getMonth() === existingStart.getMonth() && caEndDate.getFullYear() === existingStart.getFullYear())) {
		                            isOverlap = true;
		                            return false; // 중단
		                        }
		                    }
		                });
		                return isOverlap;
		            }

		            // 경력 중복 검사
		            if (checkOverlap('tr[data-section="career"]', '#ca')) {
		                alert('경력 기간이 기존 경력 기간과 겹칩니다.');
		                isValid = false;
		                return false;
		            }

		            // 학력 중복 검사
		            if (checkOverlap('tr[data-section="education"]', '#ed')) {
		                alert('경력 기간이 기존 학력 기간과 겹칩니다.');
		                isValid = false;
		                return false;
		            }
		        }
		    });

		    return isValid; // 유효성 검사 결과 반환
		}



		function validateEduTableInputs() {
		    var isValid = true; // 유효성 검사 결과를 저장할 변수

		    $('#eduTable input[name="edStartPeriod"]').each(function() {
		        var $edStartPeriod = $(this);
		        var $row = $edStartPeriod.closest('tr');
		        var birth = $('#birth').val();
		        var birthDate = '';

		        if (birth !== '') {
		            // birth를 yyyy-mm-dd 형식으로 변환
		            var year = birth.substring(0, 4);
		            var month = birth.substring(4, 6);
		            var day = birth.substring(6, 8);
		            birthDate = new Date(year + '-' + month + '-' + day);
		        } else {
		            birthDate = new Date(cleaned);
		        }

		        if ($edStartPeriod.val() !== '' || $row.find('#schoolName').val() !== '' || $row.find('#major').val() !== ''
		            || $row.find('#grade').val() !== '') {
		            
		            var edStartDate = new Date($edStartPeriod.val());
		            var edEndDate = new Date($row.find('#edEndPeriod').val());

		            if (edStartDate < birthDate) {
		                alert('재학기간을 확인해주세요.');
		                isValid = false;
		                $edStartPeriod.focus();
		                return false;
		            }
		            
		            if ($edStartPeriod.val() === '') {
		                alert('재학기간을 입력해주세요.');
		                isValid = false;
		                $edStartPeriod.focus();
		                return false;
		            }
		            
		            if ($row.find('#edEndPeriod').val() === '') {
		                alert('재학기간을 입력해주세요.');
		                isValid = false;
		                $row.find('#edEndPeriod').focus();
		                return false;
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
		            var gradeValue = $row.find('#grade').val();
		            if (!/^[0-9.]+$/.test(gradeValue)) {
		                alert('학점은 숫자만 입력가능합니다.');
		                $row.find('#grade').focus();
		                isValid = false;
		                return false;
		            }

		            if (edStartDate > edEndDate) {
		                alert("재학기간을 확인해주세요.");
		                isValid = false;
		                $row.find('#edEndPeriod').focus();
		                return false;
		            }

		            // 학력 중복 검사
		            function checkOverlap(selector, section) {
		                var isOverlap = false;
		                $(selector).not($row).each(function() {
		                    var existingStart = new Date($(this).find(section + 'StartPeriod').val());
		                    var existingEnd = new Date($(this).find(section + 'EndPeriod').val());

		                    if (!isNaN(existingStart) && !isNaN(existingEnd)) {
		                        // 시작일과 종료일이 정확히 일치하는 경우는 중복으로 보지 않음
		                        if ((edStartDate <= existingEnd && edEndDate >= existingStart) &&
		                            !(edStartDate.getMonth() === existingEnd.getMonth() && edStartDate.getFullYear() === existingEnd.getFullYear()) &&
		                            !(edEndDate.getMonth() === existingStart.getMonth() && edEndDate.getFullYear() === existingStart.getFullYear())) {
		                            isOverlap = true;
		                            return false; // 중단
		                        }
		                    }
		                });
		                return isOverlap;
		            }

		            // 학력 중복 검사
		            if (checkOverlap('#eduTable tr', '#ed')) {
		                alert('학력 기간이 기존 학력 기간과 겹칩니다.');
		                isValid = false;
		                return false;
		            }

		            // 경력 중복 검사
		            if (checkOverlap('tr[data-section="career"]', '#ca')) {
		                alert('학력 기간이 기존 경력 기간과 겹칩니다.');
		                isValid = false;
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
		        var birthDate = '';

		        if (birth !== '') {
		            // birth를 yyyy-mm-dd 형식으로 변환
		            var year = birth.substring(0, 4);
		            var month = birth.substring(4, 6);
		            var day = birth.substring(6, 8);
		            birthDate = new Date(year + '-' + month + '-' + day);
		        } else {
		            birthDate = new Date(cleaned);
		        }
		        
		        
		        if ($qualifiName.val() !== '' || $row.find('#qualifiName').val() !== '' || $row.find('#acquDate').val() !== '' || $row.find('#organizeName').val() !== '') {
		        	
		            if ($row.find('#acquDate').val() === '') {
		            	console.log('ce  birthDate : ', $row.find('#acquDate').val());
		        		console.log('birthDate : ', birthDate);
		            	alert('취득일을 입력해주세요.');
		                isValid = false;
		                $row.find('#acquDate').focus();
		                return false; // each 함수를 종료하기 위해 false 반환
		            }
		            var acDate = new Date($row.find('#acquDate').val());

		            if(acDate < birthDate){
		            	alert('취득일을 확인해주세요.');
		            	$row.find('#acquDate').focus();
		                isValid = false;
		                return false;
		            }
		            if ($row.find('#qualifiName').val() === '') {
		                alert('자격증명을 입력해주세요.');
		                isValid = false;
		                $row.find('#qualifiName').focus();
		                return false; 
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
	 	    if (birth.length < 8 || birth.length > 8) {
	 	    	alert('생년월일을 다시 입력해주세요 ex) 19990101');
	 	    	$('#birth').focus();
				return;
	 	    }
	 	    
	 	   if (birth.length == 8) {
	 	      var year = parseInt(birth.substring(0, 4), 10);
	 	      var month = parseInt(birth.substring(4, 6), 10);
	 	      var day = parseInt(birth.substring(6, 8), 10);

	 	      // 날짜 유효성 검사
	 	      if (isNaN(year) || isNaN(month) || isNaN(day) ||
	 	          month < 1 || month > 12 || // 월이 1부터 12 사이여야 함
	 	          day < 1 || day > 31 ||     // 일이 1부터 31 사이여야 함 (달에 따라 다를 수 있음)
	 	          (month === 4 || month === 6 || month === 9 || month === 11) && day > 30 || // 30일까지 있는 달
	 	          (month === 2 && (day > 29 || (day > 28 && !((year % 4 === 0) && (year % 100 !== 0)) || (year % 400 === 0)))) // 윤년 계산
	 	      ) {
	 	    	  alert('유효한 날짜를 입력해주세요.');
	 	          $('#birth').focus();
	 	          return;
	 	      }
		   }
	 		
	 		if (isValidEmail($('#email').val())) {
	  		}else {
  		       alert('이메일 형식이 틀립니다 : ex)아이디@email.com ');
  		     $('#email').focus()
  		       return; 
	  		}
	 		
// 	 		var gradeValue = $('#grade').val();
// 	 		console.log(gradeValue);
//             if (!/^[0-9.]+$/.test(gradeValue)) {
//                 alert('학점을 확인해주세요.');
//                 $('#grade').focus()
//                 return false;
//             }
			
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
	 		console.log("birth : ", birth);
	 	    if (birth.length < 8 || birth.length > 8) {
	 	        alert('생년월일을 다시 입력해주세요 ex) 19990101');
				return;
	 	    }
	 	    
	 		var year = parseInt(cleanded.substring(0, 4), 10);
	 	    var month = parseInt(cleanded.substring(4, 6), 10);
	 	    var day = parseInt(cleanded.substring(6, 8), 10);

	 	    // 날짜 유효성 검사
	 	    if (isNaN(year) || isNaN(month) || isNaN(day) ||
	 	        month < 1 || month > 12 || // 월이 1부터 12 사이여야 함
	 	        day < 1 || day > 31 ||     // 일이 1부터 31 사이여야 함 (달에 따라 다를 수 있음)
	 	        (month === 4 || month === 6 || month === 9 || month === 11) && day > 30 || // 30일까지 있는 달
	 	        (month === 2 && (day > 29 || (day > 28 && !((year % 4 === 0) && (year % 100 !== 0)) || (year % 400 === 0)))) // 윤년 계산
	 	    ) {
	 	    	alert('유효한 날짜를 입력해주세요.');
	 	    	$('#birth').focus();
	 	        return;
	 	    }	    
	 	    
            if (!/^[0-9.]+$/.test($('#grade').val())) {
                alert('학점을 확인해주세요.');
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

	        $('.edStartPeriod').attr('min', cleaned);
	        $('.edStartPeriod').attr('max', currentDateString);
	        $('.edEndPeriod').attr('max', currentDateString);
		 		
		});
		
		$('#carAdd').on('click', function(){
			var str = '';
			str +=	"<tr data-section='career'>"
			str += "<input type='hidden' id='carSeq' name='carSeq' value='${seq.carSeq}'>"
			str += "<input type='hidden' id='recruitCaSeq' name='recruitCaSeq' value='" + recruitSeq + "' />" 
			str += "<input type='hidden' id='salary' name='salary' value='0'>"
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

		        $('.caStartPeriod').attr('min', eduEnd);
		        $('.caStartPeriod').attr('max', currentDateStringMonth);
		        $('.caEndPeriod').attr('max', currentDateStringMonth);
			
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
		    var birth = $('#birth').val();
			
			var currentDateString = getCurrentDateString();		
	        $('.acquDate').attr('min', cleaned);
	        $('.acquDate').attr('max', currentDateString);
			
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
				<input type="hidden" id="salary" name="salary"value="0">	
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