<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <h1 class="text-center dark-color" style="padding: 0 30px">${jobPost.title}</h1>

    <section class="section about-section gray-bg" id="about">
        <div class="container m-0">
            <div class="row flex-row-reverse">
                <div class="col-lg-6">
                    <div class="about-text go-to">
                        <div class="row py-2" style="border-bottom: 1px solid lightgray">
                            <div class="col-md-5">
                                <h5>Mô tả</h5>
                            </div>
                            <div class="col-md-7">
                                <p style="text-align: justify">
                                    ${jobPost.description}
                                </p>
                            </div>
                        </div>
                        <div class="row py-2" style="border-bottom: 1px solid lightgray">
                            <div class="col-md-5">
                                <h5>Loại công việc</h5>
                            </div>
                            <div class="col-md-7">
                                <p>${jobType.name}</p>
                            </div>
                        </div>
                        <div class="row py-2" style="border-bottom: 1px solid lightgray">
                            <div class="col-md-5">
                                <h5>Lương khởi điểm</h5>
                            </div>
                            <div class="col-md-7">
                                <p>
                                    <fmt:formatNumber type="number" maxFractionDigits="3"
                                                      value="${jobPost.beginningSalary}"/> VNĐ
                                </p>
                            </div>
                        </div>
                        <div class="row py-2" style="border-bottom: 1px solid lightgray">
                            <div class="col-md-5">
                                <h5>Lương tối đa</h5>
                            </div>
                            <div class="col-md-7">
                                <p>
                                    <fmt:formatNumber type="number" maxFractionDigits="3"
                                                      value="${jobPost.endingSalary}"/> VNĐ
                                </p>
                            </div>
                        </div>
                        <div class="row py-2" style="border-bottom: 1px solid lightgray">
                            <div class="col-md-5">
                                <h5>Nơi làm việc</h5>
                            </div>
                            <div class="col-md-7">
                                <p>${jobPost.location}</p>
                            </div>
                        </div>
                        <div class="row py-2" style="border-bottom: 1px solid lightgray">
                            <div class="col-md-5">
                                <h5>Ngày đăng</h5>
                            </div>
                            <div class="col-md-7">
                                <p>
                                    <fmt:formatDate pattern="HH:mm:ss - dd/MM/yyyy" value="${jobPost.createdDate}"/>
                                </p>
                            </div>
                        </div>
                        <div class="row py-2" style="border-bottom: 1px solid lightgray">
                            <div class="col-md-5">
                                <h5>Ngày hết hạn</h5>
                            </div>
                            <div class="col-md-7">
                                <p>
                                    <fmt:formatDate pattern="HH:mm:ss - dd/MM/yyyy" value="${jobPost.expiredDate}"/>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="about-avatar d-flex justify-content-center">
                        <c:if test="${currentUser.avatar.startsWith('https')}">
                            <img src="<c:url value="${currentUser.avatar}"/>"
                                 class="rounded">
                        </c:if>
                        <c:if test="${!currentUser.avatar.startsWith('https')}">
                            <img src="<c:url value="/resources/images/none.png"/>"
                                 class="rounded">
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<div class="container">
    <c:if test="${applyJobs.size() != 0}">
        <table class="table table-striped mt-5">
            <thead>
            <tr>
                <th class="text-center" style="width: 12%"></th>
                <th class="text-center" style="width: 5%">STT</th>
                <th>Họ và tên</th>
                <th>Chuyên ngành</th>
                <th class="text-center">Số năm kinh nghiệm</th>
                <th>CV</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${applyJobs}" var="aj" varStatus="loop">
                <tr id="apply-job-row-${aj.id}">
                    <td style="text-align: center">
                        <a style="margin-right: 10px; cursor: pointer"
                           href="<c:url value="/employer/find/view" />?id=${aj.candidate.user.id}"
                           class="info-color" title="Xem chi tiết">
                            <i class="fa-solid fa-eye fa-lg"></i>
                        </a>
                        <a style="margin-right: 10px; cursor: pointer" class="info-color" title="Xoá"
                           onclick="deleteApplyJob(${aj.id})">
                            <i class="fa-solid fa-circle-minus fa-lg"></i>
                        </a>
                    </td>

                    <td class="text-center">${(currentPage - 1) * maxItems + loop.index + 1}</td>

                    <td>
                        <a class="info-color text-left"
                           href="<c:url value="/employer/find/view" />?id=${aj.candidate.user.id}">
                                ${aj.candidate.user.fullName}
                        </a>
                    </td>

                    <td class="text-left">
                            ${aj.candidate.majoring}
                    </td>

                    <td class="text-center">
                            ${aj.candidate.yearsExperience}
                    </td>

                    <td>
                        <a class="info-color" href="${aj.candidate.cv}"
                           target="_blank">
                            Xem CV
                        </a>
                    </td>
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

        <ul class="pagination d-flex justify-content-center mt-2 mx-auto">
            <c:forEach begin="1" end="${Math.ceil(counter/maxItems)}" var="page">
                <li class="page-item">
                    <a class="page-link" href="${url}?page=${page}">${page}</a>
                </li>
            </c:forEach>
        </ul>
    </c:if>
</div>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary d-none" id="lauch-modal"
        data-toggle="modal" data-target="#exampleModal">
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Thông báo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="modal-body">
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<style>
    .gray-bg {
        background-color: #f5f5f5;
    }

    img {
        max-width: 90%;
    }

    img {
        vertical-align: middle;
        border-style: none;
    }

    /* About Me
    ---------------------*/
    .about-text h3 {
        font-size: 45px;
        font-weight: 700;
        margin: 0 0 6px;
    }

    @media (max-width: 767px) {
        .about-text h3 {
            font-size: 35px;
        }
    }

    .about-text h6 {
        font-weight: 600;
        margin-bottom: 15px;
    }

    @media (max-width: 767px) {
        .about-text h6 {
            font-size: 18px;
        }
    }

    .about-text p {
        font-size: 18px;
        max-width: 450px;
    }

    .about-text p mark {
        font-weight: 600;
        color: #20247b;
    }

    .about-list {
        padding-top: 10px;
    }

    .about-list .media {
        padding: 5px 0;
    }

    .about-list label {
        color: #20247b;
        font-weight: 600;
        width: 88px;
        margin: 0;
        position: relative;
    }

    .about-list label:after {
        content: "";
        position: absolute;
        top: 0;
        bottom: 0;
        right: 11px;
        width: 1px;
        height: 12px;
        background: #20247b;
        -moz-transform: rotate(15deg);
        -o-transform: rotate(15deg);
        -ms-transform: rotate(15deg);
        -webkit-transform: rotate(15deg);
        transform: rotate(15deg);
        margin: auto;
        opacity: 0.5;
    }

    .about-list p {
        margin: 0;
        font-size: 15px;
    }

    @media (max-width: 991px) {
        .about-avatar {
            margin-top: 30px;
        }
    }

    .about-section .counter {
        margin-top: 30px;
        padding: 22px 20px;
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0 0 30px rgba(31, 45, 61, 0.125);
    }

    .about-section .counter .count-data {
        margin-top: 10px;
        margin-bottom: 10px;
    }

    .about-section .counter .count {
        font-weight: 700;
        color: #20247b;
        margin: 0 0 5px;
    }

    .about-section .counter p {
        font-weight: 600;
        margin: 0;
    }

    mark {
        background-image: linear-gradient(rgba(252, 83, 86, 0.6), rgba(252, 83, 86, 0.6));
        background-size: 100% 3px;
        background-repeat: no-repeat;
        background-position: 0 bottom;
        background-color: transparent;
        padding: 0;
        color: currentColor;
    }

    .theme-color {
        color: #fc5356;
    }

    .dark-color {
        color: #20247b;
    }
</style>