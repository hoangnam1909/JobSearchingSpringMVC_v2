<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="py-4">
    <h1 class="text-center dark-color mb-3">QUẢN LÝ TIN TUYỂN DỤNG</h1>

    <div class="row">
        <div class="col">
            <div class="card shadow my-4">
                <div class="card-header py-3 d-flex justify-content-between">
                    <h4 class="m-0 font-weight-bold text-primary" style="align-self: center">
                        Danh sách tin tuyển dụng
                    </h4>

                    <nav aria-label="...">
                        <ul class="pagination justify-content-center my-2">
                            <c:forEach begin="1" end="${Math.ceil(counter/jobPostService.maxItemsInPage)}" var="page">
                                <li class="page-item">
                                    <a class="page-link" style="cursor: pointer"
                                       onclick="loadJobPost(${page})">${page}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <a href="<c:url value="/admin/job-post/add" />" style="text-decoration: none">
                            <i class="fa-solid fa-plus"></i>
                            <span>
                                Thêm tin tuyển dụng
                            </span>
                        </a>
                    </div>
                    <div id="alert-area"></div>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th class="text-center" style="width: 12%">Hành động</th>
                                <th class="text-center" style="width: 5%">STT</th>
                                <th>Tiêu đề</th>
                                <th>Ngày đăng</th>
                                <th>Nhà tuyển dụng</th>
                                <th>Loại việc làm</th>
                            </tr>
                            </thead>
                            <tbody id="tbody-data-job-post">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-3">
            <h2 class="text-center dark-color mt-4 mb-1">Bộ lọc</h2>
            <section class="d-flex justify-content-center">
                <form class="mt-3" action="javascript:void(0)" style="width: 80%">
                    <div class="form-group">
                        <label for="username">Tên đăng nhập</label>
                        <input class="form-control" name="username" id="username" value="${usernameSearch}">
                    </div>
                    <div class="form-group">
                        <label for="phone">Số điện thoại</label>
                        <input class="form-control" name="phone" id="phone" value="${phoneSearch}">
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input class="form-control" name="email" id="email" value="${emailSearch}">
                    </div>
                    <div class="form-group">
                        <label for="userType">Loại tài khoản</label>
                        <select class="form-control" name="userType" id="userType">
                            <option value="" selected>Không chọn</option>
                            <c:if test="${userTypeSearch.equals('ROLE_ADMIN')}">
                                <option value="ROLE_ADMIN" selected>Admin</option>
                            </c:if>
                            <c:if test="${!userTypeSearch.equals('ROLE_ADMIN')}">
                                <option value="ROLE_ADMIN">Admin</option>
                            </c:if>

                            <c:if test="${userTypeSearch.equals('ROLE_NTD')}">
                                <option value="ROLE_NTD" selected>Nhà tuyển dụng</option>
                            </c:if>
                            <c:if test="${!userTypeSearch.equals('ROLE_NTD')}">
                                <option value="ROLE_NTD">Nhà tuyển dụng</option>
                            </c:if>

                            <c:if test="${userTypeSearch.equals('ROLE_UV')}">
                                <option value="ROLE_UV" selected>Ứng viên</option>
                            </c:if>
                            <c:if test="${!userTypeSearch.equals('ROLE_UV')}">
                                <option value="ROLE_UV">Ứng viên</option>
                            </c:if>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary" onclick="loadJobPost(1)">Tra cứu</button>
                    <input type="button" class="btn btn-primary" onclick="loadJobPost(1)"
                           value="Loại bỏ bộ lọc"/>
                </form>
            </section>
        </div>
    </div>
</section>

<%--<div class="container">--%>
<%--    <h1 class="text-center dark-color">QUẢN LÝ TIN TUYỂN DỤNG</h1>--%>

<%--    <section class="d-flex justify-content-center">--%>
<%--        <form class="mt-3 w-50">--%>
<%--            <div class="form-group">--%>
<%--                <label for="title">Tiêu đề</label>--%>
<%--                <input class="form-control" name="title" id="title" value="${title}">--%>
<%--            </div>--%>

<%--            <div class="form-group">--%>
<%--                <label for="beginningSalary">Lương khởi điểm từ</label>--%>
<%--                <input class="form-control" name="beginningSalary" id="beginningSalary" value="${beginningSalary}">--%>
<%--            </div>--%>

<%--            <div class="form-group">--%>
<%--                <label for="endingSalary">Lương tối đa đến</label>--%>
<%--                <input class="form-control" name="endingSalary" id="endingSalary" value="${endingSalary}">--%>
<%--            </div>--%>

<%--            <div class="form-group">--%>
<%--                <label for="location">Địa điểm làm việc</label>--%>
<%--                <input class="form-control" name="location" id="location" value="${location}">--%>
<%--            </div>--%>

<%--            <div class="form-group">--%>
<%--                <label for="sort">Sắp xếp</label>--%>
<%--                <select class="form-control" name="sort" id="sort">--%>
<%--                    <option value="" selected>Không chọn</option>--%>
<%--                    <c:if test="${sort.equals('asc')}">--%>
<%--                        <option value="asc" selected>Ngày đăng cũ nhất</option>--%>
<%--                    </c:if>--%>
<%--                    <c:if test="${!sort.equals('asc')}">--%>
<%--                        <option value="asc">Ngày đăng cũ nhất</option>--%>
<%--                    </c:if>--%>

<%--                    <c:if test="${sort.equals('desc')}">--%>
<%--                        <option value="desc" selected>Ngày đăng mới nhất</option>--%>
<%--                    </c:if>--%>
<%--                    <c:if test="${!sort.equals('desc')}">--%>
<%--                        <option value="desc">Ngày đăng mới nhất</option>--%>
<%--                    </c:if>--%>
<%--                </select>--%>
<%--            </div>--%>

<%--            <button type="submit" class="btn btn-info">Tra cứu</button>--%>
<%--            <input type="button" class="btn btn-dark" onclick="removeFilter()" value="Loại bỏ bộ lọc"/>--%>
<%--        </form>--%>
<%--    </section>--%>
<%--</div>--%>

<%--<script src="<c:url value="/resources/vendor/datatables/jquery.dataTables.min.js" /> "></script>--%>
<%--<script src="<c:url value="/resources/vendor/datatables/dataTables.bootstrap4.min.js" /> "></script>--%>
<%--<script src="<c:url value="/resources/js/datatables-demo.js"/>"></script>--%>
<script src="<c:url value="/resources/js/admin-job-post.js"/>"></script>

<script>
    let maxItems = ${jobPostService.maxItemsInPage};

    window.onload = (event) => {
        loadJobPost(1)
    };
</script>
