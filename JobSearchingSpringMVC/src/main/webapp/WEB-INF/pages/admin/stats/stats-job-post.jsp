<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 text-gray-800">Trang thống kê tổng hợp</h1>
    <a href="#" class="btn btn-primary btn-icon-split" onclick="reloadStats()">
        <span class="icon text-white-50">
            <i class="fa-solid fa-arrow-rotate-right"></i>
        </span>
        <span class="text">Tải lại biểu đồ thống kê</span>
    </a>
</div>

<div class="row">

    <div class="col-xl-8 col-lg-7">

        <!-- Area Chart -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Area Chart</h6>
            </div>
            <div class="card-body">
                <div class="chart-area">
                    <canvas id="myAreaChart"></canvas>
                </div>
                <hr>
                Styling for the area chart can be found in the
                <code>/js/demo/chart-area-demo.js</code> file.
            </div>
        </div>

        <!-- Bar Chart -->
        <div class="card shadow mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h5 class="m-0 font-weight-bold text-primary">
                    Số lượng tin tuyển dụng theo loại việc làm
                </h5>
            </div>
            <div class="card-body py-4" id="job-post-in-job-type-loading">
                <div class="d-flex justify-content-center">
                    <div class="spinner-border" style="width: 4rem; height: 4em;" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>
            </div>

            <div class="card-body" id="job-post-in-job-type-display"
                 style="display: none">
                <div class="chart-container" style="position: relative; height:35vh">
                    <canvas id="job-post-in-job-type-canvas"></canvas>
                </div>
                <hr>
                Biểu đồ trên cho biết số lượng tin tuyển dụng của từng loại việc làm.
            </div>
        </div>
    </div>

    <!-- Donut Chart -->
    <div class="col-xl-4 col-lg-5">
        <div class="card shadow mb-4">
            <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h5 class="m-0 font-weight-bold text-primary">
                    Nhà tuyển dụng đã kích hoạt
                </h5>
            </div>
            <div class="card-body py-4" id="employer-activated-loading">
                <div class="d-flex justify-content-center">
                    <div class="spinner-border" style="width: 4rem; height: 4em;" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>
            </div>
            <!-- Card Body -->
            <div class="card-body" id="employer-activated-display"
                 style="display: none">
                <div class="pt-4">
                    <canvas id="employer-activated-canvas"></canvas>
                </div>
                <hr>
                Styling for the donut chart can be found in the
            </div>
        </div>
    </div>
</div>

<script src="<c:url value="/resources/js/stats/stats.js"/>"></script>
<script src="<c:url value="/resources/js/stats/stat-job-post.js"/>"></script>
<script src="<c:url value="/resources/js/stats/stat-employer-activated.js"/>"></script>

<script>
    window.onload = (event) => {
        document.getElementById('job-post-in-job-type-display').style.display = "none";
        jobPostInJobTypeChart('job-post-in-job-type-canvas');

        document.getElementById('employer-activated-display').style.display = "none";
        statEmployerActivated('employer-activated-canvas');
    };
</script>
