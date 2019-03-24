const isReviewShowPath = (pathname) => {
  if (pathname == pathname.match(/\/reviews\/\d+$/g)) {
    return true
  } else {
    return false
  }
}

let pathname = window.location.pathname; 
let totalReviews = (function() {
  if (isReviewShowPath(pathname)) {
    $.get(`/total_reviews.json`, function(reviews) {
      totalReviews = reviews.total_reviews
    })
  }
})();


$(document).on('turbolinks:load', function(){
  const currentReviewId = $("#next-review").attr('data-next_id')
  
  if (currentReviewId == totalReviews) {
    document.getElementById("next-review").disabled = true;
  } else if (currentReviewId == 1){
    document.getElementById("previous-review").disabled = true;
  }

  $(".reviews-btn").on("click", function() {
    let reviewId = null;

    if ($(this).attr('id') === 'next-review') {
      reviewId = parseInt($(this).attr('data-next_id'))
      
      document.getElementById("next-review").disabled = false;
      document.getElementById("previous-review").disabled = false;
      $(this).attr('data-next_id', (reviewId + 1))
      $(this).prev().attr('data-previous_id', (reviewId + 1))
      $.get(`/reviews/${reviewId + 1}.json`, function(review) {
        review.created_at = dateFormat(review.created_at);
        review.hollowStars = 5 - review.rating;

        $("#reviews_show_page").html(HandlebarsTemplates['show_review']({review: review, user: review.user}))
      })

      if (reviewId + 1 >= totalReviews) {
        document.getElementById("next-review").disabled = true;
      }
      
    } else {
      reviewId = parseInt($(this).attr('data-previous_id'))
      
      document.getElementById("previous-review").disabled = false;
      document.getElementById("next-review").disabled = false;
      $(this).attr('data-previous_id', (reviewId - 1))
      $(this).next().attr('data-next_id', (reviewId - 1))
      $.get(`/reviews/${reviewId - 1}.json`, function(review) {
        review.created_at = dateFormat(review.created_at);
        review.hollowStars = 5 - review.rating;

        $("#reviews_show_page").html(HandlebarsTemplates['show_review']({review: review, user: review.user}))
      })

      if (reviewId - 1 <= 1) {
        document.getElementById("previous-review").disabled = true;
      }
    }
  })
})
  /*$(".reviews-btn").on("click", function() {
    let reviewId = null;
    
    if ($(this).attr('id') === 'next-review') {
      reviewId = parseInt($(this).attr('data-next_id')) + 1
      
      if (reviewId <= totalReviews) {
        $(this).attr('data-next_id', reviewId)
        $(this).prev().attr('data-previous_id', reviewId)
      }
    } else {
      reviewId = parseInt($(this).attr('data-previous_id')) - 1

      if (reviewId >= 1) {
        $(this).next().attr('data-next_id', reviewId)
        $(this).attr('data-previous_id', reviewId)
      }
    }

    if (reviewId > totalReviews) {
      document.getElementById("next-review").disabled = true;
    } else if (reviewId < 1){
      document.getElementById("previous-review").disabled = true;
    } else {
    
    $.get(`/reviews/${reviewId}.json`, function(review) {
      review.created_at = dateFormat(review.created_at);
      review.hollowStars = 5 - review.rating;

      enableAndDisableBtn(reviewId, totalReviews)

      $("#reviews_show_page").html(HandlebarsTemplates['show_review']({review: review, user: review.user}))
    })
  }
    event.preventDefault();
  })
})*/