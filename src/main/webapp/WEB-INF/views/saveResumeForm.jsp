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
	    var recruitSeq = $('#seq').val();
	    var eduSeq = parseInt($('#maxEdSeq').val()) + 1;
	    var carSeq = parseInt($('#maxCaSeq').val()) + 1;
	    var certSeq = parseInt($('#maxCeSeq').val()) + 1;
	    			        
	    
	    console.log("맨위 eduSeq : ", eduSeq);
	    console.log("맨위 carSeq : ", carSeq);
	    console.log("맨위 certSeq : ", certSeq);
	    
	    if (eduSeq === null || eduSeq === undefined || eduSeq === '' || isNaN(eduSeq)) eduSeq = 1;
	    if (carSeq === null || carSeq === undefined || carSeq === '' || isNaN(carSeq)) carSeq = 1;
	    if (certSeq === null || certSeq === undefined || certSeq === '' || isNaN(certSeq)) certSeq = 1;
	        	    
	    
	    $('#name').on('keyup', function(){
			this.value = this.value.replace(/[^ㄱ-ㅎ가-힣]/g, '').substring(0,84);
		});

		$('#birth').on('keyup', function(){
			this.value = this.value.replace(/[^0-9]/g, '').substring(0,8);
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
		var cleanedMonth = "";
		$('#birth').on('keyup', function(){			
			
		    cleaned = this.value.replace(/[^0-9]/g, '');
		    cleaned = cleaned.substring(0, 8);
		    
		    
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
		    
// 		    if(cleaned.length == 10){
// 		    	this.value = cleaned;
// 		    }
		    var currentDateString = getCurrentDateString();
		    var CurrentDateStringMonth = getCurrentDateStringMonth();
		    $('#edStartPeriod').attr('min', cleaned);
		    $('#edStartPeriod').attr('max', currentDateString);
		    $('#caStartPeriod').attr('min', cleanedMonth);
		    $('#caStartPeriod').attr('max', CurrentDateStringMonth);
		    $('#acquDate').attr('min', cleaned);
		    $('#acquDate').attr('max', currentDateString);
		    $('.edStartPeriod').attr('min', cleaned);
		    $('.edStartPeriod').attr('max', currentDateString);
		    $('.caStartPeriod').attr('min', cleanedMonth);
		    $('.caStartPeriod').attr('max', CurrentDateStringMonth);
		    $('.acquDate').attr('min', cleaned);
		    $('.acquDate').attr('max', currentDateString);
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
		
		$('#grade').on('keyup', function(){
			this.value = this.value.replace(/[^0-9.]/g, '').substring(0,84);
		});
		
		var currentDateString = getCurrentDateString();
		var birth = $('#birth').val()
	    $('#acquDate').attr('min', birth); 
	   	$('#acquDate').attr('max', currentDateString);    
		
		var currentDateStringMonth = getCurrentDateStringMonth();
		var nEdEndPeriod = $('#edEndPeriod').val();
		
		var endD = new Date(nEdEndPeriod);
		var edYear = endD.getFullYear();
		var edMonth = (endD.getMonth() + 1).toString().padStart(2,'0');
		var edYearMonth = edYear + '-' + edMonth

		$('#caStartPeriod').attr('min', edYearMonth);
		$('#caStartPeriod').attr('max', currentDateStringMonth); 
		$('#caEndPeriod').attr('max', currentDateStringMonth);
		
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
		
		$('#edEndPeriod').on('change', function() {
			var endDate = $(this).val();
			var endD = new Date(endDate);
			var edYear = endD.getFullYear();
			var edMonth = (endD.getMonth() + 1).toString().padStart(2,'0');
			var edYearMonth = edYear + '-' + edMonth
	 	    $('#caStartPeriod').attr('min', edYearMonth);
			
		});
		
		$(document).on('change', '#edStartPeriod', function() {
		    var startDate = $(this).val();
		    var $edEndPeriod = $(this).closest('tr').find('#edEndPeriod');
		    var currentDateString = getCurrentDateString();
		    
		    $edEndPeriod.attr('min', startDate);
		    $edEndPeriod.attr('max', currentDateString);
		    
		    var endDate = $edEndPeriod.val();
		    if (endDate > startDate) {
		        $edEndPeriod.val('');
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

		$(document).on('change', '#caStartPeriod', function() {
		    var startDate = $(this).val();
		    var $caEndPeriod = $(this).closest('tr').find('#caEndPeriod');    
		    $caEndPeriod.attr('min', startDate);
		    var endDate = $caEndPeriod.val();
		    if (endDate > startDate) {
		        $caEndPeriod.val('');
		    }  
		});
		
		$(document).on('change', '#edStartPeriod, #edEndPeriod', function() {
		    var $row = $(this).closest('tr');
		    var startDate = $row.find('#edStartPeriod').val();
		    var endDate = $row.find('#edEndPeriod').val();

		    // 시작일을 설정하면 해당 행의 종료일의 최소값을 설정
		    if (this.id === 'edStartPeriod') {
		        $row.find('#edEndPeriod').attr('min', startDate);
		    }

		    if (endDate && startDate && endDate < startDate) {
		        alert('종료일은 시작일 이후여야 합니다.');
		        $row.find('#edEndPeriod').val('');
		        return;
		    }

		    var isOverlap = false;

		    function compareYearMonth(date1, date2) {
		        var d1 = new Date(date1);
		        var d2 = new Date(date2);
		        return (d1.getFullYear() === d2.getFullYear() && d1.getMonth() === d2.getMonth());
		    }

		    // 학력과의 중복 검사
		    $('tr').not($row).each(function() {
		        var existingEdStart = $(this).find('#edStartPeriod').val();
		        var existingEdEnd = $(this).find('#edEndPeriod').val();

		        if (existingEdStart && existingEdEnd) {
		            // 새 학력이 기존 학력과 겹치는지 확인
		            if ((new Date(startDate) >= new Date(existingEdStart) && new Date(startDate) <= new Date(existingEdEnd)) ||
		                (new Date(endDate) >= new Date(existingEdStart) && new Date(endDate) <= new Date(existingEdEnd)) ||
		                (new Date(startDate) <= new Date(existingEdStart) && new Date(endDate) >= new Date(existingEdEnd))) {
		                isOverlap = true;
		                return false; // 중단
		            }
		        }
		    });

		    // 경력과의 중복 검사
		    $('tr[data-section="career"]').each(function() {
		        var caStart = $(this).find('#caStartPeriod').val();
		        var caEnd = $(this).find('#caEndPeriod').val();

		        if (caStart && caEnd) {
		            // 새 경력과 학력이 겹치는지 확인 (년도와 월까지만 비교)
		            if (compareYearMonth(startDate, caStart) || compareYearMonth(endDate, caEnd) ||
		                (new Date(startDate) <= new Date(caStart) && new Date(endDate) >= new Date(caEnd))) {
		                isOverlap = true;
		                return false; // 중단
		            }
		        }
		    });

		    if (isOverlap) {
		        alert('경력 기간이 기존 경력 또는 학력 기간과 겹칩니다.');
		        $(this).val(''); // 겹치는 경우 현재 입력한 값을 초기화
		    }
		});

		

		$(document).on('change', '#caStartPeriod, #caEndPeriod', function() {
			    var $row = $(this).closest('tr');
			    var startDate = $row.find('#caStartPeriod').val();
			    var endDate = $row.find('#caEndPeriod').val();
			
			    // 시작일을 설정하면 해당 행의 종료일의 최소값을 설정
			    if (this.id === 'caStartPeriod') {
			        $row.find('#caEndPeriod').attr('min', startDate);
			    }
			
			    if (endDate && startDate && endDate < startDate) {
			        alert('종료일은 시작일 이후여야 합니다.');
			        $row.find('#caEndPeriod').val('');
			        return;
			    }
			
			    var isOverlap = false;
			
			    function compareYearMonth(date1, date2) {
			        var d1 = new Date(date1);
			        var d2 = new Date(date2);
			        return (d1.getFullYear() === d2.getFullYear() && d1.getMonth() === d2.getMonth());
			    }
			
			    // 경력과의 중복 검사
			    $('tr[data-section="career"]').not($row).each(function() {
			        var existingCaStart = $(this).find('#caStartPeriod').val();
			        var existingCaEnd = $(this).find('#caEndPeriod').val();
			
			        if (existingCaStart && existingCaEnd) {
			            // 새 경력이 기존 경력과 겹치는지 확인
			            if (compareYearMonth(startDate, existingCaStart) || compareYearMonth(endDate, existingCaEnd) || 
			                (new Date(startDate) <= new Date(existingCaStart) && new Date(endDate) >= new Date(existingCaEnd))) {
			                isOverlap = true;
			                return false; // 중단
			            }
			        }
			    });
			
			    // 학력과의 중복 검사
			    $('tr[data-section="education"]').each(function() {
			        var eduStart = $(this).find('#edStartPeriod').val();
			        var eduEnd = $(this).find('#edEndPeriod').val();
			
			        if (eduStart && eduEnd) {
			            // 새 경력과 학력이 겹치는지 확인
			            if (compareYearMonth(startDate, eduStart) || compareYearMonth(endDate, eduEnd) || 
			                (new Date(startDate) <= new Date(eduStart) && new Date(endDate) >= new Date(eduEnd))) {
			                isOverlap = true;
			                return false; // 중단
			            }
			        }
			    });
			
			    if (isOverlap) {
			        alert('경력 기간이 기존 경력 또는 학력 기간과 겹칩니다.');
			        $(this).val(''); // 겹치는 경우 현재 입력한 값을 초기화
			    }
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

	        this.find('tr[data-section="education"]').each(function(){
	            var eduObj = {};
	            var allFieldsValid = true;
	            $(this).find('input:not(.educheck_):not(.educheck), select').each(function(){
	                var element = $(this);
	                var id = element.attr('id');
	                var value = element.val();
	                
	                if(id === 'eduSeq' && value == ''){
	                	value = eduSeq;
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
			
	       this.find('tr[data-section="career"]').each(function(){
	            var carObj = {};
	            var allFieldsValid = true;
	            $(this).find('input:not(.carcheck_):not(.carcheck), select').each(function(){
	                var element = $(this);
	                var id = element.attr('id');
	                var value = element.val();
	                if(id === 'carSeq' && value == ''){
	                	value = carSeq;
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
			
	        this.find('tr[data-section="certification"]').each(function(){
	            var certObj = {};
	            var allFieldsValid = true;
	            $(this).find('input:not(.cercheck_):not(.cercheck), select').each(function(){
	                var element = $(this);
	                var id = element.attr('id');
	                var value = element.val();
	                if(id === 'certSeq' && value == ''){
	                	value = certSeq;
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
			var eduDel = [];
		    var rowCount = $('#eduTable tr').length;
		    $('#eduTable .educheck:checked, #eduTable .educheck_:checked').each(function(){
		    	var checkEduSeq = $(this).closest('tr').find('#eduSeq').val();
		    	var maxEduSeq = $('#maxEdSeq').val();
		    	console.log('max값 : ', $('#maxEdSeq').val());
		    	console.log('동적추가 : ', checkEduSeq);
		    	
		    	if(maxEduSeq < checkEduSeq && rowCount > 2){
		    		$(this).closest('tr').remove();
		    		return;
		    	}else if(maxEduSeq >= checkEduSeq && rowCount <= 2){
		    		$(this).closest('tr').find('input, select').val('');
		    		return;
		    	}else{
		    		if(rowCount > 2){
						$('#eduTable .educheck:checked, #eduTable .educheck_:checked').each(function(){
							var del = $(this).closest('tr').find('input[type="hidden"][name="eduSeq"]').val();
					    	console.log(del);
					        eduDel.push({"eduSeq" : del});
					        $(this).closest('tr').remove();
					        
					    });
					}else{
						$('#eduTable .educheck:checked, #eduTable .educheck_:checked').each(function(){
							var del = $(this).closest('tr').find('input[type="hidden"][name="eduSeq"]').val();
					    	console.log(del);
					        eduDel.push({"eduSeq" : del});
					        $(this).closest('tr').find('input, select').val('');
					    });
					}
						console.log('JSON : ', JSON.stringify({education: eduDel}));
					    if(eduDel.length > 0){
					    	$.ajax({
								url : "/delete.do",
							    type: "POST",
				 			    contentType: "application/json",
							    data : JSON.stringify({education: eduDel}),
							    success: function(response, textStatus, jqXHR)
							    {
									
							    },
							    error: function (xhr, textStatus, error)
							    {
							    	alert("실패");
							    }	
							
							}); 
				    	} 
		    	}
		    	
		    	
		    });
 
		});

		
		$(document).on('click', '#carDel', function(){
			var carDel = [];
		    var rowCount = $('#carTable tr').length;
		    
		    $('#carTable .carcheck:checked, #carTable .carcheck_:checked').each(function(){
		    	var checkCarSeq = $(this).closest('tr').find('#carSeq').val();
		    	var maxCarSeq = $('#maxCaSeq').val();

// 			    console.log("maxCarSeq : ", maxCarSeq);
// 			    console.log("checkCarSeq : ", checkCarSeq);

		    	if(maxCarSeq < checkCarSeq && rowCount > 2){
		    		$(this).closest('tr').remove();
		    		return;
		    	}else if(maxCarSeq > checkCarSeq && rowCount <= 2){
		    		$(this).closest('tr').find('input, select').val('');
		    	}else{
		    		
					if(rowCount > 2){
						$('#carTable .carcheck:checked, #carTable .carcheck_:checked').each(function(){
					    	var del = $(this).closest('tr').find('input[type="hidden"][name="carSeq"]').val();
					    	console.log(del);
					    	carDel.push({"carSeq" : del});
					    	$(this).closest('tr').remove();
					    });	
					} else{
						$('#carTable .carcheck:checked, #carTable .carcheck_:checked').each(function(){
					    	var del = $(this).closest('tr').find('input[type="hidden"][name="carSeq"]').val();
					    	console.log(del);
					    	carDel.push({"carSeq" : del});
					    	$(this).closest('tr').find('input, select').val('');
					    });
					}
					
					console.log('JSON : ', JSON.stringify({career: carDel}));
				    if(carDel.length > 0){
				    	$.ajax({
							url : "/delete.do",
						    type: "POST",
			 			    contentType: "application/json",
						    data : JSON.stringify({career: carDel}),
						    success: function(response, textStatus, jqXHR)
						    {
								
						    },
						    error: function (xhr, textStatus, error)
						    {
						    	alert("실패");
						    }	
						
						});
				    }  
		    	}
		    });
			
		});
		
		$(document).on('click', '#cerDel', function(){
			var cerDel = [];
			var rowCount = $('#cerTable tr').length;
			
			$('#cerTable .cercheck:checked, #cerTable .cercheck_:checked').each(function(){
		    	var checkCertSeq = $(this).closest('tr').find('#certSeq').val();
		    	var maxCertSeq = $('#maxCeSeq').val();
		    	
		    	if(maxCertSeq < checkCertSeq && rowCount > 2){
		    		$(this).closest('tr').remove();
		    		return;
		    	}else if(maxCertSeq >= checkCertSeq && rowCount <= 2){
		    		$(this).closest('tr').find('input, select').val('');
		    		return;
		    	}else{
		    		if(rowCount > 2){
					    $('#cerTable .cercheck:checked, #cerTable .cercheck_:checked').each(function(){
					    	var del = $(this).closest('tr').find('input[type="hidden"][name="certSeq"]').val();
					    	console.log(del);
					    	cerDel.push({"certSeq" : del});
					    	$(this).closest('tr').remove();
					    });
					}else{
						$('#cerTable .cercheck:checked, #cerTable .cercheck_:checked').each(function(){
					    	var del = $(this).closest('tr').find('input[type="hidden"][name="certSeq"]').val();
					    	console.log(del);
					    	cerDel.push({"certSeq" : del});
					    	$(this).closest('tr').find('input, select').val('');
					    });
					}
				    console.log('JSON : ', JSON.stringify({certification: cerDel}));
				    if(cerDel.length > 0){
				    	$.ajax({
							url : "/delete.do",
						    type: "POST",
			 			    contentType: "application/json",
						    data : JSON.stringify({certification: cerDel}),
						    success: function(response, textStatus, jqXHR)
						    {
								
						    },
						    error: function (xhr, textStatus, error)
						    {
						    	alert("실패");
						    }	
						
						});
		    		}
		    	}  
			});
		});	
		
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

		        if ($edStartPeriod.val() !== '') {
		            var edStartDate = new Date($edStartPeriod.val());
		            
		            if (edStartDate < birthDate) {
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
		        		$row.find('#caStartPeriod').focus();
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
		        var birthDate = new Date(birth); 

		        if ($qualifiName.val() !== '') {
		            if ($row.find('#acquDate').val() === '') {
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
	 	    var birth = $('#birth').val();
	 	    if (birth.length < 8 || birth.length > 8) {
	 	        alert('생년월일을 다시 입력해주세요 ex) 19990101');
	 	       	$('#birth').focus();
				return;
	 	    }
	 	    
	 	   if(birth.length == 8){
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
		 	        alert('월은 최대 12, 일은 최대31까지 가능합니다.');
		 	    	$('#birth').focus();
		 	        return;
		 	    }
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
	 		
	 		if (isValidEmail($('#email').val())) {
	  		}else {
  		       alert('이메일 형식이 틀립니다 : ex)아이디@email.com ');
  		     $('#email').focus()
  		       return; 
	  		}
	 		
            if (!/^[0-9.]+$/.test($('#grade').val())) {
                alert('학점을 확인해주세요.');
                $('#grade').focus()
                return false;
            }
			
			var name = $('#name').val();
			var phone = $('#phone').val();
			var key = (name + phone);
			
		    var form = $(this).closest('#resumeForm');
		    var data = form.serializeAll();
		    
//  		    console.log(data);		    
		    console.log(JSON.stringify(data));
		    
		    $.ajax({
				url : "/saveFormUpdate.do",
			    type: "POST",
 			    contentType: "application/json",
			    data : JSON.stringify(data),
// 			    data : data,
			    success: function(response, textStatus, jqXHR)
			    {
// 	 			    console.log(response);
					alert(response.success);
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
	 	    if (birth.length < 8 || birth.length > 8) {
	 	        alert('생년월일을 다시 입력해주세요 ex) 19990101');
	 	       	$('#birth').focus();
				return;
	 	    }
	 	    if(birth.length == 8){
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
		 	        alert('정확한 생년월일을 입력해주세요.');
		 	    	$('#birth').focus();
		 	        return;
		 	    }
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
	 		
            if (!/^[0-9.]+$/.test($('#grade').val())) {
                alert('학점을 확인해주세요.');
                return false;
            }
	 		
	 		if (isValidEmail($('#email').val())) {
	  		}else {
  		       alert('이메일 형식이 틀립니다 : ex)아이디@email.com ');
  		     $('#email').focus()
  		       return; 
	  		}
			
			var name = $('#name').val();
			var phoneNum = $('#phone').val();
			var key = (name + phone);
			
		    var form = $(this).closest('#resumeForm');
		    form.find('tr[data-section="recruit"] input#submit').val(2);
		    var data = form.serializeAll();	    
		    console.log(JSON.stringify(data));
		    
		    $.ajax({
				url : "/saveFormUpdate.do",
			    type: "POST",
 			    contentType: "application/json",
			    data : JSON.stringify(data),
// 			    data : data,
			    success: function(response, textStatus, jqXHR)
			    {
	 			    alert('제출완료');
	 			   location.href = "/login.do";
// 					location.href="/submit.do?name=" + name + "&phoneNum=" + phoneNum;
					
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
			var newEduSeq = eduSeq + 1;
			eduSeq++;
		    
			var str = '';
			str +=      "<tr data-section='education'>";
			str += 			"<input type='hidden' id='eduSeq' name='eduSeq' value='" + newEduSeq + "'/>"
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

	        $('.edStartPeriod').attr('min', birth);
	        $('.edStartPeriod').attr('max', currentDateString);
	        $('.edEndPeriod').attr('max', currentDateString);
			 		
		});
		
		$('#carAdd').on('click', function(){
			var newCarSeq = carSeq + 1;
			carSeq++;
			
			var str = '';
			str +=	"<tr data-section='career'>"
			str += "<input type='hidden' id='carSeq' name='carSeq' value='" + newCarSeq + "'/>"
			str += "<input type='hidden' id='recruitCaSeq' name='recruitCaSeq' value='" + recruitSeq + "' />" 
			str +=          "<input type='hidden' id='salary' name='salary' value='0'>"	
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
	        var eduEnd = $('#edEndPeriod').val();
			
			
// 	        $('.caStartPeriod').attr('min', yearMonth);
	        $('.caStartPeriod').attr('max', currentDateStringMonth);
	        $('.caEndPeriod').attr('max', currentDateStringMonth);
			
	        
		});
		
		$('#cerAdd').on('click', function(){	
			var newCertSeq = certSeq + 1;
			certSeq++;
			
			var str = '';
			str +=	"<tr data-section='certification'>"
			str +=  "<input type='hidden' id='certSeq' name='certSeq' value='" + newCertSeq + "'/>"
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
	        $('.acquDate').attr('min', birth);
	        $('.acquDate').attr('max', currentDateString);
			
	        
		});
		
					
	});
				
		
</script>
<body>
	
	<h1>입사지원서</h1>
	<a href="/login.do" style="float: right; text-align: right;">HOME</a>
	<form id="resumeForm">
		<table border="1">
		<input input type="hidden" id="maxEdSeq" value="${seq.eduSeq}">
		<input input type="hidden" id="maxCaSeq" value="${seq.carSeq}">
		<input input type="hidden" id="maxCeSeq" value="${seq.certSeq}">


			<tr data-section="recruit">
				<input type="hidden" id="seq" value="${recruit.seq}">
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
			<c:choose>
			    <c:when test="${empty education}">
			        <tr data-section="education">
			            <input type="hidden" id="eduSeq" name="eduSeq" value="" />
			            <input type="hidden" id="recruitEdSeq" name="recruitEdSeq" value="${recruit.seq}" />
			            <td><input class="educheck" type="checkbox"/></td>
			            <td>
			                <input type="date" id="edStartPeriod" name="edStartPeriod" value=""/>
			                ~
			                <input type="date" id="edEndPeriod" name="edEndPeriod" value=""/>
			            </td>
			            <td>
			                <select id="division" name="division">
			                    <option value="졸업">졸업</option>
			                    <option value="재학">재학</option>
			                    <option value="중퇴">중퇴</option>
			                </select>
			            </td>
			            <td>
			                <input id="schoolName" value=""/>
			                <select id="edLocation" name="edLocation">
			                    <option value="서울">서울</option>
			                    <option value="인천">인천</option>
			                    <option value="부산">부산</option>
			                    <option value="울산">울산</option>
			                    <option value="광주">광주</option>
			                    <option value="대구">대구</option>
			                    <option value="대전">대전</option>
			                </select>
			            </td>
			            <td><input id="major" name="major" value=""/></td>
			            <td><input id="grade" name="grade" value=""/></td>
			        </tr>
			    </c:when>
			    <c:otherwise>
			        <c:forEach var="edu" items="${education}">
			            <tr data-section="education">
			                <input type="hidden" id="eduSeq" name="eduSeq" value="${edu.eduSeq}" />
			                <input type="hidden" id="recruitEdSeq" name="recruitEdSeq" value="${recruit.seq}" />
			                <td><input class="educheck" type="checkbox"/></td>
			                <td>
			                    <input type="date" id="edStartPeriod" name="edStartPeriod" value="${edu.edStartPeriod}"/>
			                    ~
			                    <input type="date" id="edEndPeriod" name="edEndPeriod" value="${edu.edEndPeriod}"/>
			                </td>
			                <td>
			                    <select id="division" name="division">
			                        <option value="졸업" ${edu.division == '졸업' ? 'selected' : ''}>졸업</option>
			                        <option value="재학" ${edu.division == 'enrolled' ? 'selected' : ''}>재학</option>
			                        <option value="중퇴" ${edu.division == 'dropout' ? 'selected' : ''}>중퇴</option>
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
			    </c:otherwise>
			</c:choose>
		
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
			<c:choose>
			    <c:when test="${empty career}">
			        <tr data-section="career">
			            <input type="hidden" id="carSeq" name="carSeq" value="" />
			            <input type="hidden" id="recruitCaSeq" name="recruitCaSeq" value="${recruit.seq}" />
			            <input type="hidden" id="salary" name="salary" value="0" />        
			            <td><input class="carcheck" type="checkbox" /></td>
			            <td>
			                <input type="month" id="caStartPeriod" name="caStartPeriod" value="" />
			                ~
			                <input type="month" id="caEndPeriod" name="caEndPeriod" value="" />
			            </td>
			            <td>
			                <input id="compName" name="compName" value="" />
			            </td>
			            <td><input id="task" name="task" value=""  placeholder="부서 / 직급 / 직책"//></td>
			            <td><input id="caLocation" name="caLocation" value="" /></td>
			        </tr>
			    </c:when>
			    <c:otherwise>
			        <c:forEach var="car" items="${career}">
			            <tr data-section="career">
			                <input type="hidden" id="carSeq" name="carSeq" value="${car.carSeq}" />
			                <input type="hidden" id="recruitCaSeq" name="recruitCaSeq" value="${car.recruitCaSeq}" />
			                <input type="hidden" id="salary" name="salary" value="${car.salary}" />        
			                <td><input class="carcheck" type="checkbox" /></td>
			                <td>
			                    <input type="month" id="caStartPeriod" name="caStartPeriod" value="${car.caStartPeriod}" />
			                    ~
			                    <input type="month" id="caEndPeriod" name="caEndPeriod" value="${car.caEndPeriod}" />
			                </td>
			                <td>
			                    <input id="compName" name="compName" value="${car.compName}" />
			                </td>
			                <td><input id="task" name="task" value="${car.task}" /></td>
			                <td><input id="caLocation" name="caLocation" value="${car.caLocation}" /></td>
			            </tr>
			        </c:forEach>
			    </c:otherwise>
			</c:choose>
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
			<c:choose>
			    <c:when test="${empty certification}">
			        <tr data-section="certification">
			            <input type="hidden" id="certSeq" name="certSeq" value="" />
			            <input type="hidden" id="recruitCeSeq" name="recruitCeSeq" value="${recruit.seq}" />    
			            <td><input class="cercheck" type="checkbox" /></td>
			            <td>
			                <input id="qualifiName" name="qualifiName" value="" />
			            </td>
			            <td>
			                <input type="date" id="acquDate" name="acquDate" value="" />
			            </td>
			            <td><input id="organizeName" name="organizeName" value="" /></td>
			        </tr>
			    </c:when>
			    <c:otherwise>
			        <c:forEach var="cer" items="${certification}">
			            <tr data-section="certification">
			                <input type="hidden" id="certSeq" name="certSeq" value="${cer.certSeq}" />
			                <input type="hidden" id="recruitCeSeq" name="recruitCeSeq" value="${cer.recruitCeSeq}" />    
			                <td><input class="cercheck" type="checkbox" /></td>
			                <td>
			                    <input id="qualifiName" name="qualifiName" value="${cer.qualifiName}" />
			                </td>
			                <td>
			                    <input type="date" class="acquDate" id="acquDate" name="acquDate" value="${cer.acquDate}" />
			                </td>
			                <td><input id="organizeName" name="organizeName" value="${cer.organizeName}" /></td>
			            </tr>
			        </c:forEach>
			    </c:otherwise>
			</c:choose>
		</table>
		
			<input id="save" type="button" value="저장"/>
			<input id="submit" type="button" value="제출"/>
	</form>	



</body>
</html>