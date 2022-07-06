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

imgInp.onchange = evt => {
    const [file] = imgInp.files
    if (file) {
        blah.src = URL.createObjectURL(file)
    }
}

function refreshPage() {
    window.location.reload();
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

function viewInfo(postID) {
    url = "/JobSearchingSpringMVC/api/view-info/".concat(postID)
    fetch(url)
        .then(function (res) {
            console.info(res)
            return res.json();
        })
        .then(function (data) {
            console.info(data);

            let area = document.getElementById("modal-body");
            moment.locale('vi');

            area.innerHTML = `                         
              ${data.description}
        ` + area.innerHTML
        })

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
            moment.locale('vi');

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

