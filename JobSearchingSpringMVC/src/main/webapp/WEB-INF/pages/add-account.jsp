<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="container">
    <c:if test="${user.id == 0}">
        <h1 class="text-center dark-color">THÊM TÀI KHOẢN</h1>
    </c:if>
    <c:if test="${user.id > 0}">
        <h1 class="text-center dark-color">CHỈNH SỬA THÔNG TIN TÀI KHOẢN</h1>
    </c:if>

    <c:url value="/admin/account/add-or-update" var="action"/>

    <c:if test="${errMsg != null}">
        <div class="alert alert-danger">
                ${errMsg}
        </div>
    </c:if>

    <form:form action="${action}" method="post" enctype="multipart/form-data" modelAttribute="user">
        <form:errors path="*" element="div" cssClass="alert alert-danger mt-3"/>
        <form:hidden path="id"/>
        <form:hidden path="avatar"/>
        <div class="form-group">
            <label>Tên đăng nhập <span style="color: red">*</span></label>
            <form:input path="username" class="form-control" required="required" autofocus="autofocus"/>
        </div>
        <div class="form-group">
            <label>Mật khẩu <span style="color: red">*</span></label>
            <form:input path="password" class="form-control" id="password" type="password" required="required"/>
        </div>
        <div class="form-group">
            <label>Nhập lại mật khẩu <span style="color: red">*</span></label>
            <form:input path="confirmPassword" class="form-control" id="confirmPassword" type="password"
                        required="required"/>
        </div>
        <div class="form-group">
            <label>Email</label>
            <form:input path="email" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Số điện thoại</label>
            <form:input path="phone" class="form-control"/>
        </div>
        <div class="form-group row">
            <div class="col">
                <label for="avatar">Ảnh đại diện</label>
                <form:input type="file" id="imgInp" path="file"
                            accept="image/*" class="form-control"/>
            </div>
            <div class="col text-center">
                <img src="<c:url value="${user.avatar}"/>"
                     style="height: 200px; margin-top: 10px; border: 1px solid black;"
                     class="img-fluid rounded" id="blah" alt="avatar">
            </div>
        </div>
        <div class="form-group">
            <label>Họ và tên</label>
            <form:input path="fullName" class="form-control"/>
        </div>
        <div class="input-group input-group-static mb-4 d-flex flex-column">
            <label>Ngày sinh (Ngày/Tháng/Năm)</label>
            <div class="d-flex flex-row align-items-center">
                <fmt:formatDate pattern="dd" value="${user.dob}" var="dobDay"/>
                <form:input path="day" value="${dobDay}" class="form-control" id="dobDay"
                            placeholder="Ngày" type="number" required="required"/>

                <span class="mx-2">/</span>
                <fmt:formatDate pattern="MM" value="${user.dob}" var="dobMonth"/>
                <form:input path="month" value="${dobMonth}" class="form-control" id="dobMonth"
                            placeholder="Tháng" type="number" required="required"/>

                <span class="mx-2">/</span>
                <fmt:formatDate pattern="yyyy" value="${user.dob}" var="dobYear"/>
                <form:input path="year" value="${dobYear}" class="form-control" id="dobYear"
                            placeholder="Năm" type="number" required="required"/>
            </div>
        </div>
        <div class="form-group">
            <label>Địa chỉ</label>
            <form:input path="address" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Giới tính</label>
            <form:select path="gender" class="custom-select">
                <form:option value="0" label="Nam" selected="${user.gender == 0 ? true : ''}"/>
                <form:option value="1" label="Nữ" selected="${user.gender == 1 ? true : ''}"/>
            </form:select>
        </div>
        <div class="form-group">
            <label>Loại tài khoản <span style="color: red">*</span></label>
            <form:select path="userType" class="custom-select">
                <form:option value="ROLE_UV" label="Ứng viên"
                             selected="${user.userType.equals('ROLE_UV') ? true : ''}"/>
                <form:option value="ROLE_NTD" label="Nhà tuyển dụng"
                             selected="${user.userType.equals('ROLE_NTD') ? true : ''}"/>
                <form:option value="ROLE_ADMIN" label="Admin"
                             selected="${user.userType.equals('ROLE_ADMIN') ? true : ''}"/>
            </form:select>
        </div>
        <div class="form-group">
            <label>Kích hoạt <span style="color: red">*</span></label>
            <form:select path="active" class="custom-select">
                <form:option value="0" label="Chưa kích hoạt" selected="${user.active == 0 ? true : ''}"/>
                <form:option value="1" label="Đã kích hoạt" selected="${user.active == 1 ? true : ''}"/>
            </form:select>
        </div>

        <c:if test="${user.id == 0}">
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Thêm</button>
            </div>
        </c:if>
        <c:if test="${user.id > 0}">
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Cập nhật</button>
            </div>
        </c:if>
    </form:form>
</div>