<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <h1 class="text-center dark-color">TRANG CHỦ NHÀ TUYỂN DỤNG</h1>
    <c:if test="${currentUser.active == 0}">
        <h4 class="text-center text-danger mt-3">NHÀ TUYỂN DỤNG CHƯA ĐƯỢC KÍCH HOẠT</h4>
    </c:if>
</div>