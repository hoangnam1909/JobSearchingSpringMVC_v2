<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <h1 class="text-center dark-color">THÔNG TIN NHÀ TUYỂN DỤNG</h1>
    <div class="container mt-4">
        <table class="table table-striped">
            <tbody>
            <tr>
                <th style="width: 30%" scope="row">ID</th>
                <td class="border-left">${employer.id}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Tên công ty</th>
                <td class="border-left">${employer.name}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Mô tả</th>
                <td class="border-left">${employer.description}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Địa điểm</th>
                <td class="border-left">${employer.location}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Liên hệ</th>
                <td class="border-left">${employer.contact}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Trang web</th>
                <td class="border-left">${employer.website}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>