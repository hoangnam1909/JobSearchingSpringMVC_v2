moment.locale('vi');


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


function showPreview(event) {
    if (event.target.files.length > 0) {
        let src = URL.createObjectURL(event.target.files[0]);
        let preview = document.getElementById("img-preview");
        preview.src = src;
        preview.style.display = "block";
    }
}

function showPreviewDiv(event) {
    if (event.target.files.length > 0) {
        let src = URL.createObjectURL(event.target.files[0]);
        let preview = document.getElementById("img-preview");
        // console.log(src)
        // console.log(preview.style.backgroundImage)
        // console.log(`url(${src}`)
        preview.style.backgroundImage = `url(${src})`;
        preview.style.display = "block";
    }
}

function userTypePreview(userType) {
    document.getElementById('user-type-badge').innerText = userType.options[userType.selectedIndex].text
}

function fullnamePreview(fullname) {
    document.getElementById('fullname-preview').innerText = fullname.value
}

function usernamePreview(username) {
    document.getElementById('username-preview').innerText = username.value
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
            // moment.locale('vi');

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


function deleteApplyJob(applyJobId) {
    let url = '/JobSearchingSpringMVC/api/apply-job/delete/'.concat(applyJobId)
    fetch(url, {
        method: 'DELETE'
    }).then(function (res) {
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


function removeActivePagination() {
    let pageButton = document.getElementsByClassName('page-item')
    for (let i = 0; i < pageButton.length; i++) {
        if (pageButton[i].classList.contains('active'))
            pageButton[i].classList.remove('active')
    }
}

