<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">

<h1 class="text-center dark-color">THÔNG TIN TÀI KHOẢN</h1>

<div class="container mt-4">
    <table class="table table-striped">
        <tbody>
        <tr>
            <th style="width: 30%" scope="row">Tên đăng nhập</th>
            <td class="border-left">${user.username}</td>
        </tr>
        <tr>
            <th style="width: 30%" scope="row">Email</th>
            <td class="border-left">${user.email}</td>
        </tr>
        <tr>
            <th style="width: 30%" scope="row">Số điện thoại</th>
            <td class="border-left">${user.phone}</td>
        </tr>
        <tr>
            <th style="width: 30%" scope="row">Ảnh đại diện</th>
            <td class="border-left">
                <c:if test="${user.avatar.length() != 0}">
                    <img src="<c:url value="${user.avatar}"/>" style="height: 100px"
                         class="img-fluid rounded" alt="avatar">
                </c:if>
                <c:if test="${user.avatar.length() == 0}">
                    Không có ảnh đại diện
                </c:if>
            </td>
        </tr>
        <tr>
            <th style="width: 30%" scope="row">Họ và tên</th>
            <td class="border-left">${user.fullName}</td>
        </tr>
        <tr>
            <th style="width: 30%" scope="row">Ngày sinh</th>
            <td class="border-left">
                <fmt:formatDate pattern="dd/MM/yyyy" value="${user.dob}"/>
            </td>
        </tr>
        <tr>
            <th style="width: 30%" scope="row">Địa chỉ</th>
            <td class="border-left">${user.address}</td>
        </tr>
        <tr>
            <th style="width: 30%" scope="row">Giới tính</th>
            <c:if test="${user.gender == 0}">
                <c:set var="gender" value="Nam"/>
            </c:if>
            <c:if test="${user.gender == 1}">
                <c:set var="gender" value="Nữ"/>
            </c:if>
            <td class="border-left">${gender}</td>
        </tr>
        <tr>
            <th style="width: 30%" scope="row">Trạng thái</th>
            <c:if test="${user.active == 0}">
                <c:set var="active" value="Chưa kích hoạt"/>
            </c:if>
            <c:if test="${user.active == 1}">
                <c:set var="active" value="Đã kích hoạt"/>
            </c:if>
            <td class="border-left">${active}</td>
        </tr>
        <tr>
            <th style="width: 30%" scope="row">Loại tài khoản</th>
            <td class="border-left">${user.userType}</td>
        </tr>
        <c:if test="${candidate != null}">
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
            <tr>
                <th style="width: 30%" scope="row">CV</th>
                <td class="border-left">
                    <c:if test="${candidate.cv.length() == 0}">
                        Chưa upload CV
                    </c:if>
                    <c:if test="${candidate.cv.length() > 0}">
                        <a href="${candidate.cv}">Xem trước CV tại đây</a>
                    </c:if>
                </td>
            </tr>
        </c:if>

        <c:if test="${employer != null}">
            <tr>
                <th style="width: 30%" scope="row">Tên công ty</th>
                <td class="border-left">${employer.name}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Mô tả</th>
                <td class="border-left">${employer.description}</td>
            </tr>
            <tr>
                <th style="width: 30%" scope="row">Trụ sở</th>
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
            <tr>
                <th style="width: 30%" scope="row">Chuyên ngành</th>
                <td class="border-left">${employer.majoring}</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
</div>
