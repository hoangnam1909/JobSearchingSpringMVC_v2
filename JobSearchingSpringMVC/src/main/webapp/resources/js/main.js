$(document).ready(function () {
    $("#password").val("");
    $("#confirmPassword").val("");

    if ($("#dobDay").val() === "0")
        $("#dobDay").val("");

    if ($("#dobMonth").val() === "0")
        $("#dobMonth").val("");

    if ($("#dobYear").val() === "0")
        $("#dobYear").val("");
});

$('.confirmation').on('click', function () {
    return confirm('Bạn có chắc chắn muốn xoá?');
});

$("textarea").each(function () {
    this.setAttribute("style", "height:" + (this.scrollHeight) + "px;overflow-y:hidden;");
}).on("input", function () {
    this.style.height = "auto";
    this.style.height = (this.scrollHeight) + "px";
});

imgInp.onchange = evt => {
    const [file] = imgInp.files
    if (file) {
        blah.src = URL.createObjectURL(file)
    }
}

function refreshPage() {
    window.location.reload();
}

function removeFilter() {
    window.location.href = window.location.href.split('?')[0]
}

function updateQueryStringParameter(key, value) {
    let uri = window.location.href
    let re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
    let separator = uri.indexOf('?') !== -1 ? "&" : "?";
    if (uri.match(re)) {
        window.location.href = uri.replace(re, '$1' + key + "=" + value + '$2');
    } else {
        window.location.href = uri + separator + key + "=" + value;
    }
}

function process(e) {
    let code = (e.keyCode ? e.keyCode : e.which);
    let textarea = document.getElementById('commentId');
    if (code === 13) {
        if (textarea.value.trim() !== '') {
            document.getElementById("commentSubmitButton").click();
            e.preventDefault()
        }
    }
}

function eraseText() {
    document.getElementById("commentId").value = "";
}

function viewInfo(postID) {
    let url = "/JobSearchingSpringMVC/api/view-info/".concat(postID)
    fetch(url)
        .then(function (res) {
            console.info(res)
            return res.json();
        })
        .then(function (data) {
            console.info(data);

            let area = document.getElementById("modal-body");
            moment.locale('vi');

            area.innerHTML = ''

            area.innerHTML = `                         
              ${data.description}
        ` + area.innerHTML
        })
}

function addComment(employerId, userId) {
    let textarea = document.getElementById('commentId');
    if (textarea.value.trim() !== '') {
        fetch("/JobSearchingSpringMVC/api/add-comment", {
            method: 'post',
            body: JSON.stringify({
                "content": document.getElementById("commentId").value,
                "employerId": employerId,
                "userId": userId
            }),
            headers: {
                "Content-Type": "application/json"
            }
        }).then(function (res) {
            console.info(res)
            return res.json();
        }).then(function (data) {
            console.info(data);

            let area = document.getElementById("commentArea");
            moment.locale('vi');

            area.innerHTML = `                         
              <div class="row">
                <div class="media g-mb-30 media-comment w-100">
                    <img class="d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15"
                         src="${data.user.avatar}"
                         alt="Image Description">
                    <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
                        <div class="g-mb-15 mb-2">
                            <h4 class="text-info g-color-gray-dark-v1 mb-0">
                                    ${data.user.fullName}
                            </h4>
                            <span class="g-color-gray-dark-v4 g-font-size-12"> ${moment(data.createdDate).fromNow()} </span>
                        </div>
                        <p style="font-weight: 400"> ${data.content} </p>
                    </div>
                </div>
            </div>  
        ` + area.innerHTML
        })
    }
}

function viewFullInfoJob(jobId) {
    let url = "/JobSearchingSpringMVC/api/view-info/".concat(jobId)
    fetch(url)
        .then(function (res) {
            console.info(res)
            return res.json();
        })
        .then(function (data) {
            console.info(data);

            let area = document.getElementById("modal-body-".concat(jobId));
            let jobPostUrl = window.location.origin.concat('/JobSearchingSpringMVC/candidate/view-post?id='.concat(jobId))
            console.log(jobPostUrl)

            moment.locale('vi');

            area.innerHTML = ''

            area.innerHTML = `                         
                <div class="g-mb-15">
                    <a class="text-decoration-none" href="${jobPostUrl}" target="_blank" >
                        <h3 class="mb-3" style="color: #1ea2b6">
                                ${data.title}
                        </h3>
                    </a>
                </div>

                <h5 class="g-color-gray-dark-v1 mb-3">
                    Mô tả: <span style="font-weight: 400"> ${data.description} </span>
                </h5>

                <h5 class="g-color-gray-dark-v1 mb-3">
                    Địa điểm: <span style="font-weight: 400"> ${data.location} </span>
                </h5>

                <h5 class="g-color-gray-dark-v1 mb-3">
                    Lương khởi điểm:
                    <span style="font-weight: 400">
                        <fmt:formatNumber type="number" maxFractionDigits="3"
                                          value="${data.beginningSalary}"/> VNĐ
                    </span>
                </h5>

                <h5 class="g-color-gray-dark-v1 mb-3">
                    Lương tối đa:
                    <span style="font-weight: 400">
                        <fmt:formatNumber type="number" maxFractionDigits="3"
                                          value="${data.endingSalary}"/> VNĐ
                    </span>
                </h5>
        ` + area.innerHTML
        })
}

function applyJob(candidateId, jobId) {
    fetch("/JobSearchingSpringMVC/api/apply-job", {
        method: 'post',
        body: JSON.stringify({
            "candidate_id": candidateId,
            "job_id": jobId
        }),
        headers: {
            "Content-Type": "application/json"
        }
    }).then(r => {
        let area = document.getElementById("modal-body-".concat(jobId));
        area.innerHTML = ''
        area.innerHTML = `                         
                <div class="g-mb-15">
                    <a class="text-decoration-none">
                        <h3 style="color: #1ea2b6; text-align: center">
                                NỘP ĐƠN ỨNG TUYỂN <br> THÀNH CÔNG
                        </h3>
                    </a>
                </div>                
        ` + area.innerHTML

        document.getElementById("button-submit-".concat(jobId)).style.display = 'none'
    })
}

function deleteApplyJob(applyJobId) {
    let url = '/JobSearchingSpringMVC/api/apply-job/delete/'.concat(applyJobId)
    fetch(url, {
        method: 'DELETE'
    })
        .then(function (res) {
            if (res.status === 202) {
                let launchModalButton = document.getElementById('launch-modal')
                let modalBodyElement = document.getElementById('modal-body')
                let rowElement = document.getElementById('apply-job-row-'.concat(applyJobId))

                rowElement.innerHTML = ''

                modalBodyElement.innerHTML = ''
                modalBodyElement.innerHTML = `
            Xoá thành công đơn ứng tuyển
            `

                launchModalButton.click()
            }
        })
}

function loadJobs() {
    fetch("/JobSearchingSpringMVC/api/load-jobs", {
        method: 'post',
        body: JSON.stringify({
            "maxItems": 3
        }),
        headers: {
            "Content-Type": "application/json"
        }
    }).then(function (res) {
        console.info(res)
        return res.json();
    }).then(function (data) {
        console.info(data);

        let area = document.getElementById('display-jobs')
        let urlToJob
        area.innerHTML = ""

        for (let i = 0; i < data.length; i++) {
            urlToJob = window.location.origin.concat('/JobSearchingSpringMVC/candidate/view-post?id='.concat(data[i].id))

            area.innerHTML = area.innerHTML + `
                <div class="container m-0 p-0 pt-2">
                    <div class="col">
                        <div class="row">
                            <div class="media g-mb-30 media-comment w-100">
                                <a class="text-decoration-none"
                                   href="${urlToJob}">
                                    <img class="d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15"
                                         src="${data[i].postedByUser.avatar}"
                                         alt="Image Description">
                                </a>

                                <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
                                    <div class="g-mb-15">
                                        <a class="text-decoration-none"
                                           href="${urlToJob}">
                                            <h3 class="text-info mb-3">
                                                    ${data[i].title}
                                            </h3>
                                        </a>
                                    </div>

                                    <c:if test="${data[i].createdDate != null}">
                                        <h5 class="g-color-gray-dark-v1 mb-3">
                                            Ngày đăng: <span style="font-weight: 400">
                                    <fmt:formatDate pattern="HH:mm:ss - dd/MM/yyyy" value="${data[i].createdDate}"/>
                                </span>
                                        </h5>
                                    </c:if>

                                    <c:if test="${data[i].description != null}">
                                        <h5 class="g-color-gray-dark-v1 mb-3">
                                            Mô tả: <span style="font-weight: 400"> ${data[i].description} </span>
                                        </h5>
                                    </c:if>

                                    <c:if test="${data[i].location != null}">
                                        <h5 class="g-color-gray-dark-v1 mb-3">
                                            Địa điểm: <span style="font-weight: 400"> ${data[i].location} </span>
                                        </h5>
                                    </c:if>

                                    <c:if test="${data[i].beginningSalary != null}">
                                        <h5 class="g-color-gray-dark-v1 mb-3">
                                            Lương khởi điểm: <span style="font-weight: 400">
                                    <fmt:formatNumber type="number" maxFractionDigits="3"
                                                      value="${data[i].beginningSalary}"/> VNĐ
                            </span>
                                        </h5>
                                    </c:if>

                                    <c:if test="${data[i].endingSalary != null}">
                                        <h5 class="g-color-gray-dark-v1 mb-3">
                                            Lương tối đa: <span style="font-weight: 400">
                                <fmt:formatNumber type="number" maxFractionDigits="3"
                                                  value="${data[i].endingSalary}"/> VNĐ
                            </span>
                                        </h5>
                                    </c:if>

                                    <!-- Button trigger modal -->
                                    <button type="button" class="btn btn-info" data-toggle="modal"
                                            data-target="#exampleModalCenter${data[i].id}"
                                            onclick="viewFullInfoJob(${data[i].id})">
                                        Đăng ký ứng tuyển
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal -->
                <div class="modal fade" id="exampleModalCenter${data[i].id}" tabindex="-1" role="dialog"
                     aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header px-4">
                                <h5 class="modal-title" id="exampleModalLongTitle">Xác nhận nộp đơn ứng tuyển</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body px-4" id="modal-body-${data[i].id}"></div>
                            <div class="modal-footer px-4">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                <button type="button" class="btn btn-info" id="button-submit-${data[i].id}"
                                        onclick="">
                                    Nộp đơn ứng tuyển
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            `
        }
    })
}
