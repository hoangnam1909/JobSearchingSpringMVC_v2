let loadingJobPostInJobTypeLoadingElement = document.getElementById('job-post-in-job-type-loading')
let loadingJobPostInJobTypeDisplayElement = document.getElementById('job-post-in-job-type-display')

function generateColors() {
    let r = parseInt(Math.random() * 255);
    let g = parseInt(Math.random() * 255);
    let b = parseInt(Math.random() * 255);
    return `rgb(${r}, ${g}, ${b}, 0.6)`
}

async function getLabelsJobPostInJobTypeChart() {
    let labels = []
    let values = []

    try {
        await fetch("/JobSearchingSpringMVC/api/stat-job-post-by-job-type", {
            method: 'get'
        }).then(function (res) {
            console.info(res)
            return res.json();
        }).then(function (data) {
            console.info(data);

            for (let i = 0; i < data.length; i++) {
                labels.push(data[i].label)
                values.push(data[i].value)
            }

            return data;
        })

        return {
            'labels': labels,
            'values': values
        }
    } catch (error) {
        console.log(error);
    }
}

async function jobPostInJobTypeChart(id) {
    let dataPackage = await getLabelsJobPostInJobTypeChart()
    loadingJobPostInJobTypeLoadingElement.style.display = "none"
    loadingJobPostInJobTypeDisplayElement.style.display = "block"

    let jobTypeLabels = dataPackage.labels
    let jobTypeData = dataPackage.values

    let colors = []
    for (let i = 0; i < jobTypeLabels.length; i++)
        colors.push(generateColors())

    const data = {
        labels: jobTypeLabels,
        datasets: [{
            axis: 'y',
            label: 'Số tin tuyển dụng',
            data: jobTypeData,
            fill: false,
            backgroundColor: colors,
            borderColor: colors,
            borderWidth: 1
        }]
    };

    const config = {
        type: 'bar',
        data: data
    };

    new Chart(document.getElementById(id), {
        type: 'horizontalBar',
        data: data,
        config: config,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            legend: {
                display: false
            },
            scales: {
                xAxes: [{
                    ticks: {
                        min: 0,
                        max: Math.max(...jobTypeData) + 1,
                        stepSize: 1
                    }
                }]
            }
        }
    });
}
