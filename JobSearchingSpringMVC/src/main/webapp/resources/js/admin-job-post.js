function search() {
    const search = {}

    if (document.getElementById('title').value.trim().length !== 0)
        search.title = document.getElementById('title').value;

    if (document.getElementById('employerName').value.trim().length !== 0)
        search.employerName = document.getElementById('employerName').value;

    if (document.getElementById('jobType').value.trim().length !== 0)
        search.jobTypeId = document.getElementById('jobType').value;

    return search
}

function removeSearch() {
    search.username = document.getElementById('title').value = ""
    search.phone = document.getElementById('employerName').value = ""
    search.email = document.getElementById('jobType').value = ""
}

function employerPreview(employer) {
    let userId = employer.options[employer.selectedIndex].value

    if (parseInt(userId) === 0) {
        document.getElementById('img-employer-preview').style.backgroundImage = "url('/JobSearchingSpringMVC/resources/images/none.png')";
        document.getElementById('employer-name-preview').innerText = ""
        document.getElementById('employer-contact-preview').innerText = ""
        document.getElementById('employer-website-preview').innerText = ""
    } else {
        fetch("/JobSearchingSpringMVC/api/load-users", {
            method: 'post',
            body: JSON.stringify({
                "id": userId
            }),
            headers: {
                "Content-Type": "application/json"
            }
        }).then(function (res) {
            console.info(res)
            return res.json();
        }).then(function (data) {
            console.info(data[0].avatar);
            document.getElementById('img-employer-preview').style.backgroundImage = `url(${data[0].avatar})`;
            document.getElementById('employer-name-preview').innerText = data[0].employer.name
            document.getElementById('employer-contact-preview').innerText = data[0].employer.contact
            document.getElementById('employer-website-preview').innerText = data[0].employer.website
        })
    }
}

function deleteJobPost(jobPostId) {
    let urlFetch = "/JobSearchingSpringMVC/api/job-post/delete/".concat(jobPostId)
    fetch(urlFetch, {
        method: 'delete'
    }).then(function (res) {
        console.info(res)

        loadJobPost(1)

        if (res.status === 202) {
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

    console.log('query json = ' + JSON.stringify(query))

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
                    Không có kết quả
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

function loadJobPostWithNoFilter() {
    let page = 1;
    removeSearch()
    loadJobPostPagination(1)

    document.getElementById('alert-area').innerHTML = ""

    fetch("/JobSearchingSpringMVC/api/load-jobs", {
        method: 'post',
        body: JSON.stringify({}),
        headers: {
            "Content-Type": "application/json"
        }
    }).then(function (res) {
        console.info(res)
        return res.json();
    }).then(function (data) {
        console.info(data);

        let area = document.getElementById('tbody-data-job-post')
        let urlView
        let urlEdit
        area.innerHTML = ""

        for (let i = 0; i < data.length; i++) {
            urlView = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-post/view?id='.concat(data[i].id))
            urlEdit = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-post/update?id='.concat(data[i].id))

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

