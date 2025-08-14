<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<title>Tables - modify</title>

<jsp:include page="../common/head.jsp" />

<body id="page-top">
  <!-- Page Wrapper -->
  <div id="wrapper">
    
    <!-- Sidebar -->
    <jsp:include page="../common/sidebar.jsp" />

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
      <!-- Main Content -->
      <div id="content">
      
        <!-- Topbar -->
        <jsp:include page="../common/topbar.jsp" />
        
        <!-- Begin Page Content -->
        <div class="container-fluid h-100">
          <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">게시물 수정</h1>

          <!-- DataTales Example -->
          <div class="card shadow mb-4 h-75">
            <div class="card-body">
              <!-- Basic Card Example -->
              <form id="writeForm" name="writeForm" action="#" method="post" class="h-100">
                <div class="card shadow mb-4 h-100">
                  <div class="card-header py-3">
                    <div class="col-sm-11 float-left">
                      <input
                        type="text"
                        id="board_title"
                        name="board_title"
                        class="form-control"
                        placeholder="제목"
                        maxlength="50"
                        value="${ board.board_title }"
                      />
                    </div>
                    <a href="#">
                      <button
                        id="writeButton"
                        type="button"
                        class="btn btn-primary btn float-right ml-1"
                      >
                        작성완료
                      </button></a
                    >
                  </div>
                  <div class="card-body">
                    <textarea
                      id="board_content"
                      name="board_content"
                      cols="30"
                      class="form-control h-100"
                      placeholder="내용"
                      style="resize: none"
                      maxlength="1333"
                    >${ board.board_content }</textarea>
                  </div>

                  <div class="d-flex mb-2 align-items-center">
                    <div class="ml-4">파일 업로드</div>
                    <input 
                      id="upfile"
                      type="file" 
                      class="ml-1"
                      multiple
                    />
                  </div>
                  
                  <div id="fileBox" class="ml-4 my-2" >
                    
                    <c:if test="${ empty fileList }" >
                      <div class="mr-2" > 선택된 파일 없음 </div>
                    </c:if>
                    
                    <c:forEach var="file" items="${ fileList }" >
                      <c:set var="parts" value="${ fn:split(file, '_') }" />
                      <div class="mr-2">
                        <c:forEach var="p" items="${ parts }" varStatus="status">
                          <c:if test="${ status.index >= 2 }">
                            <c:out value="${ p }" />
                          </c:if>
                        </c:forEach>
                      </div>
                    </c:forEach>
                    
                  </div>
                  
                </div>
              </form>
            </div>
          </div>
        </div>
        <!-- /.container-fluid -->
      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <jsp:include page="../common/footer.jsp" />
      
    </div>
    <!-- End of Content Wrapper -->
  </div>
  <!-- End of Page Wrapper -->

  <!-- Logout Modal-->
  <jsp:include page="../common/logout_modal.jsp" />
  
  <script>
  
		//url parameter
		  const urlParams = new URL(location.href).searchParams;
		  const board_id = urlParams.get('board_id');
		  
	  // 파일 업로드 여부
	  let file_state = false;
  
		// 파일 목록 출력
	  $("#upfile").change(function(e) {
		    const fileBox = $("#fileBox");
		    fileBox.empty();

		    if ( this.files.length === 0 ) {
		    	fileBox.innerHTML = "<div class='mr-2'> 선택된 파일 없음 </div>";
	        return;
		    }

		    Array.from( this.files ).forEach(file => {
	        const html = "<div class='mr-2'>" + file.name + "</div>";
	        fileBox.append(html);
		    });
		    
		    file_state = true;
		});
		  
    // 게시물 수정
    $("#writeButton").click(function(){
      const title = $("#board_title");
      const content = $("#board_content");
      const upfile = $("#upfile");
      var fileList = [
   	    <c:forEach var="file" items="${fileList}" varStatus="status">
   	      '${file}'<c:if test="${!status.last}">,</c:if>
   	    </c:forEach>
   	  ];
      
      if( title.val() === "" ){ 
        alert("제목을 입력해주세요.");
        title.focus();
        return false;
      }
      if( content.val() === "" ){
        alert("내용을 입력해주세요.");
        content.focus();
        return false;
      }
      
      if( !confirm("수정하시겠습니까?") ){ return false; }
      
      const form = $("#writeForm")[0];
      let formData = new FormData(form);
      
      // Array로 변환
      formData = transferArray( upfile, formData );
      
      // formData 삽입
      formData.append("board_id", board_id);
      formData.append("file_state", file_state);
      formData.append("delete_files", fileList);
      
      $.ajax({
        type: "put",
        url: "/api/board/update",
        data: formData,
        dataType: "json",
        processData: false,
        contentType: false,
        success: function(res){
          console.log("res : ", res);
          
          if( res == true ){
            alert("저장되었습니다.");
            location.href = "/";
          }else{
            alert("수정 실패");
          }
          
        },
        error: function(jqXHR, testStatus, errorThrown){
          const responseText = JSON.parse(jqXHR.responseText);
          if( responseText.NullPointerException != null ){
            alert("에러 발생 : " + responseText.NullPointerException);
          }

          if( responseText.RuntimeException != null ){
            alert("에러 발생 : " + responseText.RuntimeException);
          }
          console.log("실패", jqXHR);
        }
      });
      
    });
	  
	  // fileList array 변환
	  function transferArray( files, formData ){
	    
	    let fileList = files[0].files;
	    
	    let fileArray = Array.from(fileList);
	    
	    fileArray.forEach( file => { formData.append("files", file); } );
	
	    formData.delete( "upfile" );
	    
	    return formData;
	    
	  }
    
  </script>

  <!-- Bootstrap core JavaScript-->
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="/resources/js/demo/datatables-demo.js"></script>
</body>
</html>
