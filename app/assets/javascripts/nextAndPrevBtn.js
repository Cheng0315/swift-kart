let gCurrentReviewId = null;
let gTotalReviews = null;
let gReviewId = null; 

$(function(){

  function openNav() {
    document.getElementById("mySidepanel").style.width = "250px";
  }
  
  /* Set the width of the sidebar to 0 (hide it) */
  function closeNav() {
    document.getElementById("mySidepanel").style.width = "0";
  }

  (function() {
    gCurrentReviewId = parseInt($("#next-review").attr('data-next_id'))
    gTotalReviews = parseInt($("#next-review").attr('data-total_reviews'))

    if (gCurrentReviewId === gTotalReviews) {
      document.getElementById("next-review").disabled = true;
    } else if (gCurrentReviewId === 1){
      document.getElementById("previous-review").disabled = true;
    }
  })();

  
  $(".reviews-btn").on("click", function() {

    if ($(this).attr('id') === 'next-review') {
      gReviewId = parseInt($(this).attr('data-next_id'))
      
      document.getElementById("next-review").disabled = false;
      document.getElementById("previous-review").disabled = false;
      $(this).attr('data-next_id', (gReviewId + 1))
      $(this).prev().attr('data-previous_id', (gReviewId + 1))
      $.get(`/reviews/${gReviewId + 1}.json`, function(review) {
        review.created_at = dateFormatter(review.created_at);
        review.hollowStars = 5 - review.rating;

        $("#reviews_show_page").html(HandlebarsTemplates['show_review']({review: review, user: review.user}))
      })

      if (gReviewId + 1 >= gTotalReviews) {
        document.getElementById("next-review").disabled = true;
      }
      
    } else {
      gReviewId = parseInt($(this).attr('data-previous_id'))
      
      document.getElementById("previous-review").disabled = false;
      document.getElementById("next-review").disabled = false;
      $(this).attr('data-previous_id', (gReviewId - 1))
      $(this).next().attr('data-next_id', (gReviewId - 1))
      $.get(`/reviews/${gReviewId - 1}.json`, function(review) {
        review.created_at = dateFormatter(review.created_at);
        review.hollowStars = 5 - review.rating;

        $("#reviews_show_page").html(HandlebarsTemplates['show_review']({review: review, user: review.user}))
      })

      if (gReviewId - 1 <= 1) {
        document.getElementById("previous-review").disabled = true;
      }
    }
  })
})
 