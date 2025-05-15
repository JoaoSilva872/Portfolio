
let reviewList = document.querySelector('#reviewList');
let reviewInput = document.querySelector('#reviewInput');

function loadReviews() {
    let savedReviews = localStorage.getItem('reviews');
    if (savedReviews) {
        let reviews = JSON.parse(savedReviews);

        reviews.forEach((reviewText, index) => addReviewToDOM(reviewText, index));
    }
}

function addReviewToDOM(reviewText, index) {
    let reviewItem = document.createElement('li');
    reviewItem.className = 'review-item';


    let reviewTextP = document.createElement('p');
    reviewTextP.textContent = reviewText;


    let deleteButton = document.createElement('button');
    deleteButton.textContent = 'Excluir';
    deleteButton.onclick = () => deleteReview(index);

    reviewItem.appendChild(reviewTextP);
    reviewItem.appendChild(deleteButton);


    reviewList.appendChild(reviewItem);
}

function saveReviewToStorage(reviewText) {
    let savedReviews = localStorage.getItem('reviews');
    let reviews = savedReviews ? JSON.parse(savedReviews) : [];
    reviews.push(reviewText);
    localStorage.setItem('reviews', JSON.stringify(reviews));
}

function addReview() {
    let reviewText = reviewInput.value.trim();

    if (reviewText) {
        saveReviewToStorage(reviewText);
        let index = JSON.parse(localStorage.getItem('reviews')).length - 1;
        addReviewToDOM(reviewText, index);
        reviewInput.value = '';
    } else {
        alert('Por favor, escreva uma avaliação antes de enviar!');
    }
}

function deleteReview(index) {
    let savedReviews = localStorage.getItem('reviews');
    if (savedReviews) {
        let reviews = JSON.parse(savedReviews);
        reviews.splice(index, 1);
        localStorage.setItem('reviews', JSON.stringify(reviews));

        reviewList.innerHTML = '';
        reviews.forEach((reviewText, newIndex) => addReviewToDOM(reviewText, newIndex));
    }
}

loadReviews();