<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="py-4">
    <h1 class="text-center dark-color mb-3">THÔNG TIN TÀI KHOẢN</h1>

    <div class="container py-3">
        <div class="row">
            <div class="col-lg-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <div class="rounded-circle m-auto" id="avatar"
                             style="background-image: url('${user.avatar}');
                                     width: 140px; height: 140px;
                                     background-position: center;
                                     background-size: contain;
                                     background-repeat: no-repeat;
                                     border-radius: .35rem;
                                     border: 1px solid lightgray">
                        </div>

                        <h5 class="my-3">${user.username}</h5>

                        <c:if test="${user.candidate != null}">
                            <p class="text-muted mb-1">${user.candidate.majoring}</p>
                        </c:if>
                        <c:if test="${user.employer != null}">
                            <p class="text-muted mb-1">${user.employer.name}</p>
                        </c:if>

                        <c:if test="${user.userType == 'ROLE_UV'}">
                            <p class="text-muted mb-4">Ứng viên</p>
                        </c:if>

                        <c:if test="${user.userType == 'ROLE_NTD'}">
                            <p class="text-muted mb-4">Nhà tuyển dụng</p>
                        </c:if>

                        <c:if test="${user.userType == 'ROLE_ADMIN'}">
                            <p class="text-muted mb-4">Quản trị viên</p>
                        </c:if>

                        <div class="d-flex justify-content-center mb-2">
                            <a href="<c:url value="/admin/account/add-or-update" />?id=${user.id}">
                                <input type="button" class="btn btn-primary mx-1" value="Sửa thông tin"/>
                            </a>
                            <c:if test="${user.candidate != null and user.candidate.cv != null}">
                                <form action="${user.candidate.cv}" target="_blank">
                                    <input type="submit" class="btn btn-outline-primary mx-1" value="Xem CV"/>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div class="card mb-4 mb-lg-0">
                    <div class="card-body p-0">
                        <ul class="list-group list-group-flush rounded-3">
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fas fa-globe fa-lg text-warning"></i>
                                <p class="mb-0">https://mdbootstrap.com</p>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fab fa-github fa-lg" style="color: #333333;"></i>
                                <p class="mb-0">mdbootstrap</p>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fab fa-twitter fa-lg" style="color: #55acee;"></i>
                                <p class="mb-0">@mdbootstrap</p>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fab fa-instagram fa-lg" style="color: #ac2bac;"></i>
                                <p class="mb-0">mdbootstrap</p>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fab fa-facebook-f fa-lg" style="color: #3b5998;"></i>
                                <p class="mb-0">mdbootstrap</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Họ và tên</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">${user.fullName}</p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Giới tính</p>
                            </div>
                            <div class="col-sm-9">
                                <c:if test="${user.gender == 0}">
                                    <p class="text-muted mb-0">Nam</p>
                                </c:if>

                                <c:if test="${user.gender == 1}">
                                    <p class="text-muted mb-0">Nữ</p>
                                </c:if>

                                <c:if test="${user.gender != 0 && user.gender != 1}">
                                    <p class="text-muted mb-0">Khác</p>
                                </c:if>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Ngày sinh</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">
                                    <fmt:formatDate pattern="dd/MM/yyyy" value="${user.dob}"/>
                                </p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Email</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">${user.email}</p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Số điện thoại</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">${user.phone}</p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Địa chỉ</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">${user.address}</p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Trạng thái</p>
                            </div>
                            <div class="col-sm-9">
                                <c:if test="${user.active == 0}">
                                    <p class="text-danger mb-0">Chưa kích hoạt</p>
                                </c:if>

                                <c:if test="${user.active == 1}">
                                    <p class="text-success mb-0">Đã kích hoạt</p>
                                </c:if>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Loại tài khoản</p>
                            </div>
                            <div class="col-sm-9">
                                <c:if test="${user.userType == 'ROLE_UV'}">
                                    <p class="text-muted mb-0">Ứng viên</p>
                                </c:if>

                                <c:if test="${user.userType == 'ROLE_NTD'}">
                                    <p class="text-muted mb-0">Nhà tuyển dụng</p>
                                </c:if>

                                <c:if test="${user.userType == 'ROLE_ADMIN'}">
                                    <p class="text-muted mb-0">Quản trị viên</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <%--        FOR CANDIDATE           --%>
                <c:if test="${user.candidate != null}">
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Số năm kinh nghiệm</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${user.candidate.yearsExperience}</p>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Điểm mạnh</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${user.candidate.strengths}</p>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Điểm yếu</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${user.candidate.weaknesses}</p>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Chuyên ngành</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${user.candidate.majoring}</p>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Chứng chỉ ngoại ngữ</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${user.candidate.languageCertificate}</p>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Chứng chỉ tin học</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${user.candidate.informaticsCertificate}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <%--        FOR EMPLOYER           --%>
                <c:if test="${user.employer != null}">
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Công ty</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted text-justify mb-0">${user.employer.name}</p>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Mô tả</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted text-justify mb-0">${user.employer.description}</p>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Địa điểm</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted text-justify mb-0">${user.employer.location}</p>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Liên hệ</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted text-justify mb-0">${user.employer.contact}</p>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Website</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted text-justify mb-0">
                                        <a href="${user.employer.website}" target="_blank">
                                                ${user.employer.website}
                                        </a>
                                    </p>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Lĩnh vực</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted text-justify mb-0">${user.employer.majoring}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</section>
