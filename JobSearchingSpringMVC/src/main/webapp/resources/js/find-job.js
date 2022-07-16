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

