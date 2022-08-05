function deleteJobPost(jobPostId) {
    let urlFetch = "/JobSearchingSpringMVC/api/job-post/delete/".concat(jobPostId)
    fetch(urlFetch, {
        method: 'delete'
    }).then(function (res) {
        console.info(res)

        if (res.status === 202) {
            document.getElementById('jobPost'.concat(jobPostId)).remove()

            let alertArea = document.getElementById('alert-area')
            alertArea.innerHTML = ""
            alertArea.innerHTML = `
                <div class="alert alert-success text-center" role="alert">
                    Xoá thành công tin tuyển dụng
                </div>
            `
        }

        return res.json();
    })
}

async function loadJobPostPagination(activePageNumber) {
    let endOfNumberPage = parseInt(await numberOfPages());
    let paginationArea = document.getElementById('pagination-area')
    paginationArea.innerHTML = ""

    for (let i = 1; i <= Math.ceil(endOfNumberPage / maxItems); i++) {
        if (i === 1) {
            paginationArea.innerHTML +=
                `
                <li class="page-item">
                    <a class="page-link" style="cursor: pointer"
                       onclick="loadJobPost(${i})">${i}</a>
                </li>
            `
        } else {
            paginationArea.innerHTML +=
                `
                <li class="page-item">
                    <a class="page-link" style="cursor: pointer"
                       onclick="loadJobPost(${i})">${i}</a>
                </li>
            `
        }
    }

    activePagination(activePageNumber);
}

async function numberOfPages() {
    let result = await countLoadJobPostResult();
    return JSON.stringify(result.length)
}

async function countLoadJobPostResult() {
    const query = search()

    query.page = 0
    query.maxItems = maxItems
    query.jobTypeId = jobTypeId

    let url = '/JobSearchingSpringMVC/api/load-jobs';
    try {
        let res = await fetch(url, {
            method: 'post',
            body: JSON.stringify(query),
            headers: {
                "Content-Type": "application/json"
            }
        });
        return await res.json();
    } catch (error) {
        console.log(error);
    }
}

function loadJobPost(pageInput) {
    const query = search()

    let page = pageInput;
    if (page == undefined) {
        page = 1
    }

    query.page = page
    query.maxItems = maxItems
    query.jobTypeId = jobTypeId

    loadJobPostPagination(page)

    fetch("/JobSearchingSpringMVC/api/load-jobs", {
        method: 'post',
        body: JSON.stringify(query),
        headers: {
            "Content-Type": "application/json"
        }
    }).then(function (res) {
        console.info(res)

        if (res.status === 200) {
            let alertArea = document.getElementById('alert-area')
            alertArea.innerHTML = ""
        } else if (res.status === 204) {
            let alertArea = document.getElementById('alert-area')
            alertArea.innerHTML = ""
            alertArea.innerHTML = `
                <div class="alert alert-danger text-center" role="alert">
                    <h5 class="text-center dark-color mb-0">
                        Không có kết quả
                    </h5>
                </div>
            `
            document.getElementById('tbody-data-job-post').innerHTML = ""
            document.getElementById('pagination-area').innerHTML = ""
        }

        return res.json();
    }).then(function (data) {
        console.info(data);

        let area = document.getElementById('tbody-data-job-post')
        let urlView
        let urlEdit
        let urlDelete
        area.innerHTML = ""

        for (let i = 0; i < data.length; i++) {
            urlView = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-post/view?id='.concat(data[i].id))
            urlEdit = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-post/update?id='.concat(data[i].id))
            urlDelete = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-post/delete?id='.concat(data[i].id))

            area.innerHTML +=
                `
                    <tr id="jobPost${data[i].id}">
                        <td style="text-align: center">
                            <a style="margin-right: 10px" href="${urlView}"
                               title="Xem chi tiết">
                                <i class="fa-solid fa-eye"></i>
                            </a>
                            <a style="margin-right: 10px" href="${urlEdit}"
                               title="Sửa">
                                <i class="fa-solid fa-pen"></i>
                            </a>
                            <a onclick="deleteJobPost(${data[i].id})"
                               title="Xoá" style="cursor: pointer; color: #4e73df">
                                <i class="fa-solid fa-trash"></i>
                            </a>
                        </td>
                        <td class="text-center">
                            ${(page - 1) * maxItems + i + 1}
                        </td>
                        <td> ${data[i].title} </td>
                        <td>
                            <c:if test="${data[i].createdDate != null}">
                                ${moment(data[i].createdDate).format('L')}
                            </c:if>
                        </td>
                        <td> ${data[i].postedByEmployerUser.employer.name} </td>
                        
                        <td> ${data[i].jobType.name} </td>
                    </tr>
                `
        }
    })
}