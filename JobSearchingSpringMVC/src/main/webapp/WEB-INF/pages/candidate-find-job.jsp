<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <h1 class="text-center dark-color mb-5">TÌM KIẾM VIỆC LÀM</h1>
    <button onclick="loadJobs()">click me</button>
    <div class="row">
        <div class="col-3" style="border-right: 1px solid lightgray">
            <div style="position: sticky; top: 80px">
                <h3 class="text-center dark-color m-0 py-2">BỘ LỌC</h3>
                <section class="d-flex px-3">
                    <form class="mt-3 w-100">
                        <div class="form-group">
                            <label for="title">Tiêu đề</label>
                            <input class="form-control" name="title" id="title" value="${title}">
                        </div>

                        <div class="form-group">
                            <label for="beginningSalary">Lương khởi điểm từ</label>
                            <input class="form-control" name="beginningSalary" id="beginningSalary"
                                   value="${beginningSalary}">
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

                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-info">Tra cứu</button>
                            <input type="button" class="btn btn-dark" onclick="removeFilter()" value="Loại bỏ bộ lọc"/>
                        </div>
                    </form>
                </section>
            </div>
        </div>
        <div class="col px-4">
            <ul class="pagination d-flex justify-content-end m-0">
                <c:forEach begin="1" end="${Math.ceil(counter/maxItems)}" var="page">
                    <li class="page-item">
                        <a class="page-link" onclick="updateQueryStringParameter('page', ${page})">${page}</a>
                    </li>
                </c:forEach>
            </ul>

            <div id="display-jobs">

            </div>

<%--            <c:forEach items="${jobPosts}" var="jp" varStatus="loop">--%>
<%--                <div class="container m-0 p-0 pt-2">--%>
<%--                    <div class="col">--%>
<%--                        <div class="row">--%>
<%--                            <div class="media g-mb-30 media-comment w-100">--%>
<%--                                <a class="text-decoration-none"--%>
<%--                                   href="<c:url value="/candidate/view-post"/>?id=${jp.id}">--%>
<%--                                    <img class="d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15"--%>
<%--                                         src="${userService.getById(jp.postedByUser.id).avatar}"--%>
<%--                                         alt="Image Description">--%>
<%--                                </a>--%>

<%--                                <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">--%>
<%--                                    <div class="g-mb-15">--%>
<%--                                        <a class="text-decoration-none"--%>
<%--                                           href="<c:url value="/candidate/view-post"/>?id=${jp.id}">--%>
<%--                                            <h3 class="text-info mb-3">--%>
<%--                                                    ${jp.title}--%>
<%--                                            </h3>--%>
<%--                                        </a>--%>
<%--                                    </div>--%>

<%--                                    <c:if test="${jp.createdDate != null}">--%>
<%--                                        <h5 class="g-color-gray-dark-v1 mb-3">--%>
<%--                                            Ngày đăng: <span style="font-weight: 400">--%>
<%--                                    <fmt:formatDate pattern="HH:mm:ss - dd/MM/yyyy" value="${jp.createdDate}"/>--%>
<%--                                </span>--%>
<%--                                        </h5>--%>
<%--                                    </c:if>--%>

<%--                                    <c:if test="${jp.description.length() > 0}">--%>
<%--                                        <h5 class="g-color-gray-dark-v1 mb-3">--%>
<%--                                            Mô tả: <span style="font-weight: 400"> ${jp.description} </span>--%>
<%--                                        </h5>--%>
<%--                                    </c:if>--%>

<%--                                    <c:if test="${jp.location.length() > 0}">--%>
<%--                                        <h5 class="g-color-gray-dark-v1 mb-3">--%>
<%--                                            Địa điểm: <span style="font-weight: 400"> ${jp.location} </span>--%>
<%--                                        </h5>--%>
<%--                                    </c:if>--%>

<%--                                    <c:if test="${jp.beginningSalary != null}">--%>
<%--                                        <h5 class="g-color-gray-dark-v1 mb-3">--%>
<%--                                            Lương khởi điểm: <span style="font-weight: 400">--%>
<%--                                    <fmt:formatNumber type="number" maxFractionDigits="3"--%>
<%--                                                      value="${jp.beginningSalary}"/> VNĐ--%>
<%--                            </span>--%>
<%--                                        </h5>--%>
<%--                                    </c:if>--%>

<%--                                    <c:if test="${jp.endingSalary != null}">--%>
<%--                                        <h5 class="g-color-gray-dark-v1 mb-3">--%>
<%--                                            Lương tối đa: <span style="font-weight: 400">--%>
<%--                                <fmt:formatNumber type="number" maxFractionDigits="3"--%>
<%--                                                  value="${jp.endingSalary}"/> VNĐ--%>
<%--                            </span>--%>
<%--                                        </h5>--%>
<%--                                    </c:if>--%>

<%--                                    <!-- Button trigger modal -->--%>
<%--                                    <button type="button" class="btn btn-info" data-toggle="modal"--%>
<%--                                            data-target="#exampleModalCenter${jp.id}"--%>
<%--                                            onclick="viewFullInfoJob(${jp.id})">--%>
<%--                                        Đăng ký ứng tuyển--%>
<%--                                    </button>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <!-- Modal -->--%>
<%--                <div class="modal fade" id="exampleModalCenter${jp.id}" tabindex="-1" role="dialog"--%>
<%--                     aria-labelledby="exampleModalCenterTitle" aria-hidden="true">--%>
<%--                    <div class="modal-dialog modal-dialog-centered" role="document">--%>
<%--                        <div class="modal-content">--%>
<%--                            <div class="modal-header px-4">--%>
<%--                                <h5 class="modal-title" id="exampleModalLongTitle">Xác nhận nộp đơn ứng tuyển</h5>--%>
<%--                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                                    <span aria-hidden="true">&times;</span>--%>
<%--                                </button>--%>
<%--                            </div>--%>
<%--                            <div class="modal-body px-4" id="modal-body-${jp.id}"></div>--%>
<%--                            <div class="modal-footer px-4">--%>
<%--                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>--%>
<%--                                <button type="button" class="btn btn-info" id="button-submit-${jp.id}"--%>
<%--                                        onclick="applyJob(${candidateService.getByUserId(currentUser.id).id}, ${jp.id})">--%>
<%--                                    Nộp đơn ứng tuyển--%>
<%--                                </button>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </c:forEach>--%>
        </div>
    </div>
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

<style>
    @media (min-width: 0) {
        .g-mr-15 {
            margin-right: 15px !important;
        }
    }

    @media (min-width: 0) {
        .g-mt-3 {
            margin-top: 10px !important;
        }
    }

    .g-height-50 {
        height: 50px;
    }

    .g-width-50 {
        width: 50px !important;
    }

    @media (min-width: 0) {
        .g-pa-30 {
            padding: 20px !important;
        }
    }

    .g-bg-secondary {
        background-color: #fafafa !important;
    }

    .u-shadow-v18 {
        box-shadow: 0 5px 10px -6px rgba(0, 0, 0, 0.15);
    }

    .g-color-gray-dark-v4 {
        color: #777 !important;
    }

    .g-font-size-12 {
        font-size: 0.85714rem !important;
    }

    .media-comment {
        margin-top: 20px
    }
</style>