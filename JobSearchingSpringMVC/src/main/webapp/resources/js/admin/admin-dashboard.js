let urlLoadJobPost = '/JobSearchingSpringMVC/api/load-jobs'
let urlLoadUser = '/JobSearchingSpringMVC/api/load-users'

// COUNT JOB POSTED
async function showCountJobPosted() {
    let result = await countLoadJobPost();
    document.getElementById('jobPostCount').innerText = result.length
}

async function countLoadJobPost() {
    try {
        let res = await fetch(urlLoadJobPost, {
            method: 'post',
            body: JSON.stringify({}),
            headers: {
                "Content-Type": "application/json"
            }
        });
        return await res.json();
    } catch (error) {
        console.log(error);
    }
}

// COUNT EMPLOYER ACTIVATED
async function showCountEmployerActivated() {
    let result = await countEmployerActivated();
    document.getElementById('employerActivatedCount').innerText = result.length
}

async function countEmployerActivated() {
    try {
        const query = {}

        query.userType = 'ROLE_NTD'
        query.active = 1

        let res = await fetch(urlLoadUser, {
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
