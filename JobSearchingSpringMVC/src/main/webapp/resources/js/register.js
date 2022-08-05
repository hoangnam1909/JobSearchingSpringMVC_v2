function clickToAvatarBrowse() {
    document.getElementById('avatarBrowse').click()
}

function showPreviewDiv(event) {
    if (event.target.files.length > 0) {
        let src = URL.createObjectURL(event.target.files[0]);
        let preview = document.getElementById("img-preview");
        preview.style.backgroundImage = `url(${src})`;
        preview.style.display = "block";
    }
}

