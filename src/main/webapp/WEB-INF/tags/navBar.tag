<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:url value="/main/home" var="homeLink"/>
<c:url value="/user/register" var="registerLink"/>
<c:url value="/serviceCenter/notice/notice" var="noticeLink"/>
<nav class="navbar navbar-expand-sm bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="${homeLink }">Spring Tour</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
      <i class="fa-solid fa-bars-staggered"></i>
    </button>
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasNavbarLabel">Offcanvas</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
        <ul class="navbar-nav justify-content-left flex-grow-1 pe-3">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="${homeLink }">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${noticeLink }">Notice</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="${homeLink }" id="offcanvasNavbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Dropdown
            </a>
            <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown">
              <li><a class="dropdown-item" href="${homeLink }">Action</a></li>
              <li><a class="dropdown-item" href="${homeLink }">Another action</a></li>
              <li>
                <hr class="dropdown-divider">
              </li>
              <li><a class="dropdown-item" href="${homeLink }">Something else here</a></li>
            </ul>
          </li>
          
          <sec:authorize access="not isAuthenticated()">
	          <li class="nav-item">
	            <a class="nav-link" href="${registerLink }">회원가입</a>
	          </li>
          </sec:authorize>
          
        </ul>
        <form class="d-flex" role="search">
          <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success" type="submit">Search</button>
        </form>
      </div>
    </div>
  </div>
</nav>