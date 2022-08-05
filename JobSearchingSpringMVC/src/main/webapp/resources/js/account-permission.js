function search() {
    const search = {}

    // if (document.getElementById('username').value.trim().length !== 0)
    //     search.username = document.getElementById('username').value;

    return search
}

function activeUser(id) {
    let urlFetch = "/JobSearchingSpringMVC/api/account/active/".concat(id);

    fetch(urlFetch, {
        method: 'put'
    }).then(function (res) {
        console.info(res)

        if (res.status === 202) {
            document.getElementById("user".concat(id)).innerHTML = ""

            let alertArea = document.getElementById('alert-area')
            alertArea.innerHTML = ""
            alertArea.innerHTML = `
                <div class="alert alert-success text-center" role="alert">
                    Xác nhận thành công nhà tuyển dụng
                </div>
            `
        }
    })
}

function loadEmployers(pageInput) {
    const queryString = window.location.search;
    console.log(queryString);
    const urlParams = new URLSearchParams(queryString);

c
    removeActivePagination()
    let page = pageInput;
    if (page === undefined) {
        page = urlParams.get('page') || '1'
    }

    query.page = page
    query.maxItems = maxItems
    query.userType = 'ROLE_NTD'
    query.active = 0

    let pageButton = document.getElementsByClassName('page-item')
    for (let i = 0; i < pageButton.length; i++) {
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

        if (res.status === 204) {
            document.getElementById('data-card').innerHTML = ""

            let alertArea = document.getElementById('alert-area')
            alertArea.innerHTML = ""
            alertArea.innerHTML =
            `
                <div class="alert alert-success text-center" role="alert">
                    Tất các các nhà tuyển dụng đã được xác nhận!!!
                </div>
            `
        }

        return res.json();
    }).then(function (data) {
        console.info(data);

        let area = document.getElementById('tbody-data')
        let urlAccept

        area.innerHTML = ""

        for (let i = 0; i < data.length; i++) {
            urlAccept = window.location.origin.concat('/JobSearchingSpringMVC/admin/account/view?id='.concat(data[i].id))

            area.innerHTML +=
                `
                    <tr id="user${data[i].id}">
                        <td style="text-align: center">
                            <a style="margin-right: 10px" onclick="activeUser(${data[i].id})"
                               href="#" data-toggle="tooltip"
                               title="Duyệt">
                                <i class="fa-solid fa-check"></i>
                            </a>
                        </td>
                        <td class="text-center" >${(page - 1) * maxItems + i + 1}</td>
                        <td>${data[i].username}</td>
                        <td>${data[i].employer.name}</td>
                        <td>${data[i].employer.location}</td>
                        <td>${data[i].employer.majoring}</td>
                    </tr>
                `
        }
    })
}