document.addEventListener('scroll', () => {
    let video = document.querySelector('.video');
    let footer = document.querySelector('footer');

    let footerTop = footer.getBoundingClientRect().top;

    let stopLimit = 120;

    if (footerTop < window.innerHeight + stopLimit) {
        video.style.position = 'absolute';
        video.style.top = `500px`;
    } else {
        video.style.position = 'fixed';
        video.style.top = '130px';
    }
});