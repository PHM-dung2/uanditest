<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<title>SB Admin 2 - Register</title>

<jsp:include page="../common/head.jsp"></jsp:include>

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
                  <div class="name_isvalid" 
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
		    isNameChecked = false;
		    
		    // 이름 정규식
		    if( !isValidName(name) ){
		    	$(".name_isvalid").html("사용 불가능한 닉네임입니다."); 
          isNameChecked = false;
		    }
		    
		    // ajax
		    var svcId = "nameCheck";
		    var type = "POST";
		    var url = "/nameCheck";
		    var inData = { name : name };
		    	
		    ajaxFunc( svcId, type, url, inData, ( svcId, res ) => callBackFunc( svcId, res ) );
		    
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
			  
			  if( !isValidEmail(email) ){
          alert("사용 불가능한 이메일입니다.");
          $("#user_email").focus();
          isEmailChecked = false;
          return false;
			  }
			  
			  // ajax
        var svcId = "emailCheck";
        var type = "POST";
        var url = "/emailCheck";
        var inData = { email : email };
          
        ajaxFunc( svcId, type, url, inData, ( svcId, res ) => callBackFunc( svcId, res ) );
			  
		  })
	  
	  // 비밀번호
	  $("#user_password").change(function(){
	    const password = $("#user_password").val();
	    isPasswordChecked = false;
	    
	    if( !isValidPassword(password) ){
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
	    
	    if( !isValidPassword(passwordCheck) ){
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
			  
        if( !isValidPhone(phone) ){ 
   	      alert("사용 불가능한 휴대폰번호입니다.");
   	      isPhoneChecked = false;
   	      return false;
	  	  }
        
        // phone '-' 제거
        const phoneNum = phone.replace(/-/g, "");
        
        // ajax
        var svcId = "phoneCheck";
        var type = "POST";
        var url = "/phoneCheck";
        var inData = { phone : phoneNum };
          
        ajaxFunc( svcId, type, url, inData, ( svcId, res ) => callBackFunc( svcId, res ) );
        
		  })
      .focusin(function(){
    	  if( $(this).val().length > 3 ){ return; }
    	  document.querySelector("#user_phone_num").value = "010";
   	  });
	
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
    if( phone.val() === '' || phone.val() === '010' ){
   	  alert("휴대폰번호를 입력해주세요."); 
   	  phone.focus();
   	  return;
    }
    if( roadAddress.val() === '' ){
   	  alert("주소를 입력해주세요."); 
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
    if( !isNameChecked || !isValidName(name.val()) ){
    	alert("사용 불가능한 이름입니다.");
    	name.focus();
      return;
    }
    if( !isValidEmail(email.val()) ){
   	  alert("사용 불가능한 이메일입니다."); 
   	  email.focus();
   	  return;
    }
    if( !isEmailChecked ){
      alert("이메일 중복을 확인해주세요."); 
    	email.focus();
    	return;
    }
    if( !isPasswordChecked || !isValidPassword(password.val()) ){
      alert("사용 불가능한 비밀번호입니다."); 
      password.focus();
      return;
    }
   	if( !isMatchedPasswordChecked ){
      alert("비밀번호가 일치하지 않습니다."); 
      passwordCheck.focus();
      return;
    }
   	if( !isPhoneChecked || !isValidPhone(phone.val()) ){
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
    
    /*      
    for (let [key, value] of formData.entries()) {
   	  console.log(key, value);
   	}
    */
     
    var svcId = "createUser";
    var type = "POST";
    var url = "/createUser";
    
    ajaxFunc( svcId, type, url, formData, ( svcId, res ) => callBackFunc( svcId, res ) );

  });
  
  //콜백 함수
  function callBackFunc( svcId, res ){
	  console.log("response : ", res);
	  
	  if( svcId === "nameCheck" ){
      if( res === false ) { 
    	  $(".name_isvalid").html("사용 불가능한 닉네임입니다."); 
    	  $("#user_name").focus();
        isNameChecked = false;
      }
      else{ 
    	  $(".name_isvalid").html("사용 가능한 닉네임입니다.");
        isNameChecked = true;
      }
	  }
	  
	  if( svcId === "emailCheck" ){
		  if( res === false ){
        alert("사용 불가능한 이메일입니다.");
        $("#user_email").focus();
        isEmailChecked = false;
      }else{ 
        alert("사용 가능한 이메일입니다."); 
        isEmailChecked = true;
      }
	  }
	  
	  if( svcId === "phoneCheck" ){
		  if( res === false ){
        alert("사용 불가능한 휴대폰번호입니다.");
        $("#user_phone_num").focus();
        isPhoneChecked = false;
      }else{ 
        alert("사용 가능한 휴대폰번호입니다."); 
        isPhoneChecked = true;
      }
	  }
	  
	  if( svcId === "createUser" ){
		  if( res === true ){ 
         alert("회원가입이 완료되었습니다.");
         location.href="/login";
      }else{ alert("회원가입 실패"); }
	  }
    
  }

  </script>
  
  <jsp:include page="../common/scripts.jsp"></jsp:include>
  
  <!-- 공통 js -->
  <script src="/resources/js/common.js"></script>
  
</body>

</html>