<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
                                            <img class="d-flex justify-content-center align-items-center rounded"
                                                 src="${user.avatar}" alt="avatar" width="140" height="140">
                                        </c:if>

                                        <c:if test="${user.avatar == null}">
                                            <div class="mx-auto" style="width: 140px;">
                                                <div class="d-flex justify-content-center align-items-center rounded"
                                                     style="height: 140px; background-color: rgb(233, 236, 239);">
                                                    <span style="color: rgb(166, 168, 170); font: bold 8pt Arial;">140x140</span>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                        <div class="text-center text-sm-left mb-2 mb-sm-0">
                                            <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap">${user.fullName}</h4>
                                            <p class="mb-0">${user.username}</p>
                                            <div class="text-muted"><small>#${user.id}</small></div>
                                            <div class="mt-2">
                                                <button class="btn btn-primary" type="button">
                                                    <i class="fa fa-fw fa-camera"></i>
                                                    <span>Change Photo</span>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="text-center text-sm-right">
                                            <span class="badge badge-secondary">${user.userType}</span>
                                            <div class="text-muted"><small>Joined 09 Dec 2017</small></div>
                                        </div>
                                    </div>
                                </div>
                                <ul class="nav nav-tabs">
                                    <li class="nav-item"><a href="" class="active nav-link">Settings</a></li>
                                </ul>
                                <div class="tab-content pt-3">
                                    <div class="tab-pane active">
                                        <form class="form" novalidate="">
                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Full Name</label>
                                                                <input class="form-control" type="text" name="name"
                                                                       placeholder="John Smith" value="John Smith">
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Username</label>
                                                                <input class="form-control" type="text" name="username"
                                                                       placeholder="johnny.s" value="johnny.s">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Email</label>
                                                                <input class="form-control" type="text"
                                                                       placeholder="user@example.com">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col mb-3">
                                                            <div class="form-group">
                                                                <label>About</label>
                                                                <textarea class="form-control" rows="5"
                                                                          placeholder="My Bio"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="mb-2"><b>Change Password</b></div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Current Password</label>
                                                                <input class="form-control" type="password"
                                                                       placeholder="••••••">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>New Password</label>
                                                                <input class="form-control" type="password"
                                                                       placeholder="••••••">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Confirm <span
                                                                        class="d-none d-xl-inline">Password</span></label>
                                                                <input class="form-control" type="password"
                                                                       placeholder="••••••"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-5 offset-sm-1 mb-3">
                                                    <div class="mb-2"><b>Keeping in Touch</b></div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <label>Email Notifications</label>
                                                            <div class="custom-controls-stacked px-2">
                                                                <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" class="custom-control-input"
                                                                           id="notifications-blog" checked="">
                                                                    <label class="custom-control-label"
                                                                           for="notifications-blog">Blog posts</label>
                                                                </div>
                                                                <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" class="custom-control-input"
                                                                           id="notifications-news" checked="">
                                                                    <label class="custom-control-label"
                                                                           for="notifications-news">Newsletter</label>
                                                                </div>
                                                                <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" class="custom-control-input"
                                                                           id="notifications-offers" checked="">
                                                                    <label class="custom-control-label"
                                                                           for="notifications-offers">Personal
                                                                        Offers</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col d-flex justify-content-end">
                                                    <button class="btn btn-primary" type="submit">Save Changes</button>
                                                </div>
                                            </div>
                                        </form>

                                    </div>
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