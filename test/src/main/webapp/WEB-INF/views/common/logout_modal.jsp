<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div
    class="modal fade"
    id="logoutModal"
    tabindex="-1"
    role="dialog"
    aria-labelledby="exampleModalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button
            class="close"
            type="button"
            data-dismiss="modal"
            aria-label="Close"
          >
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          Select "Logout" below if you are ready to end your current session.
        </div>
        <div class="modal-footer">
          <button
            class="btn btn-secondary"
            type="button"
            data-dismiss="modal"
          >
            Cancel
          </button>
          <a id="logoutButton" class="btn btn-primary" href="#">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <script>
  
  // 로그아웃 버튼
  $("#logoutButton").click(function(e){
    e.preventDefault();
    
    if( !confirm("로그아웃 하시겠습니까?") ){ return false; }
    
    logout();
    
  });
  
  function logout(){
	  $.ajax({
			type: "get",
			url: "/logout",
			success: function(){
			  location.href="/";
			},
			error: function(err){
			  alert("서버 오류. 관리자에게 문의해주세요.");
			  console.log("서버 오류", err);
			}
	  });
  }
  
  </script>

</body>
</html>