<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <h1 class="text-center dark-color">THỐNG KÊ BÀI VIẾT THEO LOẠI VIỆC LÀM</h1>
</div>

<div class="container">
    <div class="row">
        <div class="col-7">
            <table class="table table-striped mt-5">
                <thead>
                <tr>
                    <th class="text-center" style="width: 15%" scope="col">ID</th>
                    <th scope="col">Loại việc làm</th>
                    <th class="text-center" scope="col">Số lượng bài đã đăng</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${jobPostStatsByJobType}" var="stat">
                    <tr>
                        <th class="text-center" scope="row">#${stat[0]}</th>
                        <td>${stat[1]}</td>
                        <td class="text-center">${stat[2]}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <button type="button" class="btn btn-info" onClick="refreshPage()">Tải lại bảng thống kê</button>
        </div>
        <div class="col-5 mt-5">
            <canvas id="myUserTypeChart"></canvas>
        </div>
    </div>
</div>

<script>
    let userTypeLabels = [], userTypeInfos = []

    <c:forEach items="${jobPostStatsByJobType}" var="stat">
    userTypeLabels.push('${stat[1]}')
    userTypeInfos.push('${stat[2]}')
    </c:forEach>

    window.onload = function () {
        userTypeChart("myUserTypeChart", userTypeLabels, userTypeInfos)
    }
</script>