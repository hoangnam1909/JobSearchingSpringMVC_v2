<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url value="/login" var="action"/>

<div class="custom-wrapper">
    <div class="container m-auto" style="background: none">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Đăng nhập</h1>
                                    </div>
                                    <form class="user" method="post" action="${action}">
                                        <div class="form-group">
                                            <input type="username" name="username" style="font-size: 16px"
                                                   class="form-control form-control-user"
                                                   placeholder="Tên đăng nhập..." autofocus="autofocus">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" name="password" style="font-size: 16px"
                                                   class="form-control form-control-user"
                                                   placeholder="Nhập mật khẩu...">
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="customCheck">
                                                <label class="custom-control-label" for="customCheck">
                                                    Remember Me
                                                </label>
                                            </div>
                                        </div>
                                        <%--                                    <a href="index.html" class="btn btn-primary btn-user btn-block">--%>
                                        <%--                                        Login--%>
                                        <%--                                    </a>--%>
                                        <button type="submit" class="btn btn-primary btn-user btn-block"
                                                style="font-size: 16px">
                                            Đăng nhập
                                        </button>
                                    </form>

                                    <hr>
                                    <div class="text-center" style="font-size: 18px">
                                        <a class="small" href="<c:url value="/forgot-password"/>">Quên mật khẩu?</a>
                                    </div>
                                    <div class="text-center" style="font-size: 18px">
                                        <a class="small" href="<c:url value="/register"/>">Tạo tài khoản!</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

</div>

<!-- Bootstrap core JavaScript-->
<script src="<c:url value="/resources/vendor/jquery/jquery.min.js"/>"></script>
<script src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"/>"></script>

<!-- Core plugin JavaScript-->
<script src="<c:url value="/resources/vendor/jquery-easing/jquery.easing.min.js"/>"></script>

<!-- Custom scripts for all pages-->
<script src="<c:url value="/resources/js/sb-admin-2.min.js"/>"></script>