

function search() {
    const search = {}

    if (document.getElementById('username').value.trim().length !== 0)
        search.username = document.getElementById('username').value;

    return search
}

function loadUserAccount(pageInput) {
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

    fetch("/JobSearchingSpringMVC/api/load-users", {
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

            innerHTML += `<tr>`
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
                            <a href="${urlDeleteUser}"
                               title="Xoá">
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