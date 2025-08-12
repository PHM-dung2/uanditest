<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<title>SB Admin 2 - Register</title>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <!-- Custom fonts for this template-->
    <link
      href="/resources/vendor/fontawesome-free/css/all.min.css"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet"
    />
    
    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet" />
    
    <!-- jquery -->
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    

</head>
<body class="bg-gradient-primary">
  <div class="container">
    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
              </div>
              
              <form id="join_form" class="user" >
                <div class="form-group">
                  <input
                    id="user_name"
                    name="user_name"
                    type="text"
                    class="form-control form-control-user"
                    placeholder="이름"
                    maxlength="10"
                  />
                  <div class="name_isvaild" 
                    style="color: red; font-size: 12px; margin:12px 0px 0px 12px; "> 
                  </div>
                </div>
                <div class="form-group row">
                  <div class="col-sm-9 mb-3 mb-sm-0">
                    <input
                      id="user_email"
                      name="user_email"
                      type="text"
                      class="form-control form-control-user"
                      placeholder="이메일주소"
                    />
                  </div>
                  <div class="col-sm-3">
                    <a
                      href="#"
                      id="email_button"
                      class="btn btn-primary btn-user btn-block"
                    >
                      중복확인
                    </a>
                  </div>
                </div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input
                      id="user_password"
                      name="user_password"
                      type="password"
                      class="form-control form-control-user"
                      placeholder="비밀번호"
                    />
                  </div>
                  <div class="col-sm-6">
                    <input
                      id="user_password_check"
                      type="password"
                      class="form-control form-control-user"
                      placeholder="비밀번호 확인"
                    />
                  </div>
                </div>
                <div class="form-group">
                  <input
                    id="user_phone_num"
                    name="user_phone_num"
                    type="tel"
                    class="form-control form-control-user"
                    maxlength="13"
                    placeholder="휴대폰번호"
                  />
                </div>
                <div class="form-group row">
                  <div class="col-sm-9 mb-3 mb-sm-0">
                    <input
                      id="user_road_address"
                      name="user_road_address"
                      type="text"
                      class="form-control form-control-user"
                      placeholder="주소"
                      readonly
                    />
                  </div>
                  <div class="col-sm-3">
                    <a
                      href="javascript:daumPostcode();"
                      class="btn btn-primary btn-user btn-block"
                    >
                      주소찾기
                    </a>
                  </div>
                </div>
                <div class="form-group">
                  <input
                    id="user_detail_address"
                    name="user_detail_address"
                    type="text"
                    class="form-control form-control-user"
                    placeholder="상세주소"
                  />
                </div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input
                      id="user_zonecode"
                      name="user_zonecode"
                      type="text"
                      class="form-control form-control-user"
                      placeholder="우편번호"
                      readonly
                    />
                  </div>
                  <div class="col-sm-6">
                    <input
                      id="user_refer_address"
                      name="user_refer_address"
                      type="text"
                      class="form-control form-control-user"
                      placeholder="참고사항"
                      readonly
                    />
                  </div>
                </div>

                <a
                  id="join_button"
                  href="#"
                  class="btn btn-primary btn-user btn-block"
                >
                  Register Account
                </a>
              </form>
              
              <hr />
              <div class="text-center">
                <a class="small" href="/login"
                  >Already have an account? Login!</a
                >
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <script>
  
	  // 정규식
	  
	  // 중복체크
	  let isNameChecked = false;
	  let isEmailChecked = false;
	  let isPasswordChecked = false;
	  let isCheckPasswordChecked = false;
	  let isMatchedPasswordChecked = false;
	  let isPhoneChecked = false;
	  
	  // 이름(특수문자, 한글 입력 불가)
	  let isComposing = false;
	  
	  $("#user_name")
		  .on("compositionstart", function () {
		    isComposing = true;
		  })
		  .on("compositionend", function () {
		    isComposing = false;
		    // 한글이 완성되고 난 직후 처리
		    const filtered = $(this).val().replace(/[^a-zA-Z0-9]/g, '');
		    $(this).val(filtered);
		  })
		  .on("input", function () {
		    if (!isComposing) {
		      const filtered = $(this).val().replace(/[^a-zA-Z0-9]/g, '');
		      $(this).val(filtered);
		    }
	    })
		  
		  // 이름(focus 이동시 사용가능여부 출력)
		  .change(function(){
			  const name = $("#user_name").val();
		    const name_invailed = document.querySelector(".name_isvaild");
		    isNameChecked = false;
		    
		    // 이름 정규식
		    if( !isVaildName(name) ){
		    	name_invailed.innerHTML = "사용 불가능한 닉네임입니다."; 
          isNameChecked = false;
		    }
		    
		    // 데이터 전달할 떄는 get 안씀!
		    $.ajax({
	        type: "post",
	        url: "/nameCheck",
	        data : { name : name },
	        dataType : "json",
	        success: function(res) {
	          console.log("response : ", res);
	          
	          if( res === false ) { 
	        	  name_invailed.innerHTML = "사용 불가능한 닉네임입니다."; 
	        	  isNameChecked = false;
        	  }
	          else{ 
	        	  name_invailed.innerHTML = "사용 가능한 닉네임입니다.";
	        	  isNameChecked = true;
        	  }
	          
	        },
	        error: function(err) {
       	    name_invailed.innerHTML = "닉네임 조회 실패. 관리자에게 문의해주세요.";
	          console.log("실패", err);
	        }
	      });
		    
	    })
	  
	  // 이메일(영어, 숫자, 특수문자(_ . @)만 입력 가능)
	  $("#user_email")
      .on("compositionstart", function () {
        isComposing = true;
      })
      .on("compositionend", function () {
        isComposing = false;
        // 한글이 완성되고 난 직후 처리
        const filtered = $(this).val().replace(/[^a-zA-Z0-9_.@]/g, '');
        $(this).val(filtered);
      })
      .on("input", function () {
        if (!isComposing) {
          const filtered = $(this).val().replace(/[^a-zA-Z0-9_.@]/g, '');
          $(this).val(filtered);
        }
      })
      .change(function(){
    	  isEmailChecked = false;
      });
	  
	  // 이메일 중복 검사
	  $("#email_button")
		  .click(function(){
			  const email = $("#user_email").val();
			  
			  if( !isVaildEmail(email) ){
          alert("사용 불가능한 이메일입니다.");
          $("#user_email").focus();
          isEmailChecked = false;
          return false;
			  }
			  
			  $.ajax({
          type: "post",
          url: "/emailCheck",
          data: { email : email },
          dataType: "json",
          success: function(res) {
            console.log("response : ", res);
            
            if( res === false ){
              alert("사용 불가능한 이메일입니다.");
              $("#user_email").focus();
              isEmailChecked = false;
            }else{ 
           	  alert("사용 가능한 이메일입니다."); 
           	  isEmailChecked = true;
         	  }
          },
          error: function(err) {
            alert("이메일 조회 실패. 관리자에게 문의해주세요.");
            console.log("실패", err);
          }
        });
			  
		  })
	  
	  // 비밀번호
	  $("#user_password").change(function(){
	    const password = $("#user_password").val();
	    isPasswordChecked = false;
	    
	    if( !isVaildPassword(password) ){
		    	alert("사용 불가능한 비밀번호입니다.");
		    	isPasswordChecked = false;
		    	return false;
	    }else{ 
		    	alert("사용 가능한 비밀번호입니다.");
		    	isPasswordChecked = true;
		    	return false;
	    }
	  })
	  
	  // 비밀번호 확인
	  $("#user_password_check").change(function(){
		  const password = $("#user_password").val();
	    const passwordCheck = $("#user_password_check").val();
	    isMatchedPasswordChecked = false;
	    
	    if( passwordCheck === '' ){ return; }
	    
	    if( !isVaildPassword(passwordCheck) ){
        alert("사용 불가능한 비밀번호입니다.");
        isCheckPasswordChecked = false;
        return false;
      }
	    
	    if( passwordCheck === password ){
	      alert("비밀번호가 일치합니다.");
	      isMatchedPasswordChecked = true;
	      return false;
	    }else{
	    	alert("비밀번호가 일치하지 않습니다.");
	    	isMatchedPasswordChecked = false;
	      return false;
	    }
	  })
	 
	  // 휴대폰번호 확인
	  $("#user_phone_num")
		  .on("input", function(){
		    const phone = $(this).val();
		    const length = phone.length;
		    
		    if(length >= 9){
			    const hyphenPhone = phone.replace(/[^0-9]/g, "") // 숫자 제외한 문자 제거
			 			  .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`) // 숫자 $1(2,3)-$2(3,4)-$3(4) 자리로 치환
	 			  $(this).val(hyphenPhone);
		    }
		  })
		  .change(function(){
			  const phone = $(this).val();
			  if( phone === '' || phone === "010" ){ return false; }
			  
        if( !isVaildPhone(phone) ){ 
   	      alert("사용 불가능한 휴대폰번호입니다.");
   	      isPhoneChecked = false;
   	      return false;
	  	  }
        
        // phone '-' 제거
        const phoneNum = phone.replace(/-/g, "");
        
        $.ajax({
          type: "post",
          url: "/phoneCheck",
          data: { phone : phoneNum },
          dataType : "json",
          success: function(res) {
            console.log("response : ", res);
            
            if( res === false ){
              alert("사용 불가능한 휴대폰번호입니다.");
              isPhoneChecked = false;
            }else{ 
              alert("사용 가능한 휴대폰번호입니다."); 
              isPhoneChecked = true;
            }
          },
          error: function(err) {
            alert("휴대폰번호 조회 실패. 관리자에게 문의해주세요.");
            console.log("실패", err);
          }
        });
        
		  })
      .focusin(function(){
    	  if( $(this).val().length > 3 ){ return; }
    	  document.querySelector("#user_phone_num").value = "010";
   	  });
  
  // 정규식 함수
  // 이름(한글, 특수문자 제외)
  function isVaildName(name){
	  const nameRegex = /^[^ㄱ-ㅎㅏ-ㅣ가-힣!@#$%^&*()_+={}\[\]|\\:;"'<>,.?\/~`-]+$/;
	  return nameRegex.test(name);
  }
  
  // 이메일(영어, 숫자, 특수문자(_ . @)만 입력 가능)
  function isVaildEmail(email){
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }

  // 비밀번호(문자, 숫자, 특수문자 조합 8~15자리)
  function isVaildPassword(password){
    const passwordRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[a-z\d!@#$%^&*]{8,15}$/
    return passwordRegex.test(password);
  }
  
  // 휴대폰번호
  function isVaildPhone(phone){
	  const phoneRegex = /^010-[0-9]{4}-[0-9]{4}$/;
	  return phoneRegex.test(phone);
  }
	
  // 회원가입 버튼 이벤트
  $("#join_button").click(function(e) {
     e.preventDefault();
     
     // 데이터 보내기 전에 확인!
     if( !confirm("회원가입을 하시겠습니까?") ){ return false; }
     
     // input 값 가져오기
     const name = $("#user_name");
     const email = $("#user_email");
     const password = $("#user_password");
     const passwordCheck = $("#user_password_check");
     const phone = $("#user_phone_num");
     const roadAddress = $("#user_road_address");
     const detailAddress = $("#user_detail_address");
     const zonecode = $("#user_zonecode");
     const referAddress = $("#user_refer_address");
     
     // 빈값
     // 형식
     // 중복체크
     // 포커스 같이
     
     if( name.val() === '' ){ 
   	   alert("이름을 입력해주세요."); 
   	   name.focus();
   	   return;
     }
     if( email.val() === '' ){
   	   alert("이메일을 입력해주세요."); 
   	   email.focus();
   	   return;
     }
     if( password.val() === '' ){
   	   alert("비밀번호을 입력해주세요."); 
   	   password.focus();
   	   return;
     }
     if( passwordCheck.val() === '' ){ 
   	   alert("비밀번호 확인을 입력해주세요."); 
   	   passwordCheck.focus();
   	   return;
     }
     if( phone.val() === '' || !isVaildPassword ){
   	   alert("휴대폰번호를 입력해주세요."); 
   	   phone.focus();
   	   return;
     }
     if( roadAddress.val() === '' ){
   	   alert("주소을 입력해주세요."); 
   	   roadAddress.focus();
   	   return;
     }
     if( detailAddress.val() === '' ){
   	   alert("상세주소을 입력해주세요."); 
   	   detailAddress.focus();
   	   return;
     }
     if( zonecode.val() === '' ){
   	   alert("주소를 입력해주세요."); 
   	   zonecode.focus();
   	   return;
     }
     
     // 이중체크
     if( !isNameChecked || !isVaildName(name.val()) ){
    	 alert("사용 불가능한 이름입니다.");
    	 name.focus();
    	 return;
     }
     if( !isVaildEmail(email.val()) ){
    	 alert("사용 불가능한 이메일입니다."); 
    	 email.focus();
    	 return;
     }
     if( !isEmailChecked ){
    	 alert("이메일 중복을 확인해주세요."); 
    	 email.focus();
    	 return;
     }
     if( !isPasswordChecked || !isVaildPassword(password.val()) ){
    	 alert("사용 불가능한 비밀번호입니다."); 
    	 password.focus();
    	 return;
     }
   	 if( !isMatchedPasswordChecked ){
       alert("비밀번호가 일치하지 않습니다."); 
       passwordCheck.focus();
       return;
     }
   	 if( !isPhoneChecked || !isVaildPhone(phone.val()) ){
   	   alert("사용 불가능한 휴대폰번호입니다."); 
   	   phone.focus();
   	   return; 
   	 }
     
     // formData 통신
     const form = $('#join_form')[0];
     const formData = new FormData(form);
     
     // phone '-' 제거
     const phoneNum = phone.val().replace(/-/g, "");
     formData.set('user_phone_num', phoneNum);
     
     for (let [key, value] of formData.entries()) {
   	  console.log(key, value);
   	}
     
     $.ajax({
       type: "post",
       url: "/createUser",
       data: formData,
       processData: false,
       contentType: false,
       success: function(res) {
         console.log("res : ", res);
         
         if( res.result === true ){ 
       	    alert("회원가입이 완료되었습니다.");
       	    location.href="/login"
   	     }else{ alert("회원가입 실패"); }
         
       },
       error: function(err) {
      	  alert("서버 오류. 관리자에게 문의해주세요.");
         console.log("실패", err);
       }
      });
   });
 
  
	  /*  
	  // json 처리 
    $("#join_button").click(function (e) {
   	  e.preventDefault();
	  
   	  const jsonData = {
  			  user_name : $("#user_name").val(),
 	      user_email : $("#user_email").val(),
 	      user_password : $("#user_password").val(),
 	      user_phone_num : $("#user_phone_num").val(),
 	      user_zonecode : $("#user_zonecode").val(),
 	      user_road_address : $("#user_road_address").val(),
 	      user_detail_address : $("#user_detail_address").val(),
 	      user_refer_address : $("#user_refer_address").val()
   	  }
   	  
   	  $.ajax({
   		  type: 'post',
        url: "/user/join/post",
        data: JSON.stringify(jsonData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (res){
          console.log(res);
          if(res.result > 0){
        	  alert("회원가입이 완료되었습니다.");
            location.href="/user/"
        	} else {
        		alert("오류가발생했습니다. 관리자에게 문의바랍니다.");
        	}
          
        },
        error : function(res){

        }
        
      })

    }) */

  
  </script>
  
  <!-- daum 주소 api -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  
  <script>
  function daumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var addr = ''; // 주소 변수
        var extraAddr = ''; // 참고항목 변수

        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
        } else { // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
        }

        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
        if(data.userSelectedType === 'R'){
          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
          if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
              extraAddr += data.bname;
          }
          // 건물명이 있고, 공동주택일 경우 추가한다.
          if(data.buildingName !== '' && data.apartment === 'Y'){
              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
          if(extraAddr !== ''){
              extraAddr = ' (' + extraAddr + ')';
          }
          // 조합된 참고항목을 해당 필드에 넣는다.
          document.getElementById("user_refer_address").value = extraAddr;
        
        } else {
            document.getElementById("user_refer_address").value = '';
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        document.getElementById('user_zonecode').value = data.zonecode;
        document.getElementById("user_road_address").value = addr;
        // 커서를 상세주소 필드로 이동한다.
        document.getElementById("user_detail_address").focus();
      }
    }).open();
  }
  </script>
 
  <!-- Bootstrap core JavaScript-->
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/js/sb-admin-2.min.js"></script>
  
</body>

</html>