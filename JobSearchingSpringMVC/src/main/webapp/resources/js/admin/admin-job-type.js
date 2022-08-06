function search() {
    const search = {}

    if (document.getElementById('name').value.trim().length !== 0)
        search.name = document.getElementById('name').value;

    return search
}

function removeSearch() {
    document.getElementById('name').value = ""
}

function deleteJobType(jobTypeId) {
    let urlFetch = "/JobSearchingSpringMVC/api/job-type/delete/".concat(jobTypeId)
    fetch(urlFetch, {
        method: 'delete'
    }).then(function (res) {
        console.info(res)

        if (res.status === 200) {
            document.getElementById('jobType'.concat(jobTypeId)).remove()

            let alertArea = document.getElementById('alert-area')
            alertArea.innerHTML = ""
            alertArea.innerHTML = `
                <div class="alert alert-success text-center" role="alert">
                    Xoá thành công loại việc làm
                </div>
            `
        }

        return res.json();
    })
}

async function loadJobTypePagination(activePageNumber) {
    let endOfNumberPage = parseInt(await numberOfPages());
    let paginationArea = document.getElementById('pagination-area')
    paginationArea.innerHTML = ""

    for (let i = 1; i <= Math.ceil(endOfNumberPage / maxItems); i++) {
        if (i === 1) {
            paginationArea.innerHTML +=
                `
                <li class="page-item">
                    <a class="page-link" style="cursor: pointer"
                       onclick="loadJobType(${i})">${i}</a>
                </li>
            `
        } else {
            paginationArea.innerHTML +=
                `
                <li class="page-item">
                    <a class="page-link" style="cursor: pointer"
                       onclick="loadJobType(${i})">${i}</a>
                </li>
            `
        }
    }

    activePagination(activePageNumber);
}

async function numberOfPages() {
    let result = await countLoadJobTypeResult();
    return JSON.stringify(result.length)
}

async function countLoadJobTypeResult() {
    const query = search()

    query.page = 0
    query.maxItems = maxItems

    console.log('query json = ' + JSON.stringify(query))

    let url = '/JobSearchingSpringMVC/api/load-job-type';
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

function loadJobType(pageInput) {
    const query = search()

    let page = pageInput;
    if (page == undefined) {
        page = 1
    }

    query.page = page
    query.maxItems = maxItems

    loadJobTypePagination(page)

    fetch("/JobSearchingSpringMVC/api/load-job-type", {
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
            document.getElementById('tbody-data-job-type').innerHTML = ""
            document.getElementById('pagination-area').innerHTML = ""
        }

        return res.json();
    }).then(function (data) {
        console.info(data);

        let area = document.getElementById('tbody-data-job-type')
        let urlView
        let urlEdit
        area.innerHTML = ""

        for (let i = 0; i < data.length; i++) {
            urlView = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-type/view-detail?id='.concat(data[i].id))
            urlEdit = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-type/add-or-update?id='.concat(data[i].id))

            area.innerHTML +=
                `
                    <tr id="jobType${data[i].id}">
                        <td style="text-align: center">
                            <a style="margin-right: 10px" href="${urlEdit}"
                               title="Sửa">
                                <i class="fa-solid fa-pen"></i>
                            </a>
                            <a onclick="deleteJobType(${data[i].id})"
                               title="Xoá" style="cursor: pointer; color: #4e73df">
                                <i class="fa-solid fa-trash"></i>
                            </a>
                        </td>
                        <td class="text-center">
                            ${(page - 1) * maxItems + i + 1}
                        </td>
                        <td> ${data[i].name} </td>
                        <td class="text-center">
                            <a style="margin-right: 10px" href="${urlView}"
                               title="Xem chi tiết">
                                <input type="button" class="btn btn-primary mx-1"
                                value="Xem danh sách việc làm" />
                            </a>
                        </td>
                    </tr>
                `
        }
    })
}

function loadJobTypeWithNoFilter() {
    let page = 1;
    removeSearch()
    loadJobTypePagination(1)

    document.getElementById('alert-area').innerHTML = ""

    fetch("/JobSearchingSpringMVC/api/load-job-type", {
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

        let area = document.getElementById('tbody-data-job-type')
        let urlEdit
        let urlDelete
        area.innerHTML = ""

        for (let i = 0; i < data.length; i++) {
            urlView = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-type/view-detail?id='.concat(data[i].id))
            urlEdit = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-type/add-or-update?id='.concat(data[i].id))

            area.innerHTML +=
                `
                    <tr id="jobType${data[i].id}">
                        <td style="text-align: center">
                            <a style="margin-right: 10px" href="${urlEdit}"
                               title="Sửa">
                                <i class="fa-solid fa-pen"></i>
                            </a>
                            <a onclick="deleteJobType(${data[i].id})"
                               title="Xoá" style="cursor: pointer; color: #4e73df">
                                <i class="fa-solid fa-trash"></i>
                            </a>
                        </td>
                        <td class="text-center">
                            ${(page - 1) * maxItems + i + 1}
                        </td>
                        <td> ${data[i].name} </td>
                        <td class="text-center">
                            <a style="margin-right: 10px" href="${urlView}"
                               title="Xem chi tiết">
                                <input type="button" class="btn btn-primary mx-1"
                                value="Xem danh sách việc làm" />
                            </a>
                        </td>
                    </tr>
                `
        }
    })
}

