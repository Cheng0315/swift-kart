function enableAndDisableBtn(review_id, total_reviews) {
  if (review_id >= total_reviews) {
    document.getElementById("next-review").disabled = true;
  } else if (review_id <= 1) {
    document.getElementById("previous-review").disabled = true;
  } else {
    document.getElementById("next-review").disabled = false;
    document.getElementById("previous-review").disabled = false;
  }
}

$(document).on('turbolinks:load', function(){
  let total_reviews = null;
  let pathname = window.location.pathname; 
  
  if (isReviewShowPath(pathname)) {
    $.get(`/total_reviews.json`, function(reviews) {
      total_reviews = reviews.total_reviews
    })
  }

  $(".reviews-btn").on("click", function() {
    let review_id = null;
    
    if ($(this).attr('id') === 'next-review') {
      let current_id = parseInt($(this).attr('data-next_id'))
      review_id = current_id + 1
      
      if (review_id <= total_reviews) {
        $(this).attr('data-next_id', review_id)
        $(this).prev().attr('data-previous_id', review_id)
      }
    } else {
      let current_id = parseInt($(this).attr('data-previous_id'))
      review_id = current_id - 1

      if (review_id <= total_reviews) {
        $(this).next().attr('data-next_id', review_id)
        $(this).attr('data-previous_id', review_id)
      }
    }

    if (review_id > total_reviews) {
      document.getElementById("next-review").disabled = true;
    } else if (review_id < 1){
      document.getElementById("previous-review").disabled = true;
    } else {
    
    $.get(`/reviews/${review_id}.json`, function(review) {
      review.created_at = dateFormat(review.created_at);
      review.hollowStars = 5 - review.rating;

      enableAndDisableBtn(review_id, total_reviews)

      $("#reviews_show_page").html(HandlebarsTemplates['show_review']({review: review, user: review.user}))
    })
  }
    event.preventDefault();
  })
})