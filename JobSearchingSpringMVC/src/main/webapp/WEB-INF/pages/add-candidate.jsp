<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container">
    <c:if test="${candidate.id == 0}">
        <h1 class="text-center dark-color">THÊM THÔNG TIN ỨNG VIÊN</h1>
    </c:if>
    <c:if test="${candidate.id > 0}">
        <h1 class="text-center dark-color">CHỈNH SỬA THÔNG TIN ỨNG VIÊN</h1>
    </c:if>

    <c:choose>
        <c:when test="${actionUrl != null}">
            <c:url value="${actionUrl}" var="action"/>
        </c:when>
        <c:otherwise>
            <c:url value="/admin/account/candidate-info/add-or-update" var="action"/>
        </c:otherwise>
    </c:choose>

    <c:if test="${sucMsg != null}">
        <div class="alert alert-success mt-3" role="alert">
                ${sucMsg}
        </div>
    </c:if>

    <c:if test="${errMsg != null}">
        <div class="alert alert-danger mt-3" role="alert">
                ${errMsg}
        </div>
    </c:if>

    <form:form action="${action}" method="post" enctype="multipart/form-data"
               modelAttribute="candidate" cssClass="mt-4">

        <form:hidden path="id" class="form-control"/>
        <form:hidden path="userId" value="${userId}" class="form-control"/>
        <form:hidden path="cv"/>
        <div class="form-group">
            <label>Số năm kinh nghiệm</label>
            <form:input path="yearsExperience" class="form-control" autofocus="autofocus"/>
        </div>
        <div class="form-group">
            <label>Điểm mạnh</label>
            <form:textarea path="strengths" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Điểm yếu</label>
            <form:textarea path="weaknesses" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Chuyên ngành</label>
            <form:input path="majoring" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Keyword về chuyên ngành</label>
            <form:textarea path="majoringDetail" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Chứng chỉ ngoại ngữ</label>
            <form:textarea path="languageCertificate" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Chứng chỉ tin học</label>
            <form:textarea path="informaticsCertificate" class="form-control"/>
        </div>
        <div class="form-group">
            <label>CV
                <mark>Chỉ upload file hình ảnh</mark>
                <c:if test="${candidate.cv.startsWith('http')}">
                    <br>Đã upload CV. Bản xem trước <span><a target="_blank" href="${candidate.cv}">Tại đây</a></span>
                </c:if>
            </label>
            <form:input type="file" path="file" accept="image/*" class="form-control"/>
        </div>
        <c:if test="${candidate.id == 0}">
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Thêm</button>
            </div>
        </c:if>
        <c:if test="${candidate.id > 0}">
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Cập nhật</button>
            </div>
        </c:if>
    </form:form>
</div>