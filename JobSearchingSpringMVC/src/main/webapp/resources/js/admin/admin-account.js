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

function removeSearch() {
    search.username = document.getElementById('username').value = ""
    search.phone = document.getElementById('phone').value = ""
    search.email = document.getElementById('email').value = ""
    search.userType = document.getElementById('userType').value = ""
}

function deleteAccount(accountId) {
    let urlFetch = "/JobSearchingSpringMVC/api/account/delete/".concat(accountId)
    fetch(urlFetch, {
        method: 'delete'
    }).then(function (res) {
        console.info(res)

        if (res.status === 202) {
            document.getElementById("user".concat(accountId)).innerHTML = ""

            let alertArea = document.getElementById('alert-area')
            alertArea.innerHTML = ""
            alertArea.innerHTML = `
                <div class="alert alert-success text-center" role="alert">
                    Xoá thành công tài khoản
                </div>
            `
        }

        return res.json();
    })
}

async function loadUserAccountPagination(activePageNumber) {
    let endOfNumberPage = parseInt(await numberOfPages());
    let paginationArea = document.getElementById('pagination-area')
    paginationArea.innerHTML = ""

    for (let i = 1; i <= Math.ceil(endOfNumberPage / maxItems); i++) {
        if (i === 1) {
            paginationArea.innerHTML +=
                `
                <li class="page-item">
                    <a class="page-link" style="cursor: pointer"
                       onclick="loadUserAccount(${i})">${i}</a>
                </li>
            `
        } else {
            paginationArea.innerHTML +=
                `
                <li class="page-item">
                    <a class="page-link" style="cursor: pointer"
                       onclick="loadUserAccount(${i})">${i}</a>
                </li>
            `
        }
    }

    activePagination(activePageNumber);
}

async function numberOfPages() {
    let result = await countLoadUserAccountResult();
    return JSON.stringify(result.length)
}

async function countLoadUserAccountResult() {
    const query = search()

    query.page = 0
    query.maxItems = maxItems

    let url = '/JobSearchingSpringMVC/api/load-users';
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

function loadUserAccount(pageInput) {
    const query = search()

    let page = pageInput;
    if (page == undefined) {
        page = 1
    }

    query.page = page
    query.maxItems = maxItems

    loadUserAccountPagination(page)

    fetch("/JobSearchingSpringMVC/api/load-users", {
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
            document.getElementById('tbody-data').innerHTML = ""
            document.getElementById('pagination-area').innerHTML = ""
        }

        return res.json();
    }).then(function (data) {
        console.info(data);

        let area = document.getElementById('tbody-data')
        let urlViewUser
        let urlUpdateUser
        let urlDeleteUser
        let innerHTML
        area.innerHTML = ""

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
    }).then(function () {
        // removeActivePagination()
        let pageButton = document.getElementsByClassName('page-item')
        for (let i = 0; i < pageButton.length; i++) {
            if (pageButton[i].innerText == page)
                pageButton[i].classList.add('active')
        }
    })
}

function loadUserAccountWithNoFilter() {
    let page = 1;
    removeSearch()
    loadUserAccountPagination(1)

    document.getElementById('alert-area').innerHTML = ""

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
