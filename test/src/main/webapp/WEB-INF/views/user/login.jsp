<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<title>SB Admin 2 - Login</title>
  
<jsp:include page="../common/head.jsp" />

<body class="bg-gradient-primary">
  <div class="container">
    <!-- Outer Row -->
    <div class="row justify-content-center">
      <div class="col-xl-10 col-lg-12 col-md-9">
        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                  </div>
                  <form id="login_form" class="user">
                    <div class="form-group">
                      <input
                        id="user_email"
                        name="user_email"
                        type="email"
                        class="form-control form-control-user"
                        aria-describedby="emailHelp"
                        placeholder="Enter Email Address..."
                      />
                    </div>
                    <div class="form-group">
                      <input
                        id="user_password"
                        name="user_password"
                        type="password"
                        class="form-control form-control-user"
                        placeholder="Password"
                      />
                    </div>
                    <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input
                          id="emailSaveCheck"
                          type="checkbox"
                          class="custom-control-input"
                        />
                        <label class="custom-control-label" for="emailSaveCheck">Remember Me</label>
                      </div>
                    </div>
                    <a
                      href="#"
                      id="login_button"
                      class="btn btn-primary btn-user btn-block"
                    >
                      로그인
                    </a>
                  </form>
                    
                  <hr />
                  <div class="text-center">
                    <a class="small" href="/join"
                      >Create an Account!</a
                    >
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <script>
  
    // 로그인 버튼 이벤트
    $("#login_button").click(function(e) {
    	e.preventDefault();
    	
   	  const email = $("#user_email").val();
   	  const password = $("#user_password").val();
   	  
   	  if( email === '' ){ 
 	      alert("이메일을 입력해주세요."); return;
 	    }
   	  if( password === '' ){ 
   		  alert("비밀번호를 입력해주세요."); return;
      };
    	  
	 	  // formData 통신
	    const form = $('#login_form')[0];
	    const formData = new FormData(form);
	    
	    // ajax
	    var svcId = "login";
	    var type = "POST";
	    var url = "/api/login";
	  	
	    ajaxFunc( svcId, type, url, formData, ( svcId, res ) => callBackFunc( svcId, res ) );
	    
    });

    // 콜백 함수
    function callBackFunc( svcId, res ){
   	  console.log("res :", res);
   	  
      if( res === true ){ 
        alert("로그인되었습니다.");
        location.href = "/";
        return true;
      }

      return false;
    }
    
    // 이메일 저장
    $(document).ready(function(){
      const savedEmail = localStorage.getItem("userEmail");
   	  if( savedEmail !== '' && savedEmail !== null ){
   		  $("#user_email").val(savedEmail);
   		  $("#emailSaveCheck").prop("checked", true);
   	  }else {
   		  $("#emailSaveCheck").prop("checked", false);
   		}

    });

    $("#emailSaveCheck").click(function(){
   	  const email = $("#user_email").val();
   	  const remember = $("#emailSaveCheck").is(":checked");
   	  
   	  if( remember === true && email !== '' ){
   		  localStorage.setItem("userEmail", email);  
   	  } else {
   		  localStorage.removeItem("userEmail");
   	  }
    })
    .change(function(){
    	const email = $("#user_email").val();
      const remember = $("#emailSaveCheck").is(":checked");
      
      if( remember === true && email !== '' ){
        localStorage.setItem("userEmail", email);  
      } else {
        localStorage.removeItem("userEmail");
      }
    });
    
  </script>

  <jsp:include page="../common/scripts.jsp"></jsp:include>
  
  <!-- 공통 js -->
  <script src="/resources/js/common.js"></script>
  
</body>
</html>
