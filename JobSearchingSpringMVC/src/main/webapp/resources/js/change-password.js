let urlCheckPassword = '/JobSearchingSpringMVC/api/check-password';
let passwordElement = document.getElementById('password')
let confirmPasswordElement = document.getElementById('confirm-password')
let alertArea = document.getElementById('alert-card')
let alertBody = document.getElementById('alert-card-body')

function checkPassword(id) {
    let rawPassword = document.getElementById('raw-password').value;

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
            console.info(res)
            return res.json();
        }).then(function (data) {
            console.info(data.status);
            // return data.status;

            if (data.status === 'false') {
                alertArea.style.display = "block"
                alertBody.innerText = "Mật khẩu hiện tại chưa chính xác"
            } else {
                alertArea.style.display = "none"
            }

            if (passwordElement.value.trim().length > 0 && confirmPasswordElement.value.length > 0) {
                if (passwordElement.value !== confirmPasswordElement.value) {
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