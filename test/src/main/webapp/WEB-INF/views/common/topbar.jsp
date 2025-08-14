<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <!-- Topbar -->
  <nav
    class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow"
  >
    <!-- Sidebar Toggle (Topbar) -->
    <form class="form-inline">
      <button
        id="sidebarToggleTop"
        class="btn btn-link d-md-none rounded-circle mr-3"
      >
        <i class="fa fa-bars"></i>
      </button>
    </form>

    <!-- Topbar Navbar -->
    <ul class="navbar-nav ml-auto">
      <div class="topbar-divider d-none d-sm-block"></div>

      <!-- Nav Item - User Information -->
      <li class="nav-item dropdown no-arrow">
        
        <c:choose>
          <c:when test="${ empty UserDto }">
            <a
              class="nav-link dropdown-toggle"
              href="#"
              id="userDropdown"
              role="button"
              data-toggle="dropdown"
              aria-haspopup="true"
              aria-expanded="false"
            >
              <span
                id="profile_user_name" 
                class="mr-2 d-none d-lg-inline text-gray-600 small"
                >Guest</span
              >
              <img
                class="img-profile rounded-circle"
                src="/resources/img/undraw_profile.svg"
              />
            </a>
          </c:when>
          <c:otherwise>
            <a
		          class="nav-link dropdown-toggle"
		          href="#"
		          id="userDropdown"
		          role="button"
		          data-toggle="dropdown"
		          aria-haspopup="true"
		          aria-expanded="false"
		        >
		          <span
		            id="profile_user_name" 
		            class="mr-2 d-none d-lg-inline text-gray-600 small"
		            >${ UserDto.user_name }</span
		          >
		          <img
		            class="img-profile rounded-circle"
		            src="/resources/img/undraw_profile.svg"
		          />
		        </a>
		        <!-- Dropdown - User Information -->
		        <div
		          class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
		          aria-labelledby="userDropdown"
		        >
		          <a class="dropdown-item" href="#">
		            <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
		            Profile
		          </a>
		
		          <div class="dropdown-divider"></div>
		          <a
		            id="modal_logout_button"
		            class="dropdown-item"
		            href="#"
		            data-toggle="modal"
		            data-target="#logoutModal"
		          >
		            <i
		              class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"
		            ></i>
		            Logout
		          </a>
		        </div>
          </c:otherwise>
        
        </c:choose>
        
      </li>
    </ul>
  </nav>
  <!-- End of Topbar -->

</body>
</html>