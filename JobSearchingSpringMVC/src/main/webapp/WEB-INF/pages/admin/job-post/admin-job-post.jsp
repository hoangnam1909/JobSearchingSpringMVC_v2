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
                        <ul class="pagination justify-content-center my-2" id="pagination-area">
                            <%--                            <c:forEach begin="1" end="${Math.ceil(counter/jobPostService.maxItemsInPage)}" var="page">--%>
                            <%--                                <li class="page-item">--%>
                            <%--                                    <a class="page-link" style="cursor: pointer"--%>
                            <%--                                       onclick="loadJobPost(${page})">${page}</a>--%>
                            <%--                                </li>--%>
                            <%--                            </c:forEach>--%>
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
                        <label for="title">Tên việc làm</label>
                        <input class="form-control" name="title" id="title">
                    </div>
                    <div class="form-group">
                        <label for="employerName">Nhà tuyển dụng</label>
                        <input class="form-control" name="employerName" id="employerName">
                    </div>
                    <div class="form-group">
                        <label for="jobType">Loại tài khoản</label>
                        <select class="form-control" name="userType" id="jobType"
                                onfocus='this.size=10;' onblur='this.size=1;' onchange='this.size=1; this.blur();'>
                            <option value="" selected>Không chọn</option>

                            <c:forEach items="${jobTypes}" var="jobType">
                                <option value="${jobType.id}">${jobType.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary" onclick="loadJobPost()">Tra cứu</button>
                    <input type="button" class="btn btn-primary" onclick="loadJobPostWithNoFilter()"
                           value="Loại bỏ bộ lọc"/>
                </form>
            </section>
        </div>
    </div>
</section>

<script src="<c:url value="/resources/js/admin/admin-job-post.js"/>"></script>

<script>
    let maxItems = ${jobPostService.maxItemsInPage};

    window.onload = (event) => {
        loadJobPost(1)
    };
</script>
