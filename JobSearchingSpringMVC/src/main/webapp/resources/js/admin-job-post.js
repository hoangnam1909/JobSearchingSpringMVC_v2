function titlePreview(title) {
    document.getElementById('title-preview').innerText = title.value
}


function employerPreview(employer) {
    let userId = employer.options[employer.selectedIndex].value

    if (parseInt(userId) === 0) {
        document.getElementById('img-employer-preview').style.backgroundImage = "url('/JobSearchingSpringMVC/resources/images/none.png')";
        document.getElementById('employer-name-preview').innerText = ""
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
            document.getElementById('employer-website-preview').innerText = data[0].employer.website
        })
    }
}


function search() {
    const search = {}

    if (document.getElementById('username').value.trim().length !== 0)
        search.username = document.getElementById('username').value;

    if (document.getElementById('phone').value.trim().length !== 0)
        search.phone = document.getElementById('phone').value;

    if (document.getElementById('email').value.trim().length !== 0)
        search.email = document.getElementById('email').value;

    if (document.getElementById('userType').value.trim().length !== 0)
        search.userType = document.getElementById('userType').value;

    return search
}


function deleteJobPost(jobPostId) {
    let urlFetch = "/JobSearchingSpringMVC/api/job-post/delete/".concat(jobPostId)
    fetch(urlFetch, {
        method: 'delete'
    }).then(function (res) {
        console.info(res)

        document.getElementById("jobPost".concat(jobPostId)).innerHTML = ""

        if (res.status === 202) {
            let alertArea = document.getElementById('alert-area')
            alertArea.innerHTML = ""
            alertArea.innerHTML = `
                <div class="alert alert-success text-center" role="alert">
                    Xoá thành công
                </div>
            `
        }

        return res.json();
    })
}

function loadJobPost(pageInput) {
    const queryString = window.location.search;
    console.log(queryString);
    const urlParams = new URLSearchParams(queryString);

    const query = search()

    removeActivePagination()
    let page = pageInput;
    if (page === undefined) {
        page = urlParams.get('page') || '1'
    }

    query.page = page
    query.maxItems = maxItems

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

        let area = document.getElementById('tbody-data')
        let urlView
        let urlEdit
        let urlDelete
        area.innerHTML = ""
        console.log(maxItems)
        for (let i = 0; i < data.length; i++) {
            urlView = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-post/view?id='.concat(data[i].id))
            urlEdit = window.location.origin.concat('/JobSearchingSpringMVC/admin/job-post/update?id='.concat(data[i].id))
            // urlDeleteUser = window.location.origin.concat('/JobSearchingSpringMVC/admin/account/delete?id='.concat(data[i].id))

            area.innerHTML +=
                `
                    <tr>
                        <td style="text-align: center">
                            <a style="margin-right: 10px" href="${urlView}"
                               title="Xem chi tiết">
                                <i class="fa-solid fa-eye"></i>
                            </a>
                            <a style="margin-right: 10px" href="${urlEdit}"
                               title="Sửa">
                                <i class="fa-solid fa-pen"></i>
                            </a>
                            <a style="margin-right: 10px" href="#"
                               class="confirmation" title="Xoá">
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

function loadUserAccountWithNoFilter(pageInput) {
    let page = pageInput;

    let pageButton = document.getElementsByClassName('page-item')
    for (let i = 0; i < pageButton.length; i++) {
        console.log(pageButton[i].innerText)
        if (pageButton[i].innerText == page)
            pageButton[i].classList.add('active')
    }

    fetch("/JobSearchingSpringMVC/api/load-users", {
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

        let area = document.getElementById('tbody-data')
        let urlViewUser
        let urlUpdateUser
        let urlDeleteUser
        let innerHTML
        area.innerHTML = ""
        console.log(maxItems)
        for (let i = 0; i < data.length; i++) {
            urlViewUser = window.location.origin.concat('/JobSearchingSpringMVC/admin/account/view?id='.concat(data[i].id))
            urlUpdateUser = window.location.origin.concat('/JobSearchingSpringMVC/admin/account/add-or-update?id='.concat(data[i].id))
            urlDeleteUser = window.location.origin.concat('/JobSearchingSpringMVC/admin/account/delete?id='.concat(data[i].id))

            innerHTML = ""

            innerHTML += `<tr id="user${data[i].id}">`
            innerHTML += `
                        <td class="d-flex" style="justify-content: space-evenly"> 
                            <a href="${urlViewUser}"
                               title="Xem chi tiết">
                                <i class="fa-solid fa-eye"></i>
                            </a>
                            <a href="${urlUpdateUser}"
                               data-toggle="tooltip" title="Sửa">
                                <i class="fa-solid fa-pen"></i>
                            </a>
                            <a onclick="deleteAccount(${data[i].id})"
                               title="Xoá" style="cursor: pointer; color: #4e73df">
                                <i class="fa-solid fa-trash"></i>
                            </a>
                        </td>
                        
                        <td class="text-center" >${(page - 1) * maxItems + i + 1}</td>
            `

            if (data[i].userType === 'ROLE_NTD' && data[i].active === 0)
                innerHTML +=
                    `
                    <c:if test="${data[i].userType === 'ROLE_NTD' && data[i].active === 0}">
                        <td style="color: red">[NOT ACTIVED] ${data[i].username}</td>
                    </c:if>
                        
                `

            if (!(data[i].userType === 'ROLE_NTD' && data[i].active === 0))
                innerHTML += ` <td>${data[i].username}</td> `

            innerHTML +=
                `
                    <td>${data[i].phone}</td>
                    <td>${data[i].email}</td>
                    <td>${data[i].userType}</td>
                `
            innerHTML += `</tr>`

            area.innerHTML += innerHTML
        }
    })
}

