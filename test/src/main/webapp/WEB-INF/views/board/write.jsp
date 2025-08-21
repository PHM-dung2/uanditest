<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

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
          <h1 class="h3 mb-2 text-gray-800">게시판</h1>

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
                    ></textarea>
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
  
    // 게시물 작성
    $("#writeButton").click(function(){
    	const title = $("#board_title");
    	const content = $("#board_content");
    	const upfile = $("#upfile");
    	
    	if( !confirm("작성을 하시겠습니까?") ){ return false; }
    	
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
    	
    	const form = $("#writeForm")[0];
    	let formData = new FormData(form);
    	
    	// Array로 변환
    	formData = transferArray( upfile, formData );
    	
    	// ajax
      var svcId = "boardWrite";
      var type = "POST";
      var url = "/api/board/write";
      
      ajaxFunc( svcId, type, url, formData, callBackFunc );
    	
    });

    $("#upfile").change(function(e) {
      const fileBox = $("#fileBox");
      fileBox.empty(); // 기존 목록 비우기

      if (this.files.length === 0) {
        fileBox.html("<div class='mr-2'>선택된 파일 없음</div>");
        return;
      }

      Array.from(this.files).forEach(file => {
        fileBox.append("<div class='mr-2'>" + file.name + "</div>");
      });
    });
    
    function callBackFunc( svcId, res ){
    	if( res == true ){
        alert("저장되었습니다.");
        location.href = "/";
      }else{
        alert("저장 실패");
      }
    }

    
    // 이미지 첨부
/* 	let imgCount = 0;
  let html = '';
  
  $("#imgBox").html("선택된 파일 없음");
  
	$("#upfile").change(function(e){
	  imgCount++;

	  if( imgCount === 1 ){ $("#imgBox").html( '' ); }
	  
	  let newId = "img" + imgCount;
	  console.log( newId );
	  html = '<img id="' + newId + '" class="mr-2" style="height:150px; width:150px; display:none; margin-right:5px;" />';
    console.log( html )
	  
	  $("#imgBox").append( html );
	
	  var file = e.target.files[0];
	  var reader = new FileReader();
	
	  reader.onload = function(e){
	    $("#" + newId).attr("src", e.target.result);
	    $("#" + newId).css("display", "block");
	  }
	  reader.readAsDataURL(file);
	}); */
	
	// fileList array 변환
	function transferArray( files, formData ){
		
		let fileList = files[0].files;
		
		let fileArray = Array.from(fileList);
		
		fileArray.forEach( file => { formData.append("files", file); } );

		formData.delete( "upfile" );
		
		return formData;
		
	}
    
  </script>

  <jsp:include page="../common/scripts.jsp"></jsp:include>
  
  <!-- 공통 js -->
  <script src="/resources/js/common.js"></script>

</body>
</html>
