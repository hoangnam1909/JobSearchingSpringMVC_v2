let urlCheckPassword = '/JobSearchingSpringMVC/api/check-password';
let urlChangePassword = '/JobSearchingSpringMVC/api/change-password';
let rawPasswordElement = document.getElementById('raw-password')
let newPasswordElement = document.getElementById('new-password')
let confirmPasswordElement = document.getElementById('confirm-password')
let alertArea = document.getElementById('alert-card')
let alertBody = document.getElementById('alert-card-body')

function successAlert() {
    if (alertArea.classList.contains('bg-danger')){
        alertArea.classList.remove('bg-danger')
        alertArea.classList.add('bg-success')
    }
}

function dangerAlert() {
    if (alertArea.classList.contains('bg-success')){
        alertArea.classList.remove('bg-success')
        alertArea.classList.add('bg-danger')
    }
}

function checkPassword(id) {
    let rawPassword = rawPasswordElement.value;

    try {
        fetch(urlCheckPassword, {
            method: 'post',
            body: JSON.stringify({
                "id": id,
                "rawPassword": rawPassword
            }),
            headers: {
                "Content-Type": "application/json"
            }
        }).then(function (res) {
            return res.json();
        }).then(function (data) {
            dangerAlert()

            if (data.status === 'false') {
                alertArea.style.display = "block"
                alertBody.innerText = "Mật khẩu hiện tại chưa chính xác"
            } else {
                alertArea.style.display = "none"
            }

            if (newPasswordElement.value.trim().length > 0 || confirmPasswordElement.value.length > 0) {
                if (rawPasswordElement.value === newPasswordElement.value ||
                    rawPasswordElement.value === confirmPasswordElement.value) {
                    alertArea.style.display = "block"
                    alertBody.innerText = "Mật khẩu mới không được trùng với mật khẩu cũ"
                } else {
                    alertArea.style.display = "none"
                }
            }

            if (newPasswordElement.value.trim().length > 0 && confirmPasswordElement.value.length > 0) {
                if (newPasswordElement.value !== confirmPasswordElement.value) {
                    alertArea.style.display = "block"
                    alertBody.innerText = "Mật khẩu chưa trùng khớp"
                } else {
                    alertArea.style.display = "none"
                }
            }
        })
    } catch (error) {
        console.log(error);
    }
}

function changePassword(id) {
    try {
        fetch(urlChangePassword, {
            method: 'post',
            body: JSON.stringify({
                "id": id,
                "newPassword": newPasswordElement.value
            }),
            headers: {
                "Content-Type": "application/json"
            }
        }).then(function (res) {
            return res.json();
        }).then(function (data) {
            if (data.status === 'true') {
                successAlert()
                alertArea.style.display = "block"
                alertBody.innerText = "Thay đổi mật khẩu thành công"

                rawPasswordElement.value = ""
                newPasswordElement.value = ""
                confirmPasswordElement.value = ""
            } else {
                dangerAlert()
                alertArea.style.display = "block"
                alertBody.innerText = "Thay đổi mật khẩu thất bại"
            }
        })
    } catch (error) {
        console.log(error);
    }
}
