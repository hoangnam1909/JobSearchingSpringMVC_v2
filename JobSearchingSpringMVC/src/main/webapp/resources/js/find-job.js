async function candidateInfo(candidateId) {
    return fetch('/JobSearchingSpringMVC/api/candidate-info/'.concat(candidateId))
        .then(res => res.json());
}

async function jobInfo(jobId) {
    return fetch('/JobSearchingSpringMVC/api/view-info/'.concat(jobId))
        .then(res => res.json());
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
            // moment.locale('vi');

            area.innerHTML = ''

            area.innerHTML = `                         
              ${data.description}
        ` + area.innerHTML
        })
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

            // moment.locale('vi');

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
                        ${new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(data.beginningSalary)}
                    </span>
                </h5>

                <h5 class="g-color-gray-dark-v1 mb-3">
                    Lương tối đa:
                    <span style="font-weight: 400">
                        ${new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(data.endingSalary)}
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
    }).then(function (res) {
        console.info(res)
        // return res.json();
    }).then(async function (data) {
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

        let candidateRes = await candidateInfo(currentCandidateId)
        let jobRes = await jobInfo(jobId)
        console.log(jobRes)

        let sendTo = candidateRes.user.email
        let subject = 'Nộp đơn ứng tuyển thành công'
        let content = `Bạn đã nộp đơn ứng tuyển vào công việc ${jobRes.title}.
                        \nVui lòng chờ sự phản hồi từ nhà tuyển dụng ${jobRes.postedByUser.email}
                        \nXin cảm ơn`

        fetch('/JobSearchingSpringMVC/api/send-email', {
            method: 'post',
            body: JSON.stringify({
                "sendTo": sendTo,
                "subject": subject,
                "content": content
            }),
            headers: {
                "Content-Type": "application/json"
            }
        })
    })
}

function search() {
    const search = {}

    if (document.getElementById('job-title').value.trim().length !== 0)
        search.title = document.getElementById('job-title').value;

    if (document.getElementById('beginningSalary').value.trim().length !== 0)
        search.beginningSalary = document.getElementById('beginningSalary').value;

    return search
}

function loadJobs(pageInput, maxItems) {
    const queryString = window.location.search;
    console.log(queryString);
    const urlParams = new URLSearchParams(queryString);

    const query = {}

    removeActivePagination()
    let page = pageInput;
    if (page === undefined) {
        page = urlParams.get('page') || '1'
    }

    query.page = page
    query.maxItems = maxItems

    if (document.getElementById('job-title').value.trim().length !== 0)
        query.title = document.getElementById('job-title').value;

    let pageButton = document.getElementsByClassName('page-item')
    for (let i = 0; i < pageButton.length; i++) {
        console.log(pageButton[i].innerText)
        if (pageButton[i].innerText == page)
            pageButton[i].classList.add('active')
    }

    fetch("/JobSearchingSpringMVC/api/load-jobs", {
        method: 'post',
        body: JSON.stringify(query),
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
                                                ${moment(data[i].createdDate).format('LLLL').charAt(0).toUpperCase()
            + moment(data[i].createdDate).format('LLLL').slice(1)}
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
                                            ${new Intl.NumberFormat('vi-VN',
                {style: 'currency', currency: 'VND'})
                .format(data[i].beginningSalary)}
                                        </span>
                                        </h5>
                                    </c:if>

                                    <c:if test="${data[i].endingSalary != null}">
                                        <h5 class="g-color-gray-dark-v1 mb-3">
                                            Lương tối đa: <span style="font-weight: 400">
                                                ${new Intl.NumberFormat('vi-VN',
                {style: 'currency', currency: 'VND'})
                .format(data[i].endingSalary)}
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
                                        onclick="applyJob(${currentCandidateId}, ${data[i].id})">
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
