<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:url value="/admin/account/add-or-update" var="action"/>

<div class="container">
    <div class="row flex-lg-nowrap">
        <%--        <div class="col-12 col-lg-auto mb-3" style="width: 200px;">--%>
        <%--            <div class="card p-3">--%>
        <%--                <div class="e-navlist e-navlist--active-bg">--%>
        <%--                    <ul class="nav">--%>
        <%--                        <li class="nav-item"><a class="nav-link px-2 active" href="#"><i class="fa fa-fw fa-bar-chart mr-1"></i><span>Overview</span></a></li>--%>
        <%--                        <li class="nav-item"><a class="nav-link px-2" href="https://www.bootdey.com/snippets/view/bs4-crud-users" target="__blank"><i class="fa fa-fw fa-th mr-1"></i><span>CRUD</span></a></li>--%>
        <%--                        <li class="nav-item"><a class="nav-link px-2" href="https://www.bootdey.com/snippets/view/bs4-edit-profile-page" target="__blank"><i class="fa fa-fw fa-cog mr-1"></i><span>Settings</span></a></li>--%>
        <%--                    </ul>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--        </div>--%>

        <div class="col">
            <div class="row">
                <div class="col mb-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="e-profile">
                                <div class="row">
                                    <div class="col-12 col-sm-auto mb-3">
                                        <c:if test="${user.avatar != null}">
                                            <%--                                            <img class="d-flex justify-content-center align-items-center rounded"--%>
                                            <%--                                                 src="${user.avatar}"--%>
                                            <%--                                                 id="img-preview" alt="avatar" width="140" height="140">--%>

                                            <div class="rounded-circle m-auto" id="img-preview"
                                                 style="background-image: url('${user.avatar}');
                                                         width: 140px; height: 140px;
                                                         background-position: center;
                                                         background-size: contain;
                                                         background-repeat: no-repeat;
                                                         border-radius: .35rem;
                                                         border: 1px solid lightgray">
                                            </div>
                                        </c:if>

                                        <c:if test="${user.avatar == null}">
                                            <div class="rounded-circle m-auto" id="img-preview"
                                                 style="background-image: url('<c:url
                                                         value='/resources/images/none.png'/>');
                                                         width: 140px; height: 140px;
                                                         background-position: center;
                                                         background-size: contain;
                                                         background-repeat: no-repeat;
                                                         border-radius: .35rem;
                                                         border: 1px solid lightgray">
                                            </div>

                                            <%--                                            <img class="d-flex justify-content-center align-items-center rounded"--%>
                                            <%--                                                 src="<c:url value="/resources/images/none.png" />"--%>
                                            <%--                                                 id="img-preview" alt="avatar" width="140" height="140">--%>
                                        </c:if>
                                    </div>
                                    <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                        <div class="text-center text-sm-left mb-2 mb-sm-0">
                                            <h4 id="fullname-preview"
                                                class="pt-sm-2 pb-1 mb-0 text-nowrap">${user.fullName}</h4>
                                            <p id="username-preview" class="mb-0">${user.username}</p>
                                        </div>
                                        <div class="text-center text-sm-right">
                                            <span class="badge badge-secondary" id="user-type-badge">
                                                <c:if test="${user.userType == 'ROLE_UV'}">
                                                    Ứng viên
                                                </c:if>
                                                <c:if test="${user.userType == 'ROLE_NTD'}">
                                                    Nhà tuyển dụng
                                                </c:if>
                                                <c:if test="${user.userType == 'ROLE_ADMIN'}">
                                                    Quản trị viên
                                                </c:if>
                                            </span>
                                            <div class="text-muted"><small>Joined 09 Dec 2017 ${user.userType}</small></div>
                                            <c:if test="${user.userType == 'ROLE_NTD'}">
                                                <a href="<c:url value="/admin/account/employer/add-or-update" />?userId=${user.id}">
                                                    <input type="button" class="btn btn-primary mt-3 w-100"
                                                           value="Thay đổi thông tin nhà tuyển dụng"/>
                                                </a>
                                            </c:if>
                                            <c:if test="${user.userType == 'ROLE_UV'}">
                                                <a href="<c:url value="/admin/account/candidate/add-or-update" />?userId=${user.id}">
                                                    <input type="button" class="btn btn-primary mt-3 w-100"
                                                           value="Thay đổi thông tin ứng viên"/>
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <ul class="nav nav-tabs">
                                    <li class="nav-item"><a href="" class="active nav-link">Thông tin cá nhân</a></li>
                                </ul>
                                <div class="tab-content pt-3">
                                    <div class="tab-pane active">
                                        <form:form action="${action}" method="post" enctype="multipart/form-data"
                                                   modelAttribute="user">
                                            <form:errors path="*" element="div" cssClass="alert alert-danger mt-3"/>
                                            <form:hidden path="id"/>
                                            <form:hidden path="avatar"/>
                                            <form:hidden path="candidateId" value="${user.candidate.id}"/>
                                            <form:hidden path="employerId" value="${user.employer.id}"/>
                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Họ và tên</label>
                                                                <form:input path="fullName" class="form-control"
                                                                            oninput="fullnamePreview(this)"
                                                                            required="required" autofocus="autofocus"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Tên đăng nhập</label>
                                                                <form:input path="username" class="form-control"
                                                                            oninput="usernamePreview(this)"
                                                                            required="required"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Email</label>
                                                                <form:input path="email" class="form-control"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Số điện thoại</label>
                                                                <form:input path="phone" class="form-control"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Ảnh đại diện</label>
                                                                <div class="input-group">
                                                                    <div class="input-group-prepend">
                                                                        <span class="input-group-text"
                                                                              id="inputGroupFileAddon01">Tải lên</span>
                                                                    </div>
                                                                    <div class="custom-file">
                                                                        <form:input type="file" path="file"
                                                                                    id="inputGroupFile01"
                                                                                    onchange="showPreviewDiv(event);"
                                                                                    accept="image/*"
                                                                                    class="form-control"/>
                                                                        <label class="custom-file-label"
                                                                               for="inputGroupFile01">
                                                                            Tải lên ảnh đại diện của bạn tại đây
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Ngày sinh (Ngày/Tháng/Năm)</label>
                                                                <div class="d-flex flex-row align-items-center">
                                                                    <fmt:formatDate pattern="dd" value="${user.dob}"
                                                                                    var="dobDay"/>
                                                                    <form:input path="day" value="${dobDay}"
                                                                                class="form-control" id="dobDay"
                                                                                placeholder="Ngày" type="number"
                                                                                required="required"/>

                                                                    <span class="mx-2">/</span>
                                                                    <fmt:formatDate pattern="MM" value="${user.dob}"
                                                                                    var="dobMonth"/>
                                                                    <form:input path="month" value="${dobMonth}"
                                                                                class="form-control" id="dobMonth"
                                                                                placeholder="Tháng" type="number"
                                                                                required="required"/>

                                                                    <span class="mx-2">/</span>
                                                                    <fmt:formatDate pattern="yyyy" value="${user.dob}"
                                                                                    var="dobYear"/>
                                                                    <form:input path="year" value="${dobYear}"
                                                                                class="form-control" id="dobYear"
                                                                                placeholder="Năm" type="number"
                                                                                required="required"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Địa chỉ</label>
                                                                <form:input path="address" class="form-control"/>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Giới tính</label>
                                                                <form:select path="gender" class="custom-select">
                                                                    <form:option value="0" label="Nam"
                                                                                 selected="${user.gender == 0 ? true : ''}"/>
                                                                    <form:option value="1" label="Nữ"
                                                                                 selected="${user.gender == 1 ? true : ''}"/>
                                                                </form:select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Loại tài khoản <span
                                                                        style="color: red">*</span></label>
                                                                <form:select path="userType" class="custom-select"
                                                                             id="userType"
                                                                             onchange="userTypePreview(this)">
                                                                    <form:option value="ROLE_UV" label="Ứng viên"
                                                                                 selected="${user.userType.equals('ROLE_UV') ? true : ''}"/>
                                                                    <form:option value="ROLE_NTD" label="Nhà tuyển dụng"
                                                                                 selected="${user.userType.equals('ROLE_NTD') ? true : ''}"/>
                                                                    <form:option value="ROLE_ADMIN"
                                                                                 label="Quản trị viên"
                                                                                 selected="${user.userType.equals('ROLE_ADMIN') ? true : ''}"/>
                                                                </form:select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Kích hoạt <span
                                                                        style="color: red">*</span></label>
                                                                <form:select path="active" class="custom-select">
                                                                    <form:option value="0" label="Chưa kích hoạt"
                                                                                 selected="${user.active == 0 ? true : ''}"/>
                                                                    <form:option value="1" label="Đã kích hoạt"
                                                                                 selected="${user.active == 1 ? true : ''}"/>
                                                                </form:select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label>Mật khẩu</label>
                                                        <form:input path="password" class="form-control"
                                                                    id="password" type="password"
                                                                    required="required"/>
                                                    </div>
                                                </div>
                                                <c:if test="${user.id == 0}">
                                                    <div class="col">
                                                        <div class="form-group">
                                                            <label>Nhập lại mật khẩu</label>
                                                            <form:input path="confirmPassword" class="form-control"
                                                                        id="confirmPassword" type="password"
                                                                        required="required"/>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>

                                            <div class="row justify-content-center mt-3">
                                                <c:if test="${user.id == 0}">
                                                    <div class="form-group w-25">
                                                        <button type="submit" class="btn btn-primary w-100">Thêm
                                                        </button>
                                                    </div>
                                                </c:if>
                                                <c:if test="${user.id > 0}">
                                                    <div class="form-group w-25">
                                                        <button type="submit" class="btn btn-primary w-100">Cập nhật
                                                        </button>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--                <div class="col-12 col-md-3 mb-3">--%>
                    <%--                    <div class="card mb-3">--%>
                    <%--                        <div class="card-body">--%>
                    <%--                            <div class="px-xl-3">--%>
                    <%--                                <button class="btn btn-block btn-secondary">--%>
                    <%--                                    <i class="fa fa-sign-out"></i>--%>
                    <%--                                    <span>Logout</span>--%>
                    <%--                                </button>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>
                    <%--                    <div class="card">--%>
                    <%--                        <div class="card-body">--%>
                    <%--                            <h6 class="card-title font-weight-bold">Support</h6>--%>
                    <%--                            <p class="card-text">Get fast, free help from our friendly assistants.</p>--%>
                    <%--                            <button type="button" class="btn btn-primary">Contact Us</button>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>
                    <%--                </div>--%>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
    window.onload = (event) => {
        document.getElementById('password').value = ""
    };
</script>
