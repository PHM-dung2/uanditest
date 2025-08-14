<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<title>Tables - detail</title>

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
              <div class="card shadow mb-4 h-100">
                <div class="card-header py-3">
 
                  <h6
	                  class="m-0 font-weight-bold text-primary btn float-left"
	                >
	                  ${ board.board_title }
	                </h6>
	                
                  <c:if test="${ isWriter }" >
                  
                    <a href="#">
	                    <button
	                      id="update_btn"
	                      type="button"
	                      class="btn btn-primary btn float-right ml-1"
	                    >
	                      수정
	                    </button>
	                  </a>
	                  <button
	                    id="delete_btn"
	                    type="button"
	                    class="btn btn-danger btn float-right"
	                  >
	                    삭제
	                  </button>
                   
                  </c:if>
                  
                </div>
                
                <div
                  class="card-body navbar-nav-scroll"
                  style="height: 320px !important; overflow-y: auto; word-break: break-word;"
                >
                  ${ board.board_content }
                </div>
                
                <!-- file -->
                <div class="card-body fileUpLoad mb-4"> 
	                <label class="fileUpLoadBtn">파일</label>
	                <div id="fileName" class="fileName">
	                  
	                  <c:forEach var="file" items="${ fileList }">
										  <c:set var="parts" value="${ fn:split(file, '_') }" />
										  <a href="/api/file/download?file_name=${ file }"
										     download
										     style="display: block">
										    <c:forEach var="p" items="${ parts }" varStatus="status">
										      <c:if test="${ status.index >= 2 }">
										        <c:out value="${ p }" />
										      </c:if>
										    </c:forEach>
										  </a>
										</c:forEach>
	               
	                </div>
	              </div>
	              
                <div class="card-footer">
                
	                <form action="#" id="replyForm" name="replyForm">
	                
	                <input type="hidden" name="boardNo" value="1">
	                <input type="hidden" name="parentCommentNo" value="0">
	                <input type="hidden" name="commentNo" value="0">
	                  <ul id="commentDiv" style="max-height: 500px; overflow-y: scroll;overflow-x: hidden;">
	                     
	                     <c:forEach var="comment" items="${ commentList }" >
	                     
	                       <li data-id="${ comment.user_id }"
	                           data-commentid="${ comment.comment_id }"
	                           data-name="${ comment.writer_name }"
	                           data-tagname="${ comment.tag_name }"
	                           data-content="${ comment.comment_content }"
	                           data-date="2024-04-01 12:45:23" 
	                           data-parentlevel="${ comment.comment_parent_level }"
	                           data-rootid="${ comment.comment_root_id }"
	                           data-parentid="${ comment.comment_parent_id }"
	                           data-deletestate="${ comment.comment_delete_state }"
	                       >
		                       <div class="commentDiv" 
		                            style="padding-left: 2rem; 
		                                   margin-left: ${ (comment.comment_parent_level) * 20 }px;
		                            ">
		                            
	                           <div class="commentHead">
	                             <div class="commentHead1">
	                               <div class="commentName">${ comment.writer_name }</div>
	                               <div class="commentDate">${ comment.comment_display_date }</div>
	                             </div>
	                       
	                             <div class="commentHead2">
	                          
	                               <div class="commentReply">답글</div>
	                          
	                             </div>
	                       
	                           </div>
	                          
		                         <div class="comment">
		                           <p>
		                             ${ comment.comment_content }  
		                           </p>
		                         </div>
					                   
					                 </div>
	                         
	                       </li>
	                       
                         <hr class="sidebar-dividzer d-none d-md-block">
                         
	                     </c:forEach>
	                     
	                  </ul>
	                </form>
	                   
	                <div class="writeForm">
	                  <form action="#" class="flex" id="commentForm" name="commentForm">
		                  <input type="hidden" name="boardNo" value="1">
		                  <textarea id="comment_content" cols="30" row="5" name="comment_content" class="form-control flex" style="width: 90%" placeholder="내용
		                  "></textarea>
		                  <a href="#" class="commentAdd flex" style="width: 9%">
		                    <button id="reply-button" type="button" class="btn btn-primary btn ml-1" style="margin-top: 0.75rem;width: 100%">등록</button>
		                  </a>
	                  </form>
	                </div>
                   
                </div>
              </div>
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
  
  <script type="text/html" id="asyncComment">

    <li data-id="{{ user_id }}"
        data-commentid="{{ comment_id }}"
        data-name="{{ writer_name }}"
        data-tagname="{{ tag_name }}"
        data-content="{{ comment_content }}"
        data-parentlevel="{{ comment_parent_level }}"
        data-rootid="{{ comment_root_id }}"
        data-parentid="{{ comment_parent_id }}"
        data-deletestate="{{ comment_delete_state }}"
    >
      <div class="commentDiv" 
           style="padding-left: 2rem; 
                  margin-left: {{ parent_level_margin }}px;
      ">
                   
        <div class="commentHead">
          <div class="commentHead1">
            <div class="commentName">{{ writer_name }}</div>
            <div class="commentDate">{{ comment_display_date }}</div>
          </div>
                         
          <div class="commentHead2">
            <div class="commentReply">답글</div>
          </div>
        </div>
                            
        <div class="comment">
          <p>
            {{ comment_content }}  
          </p>
        </div>
                             
      </div>
    </li>

    <hr class="sidebar-dividzer d-none d-md-block">
                
  </script>
  
  <script>
  
    // url parameter
    const urlParams = new URL(location.href).searchParams;
    const board_id = urlParams.get('board_id');
    
    // 처음 JSP에서 렌더링된 댓글에 적용
    $(document).ready(function() {
   	  renderComment();  
   	});
    
    // 게시물
	    // 게시물 수정 버튼 클릭 이벤트
	    $("#update_btn").click(function(){
	   	  location.href="/board/modify?board_id=" + board_id;
	    });
	    
	    // 게시물 삭제 이벤트
	    $("#delete_btn").click(function(){
	   	  if( !confirm("게시물을 삭제하시겠습니까?") ){ return false; }
	   	  
	   	  $.ajax({
	   		  type: "put",
	   		  url: "/api/board/delete",
	   		  data: { board_id : board_id },
	   		  dataType: "json",
	   		  success: function(res){
	   			  
	   			  // session은 공통으로 묶어서 Exception 처리하는 것이 좋아보임!
	   			  if( res.result === false ){
	   				  // 세션 체크
	   				  if( res.message === "notSession" ){
	   					  alert("세션 시간 초과. 로그인 후 다시 시도해주세요.");
	   					  location.href="/login";
	   					  return false;
	   				  }
	   				  // 삭제 실패
	   				  if( res.message === "deleteFail" ){
	   					  alert("삭제 실패.");
	   					  return false;
	   				  }
	   			  }else{
	   				  alert("삭제되었습니다.");
	   				  location.href="/";
	   				  return true;
	   			  }
	   			  
	   		  },
	   		  error: function(err){
	   			  alert("서버 오류. 관리자에게 문의해주세요.");
	   	      console.log("서버 오류", err);
	   		  }
	   	  });
	   	  
	    });
    
	    
    // 답글 
		  // 답변 폼 생성 
		  $(document).on("click", ".commentReply", function(e){
		    // 로그아웃시 답글 버튼 막기
			  if( !preventButton(e) ){ return false; }
		
	 		  const commentDiv = $(this).closest(".commentDiv");
			  const commentHead2 = $(this).closest(".commentDiv").find(".commentHead2");
		
		    // 버튼 이벤트시 다른 폼 제거
		    $("#commentForm").hide();
		    $("#updateForm").remove();
		    $("#replyFormEvent").remove();
			  commentHead2.hide();
			   
		    const li = $(this).closest("li");
			  const parentLevel = li.data("parentlevel");
			  const tagName = li.data("tagname") ?? '';
			  const userName = li.data("name");
			   
			  const name = tagName === '' ? userName : tagName;
			   
			  // 답변 폼
			  const replyForm =
				  '<div style="padding-left: 2rem; margin-left: ' + (parentLevel * 20) + 'px;">' +
		      '  <form action="#" class="flex" id="replyFormEvent" name="replyFormEvent">' +
		      '    <input type="hidden" name="boardNo" value="1">' +
		      '    <textarea cols="30" rows="2" id="comment_content" name="comment_content" class="form-control flex" style="width: 90%" placeholder="내용">@' + name + ' </textarea>' +
		      '    <a href="#" class="commentAdd" style="width: 9%">' +
		      '      <button id="reply-cancle-button" type="button" class="btn btn-secondary btn ml-1" style="margin-top: 0.75rem;width: 100%">취소</button>' +
		      '      <button id="reply-button" type="button" class="btn btn-primary btn ml-1" style="margin-top: 0.75rem;width: 100%">등록</button>' +
		      '    </a>' +
		      '  </form>' +
		      '</div>';
		       
		    commentDiv.after(replyForm);
			   
		  });
		   
		  // 답글 취소 클릭 이벤트
		  $(document).on("click", "#reply-cancle-button", function(e){
			  e.preventDefault();
			  const commentHead2 = $(this).closest("li").find(".commentHead2");
			  
		    $("#replyFormEvent").remove();
		    $("#commentForm").show();
		    commentHead2.show();
		  })
		   
		  // 수정 폼 생성 
		  $(document).on("click", ".commentModify", function(e){
		
			  // 로그아웃시 답글 버튼 막기
			  if( !preventButton(e) ){ return false; }
		   
			  const comment = $(this).closest(".commentDiv").find(".comment");
			  const commentHead2 = $(this).closest(".commentDiv").find(".commentHead2");
			   
		    $("#commentForm").hide();
		    $("#updateForm").remove();
		    $("#replyFormEvent").remove();
		    commentHead2.hide();
		    comment.hide();
		    
		    const li = $(this).closest("li");
		    const userName = li.data("name");
		    const content = li.data("content");
		    
		    // 수정 폼
		    const updateForm =
		      '<form action="#" class="flex" id="updateForm" name="updateForm">' +
		      '  <input type="hidden" name="boardNo" value="1">' +
		      '  <textarea cols="30" rows="2" id="comment_content" name="comment_content" class="form-control flex" style="width: 90%" placeholder="내용">@' + userName + ' ' + content + '</textarea>' +
		      '  <a href="#" class="commentAdd" style="width: 9%">' +
		      '    <button id="update-cancle-button" type="button" class="btn btn-secondary btn ml-1" style="margin-top: 0.75rem;width: 100%">취소</button>' +
		      '    <button id="update-button" type="button" class="btn btn-primary btn ml-1" style="margin-top: 0.75rem;width: 100%">수정</button>' +
		      '  </a>' +
		      '</form>';
		      
		    comment.after(updateForm);
		    
		  });
		   
		  // 수정 취소 클릭 이벤트
		  $(document).on("click", "#update-cancle-button", function(e){
			  e.preventDefault();
		    const comment = $(this).closest(".commentDiv").find(".comment");
		    const commentHead2 = $(this).closest(".commentDiv").find(".commentHead2");
			     
		    $("#updateForm").remove();
		    $("#commentForm").show();
		    commentHead2.show();
		    comment.show();
		  })
		  
		  
		  // 답변 등록 클릭 이벤트
		  $(document).on("click", "#reply-button", function(e){
		    // 로그아웃시 답글 버튼 막기
		    if( !preventButton(e) ){ return false; }
		   
		    if( !confirm("답글을 등록하시겠습니까?") ){ return false; }
			   
			  // 부모 댓글 정보 가져오기
			  const li = $(this).closest("li");
			  const commentId = li.data("commentid") ?? 0;
			  const tagName = li.data("tagname") ?? '';
			  const userName = li.data("name") ?? '';
			  const userId = li.data("id") ?? 0;
		    const rootId = li.data("rootid") ?? 0;
		    const parentId = li.data("parentid") ?? 0;
		    const parentLevel = li.data("parentlevel") ?? -1;
		    const name = tagName === '' ? userName : tagName;
			  const content = trimContent( name );
		    
		    if( content === '' ){ alert("댓글내용을 입력해주세요."); }
		     
		    // formData
			  let formData = new FormData();
			   
			  formData.append("comment_content", content);	   
			  formData.append("board_id", board_id);
			  formData.append("comment_root_id", rootId);
			  formData.append("comment_parent_id", commentId);
			  formData.append("tag_name", name);
			  
			  if( parentLevel == -1 ){
				  formData.append("comment_parent_level", 0);
			  }else{
				  formData.append("comment_parent_level", Number(parentLevel) + 1);
			  }
			  
			  $.ajax({
				  type: "post",
				  url: "/api/comment/write",
				  async: true,
				  data: formData,
				  dataType: "json",
				  processData: false,
				  contentType: false,
				  success: function(res){
				  console.log("res : ", res);
				   
				    if( res.result === true ){ 
					    alert("댓글 작성이 완료되었습니다."); 
					    
					    asyncComment( res.commentList );
					    renderComment();
					    $("#commentForm").show();
					    $("#comment_content").val('');
					    
					    $("#commentDiv").scrollTop( $("#commentDiv")[0].scrollHeight );
					    
				    } else { alert("댓글 작성 실패"); }
				   
				  },
				  error: function(){
		
				  }
			  })
			   
		  });
		  
		  // 답변 수정 클릭 이벤트
	    $(document).on("click", "#update-button", function(e){
	      // 로그아웃시 답글 버튼 막기
	      if( !preventButton(e) ){ return false; }
	     
	      if( !confirm("댓글을 수정하시겠습니까?") ){ return false; }
	      
	      // 댓글 정보 가져오기
        const li = $(this).closest("li");
        const commentId = li.data("commentid") ?? 0;
        const tagName = li.data("tagname") ?? '';
        const name = tagName === '' ? userName : tagName;
        const content = trimContent( name );
	      
	      const data = {
    		  comment_id : commentId,
    		  comment_content : content,
    		  board_id : board_id
    		}
	   	
	      $.ajax({
          type: "put",
          url: "/api/comment/update",
          async: true,
          data: data,
          dataType: "json",
          success: function(res){
          console.log("res : ", res);
           
            if( res.result === true ){ 
              alert("댓글 수정이 완료되었습니다."); 
              
              asyncComment( res.commentList );
              renderComment();
              
            } else { alert("댓글 수정 실패"); }
           
          },
          error: function(){
    
          }
        })
	      
	    });
		  
	    // 답변 삭제 클릭 이벤트
	    $(document).on("click", ".commentRemove", function(e){
	      // 로그아웃시 답글 버튼 막기
	      if( !preventButton(e) ){ return false; }
	     
	      if( !confirm("댓글을 삭제하시겠습니까?") ){ return false; }
	    
	      // 댓글 정보 가져오기
        const li = $(this).closest("li");
        const commentId = li.data("commentid") ?? 0;
        
        const data = {
          comment_id : commentId,
          board_id : board_id
        }
	      
	      $.ajax({
          type: "put",
          url: "/api/comment/delete",
          async: true,
          data: data,
          dataType: "json",
          success: function(res){
          console.log("res : ", res);
           
            if( res.result === true ){ 
              alert("댓글 삭제가 완료되었습니다."); 
              
              asyncComment( res.commentList );
              renderComment();
              
            } else { alert("댓글 삭제 실패"); }
           
          },
          error: function(){
    
          }
        })
	      
	    });
		  
		   
		  // 로그아웃시 버튼 막기
		  function preventButton(e){
			  const userDtoExists = ${not empty UserDto ? 'true' : 'false'};
			  
			  if (!userDtoExists) { // 로그인 여부 변수
			    e.preventDefault();
			    if( confirm("로그인 후 이용 가능합니다. 로그인하시겠습니까?") ){
			      location.href = "/login";
			    }
			    return false;
			  }
			  return true;
		  }
		  
		  // 태그네임 존재하면 제외
		  function trimContent( name ){
			  let content = $("#comment_content").val();
        const prefix = "@" + name + " ";
        
        if( content.startsWith( prefix ) ){
            content = content.substring( prefix.length );
        }
        
        return content;
		  }
		  
		  // 비동기 렌더링
		  function renderComment(){
			  $("#commentDiv li").each(function(){
	        // 삭제된 댓글 표시
	        const isDeleted = $(this).data("deletestate");  // 혹은 class, 특정 속성으로 판단
	        const deleteHtml = '<div class="py-2">삭제된 댓글입니다.</div>';
	        
	        if( isDeleted ){
	          $(this).find(".commentDiv").html( deleteHtml );
	        }
	        
	        // 본인 게시물에만 수정 삭제 버튼 표시
	        const userDtoExists = ${not empty UserDto ? 'true' : 'false'};
	        const writerId = $(this).data("id");
	        const loginId = "${ UserDto.user_id }";
	        const buttonHtml = '<div class="commentModify">수정</div>' +
	                           '<div class="commentRemove">삭제</div>';
	                           
	        if( userDtoExists ){
	          if( writerId == loginId ){ 
	            $(this).find(".commentHead2").append( buttonHtml ); 
	          }
	        }
	        
	        // parentlevel이 0이면 태그 이름 출력 x
	        const parentLevel = $(this).data("parentlevel");
	        const tagName = "@" + $(this).data("tagname") + " ";
	        const content = $(this).data("content");
	        
	        if( parentLevel !== 0 ){
	          $(this).find(".comment p").html( tagName + content );
	        }
	        
	      });
		  };
		  
		  // 댓글 목록 렌더링
		  function asyncComment( commentList ){
	      let html = "";
	      
	      commentList.forEach( comment => {
			    let asyncCommentHtml = $("#asyncComment").html();
	    	  
	        let item = asyncCommentHtml
	              .replaceAll("{{ user_id }}", comment.user_id ?? 0)
	              .replaceAll("{{ comment_id }}", comment.comment_id)
	              .replaceAll("{{ writer_name }}", comment.writer_name)
	              .replaceAll("{{ tag_name }}", comment.tag_name)
	              .replaceAll("{{ comment_content }}", comment.comment_content)
	              .replaceAll("{{ comment_parent_level }}", comment.comment_parent_level)
	              .replaceAll("{{ parent_level_margin }}", comment.comment_parent_level * 20)
	              .replaceAll("{{ comment_root_id }}", comment.comment_root_id)
	              .replaceAll("{{ comment_parent_id }}", comment.comment_parent_id)
	              .replaceAll("{{ comment_display_date }}", comment.comment_display_date)
	              .replaceAll("{{ comment_delete_state }}", comment.comment_delete_state);
	              
	        html += item;
	      })
	      console.log("html : ", html);
	      
	      $("#commentDiv").html(html);
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
