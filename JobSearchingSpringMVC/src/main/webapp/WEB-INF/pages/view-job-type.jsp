<%--
  Created by IntelliJ IDEA.
  User: Lightning
  Date: 10/04/2022
  Time: 3:19 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">

    <h1 class="text-center dark-color">THÔNG TIN LOẠI VIỆC LÀM</h1>

    <div class="container mt-4">
        <table class="table table-striped">
            <tbody>
            <tr>
                <th style="width: 30%" scope="row">ID</th>
                <td class="border-left">${jobType.id}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Tên loại việc làm</th>
                <td class="border-left">${jobType.name}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>