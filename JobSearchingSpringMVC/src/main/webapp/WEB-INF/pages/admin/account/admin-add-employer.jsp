<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:choose>
    <c:when test="${actionUrl != null}">
        <c:url value="${actionUrl}" var="action"/>
    </c:when>
    <c:otherwise>
        <c:url value="/admin/account/employer-info/add-or-update" var="action"/>
    </c:otherwise>
</c:choose>

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
                                                 src="${user.avatar}"
                                                 id="img-preview" alt="avatar" width="140" height="140">
                                        </c:if>

                                        <c:if test="${user.avatar == null}">
                                            <img class="d-flex justify-content-center align-items-center rounded"
                                                 src="<c:url value="/resources/images/none.png" />"
                                                 id="img-preview" alt="avatar" width="140" height="140">
                                        </c:if>
                                    </div>
                                    <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                        <div class="text-center text-sm-left mb-2 mb-sm-0">
                                            <h4 id="fullname-preview"
                                                class="pt-sm-2 pb-1 mb-0 text-nowrap">${user.employer.name}</h4>
                                            <p id="username-preview" class="mb-0">${user.employer.website}</p>
                                        </div>
                                        <div class="text-center text-sm-right">
                                            <span class="badge badge-secondary">
                                                <c:if test="${user.userType == 'ROLE_UV'}">
                                                    Ứng viên
                                                </c:if>
                                                <c:if test="${user.userType == 'ROLE_NTD'}">
                                                    Nhà tuyển dụng
                                                </c:if>
                                            </span>
                                            <div class="text-muted"><small>Joined 09 Dec 2017</small></div>
                                            <c:if test="${user.userType == 'ROLE_NTD'}">
                                                <a href="<c:url value="/admin/account/employer/add-or-update" />?userId=${user.employer.id}">
                                                    <input type="button" class="btn btn-primary mt-3 w-100"
                                                           value="Thay đổi thông tin nhà tuyển dụng"/>
                                                </a>
                                            </c:if>
                                        </div>
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

                                <ul class="nav nav-tabs">
                                    <li class="nav-item"><a href="" class="active nav-link">Thông tin</a></li>
                                </ul>
                                <div class="tab-content pt-3">
                                    <div class="tab-pane active">
                                        <form:form action="${action}" method="post" enctype="multipart/form-data"
                                                   modelAttribute="employer">
                                            <form:errors path="*" element="div" cssClass="alert alert-danger mt-3"/>
                                            <form:hidden path="id"/>
                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Họ và tên</label>
                                                                <form:input path="name" class="form-control"
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
                                                                <form:textarea path="description" class="form-control" cssStyle="height: 100px;"/>
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
                                                                <label>Địa điểm</label>
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
                                                                <label>Liên hệ</label>
                                                                <form:input path="contact" class="form-control"/>
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
                                                                <label>Trang web</label>
                                                                <form:input path="website" class="form-control"/>
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
                                                                <label>Lĩnh vực</label>
                                                                <form:input path="majoring" class="form-control"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row justify-content-center mt-3">
                                                <c:if test="${employer.id == 0}">
                                                    <div class="form-group w-25">
                                                        <button type="submit" class="btn btn-primary w-100">
                                                            Thêm
                                                        </button>
                                                    </div>
                                                </c:if>
                                                <c:if test="${employer.id > 0}">
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
