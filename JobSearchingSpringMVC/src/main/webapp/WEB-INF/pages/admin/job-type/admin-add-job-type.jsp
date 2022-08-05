<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:url value="/admin/job-type/add-or-update" var="action"/>

<div class="container py-4">
    <h1 class="text-center dark-color mb-3">THÊM LOẠI VIỆC LÀM</h1>

    <div class="card">
        <div class="card-body">
            <form:form action="${action}" method="post" modelAttribute="jobType">
                <form:errors path="*" element="div" cssClass="alert alert-danger mt-3"/>
                <form:hidden path="id"/>
                <div class="form-group">
                    <label>Tên loại việc làm</label>
                    <form:input path="name" class="form-control" autofocus="autofocus"/>
                </div>
                <c:if test="${jobType.id == 0}">
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">Thêm</button>
                    </div>
                </c:if>
                <c:if test="${jobType.id > 0}">
                    <div class="form-group mb-0">
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </c:if>
            </form:form>
        </div>
    </div>
</div>
