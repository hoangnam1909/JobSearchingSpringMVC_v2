<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar sticky-top navbar-expand-md bg-dark navbar-dark">
    <!-- Brand -->
    <c:choose>
        <c:when test = "${currentUser.userType == 'ROLE_ADMIN'}">
            <a class="navbar-brand" href="<c:url value="/admin" />">Job Searching</a>
        </c:when>

        <c:when test = "${currentUser.userType == 'ROLE_NTD'}">
            <a class="navbar-brand" href="<c:url value="/employer" />">Job Searching</a>
        </c:when>

        <c:when test = "${currentUser.userType == 'ROLE_UV'}">
            <a class="navbar-brand" href="<c:url value="/candidate" />">Job Searching</a>
        </c:when>

        <c:otherwise>
            <a class="navbar-brand" href="<c:url value="/" />">Job Searching</a>
        </c:otherwise>
    </c:choose>
    <!-- Toggler/collapsibe Button -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Navbar links -->
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
        <ul class="navbar-nav">
            <c:if test="${currentUser.userType == 'ROLE_ADMIN'}">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/admin/account"/> ">Tài khoản</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/admin/account-permission"/> ">Duyệt NTD</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/admin/job-post"/> ">Bài viết</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/admin/job-type"/> ">Loại việc làm</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                        Thống kê
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="<c:url value="/admin/stats/user"/>">Thống kê loại tài khoản</a>
                        <a class="dropdown-item" href="<c:url value="/admin/stats/jobPostDate"/>">Thống kê bài viết theo tháng</a>
                        <a class="dropdown-item" href="<c:url value="/admin/stats/jobPostByJobType"/>">Thống kê bài viết theo loại việc làm</a>
                    </div>
                </li>
            </c:if>
            <c:if test="${currentUser.userType == 'ROLE_NTD' && currentUser.active == 1}">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/employer/employer-info/add-or-update"/>">
                        Cập nhật thông tin
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/employer/post/add-or-update" />">Đăng tin</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/employer/management" />">Quản lý tin tuyển dụng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/employer/find" />">Tìm kiếm ứng viên</a>
                </li>
            </c:if>
            <c:if test="${currentUser.userType == 'ROLE_UV'}">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/candidate/candidate-info/add-or-update"/>">Cập nhật thông tin</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/candidate/find-employer"/>">Tìm kiếm nhà tuyển dụng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/candidate/suggest-employer"/>">Gợi ý nhà tuyển dụng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/candidate/find-job"/>">Tìm việc làm</a>
                </li>
            </c:if>
        </ul>
    </div>
    <c:if test="${currentUser != null}">
        <ul class="nav navbar-nav navbar-right">
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/me/view" />">
                            <span>
                                <i class="fa-solid fa-user"></i>
                            </span>

                    <c:if test="${!(currentUser.userType == 'ROLE_NTD')}">
                        ${currentUser.fullName}
                    </c:if>

                    <c:if test="${currentUser.userType == 'ROLE_NTD'}">
                        ${employerService.getByUserId(currentUser.id).name}
                    </c:if>

                    <span class="badge badge-secondary">${currentUser.userType}</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/logout" />">
                    Đăng xuất
                </a>
            </li>
        </ul>
    </c:if>
    <c:if test="${currentUser == null}">
        <ul class="nav navbar-nav navbar-right">
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/login" />">Đăng nhập</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/register" />">Đăng ký</a>
            </li>
        </ul>
    </c:if>
</nav>