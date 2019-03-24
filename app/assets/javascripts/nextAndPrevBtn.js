const isReviewShowPath = (pathname) => {
  if (pathname == pathname.match(/\/reviews\/\d+$/g)) {
    return true
  } else {
    return false
  }
}

let globalCurrentReviewId = null
let globalPathname = window.location.pathname; 
let globalTotalReviews = null;
let globalReviewId = null;

$(document).on('turbolinks:load', function(){

  if (isReviewShowPath(globalPathname)) {
    globalCurrentReviewId = parseInt($("#next-review").attr('data-next_id'))
    globalTotalReviews = parseInt($("#next-review").attr('data-total_reviews'))

    if (globalCurrentReviewId === globalTotalReviews) {
      document.getElementById("next-review").disabled = true;
    } else if (globalCurrentReviewId === 1){
      document.getElementById("previous-review").disabled = true;
    }
  }
  
  $(".reviews-btn").on("click", function() {

    if ($(this).attr('id') === 'next-review') {
      globalReviewId = parseInt($(this).attr('data-next_id'))
      
      document.getElementById("next-review").disabled = false;
      document.getElementById("previous-review").disabled = false;
      $(this).attr('data-next_id', (globalReviewId + 1))
      $(this).prev().attr('data-previous_id', (globalReviewId + 1))
      $.get(`/reviews/${globalReviewId + 1}.json`, function(review) {
        review.created_at = dateFormat(review.created_at);
        review.hollowStars = 5 - review.rating;

        $("#reviews_show_page").html(HandlebarsTemplates['show_review']({review: review, user: review.user}))
      })

      if (globalReviewId + 1 >= globalTotalReviews) {
        document.getElementById("next-review").disabled = true;
      }
      
    } else {
      globalReviewId = parseInt($(this).attr('data-previous_id'))
      
      document.getElementById("previous-review").disabled = false;
      document.getElementById("next-review").disabled = false;
      $(this).attr('data-previous_id', (globalReviewId - 1))
      $(this).next().attr('data-next_id', (globalReviewId - 1))
      $.get(`/reviews/${globalReviewId - 1}.json`, function(review) {
        review.created_at = dateFormat(review.created_at);
        review.hollowStars = 5 - review.rating;

        $("#reviews_show_page").html(HandlebarsTemplates['show_review']({review: review, user: review.user}))
      })

      if (globalReviewId - 1 <= 1) {
        document.getElementById("previous-review").disabled = true;
      }
    }
  })
})
 