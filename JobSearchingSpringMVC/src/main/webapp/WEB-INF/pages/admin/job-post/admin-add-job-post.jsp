<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:url value="/admin/job-post/add-or-update" var="action"/>

<div class="container py-4">
    <h1 class="text-center dark-color mb-3">ĐĂNG TIN TUYỂN DỤNG</h1>

    <div class="row flex-lg-nowrap my-4">
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
                                        <c:if test="${jobPost.postedByEmployerUser.avatar != null}">
                                            <%--                                            <img class="d-flex justify-content-center align-items-center rounded"--%>
                                            <%--                                                 src="${jobPost.postedByEmployerUser.avatar}"--%>
                                            <%--                                                 id="img-employer-preview" alt="avatar" width="140" height="140">--%>

                                            <div class="m-auto" id="img-employer-preview"
                                                 style="background-image: url('${jobPost.postedByEmployerUser.avatar}');
                                                         width: 140px; height: 140px;
                                                         background-position: center;
                                                         background-size: contain;
                                                         background-repeat: no-repeat;
                                                         border-radius: .35rem">
                                            </div>
                                        </c:if>

                                        <c:if test="${jobPost.postedByEmployerUser.avatar == null}">
                                            <%--                                            <img class="d-flex justify-content-center align-items-center rounded"--%>
                                            <%--                                                 src="<c:url value="/resources/images/none.png" />"--%>
                                            <%--                                                 id="img-employer-preview" alt="avatar" width="140" height="140">--%>
                                            <div class="m-auto" id="img-employer-preview"
                                                 style="background-image: url('<c:url
                                                         value='/resources/images/none.png'/>');
                                                         width: 140px; height: 140px;
                                                         background-position: center;
                                                         background-size: contain;
                                                         background-repeat: no-repeat;
                                                         border-radius: .35rem;
                                                         border: 1px solid lightgray">
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                        <div class="text-center text-sm-left mb-2 mb-sm-0">
                                            <h4 id="employer-name-preview" class="pt-sm-2 pb-1 mb-0 text-wrap"></h4>
                                            <p id="employer-website-preview" class="mb-0"></p>
                                            <p id="employer-contact-preview" class="mb-0"></p>
                                        </div>
                                        <%--                                        <div class="text-center text-sm-right">--%>
                                        <%--                                            <span class="badge badge-secondary">--%>
                                        <%--                                                <c:if test="${user.userType == 'ROLE_UV'}">--%>
                                        <%--                                                    Ứng viên--%>
                                        <%--                                                </c:if>--%>
                                        <%--                                                <c:if test="${user.userType == 'ROLE_NTD'}">--%>
                                        <%--                                                    Nhà tuyển dụng--%>
                                        <%--                                                </c:if>--%>
                                        <%--                                            </span>--%>
                                        <%--                                            <div class="text-muted"><small>Joined 09 Dec 2017</small></div>--%>
                                        <%--                                            <c:if test="${user.userType == 'ROLE_NTD'}">--%>
                                        <%--                                                <a href="<c:url value="/admin/account/employer/add-or-update" />?userId=${user.employer.id}">--%>
                                        <%--                                                    <input type="button" class="btn btn-primary mt-3 w-100"--%>
                                        <%--                                                           value="Thay đổi thông tin nhà tuyển dụng"/>--%>
                                        <%--                                                </a>--%>
                                        <%--                                            </c:if>--%>
                                        <%--                                        </div>--%>
                                    </div>
                                </div>

                                <%--                                <c:if test="${sucMsg != null}">--%>
                                <%--                                    <div class="alert alert-success" role="alert">--%>
                                <%--                                            ${sucMsg}--%>
                                <%--                                    </div>--%>
                                <%--                                </c:if>--%>
                                <%--                                <c:if test="${errMsg != null}">--%>
                                <%--                                    <div class="alert alert-danger" role="alert">--%>
                                <%--                                            ${errMsg}--%>
                                <%--                                    </div>--%>
                                <%--                                </c:if>--%>

                                <ul class="nav nav-tabs">
                                    <li class="nav-item"><a href="" class="active nav-link">Thông tin</a></li>
                                </ul>
                                <div class="tab-content pt-3">
                                    <div class="tab-pane active">
                                        <%--@elvariable id="jobPost" type=""--%>
                                        <form:form action="${action}" method="post"
                                                   modelAttribute="jobPost">
                                            <form:errors path="*" element="div" cssClass="alert alert-danger mt-3"/>
                                            <form:hidden path="id"/>
                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Tên việc làm</label>
                                                                <form:input path="title" class="form-control"
                                                                            oninput="titlePreview(this)"
                                                                            required="required" autofocus="autofocus"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Mô tả</label>
                                                                <form:textarea path="description" class="form-control"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Lương tối thiểu</label>
                                                                <form:input path="beginningSalary"
                                                                            class="form-control"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Lương tối đa</label>
                                                                <form:input path="endingSalary" class="form-control"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Địa chỉ</label>
                                                                <form:input path="location" class="form-control"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Ngày hết hạn</label>
                                                                <div class="d-flex flex-row align-items-center">
                                                                    <fmt:formatDate pattern="dd"
                                                                                    value="${jobPost.expiredDate}"
                                                                                    var="dobDay"/>
                                                                    <form:input path="day" value="${dobDay}"
                                                                                class="form-control" id="dobDay"
                                                                                placeholder="Ngày" type="number"/>

                                                                    <span class="mx-2">/</span>
                                                                    <fmt:formatDate pattern="MM"
                                                                                    value="${jobPost.expiredDate}"
                                                                                    var="dobMonth"/>
                                                                    <form:input path="month" value="${dobMonth}"
                                                                                class="form-control" id="dobMonth"
                                                                                placeholder="Tháng" type="number"/>

                                                                    <span class="mx-2">/</span>
                                                                    <fmt:formatDate pattern="yyyy"
                                                                                    value="${jobPost.expiredDate}"
                                                                                    var="dobYear"/>
                                                                    <form:input path="year" value="${dobYear}"
                                                                                class="form-control" id="dobYear"
                                                                                placeholder="Năm" type="number"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Nhà tuyển dụng</label>
                                                                <form:select path="postedByEmployerUserId"
                                                                             class="custom-select"
                                                                             id="select-employer"
                                                                             onchange="employerPreview(this)">
                                                                    <option value="0" selected>
                                                                        Chọn nhà tuyển dụng
                                                                    </option>
                                                                    <c:forEach items="${users}" var="user">
                                                                        <c:if test="${user.employer != null}">
                                                                            <c:if test="${user.id == jobPost.postedByEmployerUser.id}">
                                                                                <option value="${user.id}" selected>
                                                                                        ${user.username}
                                                                                </option>
                                                                            </c:if>

                                                                            <c:if test="${user.id != jobPost.postedByEmployerUser.id}">
                                                                                <option value="${user.id}">
                                                                                        ${user.employer.name}
                                                                                </option>
                                                                            </c:if>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </form:select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Loại công việc</label>
                                                                <form:select path="jobTypeId" class="custom-select">
                                                                    <c:forEach items="${jobTypes}" var="jobType">
                                                                        <c:if test="${jobType.id == jobPost.jobType.id}">
                                                                            <option value="${jobType.id}"
                                                                                    selected>${jobType.name}</option>
                                                                        </c:if>

                                                                        <c:if test="${jobType.id != jobPost.jobType.id}">
                                                                            <option value="${jobType.id}">${jobType.name}</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </form:select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row justify-content-center mt-3">
                                                <c:if test="${jobPost.id == 0}">
                                                    <div class="form-group w-25">
                                                        <button type="submit" class="btn btn-primary w-100">
                                                            Thêm
                                                        </button>
                                                    </div>
                                                </c:if>

                                                <c:if test="${jobPost.id != 0}">
                                                    <div class="form-group w-25">
                                                        <button type="submit" class="btn btn-primary w-100">
                                                            Cập nhật
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

<script src="<c:url value="/resources/js/admin/admin-job-post.js"/>"></script>
