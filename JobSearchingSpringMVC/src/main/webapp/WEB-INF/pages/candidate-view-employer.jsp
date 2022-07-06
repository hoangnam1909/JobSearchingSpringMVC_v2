<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>

<div class="container">

    <h1 class="text-center dark-color" style="padding: 0 30px">THÔNG TIN NHÀ TUYỂN DỤNG</h1>

    <section class="section about-section gray-bg" id="about">
        <div class="container m-0">
            <div class="row flex-row-reverse">
                <div class="col-lg-6">
                    <div class="about-text go-to">
                        <h3 class="dark-color mb-4">
                            ${employer.name}
                        </h3>
                        <div class="row mb-1">
                            <div class="col-md-4">
                                <h5>Mô tả</h5>
                            </div>
                            <div class="col-md-8">
                                <p>
                                    ${employer.description}
                                </p>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-md-4">
                                <h5>Trụ sở</h5>
                            </div>
                            <div class="col-md-8">
                                <p>
                                    ${employer.location}
                                </p>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-md-4">
                                <h5>Liên hệ</h5>
                            </div>
                            <div class="col-md-8">
                                <p>${employer.contact}</p>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-md-4">
                                <h5>Trang web</h5>
                            </div>
                            <div class="col-md-8">
                                <p>
                                    <a target="_blank" href="${employer.website}">${employer.website}</a>
                                </p>
                            </div>
                        </div>
                        <div class="row mb-1">
                            <div class="col-md-4">
                                <h5>Chuyên ngành</h5>
                            </div>
                            <div class="col-md-8">
                                <p>${employer.majoring}</p>
                            </div>
                        </div>
                        <div class="mb-1">
                            <div class="content text-center">
                                <div class="ratings">
                                    <span class="product-rating">4.6</span><span>/5</span>
                                    <div class="stars">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <div class="rating-text">
                                        <span>46 ratings & 15 reviews</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="about-avatar d-flex justify-content-center">
                        <c:if test="${userService.getById(employer.user.id).avatar.startsWith('https')}">
                            <img src="<c:url value="${userService.getById(employer.user.id).avatar}"/>"
                                 class="rounded">
                        </c:if>
                        <c:if test="${!userService.getById(employer.user.id).avatar.startsWith('https')}">
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
    <div class="col">
        <div class="row mt-3 mb-4">
            <form class="w-100">
                <div class="form-group">
                    <textarea class="form-control" id="commentId" onkeypress="process(event, this)"
                              placeholder="Nhập bình luận"></textarea>
                </div>
                <input type="button" value="Đăng bình luận" id="commentSubmitButton"
                       onclick="addComment(${employer.id}, ${currentUser.id}); eraseText();"
                       class="btn btn-info"/>
            </form>
        </div>

        <div class="d-flex flex-column" id="commentArea"></div>

        <div class="d-flex flex-column-reverse">
            <c:forEach items="${employer.comments}" var="cmt">
                <div class="row">
                    <div class="media g-mb-30 media-comment w-100">
                        <img class="d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15"
                             src="${cmt.user.avatar}"
                             alt="Image Description">
                        <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
                            <div class="g-mb-15 mb-2">
                                <h4 class="text-info g-color-gray-dark-v1 mb-0">
                                        ${cmt.user.fullName}
                                </h4>
                                <span class="g-color-gray-dark-v4 g-font-size-12" id="cmtDatePosted">
                                        ${cmt.createdDate}
                                </span>
                            </div>
                            <p style="font-weight: 400"> ${cmt.content} </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script>
    moment.locale('vi')
    let dates = document.querySelectorAll("#cmtDatePosted")
    for (let i = 0; i < dates.length; i++) {
        let d = dates[i];
        d.innerText = moment(d.innerText).fromNow();
    }

    $(function () {

        $(document).on({
            mouseover: function (event) {
                $(this).find('.far').addClass('star-over');
                $(this).prevAll().find('.far').addClass('star-over');
            },
            mouseleave: function (event) {
                $(this).find('.far').removeClass('star-over');
                $(this).prevAll().find('.far').removeClass('star-over');
            }
        }, '.rate');


        $(document).on('click', '.rate', function () {
            if (!$(this).find('.star').hasClass('rate-active')) {
                $(this).siblings().find('.star').addClass('far').removeClass('fas rate-active');
                $(this).find('.star').addClass('rate-active fas').removeClass('far star-over');
                $(this).prevAll().find('.star').addClass('fas').removeClass('far star-over');
            } else {
                console.log('has');
            }
        });

    });
</script>

<style>
    .wrap {
        height: 50px;
        background: #fff;
        border-radius: 10px;
    }

    .stars {
        width: fit-content;
        margin: 0 auto;
        cursor: pointer;
    }

    .star {
        color: #17a2b8 !important;
    }

    .rate {
        height: 50px;
        margin-left: -5px;
        padding: 5px;
        font-size: 25px;
        position: relative;
        cursor: pointer;
    }

    .rate input[type="radio"] {
        opacity: 0;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, 0%);
        pointer-events: none;
    }

    .star-over::after {
        font-family: 'Font Awesome 5 Free';
        font-weight: 900;
        font-size: 16px;
        content: "\f005";
        display: inline-block;
        color: #17a2b8;
        z-index: 1;
        position: absolute;
        top: 17px;
        left: 10px;
    }

    .rate:nth-child(1) .face::after {
        content: "\f119"; /* ☹ */
    }

    .rate:nth-child(2) .face::after {
        content: "\f11a"; /* 😐 */
    }

    .rate:nth-child(3) .face::after {
        content: "\f118"; /* 🙂 */
    }

    .rate:nth-child(4) .face::after {
        content: "\f580"; /* 😊 */
    }

    .rate:nth-child(5) .face::after {
        content: "\f59a"; /* 😄 */
    }

    .face {
        opacity: 0;
        position: absolute;
        width: 35px;
        height: 35px;
        background: #17a2b8;
        border-radius: 5px;
        top: -50px;
        left: 2px;
        transition: 0.2s;
        pointer-events: none;
    }

    .face::before {
        font-family: 'Font Awesome 5 Free';
        font-weight: 900;
        content: "\f0dd";
        display: inline-block;
        color: #17a2b8;
        z-index: 1;
        position: absolute;
        left: 9px;
        bottom: -15px;
    }

    .face::after {
        font-family: 'Font Awesome 5 Free';
        font-weight: 900;
        display: inline-block;
        color: #fff;
        z-index: 1;
        position: absolute;
        left: 5px;
        top: -1px;
    }

    .rate:hover .face {
        opacity: 1;
    }

    /*===*/

    .ratings {
        background-color: #fff;
        padding: 30px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        box-shadow: 0px 10px 10px #E0E0E0;
    }

    .product-rating {
        font-size: 50px;
    }

    @media (min-width: 0) {
        .g-mr-15 {
            margin-right: 15px !important;
        }
    }

    @media (min-width: 0) {
        .g-mt-3 {
            margin-top: 10px !important;
        }
    }

    .g-height-50 {
        height: 50px;
    }

    .g-width-50 {
        width: 50px !important;
    }

    @media (min-width: 0) {
        .g-pa-30 {
            padding: 20px !important;
        }
    }

    .g-bg-secondary {
        background-color: #fafafa !important;
    }

    .u-shadow-v18 {
        box-shadow: 0 5px 10px -6px rgba(0, 0, 0, 0.15);
    }

    .g-color-gray-dark-v4 {
        color: #777 !important;
    }

    .g-font-size-12 {
        font-size: 0.85714rem !important;
    }

    .media-comment {
        margin-top: 20px
    }
</style>

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