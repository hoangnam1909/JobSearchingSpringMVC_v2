<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="py-4">
    <h1 class="text-center dark-color mb-3">TIN TUYỂN DỤNG</h1>

    <div class="container py-3">
        <div class="row">
            <div class="col-lg-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <div class="rounded-circle m-auto" id="avatar"
                             style="background-image: url('${jobPost.postedByEmployerUser.avatar}');
                                     width: 140px; height: 140px;
                                     background-position: center;
                                     background-size: contain;
                                     background-repeat: no-repeat;
                                     border-radius: .35rem;
                                     border: 1px solid lightgray">
                        </div>

                        <a href="#">
                            <h5 class="my-3">
                                ${jobPost.postedByEmployerUser.employer.name}
                            </h5>
                        </a>
                        <a href="${jobPost.postedByEmployerUser.employer.website}" target="_blank">
                            <p class="text-muted mb-4">
                                ${jobPost.postedByEmployerUser.employer.website}
                            </p>
                        </a>

                        <div class="d-flex justify-content-center mb-2">
                            <a href="<c:url value="/admin/job-post/add-or-update" />?id=${jobPost.id}">
                                <input type="button" class="btn btn-primary mx-1" value="Sửa thông tin"/>
                            </a>
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
                                <p class="mb-0">Tên việc làm</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">${jobPost.title}</p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Mô tả công việc</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">${jobPost.description}</p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Lương tối thiểu</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">
                                    <fmt:formatNumber type="number" maxFractionDigits="0"
                                                      value="${jobPost.beginningSalary}"/>
                                    VNĐ
                                </p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Lương tối đa</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">
                                    <fmt:formatNumber type="number" maxFractionDigits="0"
                                                      value="${jobPost.endingSalary}"/>
                                    VNĐ
                                </p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Địa điểm</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">${jobPost.location}</p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Ngày đăng</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">
                                    <fmt:formatDate pattern="dd/MM/yyyy" value="${jobPost.createdDate}"/>
                                </p>
                            </div>
                        </div>
                        <hr>

                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0">Ngày hết hạn</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">
                                    <fmt:formatDate pattern="dd/MM/yyyy" value="${jobPost.expiredDate}"/>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
