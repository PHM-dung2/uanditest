<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<title>Tables - main</title>

<jsp:include page="../include/head.jsp" />

<body id="page-top">
  <!-- Page Wrapper -->
  <div id="wrapper">
    
    <!-- Sidebar -->
    <jsp:include page="../include/sidebar.jsp" />

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
      <!-- Main Content -->
      <div id="content">
      
        <!-- Topbar -->
        <jsp:include page="../include/topbar.jsp" />

        <!-- Begin Page Content -->
        <div class="container-fluid">
          <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">게시판</h1>

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-body">
              <div class="table-responsive">
                <table
                  class="table table-bordered"
                  id=""
                  width="100%"
                  cellspacing="0"
                >
                  <colgroup>
                    <col width="20%" />
                    <col width="40%" />
                    <col width="30%" />
                    <col width="20%" />
                  </colgroup>

                  <thead>
                    <tr>
                      <th>닉네임</th>
                      <th>제목</th>
                      <th>날짜</th>
                      <th>댓글</th>
                    </tr>
                  </thead>
                  <tbody>
                    
                    <c:forEach var="board" items="${ pageInfo.list }">
                      <tr>
		                    <td>${ board.user_name }</td>
		                    <td><a href="/board/detail?board_id=${ board.board_id }">${ board.board_title }</a></td>
		                    <td>${ board.board_display_date }</td>
		                    <td>0개</td>
		                  </tr>
                    </c:forEach>

                  </tbody>
                </table>
                  
                <!-- pagination -->
							  <nav aria-label="...">
							    <ul class="pagination justify-content-center">
							      
							      <c:if test="${ pageInfo.hasPreviousPage }">
							        <li class="page-item">
							          <a href="?page=${pageInfo.prePage}" class="page-link">Previous</a>
						          </li>
							      </c:if>
							      
							      <c:forEach var="page" items="${ pageInfo.navigatepageNums }">
							        <li class="page-item ${page == pageInfo.pageNum ? 'active' : ''}">
								        <a class="page-link" href="?page=${page}">${page}</a>
								      </li>
							      </c:forEach>
							      
							      <c:if test="${ pageInfo.hasNextPage }">
								      <li class="page-item">
								        <a class="page-link" href="?page=${pageInfo.nextPage}">Next</a>
								      </li>
								    </c:if>
								    
							    </ul>
							  </nav>
							  <!-- pagination -->
                
                <a href="/board/write"
                  ><button
                    id="write_btn"
                    type="button"
                    class="btn btn-primary btn float-right"
                  >
                    게시글 작성
                  </button></a
                >
              </div>
            </div>
          </div>
        </div>
        <!-- /.container-fluid -->
      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <jsp:include page="../include/footer.jsp" />
      
    </div>
    <!-- End of Content Wrapper -->
  </div>
  <!-- End of Page Wrapper -->

  <!-- Logout Modal-->
  <jsp:include page="../include/logout_modal.jsp" />
  
  <script>
  
  const userDtoExists = ${not empty UserDto};
  
  // 게시물 작성 막기
  $("#write_btn").click(function (e) {
    if (!userDtoExists) { // 로그인 여부 변수
      e.preventDefault();
      if( confirm("로그인 후 이용 가능합니다. 로그인하시겠습니까?") ){
        location.href = "/login";
      }
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

  <!-- Page level plugins -->
  <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="/resources/js/demo/datatables-demo.js"></script>
</body>
</html>
