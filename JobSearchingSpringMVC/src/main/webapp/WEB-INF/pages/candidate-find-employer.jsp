<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container">
    <h1 class="text-center dark-color">TÌM KIẾM NHÀ TUYỂN DỤNG</h1>

    <section class="d-flex justify-content-center">
        <form class="mt-3 w-50">
            <div class="form-group">
                <label for="name">Tên nhà tuyển dụng</label>
                <input class="form-control" name="name" id="name" value="${name}">
            </div>
            <div class="form-group">
                <label for="location">Địa điểm</label>
                <input class="form-control" name="location" id="location" value="${location}">
            </div>
            <div class="form-group">
                <label for="majoring">Chuyên ngành</label>
                <input class="form-control" name="majoring" id="majoring" value="${majoring}">
            </div>

            <button type="submit" class="btn btn-info">Tra cứu</button>
            <input type="button" class="btn btn-dark" onclick="removeFilter()" value="Loại bỏ bộ lọc"/>
        </form>
    </section>
</div>

<div class="container">
    <ul class="pagination d-flex justify-content-center m-0">
        <c:forEach begin="1" end="${Math.ceil(counter/maxItems)}" var="page">
            <li class="page-item">
                <a class="page-link" onclick="updateQueryStringParameter('page', ${page})">${page}</a>
            </li>
        </c:forEach>
    </ul>
</div>

<c:forEach items="${employers}" var="emp">
    <div class="container pt-2">
        <div class="col">
            <div class="row">
                <div class="media g-mb-30 media-comment w-100">
                    <img class="border d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15"
                         src="${userService.getById(emp.user.id).avatar}" alt="Image Description">
                    <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
                        <div class="g-mb-15">
                            <a class="text-decoration-none"
                               href="<c:url value="/candidate/view-employer"/>?employerId=${emp.id}">
                                <h3 class="g-color-gray-dark-v1 mb-3">
                                        ${emp.name}
                                </h3>
                            </a>
                        </div>
                        <c:if test="${emp.description.length() > 0}">
                            <h5 class="g-color-gray-dark-v1 mb-3">
                                Mô tả: <span style="font-weight: 400"> ${emp.description} </span>
                            </h5>
                        </c:if>

                        <c:if test="${emp.location.length() > 0}">
                            <h5 class="g-color-gray-dark-v1 mb-3">
                                Địa điểm: <span style="font-weight: 400"> ${emp.location} </span>
                            </h5>
                        </c:if>

                        <c:if test="${emp.contact.length() > 0}">
                            <h5 class="g-color-gray-dark-v1 mb-3">
                                Liên hệ: <span style="font-weight: 400"> ${emp.contact} </span>
                            </h5>
                        </c:if>

                        <c:if test="${emp.website.length() > 0}">
                            <h5 class="g-color-gray-dark-v1 mb-3">
                                Trang web:
                                <span style="font-weight: 400">
                                    <a target="_blank" href="${emp.website}"> ${emp.website} </a>
                                </span>
                            </h5>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

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