<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <h1 class="text-center dark-color">QUẢN LÝ TIN TUYỂN DỤNG</h1>

    <section class="d-flex justify-content-center">
        <form class="mt-3 w-50">
            <div class="form-group">
                <label for="title">Tiêu đề</label>
                <input class="form-control" name="title" id="title" value="${title}">
            </div>

            <div class="form-group">
                <label for="beginningSalary">Lương khởi điểm từ</label>
                <input class="form-control" name="beginningSalary" id="beginningSalary" value="${beginningSalary}">
            </div>

            <div class="form-group">
                <label for="endingSalary">Lương tối đa đến</label>
                <input class="form-control" name="endingSalary" id="endingSalary" value="${endingSalary}">
            </div>

            <div class="form-group">
                <label for="location">Địa điểm làm việc</label>
                <input class="form-control" name="location" id="location" value="${location}">
            </div>

            <div class="form-group">
                <label for="sort">Sắp xếp</label>
                <select class="form-control" name="sort" id="sort">
                    <option value="" selected>Không chọn</option>
                    <c:if test="${sort.equals('asc')}">
                        <option value="asc" selected>Ngày đăng cũ nhất</option>
                    </c:if>
                    <c:if test="${!sort.equals('asc')}">
                        <option value="asc">Ngày đăng cũ nhất</option>
                    </c:if>

                    <c:if test="${sort.equals('desc')}">
                        <option value="desc" selected>Ngày đăng mới nhất</option>
                    </c:if>
                    <c:if test="${!sort.equals('desc')}">
                        <option value="desc">Ngày đăng mới nhất</option>
                    </c:if>
                </select>
            </div>

            <button type="submit" class="btn btn-info">Tra cứu</button>
            <input type="button" class="btn btn-dark" onclick="removeFilter()" value="Loại bỏ bộ lọc"/>
        </form>
    </section>
</div>

<div class="container">
    <c:if test="${sucMsg != null}">
        <div class="alert alert-success" role="alert">
                ${sucMsg}
        </div>
    </c:if>

    <c:if test="${errMsg != null}">
        <div class="alert alert-danger" role="alert">
                ${errMsg}
        </div>
    </c:if>

    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link" href="<c:url value="/admin/job-post/add-or-update"/>">
                <i class="fa-solid fa-plus"></i>
                Thêm
            </a>
        </li>
    </ul>

    <table class="table table-striped">
        <thead>
        <tr>
            <th class="text-center" style="width: 15%">Thực thi</th>
            <th class="text-center" style="width: 5%">STT</th>
            <th>Tiêu đề</th>
            <th>Ngày đăng</th>
            <th>Nhà tuyển dụng</th>
            <th>Đăng bởi</th>
            <th>Loại việc làm</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${jobPosts}" var="jp" varStatus="loop">
            <tr>
                <td style="text-align: center">
                    <a style="margin-right: 10px" href="<c:url value="/admin/job-post/view" />?id=${jp.id}"
                       title="Xem chi tiết">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                    <a style="margin-right: 10px" href="<c:url value="/admin/job-post/add-or-update" />?id=${jp.id}"
                       title="Sửa">
                        <i class="fa-solid fa-pen"></i>
                    </a>
                    <a style="margin-right: 10px" href="<c:url value="/admin/job-post/delete" />?id=${jp.id}"
                       class="confirmation" title="Xoá">
                        <i class="fa-solid fa-trash"></i>
                    </a>
                </td>
                <td class="text-center">${(currentPage - 1) * jobPostService.maxItemsInPage + loop.index + 1}</td>
                <td> ${jp.title} </td>
                <td>
                    <c:if test="${jp.createdDate != null}">
                        <fmt:formatDate pattern="dd/MM/yyyy" value="${jp.createdDate}"/>
                    </c:if>
                </td>
                <td> ${employerService.getByUserId(jp.postedByUser.id).name} </td>
                <td> ${userService.getById(jp.postedByUser.id).username} </td>
                <td> ${jobTypeService.getById(jp.jobType.id).name} </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <ul class="pagination d-flex justify-content-center mt-4">
        <c:forEach begin="1" end="${Math.ceil(counter/jobPostService.maxItemsInPage)}" var="page">
            <li class="page-item">
                <a class="page-link" onclick="updateQueryStringParameter('page', ${page})">${page}</a>
            </li>
        </c:forEach>
    </ul>
</div>

<script>
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