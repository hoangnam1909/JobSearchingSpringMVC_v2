<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<h1 class="h3 mb-2 text-gray-800">Xác nhận nhà tuyển dụng</h1>
<p class="mb-4">
    Chức năng này giúp quản trị viên xác nhận và cấp quyền hoạt động cho nhà tuyển dụng, điều này giúp họ có thể hoạt
    động trên trang web của bạn.
</p>

<div id="alert-area"></div>

<div class="card shadow my-4" id="data-card">
    <div class="card-header py-3 d-flex justify-content-between">
        <h4 class="m-0 font-weight-bold text-primary" style="align-self: center">
            Danh sách nhà tuyển dụng chưa được xác nhận
        </h4>

        <nav aria-label="...">
            <ul class="pagination justify-content-center my-2">
                <c:forEach begin="1" end="${Math.ceil(counter/userService.maxItemsInPage)}" var="page">
                    <li class="page-item">
                        <a class="page-link" style="cursor: pointer"
                           onclick="loadUserAccount(${page})">${page}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
    <div class="card-body">
        <div class="mb-3">
            <a href="<c:url value="/admin/account-permission/accept-all" />" style="text-decoration: none">
                <i class="fa-solid fa-check"></i>
                <span>
                    Xác nhận tất cả
                </span>
            </a>
        </div>
        <div id="alert-area"></div>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th class="text-center" style="width: 7%">Hành động</th>
                    <th class="text-center" style="width: 5%">STT</th>
                    <th>Tên đăng nhập</th>
                    <th>Tên công ty</th>
                    <th>Địa điểm</th>
                    <th>Lĩnh vực</th>
                </tr>
                </thead>
                <tbody id="tbody-data">
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="<c:url value="/resources/js/admin/account-permission.js"/>"></script>

<script>
    let maxItems = ${userService.maxItemsInPage};

    window.onload = (event) => {
        loadEmployers(1)
    };
</script>
