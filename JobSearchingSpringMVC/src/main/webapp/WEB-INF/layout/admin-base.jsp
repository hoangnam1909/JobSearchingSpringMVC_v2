<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>
        <tiles:insertAttribute name="title"/>
    </title>
    <link rel="icon" href="<c:url value="/resources/images/admin-icon.png" />">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css"
          integrity="sha512-1sCRPdkRXhBV2PBLUdRb4tMg1w2YPf37qatUFeS7zlBy7jJI8Lf4VHwWfZZfpXtYSLy85pkm9GaYVYMfw5BC1A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <%--    <link href="<c:url value="/resources/vendor/fontawesome-free/css/all.min.css" />" rel="stylesheet" type="text/css">--%>
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<c:url value="/resources/css/sb-admin-2.min.css" />" rel="stylesheet">

    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"--%>
    <%--            integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="--%>
    <%--            crossorigin="anonymous" referrerpolicy="no-referrer"></script>--%>
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.0/js/bootstrap.bundle.min.js"--%>
    <%--            integrity="sha512-9GacT4119eY3AcosfWtHMsT5JyZudrexyEVzTBWV3viP/YfB9e2pEy3N7WXL3SV6ASXpTU0vzzSxsbfsuUH4sQ=="--%>
    <%--            crossorigin="anonymous" referrerpolicy="no-referrer"></script>--%>
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"--%>
    <%--            integrity="sha512-0QbL0ph8Tc8g5bLhfVzSqxe9GERORsKhIn1IrpxDAgUsbBGz/V7iSav2zzW325XGd1OMLdL4UiqRJj702IeqnQ=="--%>
    <%--            crossorigin="anonymous" referrerpolicy="no-referrer"></script>--%>
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.2/chart.min.js"--%>
    <%--            integrity="sha512-zjlf0U0eJmSo1Le4/zcZI51ks5SjuQXkU0yOdsOBubjSmio9iCUp8XPLkEAADZNBdR9crRy3cniZ65LF2w8sRA=="--%>
    <%--            crossorigin="anonymous" referrerpolicy="no-referrer"></script>--%>
    <%--    <script src="<c:url value="/resources/js/sb-admin-2.min.js"/>"></script>--%>

</head>

<body id="page-top">

<div id="wrapper">

    <tiles:insertAttribute name="sidebar"/>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <tiles:insertAttribute name="topbar"/>

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <tiles:insertAttribute name="content"/>

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->

        <tiles:insertAttribute name="footer"/>


    </div>
    <!-- End of Content Wrapper -->

    <%--    <script src="<c:url value="/resources/vendor/jquery/jquery.min.js" />"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.js"
            integrity="sha512-n/4gHW3atM3QqRcbCn6ewmpxcLAHGaDjpEBu4xZd47N0W2oQ+6q7oc3PXstrJYXcbNU1OHdQ1T7pAP+gi5Yu8g=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js" />"></script>
    <script src="<c:url value="/resources/vendor/jquery-easing/jquery.easing.min.js" />"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.3/moment-with-locales.min.js"
            integrity="sha512-vFABRuf5oGUaztndx4KoAEUVQnOvAIFs59y4tO0DILGWhQiFnFHiR+ZJfxLDyJlXgeut9Z07Svuvm+1Jv89w5g=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="<c:url value="/resources/js/sb-admin-2.min.js" />"></script>
    <script src="<c:url value="/resources/vendor/chart.js/Chart.min.js" />"></script>

        <script src="<c:url value="/resources/js/chart-area-demo.js" />"></script>
        <script src="<c:url value="/resources/js/chart-pie-demo.js" />"></script>
    <script src="<c:url value="/resources/js/main.js" />"></script>
</div>

<%--<a id="back-to-top" href="#" class="btn btn-light btn-lg back-to-top" role="button">--%>
<%--    <i class="fas fa-chevron-up"></i>--%>
<%--</a>--%>

<%--<script>--%>
<%--    $(document).ready(function () {--%>
<%--        $(window).scroll(function () {--%>
<%--            if ($(this).scrollTop() > 50) {--%>
<%--                $('#back-to-top').fadeIn();--%>
<%--            } else {--%>
<%--                $('#back-to-top').fadeOut();--%>
<%--            }--%>
<%--        });--%>
<%--        // scroll body to 0px on click--%>
<%--        $('#back-to-top').click(function () {--%>
<%--            $('body,html').animate({--%>
<%--                scrollTop: 0--%>
<%--            }, 400);--%>
<%--            return false;--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>

</body>

</html>