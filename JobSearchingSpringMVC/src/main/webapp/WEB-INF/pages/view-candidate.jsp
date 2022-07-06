<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <h1 class="text-center dark-color">THÔNG TIN ỨNG VIÊN</h1>

    <div class="container mt-4">
        <table class="table table-striped">
            <tbody>
            <tr>
                <th style="width: 30%" scope="row">Số năm kinh nghiệm</th>
                <td class="border-left">${candidate.yearsExperience}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Điểm mạnh</th>
                <td class="border-left">${candidate.strengths}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Điểm yếu</th>
                <td class="border-left">${candidate.weaknesses}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Chuyên ngành</th>
                <td class="border-left">${candidate.majoring}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Chứng chỉ ngoại ngữ</th>
                <td class="border-left">${candidate.languageCertificate}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Chứng chỉ tin học</th>
                <td class="border-left">${candidate.informaticsCertificate}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
