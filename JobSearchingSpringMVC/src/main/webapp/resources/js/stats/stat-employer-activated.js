let progressBarArea = document.getElementById('progress-bar-area')

let employerActivatedLoadingElement = document.getElementById('employer-activated-loading')
let employerActivatedDisplayElement = document.getElementById('employer-activated-display')

async function getStatEmployerActivatedData() {
    let activated, unActivated;

    try {
        await fetch("/JobSearchingSpringMVC/api/stat-employer-activated", {
            method: 'get'
        }).then(function (res) {
            console.info(res)
            return res.json();
        }).then(function (data) {
            console.info(data);
            activated = data.activated
            unActivated = data.unActivated
            return data;
        })

        return {
            'activated': activated,
            'unActivated': unActivated
        }
    } catch (error) {
        console.log(error);
    }
}

async function statEmployerActivated(id) {
    let dataPackage = await getStatEmployerActivatedData()
    employerActivatedLoadingElement.style.display = "none"
    employerActivatedDisplayElement.style.display = "block"

    let colors = []
    for (let i = 0; i < 2; i++)
        colors.push(generateColors())

    const data = {
        labels: [
            'Đã kích hoạt',
            'Chưa kích hoạt'
        ],
        datasets: [{
            label: 'My First Dataset',
            data: [dataPackage.activated, dataPackage.unActivated],
            backgroundColor: colors,
            hoverOffset: 4
        }]
    };

    const config = {
        type: 'doughnut',
        data: data,
    };

    new Chart(document.getElementById(id), {
        type: 'doughnut',
        data: data,
        config: config
    });
}
