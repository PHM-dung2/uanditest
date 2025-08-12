<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta
    name="viewport"
    content="width=device-width, initial-scale=1, shrink-to-fit=no"
  />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>SB Admin 2 - Login</title>

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
	  	  
	  	$.ajax({
		    type: "post",
		    url: "/login",
		    data: formData,
		    processData: false,
		    contentType: false,
		    success: function(res) {
		      console.log("response : ", res);
		       
		      if( res === true ){ 
	         alert("로그인되었습니다.");
	         location.href="/";
	         return true;
		      }
		      else{
	      	  alert("이메일 혹은 비밀번호가 실패하였습니다.");
		      }

		      return false;
		      
	      },
	     error: function(err) {
	       alert("서버 오류. 관리자에게 문의해주세요.");
	       console.log("실패", err);
	     }
	    });
    	  
    });
    
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

  <!-- Bootstrap core JavaScript-->
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/js/sb-admin-2.min.js"></script>
</body>
</html>
