function generateColors() {
    let r = parseInt(Math.random() * 255);
    let g = parseInt(Math.random() * 255);
    let b = parseInt(Math.random() * 255);
    return `rgb(${r}, ${g}, ${b})`
}

function userTypeChart(id, userTypeLabels = [], userTypeInfos = []) {
    let colors = []
    for (let i = 0; i < userTypeLabels.length; i++)
        colors.push(generateColors())

    const data = {
        labels: userTypeLabels,
        datasets: [{
            label: 'Thống kê số lượng các tài khoản được tạo theo loại tài khoản',
            data: userTypeInfos,
            backgroundColor: colors,
            hoverOffset: 4
        }]
    };

    const config = {
        type: 'pie',
        data: data,
    };

    let ctx = document.getElementById(id).getContext("2d")
    new Chart(ctx, config)
}