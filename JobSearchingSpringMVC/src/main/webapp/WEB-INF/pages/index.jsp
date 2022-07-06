<%-- 
    Document   : index
    Created on : Apr 4, 2022, 11:39:10 PM
    Author     : Lightning
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">

<c:if test="${sucMsg != null}">
    <div class="alert alert-success my-0" role="alert">
            ${sucMsg}
        <br>
        <a class="link-success" href="<c:url value="/login"/>">
            Đăng nhập ngay thôi!
        </a>
    </div>
</c:if>
</div>
