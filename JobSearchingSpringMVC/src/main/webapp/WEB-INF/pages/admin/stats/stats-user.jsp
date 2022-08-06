<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <h1 class="text-center dark-color">THỐNG KÊ LOẠI TÀI KHOẢN</h1>
</div>

<div class="container">
    <div class="row">
        <div class="col">
            <table class="table table-striped mt-5">
                <thead>
                <tr>
                    <th scope="col">Loại tài khoản</th>
                    <th class="text-center" scope="col">Số lượng tài khoản</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${userStats}" var="stat">
                    <tr>
                        <th scope="row">${stat[0]}</th>
                        <td class="text-center">${stat[1]}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <button type="button" class="btn btn-info" onClick="refreshPage()">Tải lại bảng thống kê</button>
        </div>
        <div class="col mt-5">
            <canvas id="myUserTypeChart"></canvas>
        </div>
    </div>
</div>

<script>
    let userTypeLabels = [], userTypeInfos = []

    <c:forEach items="${userStats}" var="stat">
    userTypeLabels.push('${stat[0]}')
    userTypeInfos.push('${stat[1]}')
    </c:forEach>

    window.onload = function () {
        userTypeChart("myUserTypeChart", userTypeLabels, userTypeInfos)
    }
</script>