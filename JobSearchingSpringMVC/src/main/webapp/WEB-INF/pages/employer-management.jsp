<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <h1 class="text-center dark-color">TRANG QUẢN LÝ TIN TUYỂN DỤNG</h1>

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

    <button type="button" class="btn btn-primary"
            data-toggle="modal" data-target="#exampleModal"
            onclick="viewInfo(36)">
        Launch demo modal
    </button>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="modal-body">
                    ...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${jobPosts.size() == 0}">
        <div class="alert alert-danger mt-4 d-flex justify-content-center align-items-center" style="height: 80px"
             role="alert">
            <h5>Không có dữ liệu về bài viết!</h5>
        </div>
    </c:if>
    <c:if test="${jobPosts.size() != 0}">
        <table class="table table-striped mt-5">
            <thead>
            <tr>
                <th class="text-center" style="width: 15%"></th>
                <th class="text-center" style="width: 5%">STT</th>
                <th>Tiêu đề</th>
                <th>Ngày đăng</th>
                <th>Loại việc làm</th>
                <th>Lương khởi điểm (VNĐ)</th>
                <th>Lương tối đa (VNĐ)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${jobPosts}" var="jp" varStatus="loop">
                <tr>
                    <td style="text-align: center">
                        <a style="margin-right: 10px" href="<c:url value="/employer/post/view" />?id=${jp.id}"
                           title="Xem chi tiết" onclick="">
                            <i class="fa-solid fa-eye"></i>
                        </a>
                        <a style="margin-right: 10px"
                           href="<c:url value="/employer/post/add-or-update" />?id=${jp.id}"
                           title="Sửa">
                            <i class="fa-solid fa-pen"></i>
                        </a>
                        <a style="margin-right: 10px" href="<c:url value="/employer/post/delete" />?id=${jp.id}"
                           class="confirmation" title="Xoá">
                            <i class="fa-solid fa-trash"></i>
                        </a>
                    </td>
                    <td class="text-center">${(currentPage - 1) * maxItems + loop.index + 1}</td>
                    <td> ${jp.title} </td>
                    <td>
                        <c:if test="${jp.createdDate != null}">
                            <fmt:formatDate pattern="dd/MM/yyyy" value="${jp.createdDate}"/>
                        </c:if>
                    </td>
                    <td> ${jobTypeService.getById(jp.jobType.id).name} </td>
                    <td>
                        <fmt:formatNumber type="number" maxFractionDigits="3"
                                          value="${jp.beginningSalary}"/>
                    </td>
                    <td>
                        <fmt:formatNumber type="number" maxFractionDigits="3"
                                          value="${jp.endingSalary}"/>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

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

        <ul class="pagination d-flex justify-content-center mt-2 mx-auto">
            <c:forEach begin="1" end="${Math.ceil(counter/maxItems)}" var="page">
                <li class="page-item">
                    <a class="page-link" href="${url}?page=${page}">${page}</a>
                </li>
            </c:forEach>
        </ul>
    </c:if>
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
