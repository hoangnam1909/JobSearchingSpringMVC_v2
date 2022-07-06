<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<c:set value="${Math.ceil(counter/userService.maxItemsInPage)}" var="numbersOfPage"/>

<div class="container">

    <h1 class="text-center dark-color">TÌM KIẾM ỨNG VIÊN</h1>

    <div class="row mt-5">
        <div class="col-3">
            <form>
                <c:choose>
                    <c:when test="${currentPage > numbersOfPage}">
                        <input style="display: none;" name="page" value="${currentPage}">
                    </c:when>
                    <c:otherwise>
                        <input style="display: none;" name="page" value="1">
                    </c:otherwise>
                </c:choose>
                <div class="form-group">
                    <h6>Họ và tên</h6>
                    <input class="form-control" name="fullname">
                </div>
                <div class="form-group">
                    <h6>Độ tuổi</h6>
                    <div class="row">
                        <div class="col-6 border-right">
                            <div>
                                <label for="fromAge">Từ</label>
                                <input class="form-control" name="fromAge" id="fromAge">
                            </div>
                        </div>
                        <div class="col-6">
                            <div>
                                <label for="toAge">Đến</label>
                                <input class="form-control" name="toAge" id="toAge">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <h6>Giới tính</h6>
                    <select class="form-control" name="gender">
                        <option value="-1" selected>Chọn giới tính</option>
                        <option value="0">Nam</option>
                        <option value="1">Nữ</option>
                    </select>
                </div>
                <div class="form-group">
                    <h6>Nơi sinh sống</h6>
                    <input class="form-control" name="address">
                </div>
                <button type="submit" class="btn btn-info">Tra cứu</button>
                <input type="button" class="btn btn-dark" onclick="removeFilter()" value="Loại bỏ bộ lọc"/>
            </form>
        </div>
        <div class="col">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th style="width: 10%"></th>
                    <th class="text-center" style="width: 10%">STT</th>
                    <th>Họ và tên</th>
                    <th>Số điện thoại</th>
                    <th>Email</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="u" varStatus="loop">
                    <tr>
                        <td class="text-center">
                            <a href="<c:url value="/employer/find/view" />?id=${u.id}" title="Xem chi tiết">
                                <i class="fa-solid fa-eye"></i>
                            </a>
                        </td>
                        <td class="text-center">
                                ${(currentPage - 1) * userService.maxItemsInPage + loop.index + 1}
                        </td>
                        <td>${u.fullName}</td>
                        <td>${u.phone}</td>
                        <td>${u.email}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

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
        <c:forEach begin="1" end="${numbersOfPage}" var="page">
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