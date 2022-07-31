<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<section class="py-4">
    <h1 class="text-center dark-color mb-3">QUẢN LÝ NGƯỜI DÙNG</h1>

    <div class="row">
        <div class="col">
            <div class="card shadow my-4">
                <div class="card-header py-3 d-flex justify-content-between">
                    <h4 class="m-0 font-weight-bold text-primary" style="align-self: center">
                        Danh sách người dùng
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
                        <a href="<c:url value="/admin/account/add-or-update" />" style="text-decoration: none">
                            <i class="fa-solid fa-plus"></i>
                            <span>
                                Thêm người dùng
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
                                <th>Tên đăng nhập</th>
                                <th>Số điện thoại</th>
                                <th>Email</th>
                                <th>Loại tài khoản</th>
                            </tr>
                            </thead>
                            <tbody id="tbody-data">
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

                    <button type="submit" class="btn btn-primary" onclick="loadUserAccount()">Tra cứu</button>
                    <input type="button" class="btn btn-primary" onclick="removeFilter()" value="Loại bỏ bộ lọc"/>
                </form>
            </section>
        </div>
    </div>
</section>

<script src="<c:url value="/resources/vendor/datatables/jquery.dataTables.min.js" /> "></script>
<script src="<c:url value="/resources/vendor/datatables/dataTables.bootstrap4.min.js" /> "></script>
<script src="<c:url value="/resources/js/datatables-demo.js"/>"></script>
<script src="<c:url value="/resources/js/admin-account.js"/>"></script>

<script>
    let maxItems = ${userService.maxItemsInPage}

        window.onload = (event) => {
            loadUserAccount(1)
        };

    $(document).ready(function () {
        $("form").submit(function () {
            $("input, select").each(function (index, obj) {
                if ($(obj).val() === "" || $(obj).val() === "-1") {
                    $(obj).remove();
                }
            });
        });
    });
</script>
