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
	  var isNameChecked = false;
	  var isEmailChecked = false;
	  var isPasswordChecked = false;
	  var isVerifiedPasswordChecked = false;
	  var isMatchedPasswordChecked = false;
	  var isPhoneChecked = false;
	  
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
			  const nameIsvalid = $(".name_isvalid");
		    isNameChecked = false;
		    
		    // validation
		    const nameValidation = runValidation( "name", name );
		    if( !nameValidation.valid ){
		    	nameIsvalid.html( nameValidation.msg ); 
          isNameChecked = false;
		    }
		    
		    // ajax
		    var svcId = "nameCheck";
		    var type = "POST";
		    var url = "/api/nameCheck";
		    var inData = { name : name };
		    	
		    ajaxFunc( svcId, type, url, inData, callBackFunc );
		    
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
			  const email = $("#user_email");
			  
			  // validation
			  if ( !validateField( "email", email, false ) ){ return false; }
			  
			  // ajax
        var svcId = "emailCheck";
        var type = "POST";
        var url = "/api/emailCheck";
        var inData = { email : email.val() };
          
        ajaxFunc( svcId, type, url, inData, callBackFunc );
			  
	  })
	  
	  // 비밀번호
	  $("#user_password").change(function(){
	    const password = $("#user_password");
	    isPasswordChecked = false;
	    
	    if( password.val() === "" ){ return false; }
	    
	    // validation
	    validateField( "password", password );
	  })
	  
	  // 비밀번호 확인
	  $("#user_password_check").change(function(){
		  const password = $("#user_password");
	    const passwordCheck = $("#user_password_check");
	    isMatchedPasswordChecked = false;
	    
	    if( passwordCheck.val() === "" ){ return false; }
	    
	    // 비밀번호 확인 검증
	    if ( !validateField( "verifiedPassword", passwordCheck ) ){ return false; }
	    // 비밀번호 일치 여부 검증
	    if ( !validateField( "matchedPassword", passwordCheck, true, password ) ){ return false; }
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
			  const phone = $(this);
			  if( phone === '' || phone === "010" ){ return false; }
			  
			  // 휴대폰 번호 확인
			  if ( !validateField( "phone", phone, false ) ){ return false; }
        
        // phone '-' 제거
        const phoneNum = phone.val().replace(/-/g, "");
        
        // ajax
        var svcId = "phoneCheck";
        var type = "POST";
        var url = "/api/phoneCheck";
        var inData = { phone : phoneNum };
          
        ajaxFunc( svcId, type, url, inData, callBackFunc );
        
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
    const inputs = {
      name: $("#user_name"),
      email: $("#user_email"),
      password: $("#user_password"),
      passwordCheck: $("#user_password_check"),
      phone: $("#user_phone_num"),
      roadAddress: $("#user_road_address"),
      detailAddress: $("#user_detail_address"),
      zonecode: $("#user_zonecode"),
      referAddress: $("#user_refer_address")
    };
     
    // 빈값
    // 형식
    // 중복체크
    // 포커스 같이
    if( !validateForm( inputs ) ){ return false; }
     
    // formData 통신
    const form = $('#join_form')[0];
    const formData = new FormData(form);
     
    // phone '-' 제거
    const phoneNum = inputs.phone.val().replace(/-/g, "");
    formData.set('user_phone_num', phoneNum);
    
    /*      
    for (let [key, value] of formData.entries()) {
   	  console.log(key, value);
   	}
    */
     
    var svcId = "createUser";
    var type = "POST";
    var url = "/api/createUser";
    
    ajaxFunc( svcId, type, url, formData, callBackFunc );

  });
  
  //콜백 함수
  function callBackFunc( svcId, res ){
    console.log("response : ", res);
    
    // 메시지 템플릿
    const getMessages = (type) => ({
      success: "사용 가능한" + type + "입니다.",
      fail: "사용 불가능한 " + type + "입니다."
    });
    
    if( svcId === "nameCheck" ){
      const nameIsvalid = $(".name_isvalid");
      const msg = getMessages("이름(닉네임)");
        
      if( res === false ) {
        nameIsvalid.html( msg.fail );
        $("#user_name").focus();
        isNameChecked = false;
      } else {
        nameIsvalid.html(msg.success);
        isNameChecked = true;
      }
    }
    
    if( svcId === "emailCheck" ){
      const msg = getMessages("이메일");
        
      if( res === false ){
        alert( msg.fail );
        $("#user_email").focus();
        isEmailChecked = false;
      } else {
        alert( msg.success );
        isEmailChecked = true;
      }
    }
    
    if( svcId === "phoneCheck" ){
      const msg = getMessages("휴대폰 번호");
        
      if( res === false ){
        alert( msg.fail );
        $("#user_phone_num").focus();
        isPhoneChecked = false;
      } else {
        alert( msg.success );
        isPhoneChecked = true;
      }
    }
    
    if( svcId === "createUser" ){
      if( res === true ){
        alert("회원가입이 완료되었습니다.");
        location.href="/login";
      } else { 
        alert("회원가입 실패"); 
      }
    }
  }

  </script>
  
  <jsp:include page="../common/scripts.jsp"></jsp:include>
  
  <!-- 공통 js -->
  <script src="/resources/js/common.js"></script>
  
</body>

</html>