<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<div class="container">

<h1 class="text-center dark-color">QUẢN LÝ LOẠI VIỆC LÀM</h1>

<ul class="nav nav-tabs">
    <li class="nav-item">
        <a class="nav-link" href="<c:url value="/admin/job-type/add-or-update"/>">
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
        <th>Tên loại việc làm</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${jobTypes}" var="jt" varStatus="loop">
        <tr>
            <td style="text-align: center">
                <a style="margin-right: 10px" href="<c:url value="/admin/job-type/view" />?id=${jt.id}"
                   data-toggle="tooltip" title="Xem chi tiết">
                    <i class="fa-solid fa-eye"></i>
                </a>
                <a style="margin-right: 10px" href="<c:url value="/admin/job-type/add-or-update" />?id=${jt.id}"
                   data-toggle="tooltip" title="Sửa">
                    <i class="fa-solid fa-pen"></i>
                </a>
                <a href="<c:url value="/admin/job-type/delete" />?id=${jt.id}"
                   data-toggle="tooltip" title="Xoá">
                    <i class="fa-solid fa-trash"></i>
                </a>
            </td>
            <td class="text-center">${(currentPage - 1) * jobTypeService.maxItemsInPage + loop.index + 1}</td>
            <td>${jt.name}</td>
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

<ul class="pagination d-flex justify-content-center mt-4">
    <c:forEach begin="1" end="${Math.ceil(counter/jobTypeService.maxItemsInPage)}" var="page">
        <li class="page-item">
            <a class="page-link" href="<c:url value="/admin/job-type" />?page=${page}">${page}</a>
        </li>
    </c:forEach>
</ul>
</div>