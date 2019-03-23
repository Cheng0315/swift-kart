$(document).on('turbolinks:load', function(){

  $(".sort-reviews").change(function() {
    const sortBy = $(this).val();
    const itemId = $(this).attr('data-item_id')
    
    $.ajax({
      type: 'GET',
      url: "/sort_reviews",
      data: {sortBy: sortBy, itemId: itemId}
    }).done(function(reviews) {
      reviews.forEach(function(review) {
        review.created_at = dateFormat(review.created_at);
        review.hollowStars = 5 - review.rating;
      })
      
      $('#list-reviews').html(HandlebarsTemplates['sort_reviews'](reviews))
    })
  })

})