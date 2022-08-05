<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="custom-wrapper">
    <div class="container m-auto" style="background: none">
        <!-- Outer Row -->
        <div class="row justify-content-center">
            <div class="col-xl-10 col-lg-12 col-md-9">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-change-password-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-2">Đổi mật khẩu</h1>
                                        <p class="mb-4">
                                            Bạn có thể thay đổi mật khẩu vì lý do bảo mật.
                                        </p>
                                    </div>

                                    <form class="user">
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                   id="raw-password"
                                                   oninput="checkPassword(${currentUser.id})"
                                                   placeholder="Mật khẩu hiện tại">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                   id="password"
                                                   oninput="checkPassword(${currentUser.id})"
                                                   placeholder="Mật khẩu mới">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                   id="confirm-password"
                                                   oninput="checkPassword(${currentUser.id})"
                                                   placeholder="Xác nhận mật khẩu mới">
                                        </div>
                                        <div class="card bg-danger text-white shadow" id="alert-card"
                                             style="display:none;">
                                            <div class="card-body" id="alert-card-body">
                                                Success
                                            </div>
                                        </div>
                                        <hr>
                                        <button type="submit" class="btn btn-primary btn-user btn-block">
                                            Đổi mật khẩu
                                        </button>
                                    </form>
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
<script src="<c:url value="/resources/js/change-password.js"/>"></script>

